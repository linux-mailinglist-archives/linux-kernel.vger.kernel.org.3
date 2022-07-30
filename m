Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F4F5857F7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 04:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbiG3CYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 22:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiG3CYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 22:24:30 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1EA78DF6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 19:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659147864;
        bh=lLrFDNLYFIvJDBeCh1p3b+wuDEcKqH51FlP5FJjN88I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y4XYAhliaOue8DGO7fjc9N/V+FwTUNieeLcLKX4RRHvrZC8mRG38jHaCB4EgZNlF9
         1cIpru95sOo71Mdwe8vnDZRsytKVt4I3EOiqC8PRyI3JGpECYd3HHBn3x2KBJy5Rij
         3Alp/uu/+E72BBAzX6PIk3k2tT/8koK9XEcK9FDE=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 1457E66B48;
        Fri, 29 Jul 2022 22:24:21 -0400 (EDT)
Message-ID: <1d0783b87bda3e454a111862fcc5b5faffcb16b0.camel@xry111.site>
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>, loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jinyang He <hejinyang@loongson.cn>,
        Lulu Cheng <chenglulu@loongson.cn>
Date:   Sat, 30 Jul 2022 10:24:19 +0800
In-Reply-To: <7cad6e78014168a8906e130e1cf3809077d2bda7.camel@xry111.site>
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
         <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn>
         <0179679b736aea7258981dec2d83107cce74dfc1.camel@xry111.site>
         <a139a8475fe295ac9f17064269cd0312dca6f96e.camel@xry111.site>
         <6b5d2188f93ed72b67a4bbb7116113f833fe1ee5.camel@xry111.site>
         <d7670b60-2782-4642-995b-7baa01779a66@loongson.cn>
         <7cad6e78014168a8906e130e1cf3809077d2bda7.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-30 at 01:55 +0800, Xi Ruoyao wrote:
> On Fri, 2022-07-29 at 20:19 +0800, Youling Tang wrote:
>=20
> > On 07/29/2022 07:45 PM, Xi Ruoyao wrote:
> > > Hmm... The problem is the "addresses" of per-cpu symbols are
> > > faked: they
> > > are actually offsets from $r21.=C2=A0 So we can't just load such an
> > > offset
> > > with PCALA addressing.
> > >=20
> > > It looks like we'll need to introduce an attribute for GCC to make
> > > an
> > > variable "must be addressed via GOT", and add the attribute into
> > > PER_CPU_ATTRIBUTES.
>=20
> > Yes, we need a GCC attribute to specify the per-cpu variable.
>=20
> GCC patch adding "addr_global" attribute for LoongArch:
> https://gcc.gnu.org/pipermail/gcc-patches/2022-July/599064.html
>=20
> An experiment to use it:
> https://github.com/xry111/linux/commit/c1d5d70

Correction: https://github.com/xry111/linux/commit/c1d5d708

It seems 7-bit SHA is not enough for kernel repo.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
