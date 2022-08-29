Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808985A4585
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiH2IzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiH2Iy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:54:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28B764E1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F9C5B80DA9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CD8C433C1;
        Mon, 29 Aug 2022 08:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661763294;
        bh=cpD20IECoAEsU5QWrTpmUWeRwStSRURBU0+JaQT7J7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CyMJlWd73MEePoYJ/WtOSAwPovn50mfbBDP2m/BfY4rZ401xhXc+8J/nfG7ZeLzOy
         ZRL57h+IkrKMMKPzp4hoDWiEaFgXFfUXYnPKoF6yrNCunBKkdw7wTN3hjoHevTn765
         byeu7aLXBA1k+PPgl1DYl1aJQjFkoAF2fqqVXLaVicqIVcKjL1DJatNBBXp6+/+HTB
         qOT6M33x0PVS2efbyDCyWPCd+VbB30nRHiCMqqEUb9Ub9G/sAaNWYeR+UtTz8VPXNh
         sYbXcEagfnm2+qbsgASS9ZI28oEseXeebL1QqBoUTPvtY2zG0rKTMDJpL6M7lTcQYA
         QzJGmHeNWxprg==
Received: by pali.im (Postfix)
        id 4AF797DE; Mon, 29 Aug 2022 10:54:51 +0200 (CEST)
Date:   Mon, 29 Aug 2022 10:54:51 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] powerpc/boot: Don't always pass -mcpu=powerpc when
 building 32-bit uImage
Message-ID: <20220829085451.upubyo5e7uop72lb@pali>
References: <20220820105200.30425-1-pali@kernel.org>
 <20220828095659.4061-1-pali@kernel.org>
 <e3cb2642-20e4-6c26-104d-329a04260946@csgroup.eu>
 <c8d657db-02da-7840-5b40-755e47277a2c@csgroup.eu>
 <20220828174135.rcql4uiunqbnn5gh@pali>
 <d49c5905-ff68-00e9-ddaf-d60d5e5ebe65@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d49c5905-ff68-00e9-ddaf-d60d5e5ebe65@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 August 2022 17:43:53 Christophe Leroy wrote:
> Le 28/08/2022 à 19:41, Pali Rohár a écrit :
> > On Sunday 28 August 2022 17:39:25 Christophe Leroy wrote:
> >> Le 28/08/2022 à 19:33, Christophe Leroy a écrit :
> >>>
> >>>
> >>> Le 28/08/2022 à 11:56, Pali Rohár a écrit :
> >>>> When CONFIG_TARGET_CPU is specified then pass its value to the compiler
> >>>> -mcpu option. This fixes following build error when building kernel with
> >>>> powerpc e500 SPE capable cross compilers:
> >>>>
> >>>>       BOOTAS  arch/powerpc/boot/crt0.o
> >>>>     powerpc-linux-gnuspe-gcc: error: unrecognized argument in option
> >>>> ‘-mcpu=powerpc’
> >>>>     powerpc-linux-gnuspe-gcc: note: valid arguments to ‘-mcpu=’ are:
> >>>> 8540 8548 native
> >>>>     make[1]: *** [arch/powerpc/boot/Makefile:231:
> >>>> arch/powerpc/boot/crt0.o] Error 1
> >>>
> >>> corenet64_smp_defconfig :
> >>>
> >>>     BOOTAS  arch/powerpc/boot/crt0.o
> >>> powerpc64-linux-gcc: error: missing argument to '-mcpu='
> >>> make[1]: *** [arch/powerpc/boot/Makefile:237 : arch/powerpc/boot/crt0.o]
> >>> Erreur 1
> >>> make: *** [arch/powerpc/Makefile:253 : uImage] Erreur 2
> >>>
> >>>
> >>
> >> Seems like in fact, E5500_CPU and E6500_CPU are not taken into account
> >> in CONFIG_TARGET_CPU, and get special treatment directly in
> >> arch/powerpc/Makefile.
> >>
> >> This goes unnoticed because of CFLAGS-$(CONFIG_TARGET_CPU_BOOL) +=
> >> $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))
> >>
> >> I think we need to fix that prior to your patch.
> > 
> > It looks like that CONFIG_TARGET_CPU is broken.
> > 
> >    $ make ARCH=powerpc corenet64_smp_defconfig CROSS_COMPILE=powerpc64-linux-gnu-
> >    ...
> >    # configuration written to .config
> > 
> >    $ grep CONFIG_TARGET_CPU .config
> >    CONFIG_TARGET_CPU_BOOL=y
> > 
> > CONFIG_TARGET_CPU_BOOL is set but CONFIG_TARGET_CPU not!
> 
> Yes, because there is no default value for E5500_CPU and E6500_CPU. We 
> need to add one for each.

I see... Will you prepare this fixup for your previous patch?

And I think that following construct

  $(call cc-option,-mcpu=$(CONFIG_TARGET_CPU))

should be changed just to

  -mcpu=$(CONFIG_TARGET_CPU)

Because if user specified that want build for specific target CPU, it
should not be silently ignored.
