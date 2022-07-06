Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1030567C1D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 04:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiGFCvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 22:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGFCvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 22:51:46 -0400
X-Greylist: delayed 60647 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Jul 2022 19:51:45 PDT
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F1E1A05C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 19:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1657075901;
        bh=rJv/EpGFFRx0itZGtKusK67I1kLrUdm2Rr17FuK6Uxc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c7XvjotUG1AsXQHaXU1GQkUrbM49gH6A6gAYzAfKb6KYzf0aB4s6WvsC1WeSmaTOE
         i/hhFcnvnQ50N4y56sThaTBnpILataJfzvIkrhyOz1TnQzS6twyIOOkPCSZpbU7Qx7
         SLed7bZvXOMXZ30GbIM2zwyK4l3lVgeg6EUiE1Cg=
Received: from [IPv6:240e:358:1139:6500:dc73:854d:832e:4] (unknown [IPv6:240e:358:1139:6500:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id D2259669A8;
        Tue,  5 Jul 2022 22:51:33 -0400 (EDT)
Message-ID: <ac46f5cb4c8d1154cfc3e862fb5211e869839c9a.camel@xry111.site>
Subject: Re: [PATCH v2] LoongArch: Clean useless vcsr in loongarch_fpu.
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, Qi Hu <huqi@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 06 Jul 2022 10:51:20 +0800
In-Reply-To: <CAAhV-H5+qd1ZrOqE8fgRmWshXy57AfEFpyKSK8ZstZZEQ53owQ@mail.gmail.com>
References: <20220704153612.314112-1-huqi@loongson.cn>
         <4273e104-8392-6a06-5d18-a1933978d8c3@xen0n.name>
         <22a1ba993e298ce12a374decefebeca484240883.camel@xry111.site>
         <16c9ccaa5e5a2ffd39272cff6f66e487c659b571.camel@xry111.site>
         <CAAhV-H5+qd1ZrOqE8fgRmWshXy57AfEFpyKSK8ZstZZEQ53owQ@mail.gmail.com>
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

On Wed, 2022-07-06 at 10:35 +0800, Huacai Chen wrote:

> Maybe Xuerui and Ruoyao have some misunderstanding. LSX/LASX will
> surely be upstream, this has nothing to do with cleanup VCSR16.
> Because FP/LSX/LASX share the same control bits in FCSR now.

My guess:

Almost all behavior of vector unit is controlled by FCSR (for example,
the rounding of both FPU and vector unit should be controlled by FCSR
altogether), except one bit similar to the bit 24 of MSACSR ("flush to
zero") is in VCSR [^1].  And "flush to zero" is not really useful so it
will be removed in 3A6000, and we'll not use it for 3A5000.

[^1]: A more bold guess: the hardware engineers could have just said
"let's wire this register called MSACSR in GS464V as FCSR16/VCSR in
LA464, maybe it will be useful and who knows?"  But now in practice it's
not useful.

Am I correct?


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
