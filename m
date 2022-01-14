Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD72448EACD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbiANNff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbiANNfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:35:34 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF94C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:35:34 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id br17so30312412lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5sUBaMuP2JBBjZ2pVeaXsq/dxQDLGQkHgtbbTgs7bE=;
        b=B0hzFjEz7FPQrs5xD5Wv73vAcxJidL5Jk2PSxmX5rtrIv4wwECQx4Bz0i8YJk/ZMrp
         58+bu3HTviBozUsoM+vlw9Afb0JmYPpd/TQSaZH5l1pVx4ehwnJahPuK4oddwnKGyvxo
         al91ZiW6s4djZpSzZFoi6MausCHzJQkYsWmYBTAbSbAC3SxKhmih69JJhsT9a3R5ePL1
         mQBhbbNuYtgNFLz8JbRio/vNmSs2BfUXzJsnDYkMJ/tYwP5ozRjI3tIXZpESx7qo9BSm
         nVSMLHzqUSCsNvban1ZdZw9gezqN/BTRMUaDyAoJpUarlGcqTMrdL8hMCwFQys+OofUr
         m+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5sUBaMuP2JBBjZ2pVeaXsq/dxQDLGQkHgtbbTgs7bE=;
        b=ojJReOlnaeCMroSNV+Pe7p5YCvJcwk6Grui3XSNROtKQ2BA/vyvjAIp/nDaBJWMvqs
         JD6tTHzL36CzkE5LRb9CuvB/oQds0vPGfqEdGRATwU0Meua0LjN2lvC2eoeIj0I2/y50
         kB1DfbFJtgl6MWRBh62rB9tz5/kOeY/rD1Ue1KkheWdwh4HoPgVpaicU6NOMbeLXdfa4
         ov3vgzm7LDXX5I/oZRRmBBZDPXpvfl7UTNS3rwCQrhrfE5jcvncCabyOrIO00E0YqxTR
         Eptl0bvqDNwAcp1WfQYlHOLLlaKFGq/Lysp8RIftS6tkEWcy4COV8ZJQMHJA9SNu23/D
         I3wg==
X-Gm-Message-State: AOAM532PnIax9Q75PDS91GhCWlEGYJUb4nH4TdCG/aKtihiwtqaF4Ofo
        eqpZFiep9LrEF3K8ITwZ+ybmmM78W82GM0mdMGLbNQ==
X-Google-Smtp-Source: ABdhPJz6l8lg7gtQnzAg5JCRQ8lEVPATcuSkgXOfPW3yCUGw/FO8KOkLlmr4pPwAt0sftRx3h0LZ2I+7vxC+Ogfh0vY=
X-Received: by 2002:a05:6512:10d2:: with SMTP id k18mr6870737lfg.167.1642167332620;
 Fri, 14 Jan 2022 05:35:32 -0800 (PST)
MIME-Version: 1.0
References: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com> <1641749107-31979-11-git-send-email-quic_mkshah@quicinc.com>
In-Reply-To: <1641749107-31979-11-git-send-email-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Jan 2022 14:34:56 +0100
Message-ID: <CAPDyKFpm69YZ3bAnsbC-4PmzkRkFoTjwoXP99qVf6hhTKCogug@mail.gmail.com>
Subject: Re: [PATCH 10/10] soc: qcom: rpmh-rsc: Write CONTROL_TCS with next
 timer wakeup
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        quic_lsrao@quicinc.com, quic_rjendra@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2022 at 18:26, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> The next wakeup timer value needs to be set in always on domain timer
> as the arch timer interrupt can not wakeup the SoC if after the deepest
> CPUidle states the SoC also enters deepest low power state.
>
> To wakeup the SoC in such scenarios the earliest wakeup time is set in
> CONTROL_TCS and the firmware takes care of setting up its own timer in
> always on domain with next wakeup time. The timer wakes up the RSC and
> sets resources back to wake state.
>
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> ---
>  drivers/soc/qcom/rpmh-internal.h |  1 +
>  drivers/soc/qcom/rpmh-rsc.c      | 60 ++++++++++++++++++++++++++++++++++++++++
>  drivers/soc/qcom/rpmh.c          |  4 ++-
>  3 files changed, 64 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
> index 6770bbb..04789a37 100644
> --- a/drivers/soc/qcom/rpmh-internal.h
> +++ b/drivers/soc/qcom/rpmh-internal.h
> @@ -135,6 +135,7 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
>  int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
>                              const struct tcs_request *msg);
>  void rpmh_rsc_invalidate(struct rsc_drv *drv);
> +void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv);
>
>  void rpmh_tx_done(const struct tcs_request *msg, int r);
>  int rpmh_flush(struct rpmh_ctrlr *ctrlr);
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index c2a7c6c..b3b85f1 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -12,6 +12,7 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> +#include <linux/ktime.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/notifier.h>
> @@ -25,6 +26,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/wait.h>
>
> +#include <clocksource/arm_arch_timer.h>
>  #include <soc/qcom/cmd-db.h>
>  #include <soc/qcom/tcs.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> @@ -49,6 +51,14 @@
>  #define DRV_NCPT_MASK                  0x1F
>  #define DRV_NCPT_SHIFT                 27
>
> +/* Offsets for CONTROL TCS Registers */
> +#define RSC_DRV_CTL_TCS_DATA_HI                0x38
> +#define RSC_DRV_CTL_TCS_DATA_HI_MASK   0xFFFFFF
> +#define RSC_DRV_CTL_TCS_DATA_HI_VALID  BIT(31)
> +#define RSC_DRV_CTL_TCS_DATA_LO                0x40
> +#define RSC_DRV_CTL_TCS_DATA_LO_MASK   0xFFFFFFFF
> +#define RSC_DRV_CTL_TCS_DATA_SIZE      32
> +
>  /* Offsets for common TCS Registers, one bit per TCS */
>  #define RSC_DRV_IRQ_ENABLE             0x00
>  #define RSC_DRV_IRQ_STATUS             0x04
> @@ -142,6 +152,14 @@
>   *  +---------------------------------------------------+
>   */
>
> +#define USECS_TO_CYCLES(time_usecs)                    \
> +       xloops_to_cycles((time_usecs) * 0x10C7UL)
> +
> +static inline unsigned long xloops_to_cycles(unsigned long xloops)
> +{
> +       return (xloops * loops_per_jiffy * HZ) >> 32;
> +}
> +
>  static inline void __iomem *
>  tcs_reg_addr(const struct rsc_drv *drv, int reg, int tcs_id)
>  {
> @@ -757,6 +775,48 @@ static bool rpmh_rsc_ctrlr_is_busy(struct rsc_drv *drv)
>  }
>
>  /**
> + * rpmh_rsc_write_next_wakeup() - Write next wakeup in CONTROL_TCS.
> + * @drv: The controller
> + *
> + * Writes maximum wakeup cycles when called from suspend.
> + * Writes earliest hrtimer wakeup when called from idle.
> + */
> +void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv)
> +{
> +       ktime_t now, wakeup;
> +       u64 wakeup_us, wakeup_cycles = ~0;
> +       u32 lo, hi;
> +
> +       if (!drv->tcs[CONTROL_TCS].num_tcs || !drv->genpd)

Just curious, but in case you don't have a genpd attached, but are
rather using the CPU PM notifiers to determine the last CPU - in that
case, don't you need to write a new value for the timer/wakeup?

> +               return;
> +
> +       /* Set highest time when system (timekeeping) is suspended */
> +       if (system_state == SYSTEM_SUSPEND)
> +               goto exit;
> +
> +       /* Find the earliest hrtimer wakeup from online cpus */
> +       wakeup = drv->genpd->next_hrtimer;
> +
> +       /* Find the relative wakeup in kernel time scale */
> +       now = ktime_get();
> +       wakeup = ktime_sub(wakeup, now);
> +       wakeup_us = ktime_to_us(wakeup);
> +
> +       /* Convert the wakeup to arch timer scale */
> +       wakeup_cycles = USECS_TO_CYCLES(wakeup_us);
> +       wakeup_cycles += arch_timer_read_counter();
> +
> +exit:
> +       lo = wakeup_cycles & RSC_DRV_CTL_TCS_DATA_LO_MASK;
> +       hi = wakeup_cycles >> RSC_DRV_CTL_TCS_DATA_SIZE;
> +       hi &= RSC_DRV_CTL_TCS_DATA_HI_MASK;
> +       hi |= RSC_DRV_CTL_TCS_DATA_HI_VALID;
> +
> +       writel_relaxed(lo, drv->base + RSC_DRV_CTL_TCS_DATA_LO);
> +       writel_relaxed(hi, drv->base + RSC_DRV_CTL_TCS_DATA_HI);
> +}
> +
> +/**
>   * rpmh_rsc_cpu_pm_callback() - Check if any of the AMCs are busy.
>   * @nfb:    Pointer to the notifier block in struct rsc_drv.
>   * @action: CPU_PM_ENTER, CPU_PM_ENTER_FAILED, or CPU_PM_EXIT.
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index 01765ee..3a53ed9 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -450,7 +450,7 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
>
>         if (!ctrlr->dirty) {
>                 pr_debug("Skipping flush, TCS has latest data.\n");
> -               goto exit;
> +               goto write_next_wakeup;
>         }
>
>         /* Invalidate the TCSes first to avoid stale data */
> @@ -479,6 +479,8 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
>
>         ctrlr->dirty = false;
>
> +write_next_wakeup:
> +       rpmh_rsc_write_next_wakeup(ctrlr_to_drv(ctrlr));
>  exit:
>         spin_unlock(&ctrlr->cache_lock);
>         return ret;

Kind regards
Uffe
