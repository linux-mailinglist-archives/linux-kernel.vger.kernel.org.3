Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D87D4CD17B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiCDJne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbiCDJnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:43:10 -0500
Received: from smtp2.math.uni-bielefeld.de (smtp2.math.uni-bielefeld.de [129.70.45.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FC52FFE9;
        Fri,  4 Mar 2022 01:42:22 -0800 (PST)
Received: from math.uni-bielefeld.de (kvm01.math.uni-bielefeld.de [129.70.45.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by smtp2.math.uni-bielefeld.de (Postfix) with ESMTPSA id BBADF60179;
        Fri,  4 Mar 2022 10:42:20 +0100 (CET)
Date:   Fri, 4 Mar 2022 10:42:19 +0100
From:   Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
To:     Huijin Park <huijin.park@samsung.com>
Cc:     "H . Nikolaus Schaller" <hns@goldelico.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mmc@vger.kernel.org, letux-kernel@openphoenux.org,
        Ulf Hansson <ulf.hansson@linaro.org>, tony@atomide.com,
        bbanghj.park@gmail.com
Subject: Re: [BUG] mmc: core: adjust polling interval for CMD1
Message-ID: <20220304094219.GB20284@math.uni-bielefeld.de>
References: <CGME20220303121624epcas1p3781f58f2f04b0a26c35311aa0f4defcf@epcas1p3.samsung.com>
 <20220303121616.2285-1-huijin.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303121616.2285-1-huijin.park@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huijin Park wrote on Thu  3/03/22 21:16:
> Hi, sorry for the late reply.
> I guess the problem occurs depending on the eMMC model.
> Because I tested again and there was no problem.
> The eMMC model used for the test are as follows.
> (THGBMJG6C1LBAIL, KLM8G1GETF-B041)
> Anyway I guess the cause is interval time.
> I wrote a debug patch assuming that the reason was that some mmc models
> could not process CMD1 delivered at short intervals.
> I copied the polling function and adds interval minimum time parameter.
> I set the minimum time to 1ms. You can adjust it.
> Please test if there is no problem with the debug patch.
> 
> >Hi,
> >
> >> Am 02.03.2022 um 09:20 schrieb Jean Rene Dawin <jdawin@math.uni-bielefeld.de>:
> >> 
> >> Ulf Hansson wrote on Tue  1/03/22 14:38:
> >>> On Thu, 17 Feb 2022 at 21:12, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >>>> 
> >>> 
> >>> From: Ulf Hansson <ulf.hansson@linaro.org>
> >>> Date: Tue, 1 Mar 2022 14:24:21 +0100
> >>> Subject: [PATCH] mmc: core: Extend timeout to 2s for MMC_SEND_OP_COND
> >>> 
> >>> It looks like the timeout for the MMC_SEND_OP_COND (CMD1) might have become
> >>> a bit too small due to recent changes. Therefore, let's extend it to 2s,
> >>> which is probably more inline with its previous value, to fix the reported
> >>> timeout problems.
> >>> 
> >>> While at it, let's add a define for the timeout value, rather than using
> >>> a hard-coded value for it.
> >>> 
> >>> Reported-by: Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
> >>> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> >>> Cc: Huijin Park <huijin.park@samsung.com>
> >>> Fixes: 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1")
> >>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>> ---
> >>> drivers/mmc/core/mmc_ops.c | 4 +++-
> >>> 1 file changed, 3 insertions(+), 1 deletion(-)
> >>> 
> >>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> >>> index d63d1c735335..1f57174b3cf3 100644
> >>> --- a/drivers/mmc/core/mmc_ops.c
> >>> +++ b/drivers/mmc/core/mmc_ops.c
> >>> @@ -21,6 +21,7 @@
> >>> 
> >>> #define MMC_BKOPS_TIMEOUT_MS           (120 * 1000) /* 120s */
> >>> #define MMC_SANITIZE_TIMEOUT_MS                (240 * 1000) /* 240s */
> >>> +#define MMC_OP_COND_TIMEOUT_MS         2000 /* 2s */
> >>> 
> >>> static const u8 tuning_blk_pattern_4bit[] = {
> >>>        0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
> >>> @@ -232,7 +233,8 @@ int mmc_send_op_cond(struct mmc_host *host, u32
> >>> ocr, u32 *rocr)
> >>>        cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
> >>>        cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
> >>> 
> >>> -       err = __mmc_poll_for_busy(host, 1000, &__mmc_send_op_cond_cb, &cb_data);
> >>> +       err = __mmc_poll_for_busy(host, MMC_OP_COND_TIMEOUT_MS,
> >>> +                                 &__mmc_send_op_cond_cb, &cb_data);
> >>>        if (err)
> >>>                return err;
> >>> 
> >>> -- 
> >>> 2.25.1
> >> 
> >> Hi,
> >> 
> >> thanks. But testing with this patch still gives the same errors:
> >> 
> >> [   52.259940] mmc1: Card stuck being busy! __mmc_poll_for_busy
> >> [   52.273380] mmc1: error -110 doing runtime resume
> >> 
> >> and the system gets stuck eventually.
> >
> >Same result from my tests.
> >
> >BR and thanks,
> >Nikolaus
> 
> 
> From c2458cb998dd8e275fefba52dd2532beb153c82d Mon Sep 17 00:00:00 2001
> From: Huijin Park <huijin.park@samsung.com>
> Date: Thu, 3 Mar 2022 20:43:22 +0900
> Subject: [PATCH] mmc: core: extend timeout and set min time for op_cond
> 
> This patch extends timeout to 2s and sets minimal interval time for
> checking op_cond stuck problem.
> 
> Signed-off-by: Huijin Park <huijin.park@samsung.com>
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index d63d1c735335..ccad6379d183 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -21,6 +21,7 @@
>  
>  #define MMC_BKOPS_TIMEOUT_MS		(120 * 1000) /* 120s */
>  #define MMC_SANITIZE_TIMEOUT_MS		(240 * 1000) /* 240s */
> +#define MMC_OP_COND_TIMEOUT_MS		(  2 * 1000) /*   2s */
>  
>  static const u8 tuning_blk_pattern_4bit[] = {
>  	0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
> @@ -179,6 +180,47 @@ int mmc_go_idle(struct mmc_host *host)
>  	return err;
>  }
>  
> +static int ____mmc_poll_for_busy(struct mmc_host *host, unsigned int udelay_min,
> +				 unsigned int timeout_ms,
> +				 int (*busy_cb)(void *cb_data, bool *busy),
> +				 void *cb_data)
> +{
> +	int err;
> +	unsigned long timeout;
> +	unsigned int udelay = udelay_min, udelay_max = 32768;
> +	bool expired = false;
> +	bool busy = false;
> +
> +	timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
> +	do {
> +		/*
> +		 * Due to the possibility of being preempted while polling,
> +		 * check the expiration time first.
> +		 */
> +		expired = time_after(jiffies, timeout);
> +
> +		err = (*busy_cb)(cb_data, &busy);
> +		if (err)
> +			return err;
> +
> +		/* Timeout if the device still remains busy. */
> +		if (expired && busy) {
> +			pr_err("%s: Card stuck being busy! %s\n",
> +				mmc_hostname(host), __func__);
> +			return -ETIMEDOUT;
> +		}
> +
> +		/* Throttle the polling rate to avoid hogging the CPU. */
> +		if (busy) {
> +			usleep_range(udelay, udelay * 2);
> +			if (udelay < udelay_max)
> +				udelay *= 2;
> +		}
> +	} while (busy);
> +
> +	return 0;
> +}
> +
>  static int __mmc_send_op_cond_cb(void *cb_data, bool *busy)
>  {
>  	struct mmc_op_cond_busy_data *data = cb_data;
> @@ -232,7 +274,8 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>  	cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
>  	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
>  
> -	err = __mmc_poll_for_busy(host, 1000, &__mmc_send_op_cond_cb, &cb_data);
> +	err = ____mmc_poll_for_busy(host, 1000, MMC_OP_COND_TIMEOUT_MS,
> +				    &__mmc_send_op_cond_cb, &cb_data);
>  	if (err)
>  		return err;
>  
> -- 
> 2.17.1
> 

Hi,

thanks for the patch. 
I started with a value of 10 ms :
       err = ____mmc_poll_for_busy(host, 10, MMC_OP_COND_TIMEOUT_MS,
                                    &__mmc_send_op_cond_cb, &cb_data);

and the result was agian

[   23.349932] mmc1: Card stuck being busy! __mmc_poll_for_busy
[   23.355936] mmc1: error -110 doing runtime resume

Same with 100 ms and 500 ms.

The messages seem to come from __mmc_poll_for_busy and not ____mmc_poll_for_busy.
Yet, changing the value in the call of ____mmc_poll_for_busy to 1000 ms changed the behaviour:

       err = ____mmc_poll_for_busy(host, 1000, MMC_OP_COND_TIMEOUT_MS,
                                   &__mmc_send_op_cond_cb, &cb_data);

With this I didn't get any "stuck" errors and the board seemed stable.

Regards,
Jean Rene Dawin
