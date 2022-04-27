Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C945511935
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbiD0NFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbiD0NFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:05:16 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1660522E1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:02:04 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2ebf4b91212so17556677b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S0RACex1YHTJ+EcaotG2ytIq1qh8idLDc1lxrpTPFYM=;
        b=LPG4LILxXvwmTf642SEgiBjDLvZGjS+owvYXlX3fFL80Pk+GUwO1hPJl/k7zAc2/Ly
         xDRw36YuY0vfW5VfkD1aHt6oCMPBvYQbtG2TxuzBffQhdaudzgjDL0ADII35FkTbKBsU
         ZJ/EWGSKBI+obQA48nFWbZo1AOQCIArCKApP+6UNEpLG4aPfq8RcG4vaJt0WHMS7pIVd
         TnRYmdIaUn3lJNOUUqGaYFlu6GXPYeSmegd8SF/YsKpJYzXVSJdJD6E/YFHeEHtAsyi7
         KLZKZZhHtNKN152KGKWFcePR/PtoFMKCml0yNzMmb4NBs/ambkUWCawjE48kjMV5Nx8A
         DjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0RACex1YHTJ+EcaotG2ytIq1qh8idLDc1lxrpTPFYM=;
        b=wq+tymiguxodocH/4W9+XIH5qSvhqNhBHq/sCJ/3uLxDcNBPPO8thGifis+46qjPn0
         Ux4M3sZBjXK/7hr2j+1lps7/4DKcJSQiCQyNU3ojxLB9WiVNAwaQH9trZis1Nlpj3oK4
         VCAM0OH5Z09Yk4bulWzpZz+IrY/r0oYMPemcoG10t1S38fYC7cI0M+yhHWLI/xw0Hidb
         AVNxNgteLzcE88D97tGpJHPKNVA0BCJkftj0uVbrUxvOz3fgGAsnu2ZuBuWKBvvUc2PK
         4K7hFLKEGoDnuOFvxLdPqah4crpsBuyD6/SHIMiQ7FTpzvgnWBLBu/Od1wqkL4MoAvj6
         ciGw==
X-Gm-Message-State: AOAM531TybUnNQ6AptVCFIN2yxuKPaxu8AEScFagfy0fy7CoK6v66pva
        ya4AtcoEF8t38xP1XhrAfRCnU/X+Bt4bA5WuT6S5oA==
X-Google-Smtp-Source: ABdhPJxt74YVl9/zO3ocwML4C6FJIcGgQIJEkdkH5timGk2DZI3l8oao0wnH2sabMwxlqzVZMNY4lYMUSYU33E4tabI=
X-Received: by 2002:a81:2108:0:b0:2f5:6938:b2b8 with SMTP id
 h8-20020a812108000000b002f56938b2b8mr26219124ywh.151.1651064520075; Wed, 27
 Apr 2022 06:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220427095916.17515-1-lecopzer.chen@mediatek.com>
In-Reply-To: <20220427095916.17515-1-lecopzer.chen@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Apr 2022 15:01:48 +0200
Message-ID: <CACRpkda_hpTVxKftKBqRvBtC-KN8c9NWHFJDV10TN4JOR7CQCw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] arm: kasan: support CONFIG_KASAN_VMALLOC
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux@armlinux.org.uk, andreyknvl@gmail.com,
        anshuman.khandual@arm.com, ardb@kernel.org, arnd@arndb.de,
        dvyukov@google.com, geert+renesas@glider.be, glider@google.com,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        mark.rutland@arm.com, masahiroy@kernel.org, matthias.bgg@gmail.com,
        rmk+kernel@armlinux.org.uk, ryabinin.a.a@gmail.com,
        yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 11:59 AM Lecopzer Chen
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
> and support CONFIG_VMAP_STACK with KASan.

Excellent Lecopzer,

can you put these patches into Russell's patch tracker so he can pick them?
https://www.armlinux.org.uk/developer/patches/

Yours,
Linus Walleij
