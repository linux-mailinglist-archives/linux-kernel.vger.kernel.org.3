Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403F65ADEC5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 07:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiIFFBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 01:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiIFFBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 01:01:34 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3875F122
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 22:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1662440491;
        bh=1oNtxf1c5bbGEwVSqkKGWodjPqD73sS9Q23KWDUkQ6g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aX6nT/2JzHVMgDszWnrupgVW3cEl6rr1OHFw95xgVFGoIfsOSegPaE4yzhx5DK0Dd
         folpTg84mXDIFjOPKbbx7TKGcYj4uBDfhJS5GDM7cFZpZbCd1sKLGix+GJQxKDM6JL
         NDQYjTTvZo+xAf7IrRnSCKpkNRve+8QD07ZIXGz8=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 5BDB965C37;
        Tue,  6 Sep 2022 01:01:29 -0400 (EDT)
Message-ID: <6a3e185eaaac4a1397abe43026004548d47ee305.camel@xry111.site>
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation
 types
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Jinyang He <hejinyang@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Youling Tang <tangyouling@loongson.cn>
Date:   Tue, 06 Sep 2022 13:01:27 +0800
In-Reply-To: <CAAhV-H7LjkY+XAzGs2K3544+CGOztCd4V8BuSjMJwZCgfBLDow@mail.gmail.com>
References: <20220830104806.128365-1-xry111@xry111.site>
         <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
         <c0ba2e23-5be3-924d-554a-2f10272c05bc@xen0n.name>
         <CAAhV-H7Dz21qRgwkMcJ0SnA9FNDN19E6mpa7C25LUitrO9LGeA@mail.gmail.com>
         <5b87173faeef587a2ffaaa6f58d34e0940231067.camel@xry111.site>
         <c53303bf-a5d2-098f-8975-efadbe0b2f2e@loongson.cn>
         <bc323d8578d2f6ec580066bab181788b305ae3c3.camel@xry111.site>
         <CAAhV-H4N_XvmP9KA1M5crU44kHr33MZUVSsMY4Ugu5wQSv_LOQ@mail.gmail.com>
         <97291c0fe5a660c844475ff019c8db6af77ecf86.camel@xry111.site>
         <CAAhV-H6wzw-MV+h225rM4PfK_HY0tAdSXcUG-2Hx+_gfhzQ4_g@mail.gmail.com>
         <ae2652c5e140d407d523d7f35bee672cebe1b7a2.camel@xry111.site>
         <CAAhV-H56TQeU54JjvNQg2qZ6L1aSbzbaM2a=VQr9ZcAn4uthyg@mail.gmail.com>
         <8d0f96e2977c5c78f17bb410087f2aad986ef5a4.camel@xry111.site>
         <CAAhV-H7LjkY+XAzGs2K3544+CGOztCd4V8BuSjMJwZCgfBLDow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.3 
MIME-Version: 1.0
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-09-06 at 12:43 +0800, Huacai Chen wrote:
> > Note that -fpic/-fPIC is "position-independent code *suitable for
> > use in a shared library*", while -fpie/-fPIE is more like just
> > "position-independent code".=C2=A0 The names of those options are confu=
sing.
> > (When -fpic was invented first time, people mostly believed "PIC had
> > been only for shared libraries", so it's named -fpic instead of -shlib
> > or something.)=C2=A0 IMO in the EFI stub for other ports, -fpie should =
be
> > used instead of -fpic as well because the EFI stub is not similar to a
> > shared library in any means.

> You are right, but I guess that Ard doesn't want to squash the efistub
> change into the LoongArch efistub support patch. :)

It only changes cflags-$(CONFIG_LOONGARCH), which is LoongArch specific.
And arm64 is also using -fpie.

Should I send the one-line EFI stub change to linux-efi first?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
