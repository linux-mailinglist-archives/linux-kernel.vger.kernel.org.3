Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988CD4D28CD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiCIGPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCIGPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:15:44 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF27159E8F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:14:46 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7174868AFE; Wed,  9 Mar 2022 07:14:42 +0100 (CET)
Date:   Wed, 9 Mar 2022 07:14:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mingbao Sun <sunmingbao@tom.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/2] nvme-tcp: support specifying the
 congestion-control
Message-ID: <20220309061442.GA31316@lst.de>
References: <20220308151606.2563-1-sunmingbao@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308151606.2563-1-sunmingbao@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 11:16:06PM +0800, Mingbao Sun wrote:
> From: Mingbao Sun <tyler.sun@dell.com>
> 
> congestion-control could have a noticeable impaction on the
> performance of TCP-based communications. This is of course true
> to NVMe_over_TCP.
> 
> Different congestion-controls (e.g., cubic, dctcp) are suitable for
> different scenarios. Proper adoption of congestion control would benefit
> the performance. On the contrary, the performance could be destroyed.
> 
> Though we can specify the congestion-control of NVMe_over_TCP via
> writing '/proc/sys/net/ipv4/tcp_congestion_control', but this also
> changes the congestion-control of all the future TCP sockets that
> have not been explicitly assigned the congestion-control, thus bringing
> potential impaction on their performance.
> 
> So it makes sense to make NVMe_over_TCP support specifying the
> congestion-control. And this commit addresses the host side.
> 
> Implementation approach:
> a new option called 'tcp_congestion' was created in fabrics opt_tokens
> for 'nvme connect' command to passed in the congestion-control
> specified by the user.
> Then later in nvme_tcp_alloc_queue, the specified congestion-control
> would be applied to the relevant sockets of the host side.
> 
> Signed-off-by: Mingbao Sun <tyler.sun@dell.com>
> ---
>  drivers/nvme/host/fabrics.c | 12 ++++++++++++
>  drivers/nvme/host/fabrics.h |  2 ++
>  drivers/nvme/host/tcp.c     | 20 +++++++++++++++++++-
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index ee79a6d639b4..79d5f0dbafd3 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -548,6 +548,7 @@ static const match_table_t opt_tokens = {
>  	{ NVMF_OPT_TOS,			"tos=%d"		},
>  	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
>  	{ NVMF_OPT_DISCOVERY,		"discovery"		},
> +	{ NVMF_OPT_TCP_CONGESTION,	"tcp_congestion=%s"	},
>  	{ NVMF_OPT_ERR,			NULL			}
>  };
>  
> @@ -829,6 +830,16 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>  		case NVMF_OPT_DISCOVERY:
>  			opts->discovery_nqn = true;
>  			break;
> +		case NVMF_OPT_TCP_CONGESTION:
> +			p = match_strdup(args);
> +			if (!p) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +
> +			kfree(opts->tcp_congestion);
> +			opts->tcp_congestion = p;
> +			break;
>  		default:
>  			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
>  				p);
> @@ -947,6 +958,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
>  	kfree(opts->subsysnqn);
>  	kfree(opts->host_traddr);
>  	kfree(opts->host_iface);
> +	kfree(opts->tcp_congestion);
>  	kfree(opts);
>  }
>  EXPORT_SYMBOL_GPL(nvmf_free_options);
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index c3203ff1c654..25fdc169949d 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -68,6 +68,7 @@ enum {
>  	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
>  	NVMF_OPT_HOST_IFACE	= 1 << 21,
>  	NVMF_OPT_DISCOVERY	= 1 << 22,
> +	NVMF_OPT_TCP_CONGESTION	= 1 << 23,
>  };
>  
>  /**
> @@ -117,6 +118,7 @@ struct nvmf_ctrl_options {
>  	unsigned int		nr_io_queues;
>  	unsigned int		reconnect_delay;
>  	bool			discovery_nqn;
> +	const char		*tcp_congestion;
>  	bool			duplicate_connect;
>  	unsigned int		kato;
>  	struct nvmf_host	*host;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index babbc14a4b76..3415e178a78b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1403,6 +1403,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
>  {
>  	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>  	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
> +	char ca_name[TCP_CA_NAME_MAX];
> +	sockptr_t optval;
>  	int ret, rcv_pdu_size;
>  
>  	mutex_init(&queue->queue_lock);
> @@ -1447,6 +1449,21 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
>  	if (nctrl->opts->tos >= 0)
>  		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
>  
> +	if (nctrl->opts->mask & NVMF_OPT_TCP_CONGESTION) {
> +		strncpy(ca_name, nctrl->opts->tcp_congestion,
> +			TCP_CA_NAME_MAX-1);
> +		optval = KERNEL_SOCKPTR(ca_name);
> +		ret = sock_common_setsockopt(queue->sock, IPPROTO_TCP,
> +					     TCP_CONGESTION, optval,
> +					     strlen(ca_name));

This needs to use kernel_setsockopt.  I also can see absolutely no
need for the optval local variable, and I also don't really see why
we need ca_name either - if we need to limit the length and terminate
it (but why?) that can be done during option parsing.
