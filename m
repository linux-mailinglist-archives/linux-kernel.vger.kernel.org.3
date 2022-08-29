Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841CB5A421D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiH2FEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2FEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:04:06 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C0E2C113
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 22:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661749441;
        bh=Y2IBo/yl2C21cbNjWkR6HnBtpOv/rW+e5okc63SzE28=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=P3sv8B03EouV3Ol4B/8SyCFj9bDuGenC3FLHapba4ePX9gDXNlKUXa1RIxoS7cutG
         np8fe//5yYYP/nuXnDl8V/knGoy6Q+puDybEF9QznTZhTNAC9AJIWxJgc49hM6QN/H
         EiJDe8tPTYijqqqGrcdLlfw6R8On7gRaaQimjiok=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 4863A66817;
        Mon, 29 Aug 2022 01:04:00 -0400 (EDT)
Message-ID: <927f85844e31f0563523622134b5d01af6991e60.camel@xry111.site>
Subject: Re: [PATCH 0/8] LoongArch: Support toolchain with new relocation
 types
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Mon, 29 Aug 2022 13:03:58 +0800
In-Reply-To: <CAAhV-H5tB9nvD8Uufn5SQ1s0hzob4TuxRTaSri-cxHVqtRH6uw@mail.gmail.com>
References: <20220827175436.156464-1-xry111@xry111.site>
         <CAAhV-H4+=CqeRUUt+XPZ2Nf=1GRgHtTFyMuVu-y6QdgQgD4mog@mail.gmail.com>
         <b681993ca92d5243a73e23303ff9386ad03cf05a.camel@xry111.site>
         <CAAhV-H5tB9nvD8Uufn5SQ1s0hzob4TuxRTaSri-cxHVqtRH6uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-29 at 12:33 +0800, Huacai Chen wrote:
> > If we'll drop support for old GCC/Binutils, we can drop patch 5 (it's
> > only needed for the combination of old GCC and new Binutils).=C2=A0 The=
n
> > squash 4 and 7.=C2=A0 8 should still be standalone IMO.

> Whether we can drop old toolchains depends on Arnd. :)

I'd like to prepare V6 after we can make a final decision.

> But even if we should support old toolchains, I think we only need to
> consider new binutils + new gcc and old binutils + old gcc, I don't
> think new binutils + old gcc and old binutils + new gcc can exist in
> the real world.

Generally, how do we report an unsupported configuration in kernel
building system?  With a $(error, "message") in the Makefile, or in some
header with a #error?  I don't want to leave an unsupported
configuration silently generating modules which can't be loaded by the
kernel.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
