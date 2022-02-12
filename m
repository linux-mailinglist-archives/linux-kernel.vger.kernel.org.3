Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5C44B3837
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 22:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiBLV0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 16:26:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiBLV0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 16:26:39 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD68388
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 13:26:34 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id j2so35332551ybu.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 13:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ziBy4m282LSVlv+vy1G9xp+F8+soJK7oajWOwPn3S1I=;
        b=YOy7lPzPDyyEG9MkBWmH6IaP1jnwPEBPtTcZKWn5yyuUlOkrLzGZoO5FkmJbHJuGVl
         r5/WepoeLuAxlrJl1Dg4xGxD6iFdBkyodCLDNNX3++qjqdqvv0UF+5x9Ilbh9vthE2S/
         hofBKb1jdQVm1geygmv8iWqHTGs4Gh0u2Dpy7AAypEyomq+BNYVdsGaZ9UfewiHUC4YD
         UilJgaoB3hyLkQbVsLb8NStarnLnW0FNZMetja0HrWVDw/bBb0/fGv2QxYbA7AgHK7ph
         Hm95LQcyUN+EB0Dk+Shqk9tB9kT3KKr/IVd/MIZ1skhJWSa8olPFZ57vuByBUtuOqIft
         fZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ziBy4m282LSVlv+vy1G9xp+F8+soJK7oajWOwPn3S1I=;
        b=avFsjxOhj74M2q51aBdtuHuSp29K59QkOGz1RfS5IVXbNEij3se6NuqnqbqxcLJEo3
         CCq0EvcglG9B+MDRt/uo2esOEwNoT7rtbKq50hKUHNGwmwnMseEX3+e2rl981s1q698x
         2/oIjL2V6dMh3Y84sbdDHH1PT5J9Z9Wef7Rkup3lOUkbBGSDoQJO5n3T/Y3B9Jo+zqE7
         la0vtkHZzDIS6TexQ+c5o4SpkSbGUZaeUuENxfAZRgIPgA7A8PVR6RVBJq3nA8N0boyO
         YxaoUW6ncVFk1+9NWWrQiNLPJx/LumTz3W8nnyUqBQoH/P3T9v1fwV4z5QZxtBfAeK6T
         ZcHQ==
X-Gm-Message-State: AOAM533OOqc9l7SYKShPHGQhOenXgiH5sA2V31+8nY8tZNvXEMDtuzqY
        pnD9YyohWJmRVRrSjWi4yjnNzTPQKcnPlQ8MEPPykQ==
X-Google-Smtp-Source: ABdhPJxjDDls1xq3V8e22OPbjg7KhpK5WhAzN90SjbTjoGzOlcneh3H8OfzX96jFQW3WJ6Ntu6lHrhBpcvg5yZ81JSY=
X-Received: by 2002:a05:6902:247:: with SMTP id k7mr6803041ybs.322.1644701193652;
 Sat, 12 Feb 2022 13:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20220212074747.10849-1-lecopzer.chen@mediatek.com> <20220212074747.10849-2-lecopzer.chen@mediatek.com>
In-Reply-To: <20220212074747.10849-2-lecopzer.chen@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Feb 2022 22:26:21 +0100
Message-ID: <CACRpkdYDg3saLpfHg=R1kYpnC_BBNgBbe7un-B4e8bgDYPq1Fg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm: kasan: support CONFIG_KASAN_VMALLOC
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andreyknvl@gmail.com, anshuman.khandual@arm.com, ardb@kernel.org,
        arnd@arndb.de, dvyukov@google.com, geert+renesas@glider.be,
        glider@google.com, kasan-dev@googlegroups.com,
        linux@armlinux.org.uk, lukas.bulwahn@gmail.com,
        mark.rutland@arm.com, masahiroy@kernel.org, matthias.bgg@gmail.com,
        rmk+kernel@armlinux.org.uk, ryabinin.a.a@gmail.com,
        yj.chiang@mediatek.com
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

Hi Lecopzer,

thanks for working on this! I need this support too.

On Sat, Feb 12, 2022 at 8:47 AM Lecopzer Chen
<lecopzer.chen@mediatek.com> wrote:

> Simply make shadow of vmalloc area mapped on demand.
>
> This can fix ARM_MODULE_PLTS with KASAN and provide first step
> to support CONFIG_VMAP_STACK in ARM.
>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>

(...)

> -       kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
> +       if (!IS_ENABLED(CONFIG_KASAN_VMALLOC))
> +               kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
> +                                           kasan_mem_to_shadow((void *)VMALLOC_END));
> +
> +       kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_END),
>                                     kasan_mem_to_shadow((void *)-1UL) + 1);

Where is this actually mapped?

Can you print out where
kasan_mem_to_shadow((void *)VMALLOC_START)
kasan_mem_to_shadow((void *)VMALLOC_END)
as well as KASAN_SHADOW_START and KASAN_SHADOW_END
points?

When I looked into this getting the shadow memory between
KASAN_SHADOW_START and KASAN_SHADOW_END
seemed like the big problem since this is static, so how is Kasan
solving this now?

Please patch the picture in
include/asm/kasan_def.h
and the info in
Documentation/arm/memory.rst
so it clearly reflects where VMALLOC is shadowed.

Yours,
Linus Walleij
