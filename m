Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B3C4CD104
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbiCDJ3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiCDJ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:29:05 -0500
Received: from smtp2.math.uni-bielefeld.de (smtp2.math.uni-bielefeld.de [129.70.45.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5112A154D24;
        Fri,  4 Mar 2022 01:28:16 -0800 (PST)
Received: from math.uni-bielefeld.de (kvm01.math.uni-bielefeld.de [129.70.45.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by smtp2.math.uni-bielefeld.de (Postfix) with ESMTPSA id 81F6760179;
        Fri,  4 Mar 2022 10:28:12 +0100 (CET)
Date:   Fri, 4 Mar 2022 10:28:11 +0100
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
Message-ID: <20220304092811.GA20284@math.uni-bielefeld.de>
References: <27DDB061-1235-4F4C-B6A8-F035D77AC9CF@goldelico.com>
 <CAPDyKFrz_2Vp64SUzB8CiHJLTjO8Hx8m3QEhY1VU2ksZhVEx7A@mail.gmail.com>
 <20220302082034.GA5723@math.uni-bielefeld.de>
 <6715A5BE-CA64-4A3D-8EE5-5BEEB63F268A@goldelico.com>
 <CAPDyKFqMs6FsJHVOoVmZxzBPgUdLoqa-xeLfvkQi1pn=8k1h6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqMs6FsJHVOoVmZxzBPgUdLoqa-xeLfvkQi1pn=8k1h6Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ulf Hansson wrote on Thu  3/03/22 11:40:
> On Wed, 2 Mar 2022 at 10:40, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> 
> Alright, it starts to sound like we might need a revert (or at least a
> way to restore the previous behaviour) - even if that would just paper
> over the real problem. The real problem is more likely related to how
> the host driver manages restoring of the power to the card, which
> happens when runtime resuming it.
> 
> In any case, just to make sure the loop timeout itself isn't the
> problem, can you run the below debug patch please? The intent is to
> figure out how long the worst case timeout is, when it's working with
> CMD1. As soon as the timeout exceeds the worst case, there is a
> message printed to the log.
> 
> The below patch is based upon that the offending commit has been reverted.
> 
> Kind regards
> Uffe
> 
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Thu, 3 Mar 2022 11:00:04 +0100
> Subject: [PATCH] mmc: core: DEBUG - Measure and log worst case CMD1 loop
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/mmc_ops.c | 11 +++++++++++
>  include/linux/mmc/host.h   |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 9946733a34c6..3f03d9e8a3a4 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -177,11 +177,15 @@ int mmc_send_op_cond(struct mmc_host *host, u32
> ocr, u32 *rocr)
>  {
>         struct mmc_command cmd = {};
>         int i, err = 0;
> +       s64 cmd1_ms;
> +       ktime_t time_start;
> 
>         cmd.opcode = MMC_SEND_OP_COND;
>         cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
>         cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
> 
> +       time_start = ktime_get();
> +
>         for (i = 100; i; i--) {
>                 err = mmc_wait_for_cmd(host, &cmd, 0);
>                 if (err)
> @@ -211,6 +215,13 @@ int mmc_send_op_cond(struct mmc_host *host, u32
> ocr, u32 *rocr)
>                         cmd.arg = cmd.resp[0] | BIT(30);
>         }
> 
> +       cmd1_ms = ktime_to_ms(ktime_sub(ktime_get(), time_start));
> +       if (!err && cmd1_ms > host->cmd1_ms) {
> +               pr_warn("%s: CMD1 timeout increased to %lld ms, loop=%d\n",
> +                       mmc_hostname(host), cmd1_ms, i);
> +               host->cmd1_ms = cmd1_ms;
> +       }
> +
>         if (rocr && !mmc_host_is_spi(host))
>                 *rocr = cmd.resp[0];
> 
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 7afb57cab00b..c2ca3bb05620 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -301,6 +301,7 @@ struct mmc_host {
>         unsigned int            f_min;
>         unsigned int            f_max;
>         unsigned int            f_init;
> +       s64                     cmd1_ms;
>         u32                     ocr_avail;
>         u32                     ocr_avail_sdio; /* SDIO-specific OCR */
>         u32                     ocr_avail_sd;   /* SD-specific OCR */
> -- 
> 2.25.1

Hi,

thanks. With this patch applied with reverted 76bfc7ccc2fa9d382576f6013b57a0ef93d5a722
I don't get the "stuck" errors in __mmc_poll_for_busy and only one message of

[    1.095194] mmc1: CMD1 timeout increased to 64 ms, loop=98

Regards,
Jean Rene Dawin


