Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362A34958C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 05:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbiAUEIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 23:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiAUEIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 23:08:15 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A37C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 20:08:15 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id q186so11961161oih.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 20:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=7Kn05henpg5pbL6jUmiTf8Wb4r1PXGs3Ie4dJfSb7xM=;
        b=CVb7A/h3inhfWvli9MZEAAUchbGrGGtbRcRlSTmNLWvEUYVCsiyJAAVnpDmkY3qPk4
         ouE4WBbntnUEyyOIE/QdxIWmhk/IabEkD/LkaAh1merrEO1Qn0JmbZ+fXVy2giAN2KdG
         WI2TP8vpXsy+Zhfn60nzicWNnuuDLLqOGq1oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=7Kn05henpg5pbL6jUmiTf8Wb4r1PXGs3Ie4dJfSb7xM=;
        b=4xch77g5Uqg4J0SpRSSaBJelt11Z4zi9zKhgSqYvPzySOlSQ9ffNTi6yAS4yXY+ap7
         k0Mdf4JANRXJZJGmIFLb9ldYuZTswbpvkQOYGZUKopfCWne37iEpWAuJSb2ZCpthCEdw
         OVAwZv21NWJp+NeknaJMwxLcLLjpaxzhyeKZzVFVDwpHq0phOQZpoLk+drnITcegQ/29
         YpEYmTxyZK7MAu6QOEmEh1emAi8U89/fLPMZtm9yMPfVR1QdlhhzWpmZNVcqLTmhx4LI
         ux6hJTLxbWVIzq3bwP/UTdNNzTfqiwgeVqGJ9WnTz/wGKZG3ufRySTOmTcdkFeDdgmjh
         ZDWA==
X-Gm-Message-State: AOAM533pxP4KKNkhwUGdMcN7Fa2KAatKhc5wWMdKsKnyE5GMLW70AhZf
        9Tp1ZmKy3Ir+0VFGSiDPau3iugw4NiLMl2GAp1u+rQ==
X-Google-Smtp-Source: ABdhPJzHOQhOvtVQ00p9naRyc70i/YMRXtUEJognG5vEVTXrGPIlc9qTKQRuxCRMq25sUcnx1qBsmtgWWyuruLqtcWo=
X-Received: by 2002:aca:f241:: with SMTP id q62mr1848226oih.64.1642738094606;
 Thu, 20 Jan 2022 20:08:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Jan 2022 20:08:13 -0800
MIME-Version: 1.0
In-Reply-To: <20220120204132.17875-2-quic_amelende@quicinc.com>
References: <20220120204132.17875-1-quic_amelende@quicinc.com> <20220120204132.17875-2-quic_amelende@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 20 Jan 2022 20:08:13 -0800
Message-ID: <CAE-0n508nxF_c9pzsTaQfSi42ZGQXkqb3NyQebuMBec2DCV0KA@mail.gmail.com>
Subject: Re: [PATCH 1/3] input: misc: pm8941-pwrkey: add software key press
 debouncing support
To:     Anjelique Melendez <quic_amelende@quicinc.com>,
        dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, collinsd@codeaurora.org,
        bjorn.andersson@linaro.org, skakit@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anjelique Melendez (2022-01-20 12:41:33)
> From: David Collins <collinsd@codeaurora.org>
>
> On certain PMICs, an unexpected assertion of KPDPWR_DEB (the
> positive logic hardware debounced power key signal) may be seen
> during the falling edge of KPDPWR_N (i.e. a power key press) when
> it occurs close to the rising edge of SLEEP_CLK.  This then
> triggers a spurious KPDPWR interrupt.
>
> Handle this issue by adding software debouncing support to ignore
> key events that occur within the hardware debounce delay after the
> most recent key release event.
>
> Change-Id: Ifa3809935c01aab9078ba2302397bc9ebf390021

Please remove change-id when upstreaming.

> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
> diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
> index 33609603245d..b912ce00ce1c 100644
> --- a/drivers/input/misc/pm8941-pwrkey.c
> +++ b/drivers/input/misc/pm8941-pwrkey.c
> @@ -126,19 +144,65 @@ static irqreturn_t pm8941_pwrkey_irq(int irq, void *_data)
>         struct pm8941_pwrkey *pwrkey = _data;
>         unsigned int sts;
>         int error;
> +       u64 elapsed_us;
> +
> +       if (pwrkey->sw_debounce_time_us) {
> +               elapsed_us = ktime_us_delta(ktime_get(),
> +                                           pwrkey->last_release_time);
> +               if (elapsed_us < pwrkey->sw_debounce_time_us) {

Perhaps storing last_release_time + sw_debounce_time_us via
ktime_add_us() in the struct would be better. Then this line would be

	if (ktime_before(debounce_end, ktime_get()))

and we'd avoid a division when converting to microseconds to compare
time.

> +                       dev_dbg(pwrkey->dev, "ignoring key event received after %llu us, debounce time=%u us\n",
> +                               elapsed_us, pwrkey->sw_debounce_time_us);
> +                       return IRQ_HANDLED;
> +               }
> +       }
>
>         error = regmap_read(pwrkey->regmap,
>                             pwrkey->baseaddr + PON_RT_STS, &sts);

Nitpick: I'd prefer this be on one line. And 'ret' or 'err' be used as
it's shorter.

>         if (error)
>                 return IRQ_HANDLED;
>
> -       input_report_key(pwrkey->input, pwrkey->code,
> -                        sts & pwrkey->data->status_bit);
> +       sts &= pwrkey->data->status_bit;
> +
> +       if (pwrkey->sw_debounce_time_us && !sts)
> +               pwrkey->last_release_time = ktime_get();
> +
> +       input_report_key(pwrkey->input, pwrkey->code, sts);
>         input_sync(pwrkey->input);
>
>         return IRQ_HANDLED;
>  }
>
> +static int pm8941_pwrkey_sw_debounce_init(struct pm8941_pwrkey *pwrkey)
> +{
> +       unsigned int val, addr;
> +       int error;
> +
> +       if (pwrkey->data->has_pon_pbs && !pwrkey->pon_pbs_baseaddr) {
> +               dev_err(pwrkey->dev, "PON_PBS address missing, can't read HW debounce time\n");
> +               return 0;
> +       }
> +
> +       if (pwrkey->pon_pbs_baseaddr)
> +               addr = pwrkey->pon_pbs_baseaddr + PON_DBC_CTL;
> +       else
> +               addr = pwrkey->baseaddr + PON_DBC_CTL;
> +       error = regmap_read(pwrkey->regmap, addr, &val);
> +       if (error)
> +               return error;
> +
> +       if (pwrkey->subtype >= PON_SUBTYPE_GEN2_PRIMARY)
> +               pwrkey->sw_debounce_time_us = 2 * USEC_PER_SEC /
> +                                               (1 << (0xf - (val & 0xf)));
> +       else
> +               pwrkey->sw_debounce_time_us = 2 * USEC_PER_SEC /
> +                                               (1 << (0x7 - (val & 0x7)));

Can we have one more local variable like 'mask' or 'offset'. Then the
code would be easier to read

	if (pwrkey->subtype >= PON_SUBTYPE_GEN2_PRIMARY)
		mask = 0xf;
	else
		mask = 0x7
	
	pwrkey->sw_debounce_time_us = 2 * USEC_PER_SEC / (1 << mask - (val & 0x7));

> +
> +       dev_dbg(pwrkey->dev, "SW debounce time = %u us\n",
> +               pwrkey->sw_debounce_time_us);
> +
> +       return 0;
> +}
> +
>  static int __maybe_unused pm8941_pwrkey_suspend(struct device *dev)
>  {
>         struct pm8941_pwrkey *pwrkey = dev_get_drvdata(dev);
> @@ -167,6 +231,8 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>         struct pm8941_pwrkey *pwrkey;
>         bool pull_up;
>         struct device *parent;
> +       struct device_node *regmap_node;
> +       const __be32 *addr;
>         u32 req_delay;
>         int error;
>
> @@ -188,8 +254,10 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>         pwrkey->data = of_device_get_match_data(&pdev->dev);
>
>         parent = pdev->dev.parent;
> +       regmap_node = pdev->dev.of_node;
>         pwrkey->regmap = dev_get_regmap(parent, NULL);
>         if (!pwrkey->regmap) {
> +               regmap_node = parent->of_node;
>                 /*
>                  * We failed to get regmap for parent. Let's see if we are
>                  * a child of pon node and read regmap and reg from its
> @@ -200,15 +268,21 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>                         dev_err(&pdev->dev, "failed to locate regmap\n");
>                         return -ENODEV;
>                 }
> +       }
>
> -               error = of_property_read_u32(parent->of_node,
> -                                            "reg", &pwrkey->baseaddr);
> -       } else {
> -               error = of_property_read_u32(pdev->dev.of_node, "reg",
> -                                            &pwrkey->baseaddr);
> +       addr = of_get_address(regmap_node, 0, NULL, NULL);
> +       if (!addr) {
> +               dev_err(&pdev->dev, "reg property missing\n");
> +               return -EINVAL;
> +       }
> +       pwrkey->baseaddr = be32_to_cpu(*addr);

Can this hunk be split off? A new API is used and it doesn't look
relevant to this patch.

> +
> +       if (pwrkey->data->has_pon_pbs) {
> +               /* PON_PBS base address is optional */
> +               addr = of_get_address(regmap_node, 1, NULL, NULL);
> +               if (addr)
> +                       pwrkey->pon_pbs_baseaddr = be32_to_cpu(*addr);
>         }
> -       if (error)
> -               return error;
>
>         pwrkey->irq = platform_get_irq(pdev, 0);
>         if (pwrkey->irq < 0)
> @@ -217,7 +291,14 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>         error = regmap_read(pwrkey->regmap, pwrkey->baseaddr + PON_REV2,
>                             &pwrkey->revision);
>         if (error) {
> -               dev_err(&pdev->dev, "failed to set debounce: %d\n", error);
> +               dev_err(&pdev->dev, "failed to read revision: %d\n", error);

Nice error message fix!

> +               return error;
> +       }
> +
> +       error = regmap_read(pwrkey->regmap, pwrkey->baseaddr + PON_SUBTYPE,
> +                           &pwrkey->subtype);
> +       if (error) {
> +               dev_err(&pdev->dev, "failed to read subtype: %d\n", error);
>                 return error;
>         }
>
> @@ -255,6 +336,12 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       if (pwrkey->data->needs_sw_debounce) {
> +               error = pm8941_pwrkey_sw_debounce_init(pwrkey);
> +               if (error)
> +                       return error;
> +       }
> +
>         if (pwrkey->data->pull_up_bit) {
>                 error = regmap_update_bits(pwrkey->regmap,
>                                            pwrkey->baseaddr + PON_PULL_CTL,
> @@ -316,6 +403,8 @@ static const struct pm8941_data pwrkey_data = {
>         .phys = "pm8941_pwrkey/input0",
>         .supports_ps_hold_poff_config = true,
>         .supports_debounce_config = true,
> +       .needs_sw_debounce = true,

needs_sw_debounce is always true? Why is it even an option then?

> +       .has_pon_pbs = false,
>  };
>
>  static const struct pm8941_data resin_data = {
