Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC815698F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 06:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiGGEFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 00:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGGEFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 00:05:23 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DEB2CCAB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 21:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1657166715;
        bh=xMn7MrQA8Rmpsy+c97xahDZzxB54Wg0Ugt9J9SQO4vc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EOafTUqNac5KDAd9ls46gfsCl24HWzca6XRCAz1uXx8HGJnv5dTrHFG0ZEM/z7D2Y
         N86zIwO+ObrVe2stwKGm96K5rgkbVmXOIc+fUGbRxYJL23O6er5akeRm2ynmVrfoba
         DlJNO2AVhJiMDFgEkmoUMgJ2+MLVsUKVYsf+sU3M=
Received: from [IPv6:240e:358:1139:6500:dc73:854d:832e:4] (unknown [IPv6:240e:358:1139:6500:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id CB233669AA;
        Thu,  7 Jul 2022 00:05:06 -0400 (EDT)
Message-ID: <bd889cd7b72138a12b1339a33156ff46530c20b0.camel@xry111.site>
Subject: Re: [PATCH v2] LoongArch: Clean useless vcsr in loongarch_fpu.
From:   Xi Ruoyao <xry111@xry111.site>
To:     WANG Xuerui <kernel@xen0n.name>, Qi Hu <huqi@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 07 Jul 2022 12:04:28 +0800
In-Reply-To: <0583a335-72f7-55cf-3cd9-4dbd8109a440@xen0n.name>
References: <20220704153612.314112-1-huqi@loongson.cn>
         <4273e104-8392-6a06-5d18-a1933978d8c3@xen0n.name>
         <22a1ba993e298ce12a374decefebeca484240883.camel@xry111.site>
         <16c9ccaa5e5a2ffd39272cff6f66e487c659b571.camel@xry111.site>
         <CAAhV-H5+qd1ZrOqE8fgRmWshXy57AfEFpyKSK8ZstZZEQ53owQ@mail.gmail.com>
         <ac46f5cb4c8d1154cfc3e862fb5211e869839c9a.camel@xry111.site>
         <c824b9ca-c9c4-1912-7845-99a0989277a4@loongson.cn>
         <9d064771-9402-4e84-96f8-4713cddf42f2@www.fastmail.com>
         <730cb4c4-a6a3-783e-3e4c-7c2bdc35c088@loongson.cn>
         <0583a335-72f7-55cf-3cd9-4dbd8109a440@xen0n.name>
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

On Thu, 2022-07-07 at 11:05 +0800, WANG Xuerui wrote:

> To be frank, at this point I think you're trying to hide something.=20
> (This is not your fault, blame someone else of course because they told=
=20
> you the fact.) In the old-world kernel the VCSR a.k.a. FCSR16 is=20
> certainly being saved/restored, and there's apparently no harm in doing=
=20
> so. And if the contents are indeed "undefined", why are the code there
> in the first place? Certainly the bits *are* meaningful, only that for
> some reason you aren't revealing the semantics and pretending that they=
=20
> are "undefined" and probably "do nothing externally observable" if=20
> accessed in the first place.

On a 3A5000LL, I did an experiment via a kernel module, which enables
LSX/LASX and tries to write and read fcsr16.  I tried each bit (1, 2, 4,
8, ..., 1 << 31) one by one.  The result: no matter which bit I wrote
into fcsr16, I always read out 0.

And I've objdump'ed a kernel shipped in an early Loongnix release.  It
seems the only reference to fcsr16 is a "movgr2fcsr $r16, $r0"
instruction.
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
