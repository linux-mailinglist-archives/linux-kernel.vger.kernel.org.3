Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911554BA0EB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbiBQNVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:21:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbiBQNVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:21:35 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CE02AED95
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:21:19 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id u20so9959944lff.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HqpYw2hU4AfMpdecnlYRUtKQoN8L8CwL4tdQrOzhrbU=;
        b=LRBqktU2LOQCmUCWKN0qyj83PggUYqy2Lc8PnzwmA5idChQi2M2xA/M8JT/++U5Rh4
         Hm5L9TVlVW6zdcMkm6uuV7p7mROFpt2i/CL6P9C4bSgHpuAoX+ADnWVPNO18Di0aAx9X
         I8szoh+0W9ftm4sEBiy/zvI7g5mvWjYzbG1l7zyz8yhU7sXZSnxrPpKdrHlzv+6jeFce
         Q4UyojvMCEyhJVpn+245RhWAWr6PbYI06qlq7ev1bEaKv7WfHpJVopOrDj52gZhYxFkh
         LWQMBDCxNfHg4LcM2HaVS1vz3Exi6UxgnqWKi31v8Hg+vVD2q4xY3rY6nxfLkhUHPELc
         kw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqpYw2hU4AfMpdecnlYRUtKQoN8L8CwL4tdQrOzhrbU=;
        b=rRg1ZmXmTARmwKGoKhJNMPAYz91ifOvLB54yBF9mTyJ7Kf37trOtWhw1ed4sBP+EJC
         SKH+w++V6+MoVqajK9Nn797B/g9xZPx9pOw71wtM7EYq7E4tiX25IV+XO+XE7oeUR1IA
         TaI0AmvvEbm779w3D+Yny2crPe+zPBz/g81YN9y3PjED5KAgK53TxPpA9XIbnJX5neR/
         OzneDUQXx2afbw2InYpNMea8ycebxPa9nO9llfa3cJlfM8SdcF0OVyQIMJ/JhChsSUQF
         VG6P8gRty80Gn9b6kCRJ8aL72/lxxoRS/fZPlsScwcIJR1uPou3sSJ/jHCa470iUlByq
         AjGA==
X-Gm-Message-State: AOAM533qyFmrM5ut6deSQ7DNO3rA415dt6as/8QXXJf6yIYo6aqibwY3
        pIwWYjVPJ9Ct328XON2vuV5lHiTu5UdRfz/uIM9RlQ==
X-Google-Smtp-Source: ABdhPJxQJwQ1+7LNtV1FQqLhYGYhR1qKHRiyqfHQCaDjPzoi2G7bYLOg4pwG0lFVTZmnzQgRAaOCO5LhX1us6kgS5yw=
X-Received: by 2002:a05:6512:2241:b0:441:ce2b:18ef with SMTP id
 i1-20020a056512224100b00441ce2b18efmr2059121lfu.167.1645104077907; Thu, 17
 Feb 2022 05:21:17 -0800 (PST)
MIME-Version: 1.0
References: <20220130210210.549877-1-daniel.lezcano@linaro.org> <20220130210210.549877-6-daniel.lezcano@linaro.org>
In-Reply-To: <20220130210210.549877-6-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 14:20:41 +0100
Message-ID: <CAPDyKFrX2tR_FdJ+SVJSBGso086Db8FpZiPv5m7FwQ9PLmMEEQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] powercap/dtpm/dtpm_cpu: Add exit function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022 at 22:02, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Now that we can destroy the hierarchy, the code must remove what it
> had put in place at the creation. In our case, the cpu hotplug
> callbacks.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/powercap/dtpm_cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 71f45d2f5a60..bca2f912d349 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -299,8 +299,15 @@ static int dtpm_cpu_init(void)
>         return 0;
>  }
>
> +static void dtpm_cpu_exit(void)
> +{
> +       cpuhp_remove_state_nocalls(CPUHP_AP_ONLINE_DYN);
> +       cpuhp_remove_state_nocalls(CPUHP_AP_DTPM_CPU_DEAD);
> +}
> +
>  struct dtpm_subsys_ops dtpm_cpu_ops = {
>         .name = KBUILD_MODNAME,
>         .init = dtpm_cpu_init,
> +       .exit = dtpm_cpu_exit,
>         .setup = dtpm_cpu_setup,
>  };
> --
> 2.25.1
>
