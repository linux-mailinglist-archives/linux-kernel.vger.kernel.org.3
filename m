Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E5C4D28D7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiCIGQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiCIGQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:16:42 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401C4154721
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:15:44 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9454468AFE; Wed,  9 Mar 2022 07:15:41 +0100 (CET)
Date:   Wed, 9 Mar 2022 07:15:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mingbao Sun <sunmingbao@tom.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 1/2] nvmet-tcp: support specifying the
 congestion-control
Message-ID: <20220309061541.GB31316@lst.de>
References: <20220309053711.2561-1-sunmingbao@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309053711.2561-1-sunmingbao@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 01:37:11PM +0800, Mingbao Sun wrote:
> +		if (port->nport->tcp_congestion) {
> +			icsk_new = inet_csk(newsock->sk);
> +			if (icsk_new->icsk_ca_ops != icsk->icsk_ca_ops) {
> +				pr_warn("congestion abnormal: expected %s, actual %s.\n",
> +					icsk->icsk_ca_ops->name,
> +					icsk_new->icsk_ca_ops->name);
> +			}
> +		}

What is the point of having this code?

> +	if (nport->tcp_congestion) {
> +		strncpy(ca_name, nport->tcp_congestion, TCP_CA_NAME_MAX-1);
> +		optval = KERNEL_SOCKPTR(ca_name);
> +		ret = sock_common_setsockopt(port->sock, IPPROTO_TCP,
> +					     TCP_CONGESTION, optval,
> +					     strlen(ca_name));
> +		if (ret) {
> +			pr_err("failed to set port socket's congestion to %s: %d\n",
> +			       ca_name, ret);
> +			goto err_sock;
> +		}
> +	}

Same comment as for the host side.
