Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5722556517E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiGDJ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiGDJ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:59:03 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6F964F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1656928740;
        bh=1PaN7z3o+qL7iftcZWMXpLjiyNu9bigwG/ufouKEZLA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fNc+v4yeZHLtc2UPbLRASxgt4uuRtX1o+I8PVFSaOldI3PYC7bF18c6O2qdUk1Mh6
         3GgANmeSPb5Vstal1PusSIQtnHFc94Rwj+cYCntXpq1xiYxtfQTAVUtctPGwG40KLY
         UWrnYigguF8RmstqLFNoSRYi8oPKBzs36gQtShSA=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 3B4BA667B9;
        Mon,  4 Jul 2022 05:58:59 -0400 (EDT)
Message-ID: <e187cda4edf0a3186e7caae8ed285e2564742f26.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Clean useless vcsr in loongarch_fpu.
From:   Xi Ruoyao <xry111@xry111.site>
To:     huqi <huqi@loongson.cn>, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Mon, 04 Jul 2022 17:58:57 +0800
In-Reply-To: <7904571e-3ef4-5841-497d-6796c8c36c52@loongson.cn>
References: <20220704061402.683762-1-huqi@loongson.cn>
         <1470d272-e148-c600-f759-a1e2dac776e1@xen0n.name>
         <7904571e-3ef4-5841-497d-6796c8c36c52@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-04 at 17:27 +0800, huqi wrote:

>=20
> > The original code was written with future LSX/LASX support in mind;=20
> > the code is dead currently, but expected to get utilized Soon (TM).
> >=20
> > So, I'd like to confirm if future LoongArch models would *not* feature=
=20
> > LSX/LASX in its current form, and that the Loongson Corporation is not=
=20
> > going to upstream LSX/LASX support, given you are apparently a=20
> > Loongson employee with the first-hand information? We'd like to avoid=
=20
> > code churn in general, so if the LSX/LASX support is to be eventually=
=20
> > mainlined, removing them now would only lead to them being introduced=
=20
> > later.
>=20
> `vcsr` is removed because it has been removed in hardware. What's more,=
=20
> it will not be used to support LSX/LASX in the future.

It would be better to add this information into the commit message.  Is
it already removed in 3A5000?  On my machine "movfcsr2gr $a0, $r16"
produces SIGILL (but maybe it's because LSX is not enabled via the EUEN
register).

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
