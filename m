Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F85150BAC3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448983AbiDVO46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiDVO4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:56:54 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDC55C36E;
        Fri, 22 Apr 2022 07:54:01 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2f18982c255so88009287b3.1;
        Fri, 22 Apr 2022 07:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5f9R41E0Bd290of4rCDhR29V/pdJsF5Vk0y2KIrqB0=;
        b=LJ2pEI23WBoBu8CFL0F4+sRxxc1UY94NFFf2xjyi8Xb8escDvmcGmlYcCUwNGqG+p8
         EjKorncusfN3leVGQ3jOZCCgnd/BzsV1QqSL1WVqIZGTDBw35mEw+SIv0t5xNQIUv4cr
         BKL7UMwL+NP/6VxE0R5stOx9hEGU6APKv1VjDRvBKDZncTuJ4NLHVqMjGD01+946Bg33
         bg/8NWtX2Cz7z99qIx5ERrYauGSvtO5EIpbrqUKaf74hc4tnmmxINhSvO/wjZ2abg+aH
         pp90/vRPZoLQMMXeBddPEh0ysn6NO8j2Jg/Pyqv2hd+viMF5FcTK9PMVST52lQpnHxKq
         lyDw==
X-Gm-Message-State: AOAM533tWnF1mSE88km6ILWmkGjevpRy4KNidBcUN2Kq/PW+qB/sCUg/
        R1qAqHHOg91jX4z2d9inQSHfUUtrx50EaK/kV34=
X-Google-Smtp-Source: ABdhPJy1PiGkkd+MuQd6tHkZA93+e1SowzE8gJ+C/aSTwE9zvQcj8wPj2GuRRfxG6Y1k4OQlyMu0j44jBZlPRCoapvU=
X-Received: by 2002:a81:1096:0:b0:2ec:4a46:7e5a with SMTP id
 144-20020a811096000000b002ec4a467e5amr5400988ywq.196.1650639240745; Fri, 22
 Apr 2022 07:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220419211921.2230752-1-tony.luck@intel.com>
In-Reply-To: <20220419211921.2230752-1-tony.luck@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Apr 2022 16:53:49 +0200
Message-ID: <CAJZ5v0jd+OpnhijpH74B2+rr+52pcnZ3x05qccF7VU0Pa4L21w@mail.gmail.com>
Subject: Re: [PATCH] ACPI, APEI, EINJ: Refuse to inject into the zero page
To:     Tony Luck <tony.luck@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:19 PM Tony Luck <tony.luck@intel.com> wrote:
>
> Some validation tests dynamically inject errors into memory used by
> applications to check that the system can recover from a variety of
> poison consumption sceenarios.
>
> But sometimes the virtual address picked by these tests is mapped to
> the zero page.
>
> This causes additional unexpected machine checks as other processes that
> map the zero page also consume the poison.
>
> Disallow injection to the zero page.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
>
> ---
> I picked -EADDRINUSE as a somewhat descriptive error code distinct
> fromm -EINVAL used elsewhere in EINJ, but I'm not strongly attached
> to it. Any other non -EINVAL value would be as good an indicator to
> the validation tests that they shouldn't inject to this address.
> ---
>  drivers/acpi/apei/einj.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 95cc2a9f3e05..d4326ec12d29 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -549,6 +549,9 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>              !arch_is_platform_page(base_addr)))
>                 return -EINVAL;
>
> +       if (is_zero_pfn(base_addr >> PAGE_SHIFT))
> +               return -EADDRINUSE;
> +
>  inject:
>         mutex_lock(&einj_mutex);
>         rc = __einj_error_inject(type, flags, param1, param2, param3, param4);
> --

Applied as 5.19 material, thanks!
