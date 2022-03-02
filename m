Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA12C4C9F36
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbiCBIaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240121AbiCBIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:30:18 -0500
X-Greylist: delayed 534 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 00:29:33 PST
Received: from smtp2.math.uni-bielefeld.de (smtp2.math.uni-bielefeld.de [129.70.45.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03934B8B63;
        Wed,  2 Mar 2022 00:29:33 -0800 (PST)
Received: from math.uni-bielefeld.de (kvm01.math.uni-bielefeld.de [129.70.45.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by smtp2.math.uni-bielefeld.de (Postfix) with ESMTPSA id 0F2306030F;
        Wed,  2 Mar 2022 09:20:36 +0100 (CET)
Date:   Wed, 2 Mar 2022 09:20:34 +0100
From:   Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Huijin Park <huijin.park@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Subject: Re: [BUG] mmc: core: adjust polling interval for CMD1
Message-ID: <20220302082034.GA5723@math.uni-bielefeld.de>
References: <27DDB061-1235-4F4C-B6A8-F035D77AC9CF@goldelico.com>
 <CAPDyKFrz_2Vp64SUzB8CiHJLTjO8Hx8m3QEhY1VU2ksZhVEx7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFrz_2Vp64SUzB8CiHJLTjO8Hx8m3QEhY1VU2ksZhVEx7A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ulf Hansson wrote on Tue  1/03/22 14:38:
> On Thu, 17 Feb 2022 at 21:12, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >
> > Hi,
> > Jean Rene Dawin did report to me a problem on the Beagle Bone Black starting
> > with our disto kernel based on v5.17-rc1:
> >
> > >> since kernel 5.17-rc1 I noticed slower emmc performance on Beaglebone
> > >> Black, but didn't check the logs.
> > >> When I tried to run 5.17.0-rc3-letux+ it booted fine, but during IO
> > >> traffic there were messages like
> > >>
> > >> [  662.529584] mmc1: error -110 doing runtime resume
> > >> [  669.293590] mmc1: Card stuck being busy! __mmc_poll_for_busy
> > >>
> > >> [  739.076072] mmc1: Timeout waiting for hardware interrupt.
> > >> [  739.145676] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> > >> [  739.231053] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00003101
> > >> [  739.316472] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000400
> > >> [  739.401937] mmc1: sdhci: Argument:  0x00342d30 | Trn mode: 0x00000023
> > >> [  739.487439] mmc1: sdhci: Present:   0x01f70000 | Host ctl: 0x00000000
> > >> [  739.573007] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> > >> [  739.658609] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00003c07
> > >> [  739.744224] mmc1: sdhci: Timeout:   0x00000007 | Int stat: 0x00000002
> > >> [  739.829896] mmc1: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
> > >> [  739.915623] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
> > >> [  740.001394] mmc1: sdhci: Caps:      0x07e10080 | Caps_1:   0x00000000
> > >> [  740.087208] mmc1: sdhci: Cmd:       0x0000193a | Max curr: 0x00000000
> > >> [  740.173051] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
> > >> [  740.258928] mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> > >> [  740.344854] mmc1: sdhci: Host ctl2: 0x00000000
> > >> [  740.402796] mmc1: sdhci: ============================================
> > >>
> > >> and finally IO errors and a corrupted filesystem.
> > >>
> > >> 5.17.0-rc4-letux+ shows the same behaviour.
> >
> > I checked with my BeagleBoard Black (am3358) and can confirm this observation.
> > It happens only with the integrated eMMC but not with the µSD connected to
> > the other mmc interface.
> >
> > A git bisect found:
> >
> > 76bfc7ccc2fa9d382576f6013b57a0ef93d5a722 is the first bad commit
> > commit 76bfc7ccc2fa9d382576f6013b57a0ef93d5a722
> > Author: Huijin Park <huijin.park@samsung.com>
> > Date:   Thu Nov 4 15:32:31 2021 +0900
> >
> >   mmc: core: adjust polling interval for CMD1
> >
> >   In mmc_send_op_cond(), loops are continuously performed at the same
> >   interval of 10 ms.  However the behaviour is not good for some eMMC
> >   which can be out from a busy state earlier than 10 ms if normal.
> >
> >   Rather than fixing about the interval time in mmc_send_op_cond(),
> >   let's instead convert into using the common __mmc_poll_for_busy().
> >
> >   The reason for adjusting the interval time is that it is important
> >   to reduce the eMMC initialization time, especially in devices that
> >   use eMMC as rootfs.
> >
> >   Test log(eMMC:KLM8G1GETF-B041):
> >
> >   before: 12 ms (0.311016 - 0.298729)
> >   [    0.295823] mmc0: starting CMD0 arg 00000000 flags 000000c0
> >   [    0.298729] mmc0: starting CMD1 arg 40000080 flags 000000e1<-start
> >   [    0.311016] mmc0: starting CMD1 arg 40000080 flags 000000e1<-finish
> >   [    0.311336] mmc0: starting CMD2 arg 00000000 flags 00000007
> >
> >   after: 2 ms (0.301270 - 0.298762)
> >   [    0.295862] mmc0: starting CMD0 arg 00000000 flags 000000c0
> >   [    0.298762] mmc0: starting CMD1 arg 40000080 flags 000000e1<-start
> >   [    0.299067] mmc0: starting CMD1 arg 40000080 flags 000000e1
> >   [    0.299441] mmc0: starting CMD1 arg 40000080 flags 000000e1
> >   [    0.299879] mmc0: starting CMD1 arg 40000080 flags 000000e1
> >   [    0.300446] mmc0: starting CMD1 arg 40000080 flags 000000e1
> >   [    0.301270] mmc0: starting CMD1 arg 40000080 flags 000000e1<-finish
> >   [    0.301572] mmc0: starting CMD2 arg 00000000 flags 00000007
> >
> >   Signed-off-by: Huijin Park <huijin.park@samsung.com>
> >   Link: https://lore.kernel.org/r/20211104063231.2115-3-huijin.park@samsung.com
> >   Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Reverting this makes v5.17-rc[1-4] work.
> >
> > Any suggestions or fixes?
> >
> > BR and thanks,
> > Nikolaus Schaller
> >
> > Reported-by: jdawin@math.uni-bielefeld.de
> >
> 
> Thanks for reporting and bisecting!
> 
> What changed with the offending commit is two things:
> 
> 1) We are sending the CMD1 more frequently, initially in the loop in
> the __mmc_poll_for_busy. Step by step, we increase the polling period.
> 2) We may end up using a slightly shorter total timeout for polling
> time, compared to what we used before the offending commit.
> 
> Hopefully the problem is related to 2), in which case I think the
> below patch should help. Can you please give it a try?
> 
> Kind regards
> Uffe
> 
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Tue, 1 Mar 2022 14:24:21 +0100
> Subject: [PATCH] mmc: core: Extend timeout to 2s for MMC_SEND_OP_COND
> 
> It looks like the timeout for the MMC_SEND_OP_COND (CMD1) might have become
> a bit too small due to recent changes. Therefore, let's extend it to 2s,
> which is probably more inline with its previous value, to fix the reported
> timeout problems.
> 
> While at it, let's add a define for the timeout value, rather than using
> a hard-coded value for it.
> 
> Reported-by: Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Huijin Park <huijin.park@samsung.com>
> Fixes: 76bfc7ccc2fa ("mmc: core: adjust polling interval for CMD1")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/mmc_ops.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index d63d1c735335..1f57174b3cf3 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -21,6 +21,7 @@
> 
>  #define MMC_BKOPS_TIMEOUT_MS           (120 * 1000) /* 120s */
>  #define MMC_SANITIZE_TIMEOUT_MS                (240 * 1000) /* 240s */
> +#define MMC_OP_COND_TIMEOUT_MS         2000 /* 2s */
> 
>  static const u8 tuning_blk_pattern_4bit[] = {
>         0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
> @@ -232,7 +233,8 @@ int mmc_send_op_cond(struct mmc_host *host, u32
> ocr, u32 *rocr)
>         cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
>         cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
> 
> -       err = __mmc_poll_for_busy(host, 1000, &__mmc_send_op_cond_cb, &cb_data);
> +       err = __mmc_poll_for_busy(host, MMC_OP_COND_TIMEOUT_MS,
> +                                 &__mmc_send_op_cond_cb, &cb_data);
>         if (err)
>                 return err;
> 
> -- 
> 2.25.1

Hi,

thanks. But testing with this patch still gives the same errors:

[   52.259940] mmc1: Card stuck being busy! __mmc_poll_for_busy
[   52.273380] mmc1: error -110 doing runtime resume

and the system gets stuck eventually.

Regards,
Jean Rene Dawin
