Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F49E4D550E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344566AbiCJXKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243519AbiCJXKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:10:06 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAEB186BAA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:09:04 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2dc0364d2ceso75896717b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A3ve4hF4svjPt8CakjTgSzf8dJz57xeyB2FGYpaeJb0=;
        b=gEB1gLA0FdjCgPy3zWGGNa3KIy69udUJ6FIHuBowtWH0cGHtAvuuorwNBRlI3ou+8f
         H3648lFdKykLS5K8nx0H9Y7/GVWHxjI7NlAyXObVrEXHGi9I5Fslkz5zVbyzwc8Wpx09
         SVyyT1TmZNuO/rT15keSPpO5U9dXtctApeBzCeo6werhg8/MigISwVcOSAl3yH2geFfN
         USL9OcF9JIOkdVWTo3Etj+GGb9Q3jb5F+rTpG7L3rFEBl76Q2kIbx/KFxFXgpLGPuRob
         cbm2OhKEGkwsNGbrXBCbA0PhRrIgPEJ5aqLJ6z3bgmzzmq3Ep8qrvG2LrvnlMehneEgQ
         ikOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A3ve4hF4svjPt8CakjTgSzf8dJz57xeyB2FGYpaeJb0=;
        b=4CVtU2hMIt0Tb1wsgySXvxFiL8JwPaLvgxyhE3X46q/Jh85gkeBRP3SD+88C5YPjra
         0cepbUgWrZXO0BK0/AvQ5yRSRqeudTfZbi14KH2dB4ZRJBBzkjfiCewCzYE3BBzmm371
         rx8IrhA6OykaUIj3dZuff2vgLmXvOLrnoDPd2BxSrWFgU+tSXi0utbMEv3DWRdzjNgRR
         4vmB5BT8/ENGURNCeUnSW2rTHHdCM0w4du/cJhB3dIKya1gethuwi20d7Eh9SQ/iKXBs
         BcyMEOaqeOh2kOXke1/NEd63qPbRcJgMt9g78kNT+EOXxc8iPY/wn6gdRvO901AJtGhB
         bgjA==
X-Gm-Message-State: AOAM533XyCUkxAUrC72T85Y3srZOxmdPJsLSJhL4abrL83YUpxGBbDEY
        X0RYNFixNOQMczM8e/pT25IViPTWdHXwQ5jCsX0k/g==
X-Google-Smtp-Source: ABdhPJwCtSwgu9r8faG8SvIuVPWd5xwsC9EnUbfTiNTJjUCEV7M/uQ5BWwibvj8iMrw3ZivWxwgdcA5lDex+qWFYvA0=
X-Received: by 2002:a0d:db15:0:b0:2dc:b6e4:cd2f with SMTP id
 d21-20020a0ddb15000000b002dcb6e4cd2fmr6420087ywe.118.1646953743812; Thu, 10
 Mar 2022 15:09:03 -0800 (PST)
MIME-Version: 1.0
References: <20220227134726.27584-1-lecopzer.chen@mediatek.com>
In-Reply-To: <20220227134726.27584-1-lecopzer.chen@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Mar 2022 00:08:52 +0100
Message-ID: <CACRpkdasAGFDth-=eKgUFo+4c-638uo2RMbaUap6ent5mmBXbw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm: kasan: support CONFIG_KASAN_VMALLOC
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, andreyknvl@gmail.com,
        anshuman.khandual@arm.com, ardb@kernel.org, dvyukov@google.com,
        geert+renesas@glider.be, glider@google.com,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
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

On Sun, Feb 27, 2022 at 2:48 PM Lecopzer Chen
<lecopzer.chen@mediatek.com> wrote:

> Since the framework of KASAN_VMALLOC is well-developed,
> It's easy to support for ARM that simply not to map shadow of VMALLOC
> area on kasan_init.
>
> Since the virtual address of vmalloc for Arm is also between
> MODULE_VADDR and 0x100000000 (ZONE_HIGHMEM), which means the shadow
> address has already included between KASAN_SHADOW_START and
> KASAN_SHADOW_END.
> Thus we need to change nothing for memory map of Arm.
>
> This can fix ARM_MODULE_PLTS with KASan, support KASan for higmem
> and provide the first step to support CONFIG_VMAP_STACK with Arm.
>
>
> Test on
> 1. Qemu with memory 2G and vmalloc=500M for 3G/1G mapping.
> 2. Qemu with memory 2G and vmalloc=500M for 3G/1G mapping + LPAE.
> 3. Qemu with memory 2G and vmalloc=500M for 2G/2G mapping.
>
> v3:
>     rebase on 5.17-rc5.
>     Add simple doc for "arm: kasan: support CONFIG_KASAN_VMALLOC"
>     Tweak commit message.

Ater testing this with my kernel-in-vmalloc patches and some hacks, I got
the kernel booting in the VMALLOC area with KASan enabled!
See:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/log/?h=kernel-in-vmalloc-v5.17-rc1

That's a pretty serious stress test. So:
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
for the series.

I suppose you could put this into Russell's patch tracker, it's gonna be
for kernel v5.19 by now but why stress. It seems I can fix up
kernel-in-vmalloc on top and submit that for v5.19 as well.

Yours,
Linus Walleij
