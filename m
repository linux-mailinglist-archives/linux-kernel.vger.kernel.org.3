Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E5D585CFC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 05:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiGaDIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 23:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiGaDHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 23:07:53 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0EA12D08
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 20:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659236866;
        bh=TF0jSFWyAMGHxD7vH80YuqWWTONGkLEU23EKCiPfVHM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mAyrCk0Adr3RRE8YQmYdnephj8DOujy6Ysy21yP/WV/MfahmFdy4MWvlEQqWn+qWJ
         1E++YQdek+HgD0yEintVua8TV9sNoGLZeaLXuCLtKi+nbPE8PcuyNYfXHgVAVFp07e
         Rs3dtGbX6XC798oWfwszEFrDvGR6MlJ7aa6ep+v0=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id A1C276692A;
        Sat, 30 Jul 2022 23:07:44 -0400 (EDT)
Message-ID: <4df98aaebb02f8d14abd60a67cf03593588c4e39.camel@xry111.site>
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Lulu Cheng <chenglulu@loongson.cn>,
        Youling Tang <tangyouling@loongson.cn>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Sun, 31 Jul 2022 11:07:42 +0800
In-Reply-To: <CAAhV-H6jAxOx1xfa6N8F5L0Oc-sp9KimQN-Sen6YPDjnRVEMuQ@mail.gmail.com>
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
         <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn>
         <0179679b736aea7258981dec2d83107cce74dfc1.camel@xry111.site>
         <a139a8475fe295ac9f17064269cd0312dca6f96e.camel@xry111.site>
         <6b5d2188f93ed72b67a4bbb7116113f833fe1ee5.camel@xry111.site>
         <d7670b60-2782-4642-995b-7baa01779a66@loongson.cn>
         <7cad6e78014168a8906e130e1cf3809077d2bda7.camel@xry111.site>
         <1d0783b87bda3e454a111862fcc5b5faffcb16b0.camel@xry111.site>
         <00eede4b1380888a500f74b1e818bb25a550632b.camel@xry111.site>
         <CAAhV-H7WxRp4u1iBs47LN1Sj3rDBdbLv1u7EpSt0Bt4QuhFSXQ@mail.gmail.com>
         <674cb3e9-d820-016b-a210-afd37ed6e25e@loongson.cn>
         <5233653cceab9c2baf6510bd712cd53ef63e3aac.camel@xry111.site>
         <CAAhV-H6jAxOx1xfa6N8F5L0Oc-sp9KimQN-Sen6YPDjnRVEMuQ@mail.gmail.com>
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

On Sat, 2022-07-30 at 18:38 +0800, Huacai Chen wrote:
> So it has nothing to do with __visible in include/linux/compiler_attribut=
es.h?
> Or __visible is a similar thing that used by Linux kernel?

They are two different things.  __visible means an object can be
accessed by another TU mysteriously (with some way not described by C
semantics), but it does not changes the way resolve the symbol in the
same TU.
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
