Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFA65A41F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 06:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiH2EdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 00:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2EdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 00:33:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3680E3DF2C
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 21:33:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E155AB80CAC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 04:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D36C433B5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 04:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661747594;
        bh=FZIj8P9sqaU3saI0TjpqLdjlB7rVqC9somVTZ/+UVes=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ARXhfbG9u/BL4VG+54Vxe8uP78eIBgkUZKo0rD1sP/uNSzbSWYQls7foWLX/Da6vA
         bf0JAVknt40n5eUs25mih49FgJjWM7rovKNhVWr7yaM7o4UcKJVAptL9rOSs1blWpc
         9l9QidyIJ2hQFKrLXuhBx7Sdl28rMP24zq3BsKEWTbmObsnclZ6wCHdoppTZnb5wZb
         KWmXeCNUYDCr+12AVv4neIQgvPS8AvnC2cfWyQBGoMfoA0eHmqHyro06ibPlj66nen
         ktosurthPE1fIjX6/+4+OI2wBQABOyTSQQzpy638p2/44IkUn/nVC81Jcw6xrBSQCV
         8hU/tiTrEjdGg==
Received: by mail-ua1-f41.google.com with SMTP id z14so2664889uam.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 21:33:14 -0700 (PDT)
X-Gm-Message-State: ACgBeo0QBmRM/EzTEMHZz1jyiMSOfz0CHht5dQIaJWZSrx9HR0OqFAKU
        9fOSMNi/iaGrdpUzETRFuA8K3oLhC80tLdJKHu0=
X-Google-Smtp-Source: AA6agR5nj5071CokDeGSMkEclFusZJ8UcJyUoNE//3Dz+nMZr2bpvAKxv6yDdm/ja+FraUobdgejdQir2brItPsSt68=
X-Received: by 2002:ab0:2095:0:b0:39f:881e:51b6 with SMTP id
 r21-20020ab02095000000b0039f881e51b6mr1195184uak.23.1661747593553; Sun, 28
 Aug 2022 21:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220827175436.156464-1-xry111@xry111.site> <CAAhV-H4+=CqeRUUt+XPZ2Nf=1GRgHtTFyMuVu-y6QdgQgD4mog@mail.gmail.com>
 <b681993ca92d5243a73e23303ff9386ad03cf05a.camel@xry111.site>
In-Reply-To: <b681993ca92d5243a73e23303ff9386ad03cf05a.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 29 Aug 2022 12:33:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5tB9nvD8Uufn5SQ1s0hzob4TuxRTaSri-cxHVqtRH6uw@mail.gmail.com>
Message-ID: <CAAhV-H5tB9nvD8Uufn5SQ1s0hzob4TuxRTaSri-cxHVqtRH6uw@mail.gmail.com>
Subject: Re: [PATCH 0/8] LoongArch: Support toolchain with new relocation types
To:     Xi Ruoyao <xry111@xry111.site>, Arnd Bergmann <arnd@arndb.de>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

On Mon, Aug 29, 2022 at 12:17 AM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Sun, 2022-08-28 at 22:15 +0800, Huacai Chen wrote:
> > 1, You can still call it v5, even if it has changed a lot;
>
> Ok, so should I call the next version v2 or v6?
V6 is reasonable to me.

>
> Sorry for introducing such a mess :(.
>
> > 2, In my opinion, patch 4,5,7,8 can be combined, but I don't insist if
> > you have a good reason to separate.
>
> If we'll drop support for old GCC/Binutils, we can drop patch 5 (it's
> only needed for the combination of old GCC and new Binutils).  Then
> squash 4 and 7.  8 should still be standalone IMO.
Whether we can drop old toolchains depends on Arnd. :)
But even if we should support old toolchains, I think we only need to
consider new binutils + new gcc and old binutils + old gcc, I don't
think new binutils + old gcc and old binutils + new gcc can exist in
the real world.

>
> > 3, If possible, I still prefer to remove old relocation types support,
> > in order to make life easier, especially for objtool that is queued
> > for upstream.
>
> How about this?  I'm not sure if it's proper to invoke "error" in
> Makefile.
>
> ifneq ($(shell $(CC) $(srctree)/arch/loongarch/scripts/toolchain-check.c &> /dev/null -o /dev/null && echo "ok"), ok)
>   ifdef CONFIG_MODULES
>     $(error "toolchain is too old for LoongArch modular kernel")
>   endif
> endif
>
> toolchain-check.c:
>
> #if !__has_attribute(model)
> #error no model attribute
> #endif
>
> int main()
> {
>         __asm__("x:pcalau12i $t0,%pc_hi20(x)");
> }
Compared to toolchain-check.c, I prefer to change Kconfig, so please
keep the old way. But since new binutils + old gcc and old binutils +
new gcc can hardly exist, can we only check the gcc features
(explicit-relocs and has_attribute)?


Huacai
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
