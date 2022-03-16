Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C8A4DB94B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347769AbiCPU0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346326AbiCPU0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:26:02 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9CC2C100
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:24:47 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b189so2824920qkf.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivPqLyiNJbnmJk4hxBVjVwg3q4Q1FQmH/sEVySOJZBA=;
        b=l3sm7SDMmEOTusOKnBZMsCiPIMD62w6xc8H5g36QNSKU64kg3uK6rKuNYHwnyHvee3
         vjADlXIj187GklEXa/0ioE+lTl0Wnku6ATX9T/1iyRujJ65k3/hyaowS9+W/ZPPSDs5i
         sEWCYPD0dA7PDny7HOwkV65vKCMFcuaWmNSEs/jB9oyo0dFx1ErFNeeRd755/mHP6Uw5
         9mBf+D2qonlRg2tuGv5nlhLXrOLmwgDSC9BaehHl4AuojRjaggs8qMdAVAz1mDd114nT
         NQ9Z3zou3lO5w6oN/4rQ0/A51xGDEjKJTKV2JJArXf30iD1sglK3paYigUNXj5go6mxW
         4WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivPqLyiNJbnmJk4hxBVjVwg3q4Q1FQmH/sEVySOJZBA=;
        b=iIRg2DKmNYjN1CT3olU6QD3ePPgX1SC34yQIOWyX4SwGiKYcotw16z255o7penUu1M
         2Xmp5uzWTc6i9GUKShEKCUKCl14IzSZUJR5wKd6/ANzMQHII2y/BaqF5Tw1kok+3ey9Y
         HujkaQ+Jd56cVWVT8aDT1Bfw5VHRIZ1ZYmg+VdHPKqedGs6VJIRZ8B5429k4sNU8XRwy
         kAIp978iOyOZP7piXkyBEuNZjSCW4fnc9nhv24Rr0ZKMErTdQLEfdssLzkelj4dj0UJ/
         4zxqTec7aAyt+w4hmqT/vx/+zadlm7N1O8L6Ti42vMD1nc3E5P6RX2HHBUMVOlBW1V2D
         A46g==
X-Gm-Message-State: AOAM531A+DLUljo87PVefLCba3q5UV81DaE1fKvwHZTp5aDvEEO/Ajy2
        XHoidBZBk8tEZzDyFSLerCf0v0i7IxXebxDkQv+gSA==
X-Google-Smtp-Source: ABdhPJzqwlApxyq7lsWK+22acdlSBDDtBs7AEx7TtXUuEivO4VgVtHuDW20tK1Qk+3mgq1yJYe1/hzvMNuILSgh/WQA=
X-Received: by 2002:a05:620a:28c7:b0:67d:6d4e:16ee with SMTP id
 l7-20020a05620a28c700b0067d6d4e16eemr965648qkp.59.1647462286423; Wed, 16 Mar
 2022 13:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220316180322.88132-1-bjorn.andersson@linaro.org>
In-Reply-To: <20220316180322.88132-1-bjorn.andersson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 16 Mar 2022 23:24:35 +0300
Message-ID: <CAA8EJpotanjL_EHYr1-YQAXDOT--HGhGW2RH-0fO5189CEpB1Q@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/qcom/lmh: Fix irq handler return value
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 16 Mar 2022 at 21:01, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> After enough invocations the LMh irq is eventually reported as bad, because the
> handler doesn't return IRQ_HANDLED, fix this.
>
> Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/thermal/qcom/lmh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
> index c7f91cbdccc7..af9f0872614f 100644
> --- a/drivers/thermal/qcom/lmh.c
> +++ b/drivers/thermal/qcom/lmh.c
> @@ -45,7 +45,7 @@ static irqreturn_t lmh_handle_irq(int hw_irq, void *data)
>         if (irq)
>                 generic_handle_irq(irq);
>
> -       return 0;
> +       return IRQ_HANDLED;
>  }
>
>  static void lmh_enable_interrupt(struct irq_data *d)
> --
> 2.33.1
>


-- 
With best wishes
Dmitry
