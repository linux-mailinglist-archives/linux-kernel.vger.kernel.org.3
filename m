Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7DB5A8B67
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIAC0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiIAC0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:26:50 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05CCE1147
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661999205;
        bh=4tHyvBECj9KBnHmTMw80sFhQIk4BzEPU0bsseW2OxL0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Q+jYiCiZzdqIQA19OYopCYX/sILRrghKyP8xbiqt0QET6D1c55byKRgJTKGu7D6yf
         3LBWB2vFdhm4Al6Qg7t/r++66XjY+fH1qtFQ7H9ozTSeKj4vKI2AsFlFMz/JKLTeHs
         /YKsFZifOF0/ddzMqIbvuzM6FfrnagZdO90yL0Qo=
Received: from [IPv6:240e:358:118a:f800:dc73:854d:832e:4] (unknown [IPv6:240e:358:118a:f800:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 33C3765DC8;
        Wed, 31 Aug 2022 22:26:41 -0400 (EDT)
Message-ID: <d2036602cfd927578272041823465e6c23e7240b.camel@xry111.site>
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation
 types
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Jinyang He <hejinyang@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Youling Tang <tangyouling@loongson.cn>
Date:   Thu, 01 Sep 2022 10:26:38 +0800
In-Reply-To: <CAAhV-H6wzw-MV+h225rM4PfK_HY0tAdSXcUG-2Hx+_gfhzQ4_g@mail.gmail.com>
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

On Thu, 2022-09-01 at 10:17 +0800, Huacai Chen wrote:

> Now all global variable accesses are via got, I think the performance
> may be much worse than before when we didn't use explicit-relocs.
> I don't know whether "a new code model" or your "(1)(2)(3)" is easier
> to implement, but I think it is better to solve the performance issue
> before 6.1-rc1.

Both won't be too difficult, but I need to debate with toolchain
developers :(.

If we are running out of time:

cflags-y +=3D $(cc-option -mno-explicit-relocs)

This will at least make the new toolchain work, though we cannot be
benefited from the optimizations allowed by explicit relocations.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
