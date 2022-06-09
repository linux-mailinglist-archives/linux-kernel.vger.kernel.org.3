Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4EA545428
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345436AbiFIS3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345423AbiFIS3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:29:31 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21818FD36B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:29:31 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id n11so3135903iod.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XvsbFBsXbCJC8twXzpRgm1jbeXhuSUvfjaB5kCcvYXE=;
        b=qR91jK00NZklYiGIq5wl0kOBTG1kFUN8YrsQ6zJs5SkLuWUDNLC9UjraAArv1hI8g4
         QFoAd6OOXKkGgmDfvJ2mCI2dIr3S13IFdLr95AnKcNSd3Wu7ZW7ABKq/gVCgjdLHPUN2
         FJ2BD2E5J48eXjR/R4SgNpYHlDlmFMCEHtHyrrOXWIwR7EUG0tXT/tqe/IX9KmosDEzy
         7RCQ3fpTgJbmHaraJLmcb1UB14N0yk2qtVauT9Jiqtv88tgjwPAk3Zx3MhJHXwffhP3D
         Pf9/0BK+LhS9Z0E+q9z0q/qwcvM7lraHpcULhaeH2syVlMcktPG2Jv5Y+aGOzcqP8iTw
         nsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvsbFBsXbCJC8twXzpRgm1jbeXhuSUvfjaB5kCcvYXE=;
        b=Qv/iQ67308W382FEDAUoDxJ5yOxrm5iQzrb+O4Syus+4m0cgHLwRjYiI4/o5KqWj28
         xU44NjdcIpezAidYSHx25rbHCvGU2fa6BNw89AqgH/YNBOvSfxrHLs2kJXoycmNHbSJ7
         fyBxwk6jtT32bnzC/RuZcXwYImv3Uft3nY/apmUrgxtaYktL2y5S5SNCoPox5tIqGmoU
         Eckg3Es+9NXOdrs6km0NX9RICHSTKW0TU4b4QLvBmWozVSDptc4QBHyksJDmmcSWBhk1
         VYqas+hZyQrsfG0OfcAzcaIipiCWg37Mv96DS4DHJ0g/D7IgwaCHoLsy87rTpAnkCuPp
         GOsA==
X-Gm-Message-State: AOAM533PaA78wGTCZUvCYIOCoRbEE+RtV41txkFGWxAzLwFRoRdoZeK7
        9rXuT4G7zoSye0jAXvgbMoIy9rZfxAWv4Xf1dlw=
X-Google-Smtp-Source: ABdhPJyJ8xKT+X4cczqKHBhJzKVse/D5FvTEHBbAyGIGpyXqxb6AR8fhpkySM7vz14b4mydke0XbZ+In1zi15AQCyPg=
X-Received: by 2002:a05:6638:22cf:b0:331:a5b9:22f2 with SMTP id
 j15-20020a05663822cf00b00331a5b922f2mr12558649jat.218.1654799370610; Thu, 09
 Jun 2022 11:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220607033122.256388-1-kunyu@nfschina.com>
In-Reply-To: <20220607033122.256388-1-kunyu@nfschina.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 9 Jun 2022 20:29:20 +0200
Message-ID: <CA+fCnZd-JS2tdojpNigt9brcH=ZX78Pe3AB-wwc8o+3UNnGuJQ@mail.gmail.com>
Subject: Re: [PATCH] arm: create_mapping function to remove unused return values
To:     Li kunyu <kunyu@nfschina.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux@armlinux.org.uk, kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 5:31 AM Li kunyu <kunyu@nfschina.com> wrote:
>
> Change the return value to void to reduce eax register execution.
>
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  arch/arm/mm/kasan_init.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
> index 5ad0d6c56d56..db2068329985 100644
> --- a/arch/arm/mm/kasan_init.c
> +++ b/arch/arm/mm/kasan_init.c
> @@ -187,7 +187,7 @@ static void __init clear_pgds(unsigned long start,
>                 pmd_clear(pmd_off_k(start));
>  }
>
> -static int __init create_mapping(void *start, void *end)
> +static void __init create_mapping(void *start, void *end)
>  {
>         void *shadow_start, *shadow_end;
>
> @@ -199,7 +199,6 @@ static int __init create_mapping(void *start, void *end)
>
>         kasan_pgd_populate((unsigned long)shadow_start & PAGE_MASK,
>                            PAGE_ALIGN((unsigned long)shadow_end), false);
> -       return 0;
>  }
>
>  void __init kasan_init(void)
> --
> 2.18.2

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
