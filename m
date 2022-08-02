Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530B9587519
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiHBBjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiHBBjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:39:06 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1805B7F9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659404345;
        bh=m4BhdzwzC7+bHFGqo3nqyUy3vhOiVXHqEDhohjjf7kI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZyUXSJEWhNXreu/jLfQVP1YELVdmP61ctovqsyTlamLLDb0fz+4aZafgylO7f09K9
         dm7Fk+oXu0Cx8gTk15U3H5jqsHH88r+WPx5ODAAq4FG32DzKuwb5/01JNFaq+thWpH
         qoUACDdFM/KVyL3idCX1Pg+QEl0dxmVsxoGz6pSI=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 1D99166994;
        Mon,  1 Aug 2022 21:39:02 -0400 (EDT)
Message-ID: <1afd44fab8dacdda7927b6e699bf74c8a1cad773.camel@xry111.site>
Subject: Re: [PATCH 2/4] LoongArch: Add prologue unwinder support
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>
Cc:     Qing Zhang <zhangqing@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Tue, 02 Aug 2022 09:39:00 +0800
In-Reply-To: <CAAhV-H7yfxX-ZsXjvWvSTwsyc8jf34jEOeLJ+dJ6jktJzuiryA@mail.gmail.com>
References: <20220801121726.9681-1-zhangqing@loongson.cn>
         <20220801121726.9681-3-zhangqing@loongson.cn>
         <CAAhV-H4hR-Xdk5EpakR9ft0J+V5qgPj5q2T=zjh1SHMnnHK1vw@mail.gmail.com>
         <6e6a7219-8666-bd9e-770a-e60e4b329832@loongson.cn>
         <CAAhV-H7yfxX-ZsXjvWvSTwsyc8jf34jEOeLJ+dJ6jktJzuiryA@mail.gmail.com>
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

On Tue, 2022-08-02 at 09:34 +0800, Huacai Chen wrote:
> > > #define UNWINDER_GUESS=C2=A0=C2=A0=C2=A0=C2=A0 0
> > > #define UNWINDER_PROLOGURE 1
> >=20
> > Maybe it's better to define with enum type?
> > enum unwind_type {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UNWINDER_GUESS,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UNWINDER_PROLOGURE,
> > };
> Both macro and enum are acceptable, but enum is essentially "int",
> while the "type" member is "char" here.

"0" or "1" will also be "int" (C99 6.4.4.1 para 5).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
