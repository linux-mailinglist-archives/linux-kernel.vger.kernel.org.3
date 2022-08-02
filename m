Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926CE5877A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiHBHQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbiHBHPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:15:54 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351903C8E9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659424549;
        bh=9mfP6cIoYYdCa9fAZu+VoJwSH12XRoY1LZsv7VhawqM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E4o/TRhEf+SQtd2hrZg09OXjnDP28ozd1+RkjNuZzQa57YlVjTCkSdu8ieswHvGKF
         bAWDzd9o4k0Yl2B8z1BIA/hbUq4fQc+z06dScctuQSmx02UXjRyIbTN1NMUmezSrip
         D+bPRaAYooqBfhld4gImQNiva6N2J6VCeRVVOK0k=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id E0DB666A90;
        Tue,  2 Aug 2022 03:15:47 -0400 (EDT)
Message-ID: <8fd0864c3f7f3ca53db4c663215f757993ee1596.camel@xry111.site>
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
From:   Xi Ruoyao <xry111@xry111.site>
To:     Lulu Cheng <chenglulu@loongson.cn>,
        Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Jinyang He <hejinyang@loongson.cn>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Date:   Tue, 02 Aug 2022 15:15:45 +0800
In-Reply-To: <98efbf76-fbf3-f90b-82d4-bd2874088d05@loongson.cn>
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
         <d6cab26afc5829c1b93bc1cc5867ebf22f5c7f47.camel@xry111.site>
         <3c724516-50eb-cd34-5e4f-399c53a89ee4@loongson.cn>
         <98efbf76-fbf3-f90b-82d4-bd2874088d05@loongson.cn>
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

On Tue, 2022-08-02 at 14:39 +0800, Lulu Cheng wrote:

> >=20
> > =C2=A0OO, old toolchains require extra handlingg no matter how modified=
.=20
> > =C2=A0Maybe rejecting old toolchain builds is a good option as Huacai
> > said.=20

> Sorry to ask, is it possible to use an absolute address to visit here?
> Like precpu, do not use pcrel or got, and it directly uses
> four instructions to obtain the absolute address.
> The same is achieved by adding attributes in GCC.

Both GOT and ABS will work.  But to me GOT is better because it only
needs two instructions while ABS needs four.

The most troubling issue is how to support the old GCC.  It seems we
have to check GCC version and use -Wa,-mla-local-with-pcrel for GCC 12
(while I still think GOT is better but we don't have -mla-local-with-
got, *and* it will cause make every local object address load cost 4
instructions), or we just say "it's impossible to use GCC 12 to build
Linux 6.0 for LoongArch".

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
