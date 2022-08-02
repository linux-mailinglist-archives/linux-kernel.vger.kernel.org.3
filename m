Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5267758823C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiHBTDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiHBTDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:03:05 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738CC2316B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 12:03:04 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p5so18750002edi.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdZe8WkFIDKqrtIYgscLkYHRt1bx/RYV0KOkoVHZg/U=;
        b=gCYPSqJEQcsEXEg1PVpE4xVbI3EovHiB2CErLstNYEEw9Kd7e2Yoyj/dY3KraWCNXa
         jfH3FVYLKnyP3m92iKulAVVPL1h63ILHVaiWen5VR04KQB14SfbJART7GD7MZQA/wGlW
         3XLkj5PTJciEcprJKYLyMkpSYBlHZTQ8vs3qLiS9TYf/FMRO7XxqUnqJscqg8xuXopek
         Fa2UB3p5WH6DXM2KpSRPhSQBi3c0NCmOMuCoK/XBSxoYKTRETx7Fki+elejv6jKNa+sb
         VAgw3R95yNxm35jFxYLsMXZS4fJmBi2J2djAaaHrbABgD0VUczcgO40WULkHHFmJuEto
         nbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdZe8WkFIDKqrtIYgscLkYHRt1bx/RYV0KOkoVHZg/U=;
        b=myBg/m2PkDg2kacCx89+K++pygh0p2uH+JNpa2uo7aKGdytPIKygCks6IjypJKsZRn
         u4XpWhawWVr+MFTIQW51fKcOnAxHJ6l4946m/Cfm6TuNS/E6PUl1feMpG02z7ZhkNIYS
         03Yy+fg87Gm+RpLoM4+dt+VmE0zM1FHAv0geirMzeAPJAP77teH17NCwh5H/b+WUAspB
         r5tUF0iYHPdc7c4ompWsFsIincJRUlK64ZdEbiNzRjxDv8pztAHPP47w/aoPcWwec5TH
         WOBhITLeKUYlJ4iAyc8W3xnlLxcx6ZX0agBYn0dGN7YOnd2KtH+BKl/aCQDpie96vaW+
         XveA==
X-Gm-Message-State: AJIora8cv6uXmvCSlO35OQZab0KWWaItLpVP3gx/6dsewIa0zxgCo4J9
        ehFqphR3Ptza9ONrDoAWb4F+o1aieIfOECqqrBU=
X-Google-Smtp-Source: AGRyM1u/nRRxEHLE6sP2ETOr10p93ZE9ry7i/CBgAJ9Vjm+Hzy7fU1bSg/CnAiXNxTbBgwkcgA7CnrQKA2HsC53ijjw=
X-Received: by 2002:a05:6402:16:b0:43a:f435:5d07 with SMTP id
 d22-20020a056402001600b0043af4355d07mr22904421edu.420.1659466983066; Tue, 02
 Aug 2022 12:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <CANX2M5Ysmgv1b4toRxeTDiKtpJyv_-dTqsRediqd8NbT=RKObQ@mail.gmail.com>
In-Reply-To: <CANX2M5Ysmgv1b4toRxeTDiKtpJyv_-dTqsRediqd8NbT=RKObQ@mail.gmail.com>
From:   Dipanjan Das <mail.dipanjan.das@gmail.com>
Date:   Tue, 2 Aug 2022 12:02:51 -0700
Message-ID: <CANX2M5Z2LzD_Z6qgq9Avv3hygQ7LJNX+KyZOK6_5d-KZRNwfCg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in drm_gem_object_release
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     syzkaller@googlegroups.com, fleischermarius@googlemail.com,
        its.priyanka.bose@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 9:23 AM Dipanjan Das
<mail.dipanjan.das@gmail.com> wrote:
> ======================================================
> description: KASAN: use-after-free Read in drm_gem_object_release
> affected file: drivers/gpu/drm/drm_gem.c
> kernel version: 5.4.206
> kernel commit: 981f87403bb9841f1e0b7953e12a51f09a47a4f0
> git tree: upstream
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=1aab6d4187ddf667
> crash reproducer: attached
> ======================================================
> Crash log:
> ======================================================
> BUG: KASAN: use-after-free in drm_gem_object_release+0xf7/0x120
> drivers/gpu/drm/drm_gem.c:952
> ==================================================================
> BUG: KASAN: double-free or invalid-free in
> drm_gem_vram_create+0x1b7/0x1f0
> drivers/gpu/drm/drm_gem_vram_helper.c:142

We did an initial analysis for this bug and figured out the following:

If ttm_bo_init_reserved() fails, the `gbo` and `gbo->bo.base` will be
freed by ttm_buffer_object_destroy(). But then drm_gem_vram_create()
and drm_gem_vram_init() will attempt to free `gbo` and `gbo->bo.base`
again. This will result in UAF and Double Free. A similar bug (the
stack traces were a bit different) has been patched by this upstream
commit: https://github.com/torvalds/linux/commit/da62cb7230f0871c30dc9789071f63229158d261.
We applied this patch and can confirm that the repro does not trigger
the issue anymore.

-- 
Thanks and Regards,

Dipanjan
