Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6855C499357
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 21:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384504AbiAXUdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346897AbiAXUMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:12:13 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AF5C028C24
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:33:54 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id z25-20020a0568301db900b005946f536d85so23655074oti.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=v4SG+DqwLKzywP0j01kwA66yUj5lO6i+67mlhA4ZOG4=;
        b=R3PLwXkZGrs9ceWT1j8dt5GiDq1FaY0RBbkRiyJ5xFRj8KlGtFPGfM5BNZYqW+ONq8
         aFLQeCr3namNypqS03nc7dxIQhBmcXckv0nuEMmiDcz1gA5NSNsaiIdUN/qLotSFxGMn
         kiH4+VNO9kusFxuqPy0o4vKumCh+SifaZiN9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=v4SG+DqwLKzywP0j01kwA66yUj5lO6i+67mlhA4ZOG4=;
        b=I1vm4MPl9WYvcQYUNtwqAvbD4e//M0kszQty03K+iCaVGG1eSRu5iVfELzC0uC3ekX
         OiXWs/D43wDngjt0hT8PGkxecTjn76/BDw3LlTaajqDEyR9kJRiwjC5uLOkvrCiuN6Iu
         zcmIbzIJ6ksjhVU0+AqpLyYXeVN3l49Rp9c9NKuas4QctHel0M5pGG6BxMFyCqF795GJ
         SVbQg0x6dykfQ+0goJbKBMTfiaTNtNmtF7vRIhm/eZEUAG1pOm3koEw8kxE5jJVTg+XU
         FUv+bfV8egD0//roH4Npr35AwaJVO1sIJZZohU7XL0kxohm3t5AWGCoRq2HtDliLDlpq
         7iqQ==
X-Gm-Message-State: AOAM533pQzK7Y8NsFdgwG4mdg/H9ZJus6IWhBdqShJu10j9EpMLwXwfO
        IC1K1QAobyUWTQIde7QWwFb/RNNnx7JVf7pXUxR+fQ==
X-Google-Smtp-Source: ABdhPJxerNGg5PQ/cE7yz50qIfApJ1R8+nvofzeC6d9N1nf/CtJn5zcX/vn8QEy6PjgNpOeM0zb4zAeqFy0ndz+r+Dw=
X-Received: by 2002:a9d:410d:: with SMTP id o13mr5394273ote.77.1643052833561;
 Mon, 24 Jan 2022 11:33:53 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Jan 2022 11:33:53 -0800
MIME-Version: 1.0
In-Reply-To: <efa57fd8-d2ac-4c02-04ac-c62315b3b28c@quicinc.com>
References: <20220120204132.17875-1-quic_amelende@quicinc.com>
 <20220120204132.17875-2-quic_amelende@quicinc.com> <CAE-0n508nxF_c9pzsTaQfSi42ZGQXkqb3NyQebuMBec2DCV0KA@mail.gmail.com>
 <efa57fd8-d2ac-4c02-04ac-c62315b3b28c@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 24 Jan 2022 11:33:53 -0800
Message-ID: <CAE-0n51GUGskL17MGhk-=-dbdPU_3ChE37Hbzq6VBZc2Ge0vkA@mail.gmail.com>
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

Quoting Anjelique Melendez (2022-01-21 16:04:13)
>
>
> On 1/20/2022 8:08 PM, Stephen Boyd wrote:
> > Quoting Anjelique Melendez (2022-01-20 12:41:33)
> >> @@ -200,15 +268,21 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
> >>                         dev_err(&pdev->dev, "failed to locate regmap\n");
> >>                         return -ENODEV;
> >>                 }
> >> +       }
> >>
> >> -               error = of_property_read_u32(parent->of_node,
> >> -                                            "reg", &pwrkey->baseaddr);
> >> -       } else {
> >> -               error = of_property_read_u32(pdev->dev.of_node, "reg",
> >> -                                            &pwrkey->baseaddr);
> >> +       addr = of_get_address(regmap_node, 0, NULL, NULL);
> >> +       if (!addr) {
> >> +               dev_err(&pdev->dev, "reg property missing\n");
> >> +               return -EINVAL;
> >> +       }
> >> +       pwrkey->baseaddr = be32_to_cpu(*addr);
> > Can this hunk be split off? A new API is used and it doesn't look
> > relevant to this patch.
>
> In PMK8350 and following chips the reg property will have the pon hlos address first,
> followed by a second pon pbs address. This change is needed so that both the older chipsets
> and the newer can be used regardless of how many reg addresses are being used.

Got it, but do we ned to change to of_get_address() in this patch? I was
suggesting that the change to the new API be done first so that it's
clearer what's going on with the change in address location.

>
> >
> >> +
> >> +       if (pwrkey->data->has_pon_pbs) {
> >> +               /* PON_PBS base address is optional */
> >> +               addr = of_get_address(regmap_node, 1, NULL, NULL);
> >> +               if (addr)
> >> +                       pwrkey->pon_pbs_baseaddr = be32_to_cpu(*addr);
> >>         }
> >> -       if (error)
> >> -               return error;
> >>
> >>         pwrkey->irq = platform_get_irq(pdev, 0);
> >>         if (pwrkey->irq < 0)
> >> @@ -217,7 +291,14 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
> >>         error = regmap_read(pwrkey->regmap, pwrkey->baseaddr + PON_REV2,
> >>                             &pwrkey->revision);
> >>         if (error) {
> >> -               dev_err(&pdev->dev, "failed to set debounce: %d\n", error);
> >> +               dev_err(&pdev->dev, "failed to read revision: %d\n", error);
> > Nice error message fix!

This can be split off to a different patch as well.

> >
> >> +               return error;
> >> +       }
> >> +
> >> +       error = regmap_read(pwrkey->regmap, pwrkey->baseaddr + PON_SUBTYPE,
> >> +                           &pwrkey->subtype);
> >> +       if (error) {
> >> +               dev_err(&pdev->dev, "failed to read subtype: %d\n", error);
> >>                 return error;
> >>         }
> >>
> >> @@ -255,6 +336,12 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
> >>                 }
> >>         }
> >>
> >> +       if (pwrkey->data->needs_sw_debounce) {
> >> +               error = pm8941_pwrkey_sw_debounce_init(pwrkey);
> >> +               if (error)
> >> +                       return error;
> >> +       }
> >> +
> >>         if (pwrkey->data->pull_up_bit) {
> >>                 error = regmap_update_bits(pwrkey->regmap,
> >>                                            pwrkey->baseaddr + PON_PULL_CTL,
> >> @@ -316,6 +403,8 @@ static const struct pm8941_data pwrkey_data = {
> >>         .phys = "pm8941_pwrkey/input0",
> >>         .supports_ps_hold_poff_config = true,
> >>         .supports_debounce_config = true,
> >> +       .needs_sw_debounce = true,
> > needs_sw_debounce is always true? Why is it even an option then?
>
> As of right now the "needs_sw_debounce" property is being used for a sw work around for a hw
> problem. We anticipate that chips in the future will fix this hw problem and we would then have
> devices where needs_sw_debounce would be set to false.

Hmm ok. Why can't future chips be supported in this series? What happens
if nobody ever adds support for the new chips? We're left with this
condition that looks like dead code.
