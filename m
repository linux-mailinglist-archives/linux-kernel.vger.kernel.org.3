Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF7586848
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiHALkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiHALj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:39:59 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B55C31928
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659353997;
        bh=ukpOVj7fywYhR//4Lwx/zQHnRpAGRXXiUEyJ/bF1jLk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AFxh0lL88VO4a68vgwlsX9uTwCwmVGzGmWbsuGkK4AgZoTVOGg1ljULjvS9OrDK3M
         KEl33Ee60LYiiRoAZVzEgP7ocwp3WBEn89MtLhAgsI2yAxXtb2EGE4GB4XX3gqafJs
         eH6K/Z73Tiy2uQD2e6ACbinDYXnnp/BdJ1fuXcrE=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 2837466945;
        Mon,  1 Aug 2022 07:39:55 -0400 (EDT)
Message-ID: <d6cab26afc5829c1b93bc1cc5867ebf22f5c7f47.camel@xry111.site>
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Lulu Cheng <chenglulu@loongson.cn>
Date:   Mon, 01 Aug 2022 19:39:54 +0800
In-Reply-To: <ba5e99de-0719-af88-4d94-8860787a4251@loongson.cn>
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
         <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn>
         <0179679b736aea7258981dec2d83107cce74dfc1.camel@xry111.site>
         <a139a8475fe295ac9f17064269cd0312dca6f96e.camel@xry111.site>
         <6b5d2188f93ed72b67a4bbb7116113f833fe1ee5.camel@xry111.site>
         <d7670b60-2782-4642-995b-7baa01779a66@loongson.cn>
         <7cad6e78014168a8906e130e1cf3809077d2bda7.camel@xry111.site>
         <1d0783b87bda3e454a111862fcc5b5faffcb16b0.camel@xry111.site>
         <00eede4b1380888a500f74b1e818bb25a550632b.camel@xry111.site>
         <7512ae16-b171-d072-674f-a6b9a5e764d6@loongson.cn>
         <CAAhV-H5wSJZ2X46ySqoaJd7Z2soGcYKRNixnghmE3f3zEzyS+w@mail.gmail.com>
         <10751c9af5d45fea741e0bbed6c818ddb9db3ac3.camel@xry111.site>
         <7b1f9813-85fc-acfd-8e24-7e01469ded3a@loongson.cn>
         <ba5e99de-0719-af88-4d94-8860787a4251@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-01 at 19:28 +0800, Youling Tang wrote:

> > Actually, I really hope kernel image is in the XKVRANGE, rather
> > than being in XKPRANGE. So that we can limit kernel and modules
> > be in 4GB range. I think it will make all work normally. :-(
> >=20
>=20
> Assuming that the kernel and modules are limited to 4G, the external
> symbols will be accessed through pcrel32, which means that there is no
> need to pass the GOT table entry and there is no need for got support

We'll still need to modify GCC to use PC-rel for accessing an object in
another TU (by default, or an option to control), instead of GOT.  Or
just add support to GOT relocations here.  But anyway it will be much
easier as we won't need to handle per-CPU variables specially.
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
