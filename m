Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC21559676
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiFXJXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiFXJXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:23:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E10BF4F9EB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:23:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F7F3143D;
        Fri, 24 Jun 2022 02:23:09 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 652A13F792;
        Fri, 24 Jun 2022 02:23:08 -0700 (PDT)
Date:   Fri, 24 Jun 2022 10:22:58 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        etienne.carriere@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scmi/optee: fix response size warning
Message-ID: <YrWCctNSyKcqSHE9@e120937-lin>
References: <20220624074549.3298-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624074549.3298-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 09:45:49AM +0200, Vincent Guittot wrote:
> Some protocols check the response size with the expected value but optee
> shared memory doesn't return such size whereas it is available in the
> optee output buffer.
> 
> As an example, the base protocol compares the response size with the
> expected result when requesting the list of protocol which triggers a
> warning with optee shared memory:
> 
> [    1.260306] arm-scmi firmware:scmi0: Malformed reply - real_sz:116  calc_sz:4  (loop_num_ret:4)
> 
> Save the output buffer length and use it when fetching the answer.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Hi Vincent,

> ---
> 
> Tested on sudeep's for-next/scmi branch
> 
>  drivers/firmware/arm_scmi/optee.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> index b503c22cfd32..8abace56b958 100644
> --- a/drivers/firmware/arm_scmi/optee.c
> +++ b/drivers/firmware/arm_scmi/optee.c
> @@ -117,6 +117,7 @@ struct scmi_optee_channel {
>  	u32 channel_id;
>  	u32 tee_session;
>  	u32 caps;
> +	u32 rx_len;
>  	struct mutex mu;
>  	struct scmi_chan_info *cinfo;
>  	union {
> @@ -302,6 +303,9 @@ static int invoke_process_msg_channel(struct scmi_optee_channel *channel, size_t
>  		return -EIO;
>  	}
>  
> +	/* Save response size */
> +	channel->rx_len = param[2].u.memref.size;
> +
>  	return 0;
>  }
>  
> @@ -353,6 +357,7 @@ static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *ch
>  	shbuf = tee_shm_get_va(channel->tee_shm, 0);
>  	memset(shbuf, 0, msg_size);
>  	channel->req.msg = shbuf;
> +	channel->rx_len = msg_size;
>  
>  	return 0;
>  }
> @@ -508,7 +513,7 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
>  	struct scmi_optee_channel *channel = cinfo->transport_info;
>  
>  	if (channel->tee_shm)
> -		msg_fetch_response(channel->req.msg, SCMI_OPTEE_MAX_MSG_SIZE, xfer);
> +		msg_fetch_response(channel->req.msg, channel->rx_len, xfer);
>  	else
>  		shmem_fetch_response(channel->req.shmem, xfer);
>  }

Looks good to me.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

