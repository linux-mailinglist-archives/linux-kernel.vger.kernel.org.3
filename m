Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EE85AAD25
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiIBLLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbiIBLLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:11:13 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFB4550A2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 04:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1662117028;
        bh=EGtbjyLDzpTVkWrfldEazAiMbJLZUSfJaD+YS6RdxSw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B5ydBUwqEYiO0W7fXnSf32TmrwU0GeDqLZrXhZlNVYCpOtsVX1rmf04VFuTiINlYg
         bR1JRKOUyxbifnSV6XBlHV/0kMsAGT0oi4g6WnTQO9yC6kHaoyW67rjhbY+dI++HQi
         I4PwikI7S9zVZYI/ovM6BltW0v1uEaz+EhZqSHUQ=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 44A5366825;
        Fri,  2 Sep 2022 07:10:27 -0400 (EDT)
Message-ID: <c9880165f0355fc3be3ec23153b43ad33e558b5d.camel@xry111.site>
Subject: Re: [PATCH 1/3] LoongArch: tools: Add relocs tool support
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Fri, 02 Sep 2022 19:10:25 +0800
In-Reply-To: <1662113335-14282-2-git-send-email-tangyouling@loongson.cn>
References: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
         <1662113335-14282-2-git-send-email-tangyouling@loongson.cn>
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

Hi Youling,

On Fri, 2022-09-02 at 18:08 +0800, Youling Tang wrote:
> This tool is based on the arch/mips/boot/tools/relocs tool.

I've dig some history of MIPS relocatable kernel
(https://lwn.net/Articles/682020/):

   * Kernel is compiled & statically linked as normal, with no position
     independent code. MIPS before R6 only has limited relative jump
     instructions so the vast majority of jumps are absolute. To compile
     the kernel position independent would introduce a highly undesireable
     overhead. Relocating the static binary gives a small startup time
     penalty but the kernel otherwise perforns normally.

Unlike (pre-r6) MIPS, LoongArch has a complete support for PIC, and
currently LoongArch toolchain always produces PIC (except, if -Wa,-mla-
{local,global}-with-abs or la.abs macros are used explicitly).

So would it be easier to review and correct the uses of "la.abs" in the
code, and make the main kernel image a real PIE?  Then we can load it
everywhere w/o any need to do relocation at load time.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
