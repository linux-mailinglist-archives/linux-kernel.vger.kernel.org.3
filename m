Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6107052E8FC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347744AbiETJkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbiETJj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:39:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0050A5D672
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:39:56 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq30so13397882lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nIrxXltCmueBY34pWQ4AMY9dGbvH7DLXorjaRE3m0Bc=;
        b=F6ek65GBoWU0tPnHAwzaZB7WNP1gJTIzu7211iYqgNr0PgCbWSKQYRqdQmcIp59iFF
         M/yeFbx8fUpUxBXu1+kAbp25Fp4J3/dPYWUqeo9fvlaC9yaRa/M34jDaF2xXFFFPo+0W
         myVFfwHMdtXSucZfG3Zj1iqVIc20G3Wf17HmPMOtXu5Zi1355MLTXW/vh9fcVl2rJHUI
         Pd0yEmYhxMKbCd7LmynwZYv8MYxKORDH8NyKCKmQLEDpGLptvE0IvBK0jkXlwj5FlAwE
         lF95UQFNw6i7AYor6N43wohPg+zPFCx1Mbh+kwsbpDwR/YPOAAF49M+NGZrgWC1Nxtuq
         4IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIrxXltCmueBY34pWQ4AMY9dGbvH7DLXorjaRE3m0Bc=;
        b=6YSKnKPxKaBggoZb34a5laZ0nCilxSXLbNzRc5ialKPLGSX7NR/0mH2Nvq/o/gzzbZ
         m7nXR5r61sw5f0269szgL1ugsDIrQREMSIEDlxLvZolLLmkko8SrzNSO9UJP02hlcpqs
         EtXOMewheKVNmYA5B1Cr0VikM7bzEdIHSsZArWOZlLYttZUZEzndfJ/Zn7XY4NmqEW32
         Fqn4Fg8M6vZeSJkAYizK2XlvlV2V/bmsQIFMD0cG6iBfKmgSonqPAxWWVm3c2ZzyyhOP
         Q8sk+4ArUPhD1UDf2UWpYEioTcdkstE1MY5IIQBdFoflMDBDHQactJx27sjnq1r4VXA1
         Zqng==
X-Gm-Message-State: AOAM530vPYZyitaeEymkjxyNyZ9GWymB00eBPLWLo+jvmMdMupKhG47i
        cNwwtyaVYXTxwgQ3XiuaQyPNYQu9/rSqcRhhFsWXSA==
X-Google-Smtp-Source: ABdhPJzW84M+1Qgp5yRR/hyYidx+pFoqmn49zPcwAsl1goLonHenRJaiVr96+biBWVRxxE6uyOe/3aDt0ghvTrgRzEY=
X-Received: by 2002:a05:6512:5cb:b0:472:f7e:a5f5 with SMTP id
 o11-20020a05651205cb00b004720f7ea5f5mr6208082lfo.358.1653039595270; Fri, 20
 May 2022 02:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <1652275016-13423-1-git-send-email-quic_mkshah@quicinc.com> <1652275016-13423-7-git-send-email-quic_mkshah@quicinc.com>
In-Reply-To: <1652275016-13423-7-git-send-email-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 20 May 2022 11:39:16 +0200
Message-ID: <CAPDyKFqCdc206GX3s3PqExrp==mfJQ6m-u0F_ij_tLXbcv8G6Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] soc: qcom: rpmh-rsc: Write CONTROL_TCS with next
 timer wakeup
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        quic_lsrao@quicinc.com, quic_rjendra@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 at 15:17, Maulik Shah <quic_mkshah@quicinc.com> wrote:
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

I didn't forget to review this, but please allow me a few more days to
think a little bit more about this.

Kind regards
Uffe

> ---
>  drivers/soc/qcom/rpmh-internal.h |  3 ++
>  drivers/soc/qcom/rpmh-rsc.c      | 61 ++++++++++++++++++++++++++++++++++++++++
>  drivers/soc/qcom/rpmh.c          |  4 ++-
>  3 files changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
> index 7866bb1..39f5358 100644
> --- a/drivers/soc/qcom/rpmh-internal.h
> +++ b/drivers/soc/qcom/rpmh-internal.h
> @@ -112,6 +112,7 @@ struct rpmh_ctrlr {
>   * @tcs_wait:           Wait queue used to wait for @tcs_in_use to free up a
>   *                      slot
>   * @client:             Handle to the DRV's client.
> + * @dev:                RSC device.
>   */
>  struct rsc_drv {
>         const char *name;
> @@ -127,12 +128,14 @@ struct rsc_drv {
>         spinlock_t lock;
>         wait_queue_head_t tcs_wait;
>         struct rpmh_ctrlr client;
> +       struct device *dev;
>  };
>
>  int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
>  int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
>                              const struct tcs_request *msg);
>  void rpmh_rsc_invalidate(struct rsc_drv *drv);
> +void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv);
>
>  void rpmh_tx_done(const struct tcs_request *msg, int r);
>  int rpmh_flush(struct rpmh_ctrlr *ctrlr);
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 8e01697..25b838b 100644
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
> +       if (!drv->tcs[CONTROL_TCS].num_tcs || !drv->genpd_nb.notifier_call)
> +               return;
> +
> +       /* Set highest time when system (timekeeping) is suspended */
> +       if (system_state == SYSTEM_SUSPEND)
> +               goto exit;
> +
> +       /* Find the earliest hrtimer wakeup from online cpus */
> +       wakeup = dev_pm_genpd_get_next_hrtimer(drv->dev);
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
> @@ -1035,6 +1095,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
>         INIT_LIST_HEAD(&drv->client.batch_cache);
>
>         dev_set_drvdata(&pdev->dev, drv);
> +       drv->dev = &pdev->dev;
>
>         ret = devm_of_platform_populate(&pdev->dev);
>         if (ret && pdev->dev.pm_domain) {
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
> --
> 2.7.4
>
