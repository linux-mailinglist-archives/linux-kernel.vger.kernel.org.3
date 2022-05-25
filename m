Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A25533D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbiEYNMw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 May 2022 09:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiEYNMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:12:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4157C5FEA;
        Wed, 25 May 2022 06:12:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0C1F1FB;
        Wed, 25 May 2022 06:12:43 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 875D73F66F;
        Wed, 25 May 2022 06:12:42 -0700 (PDT)
Date:   Wed, 25 May 2022 14:12:39 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     yoan.picchi@arm.com, ardb@kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, qat-linux@intel.com
Subject: Re: [RFC PATCH 2/2] Removes the x86 dependency on the QAT drivers
Message-ID: <20220525141239.48589f25@donnerap.cambridge.arm.com>
In-Reply-To: <YoyOg/kYGtO+nQac@silpixa00400314>
References: <CAMj1kXGAiA-SkTFD5EgcacYao0RKT7oK0AxvxkR7Ho_KZSGXCw@mail.gmail.com>
        <8f6d8d1f-2872-15b9-d38b-1e8eb26f781b@foss.arm.com>
        <YoyOg/kYGtO+nQac@silpixa00400314>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2022 08:51:31 +0100
Giovanni Cabiddu <giovanni.cabiddu@intel.com> wrote:

Hi,

> On Wed, May 18, 2022 at 02:00:40PM +0100, Yoan Picchi wrote:
> > >> From: Yoan Picchi <yoan.picchi@arm.com>
> > >>
> > >> The QAT acceleration card can be very helpfull for some tasks like
> > >> dealing with IPSEC but it is currently restricted to be used only on x86  
> > machine.  
> > >> Looking at the code we didn't see any reasons why those drivers might
> > >> not work on other architectures. We've successfully built all of them
> > >> on x86, arm64, arm32, mips64, powerpc64, riscv64 and sparc64.
> > >>
> > >> We also have tested the driver with an Intel Corporation C62x Chipset
> > >> QuickAssist Technology (rev 04) PCIe card on an arm64 server. After
> > >> the numa patch, it works with the AF_ALG crypto userland interface,
> > >> allowing us to encrypt some data with cbc for instance. We've also
> > >> successfully created some VF, bound them to DPDK, and used the card
> > >> this way, thus showing some real life usecases of x86 do work on arm64  
> > too.  
> > >>
> > >> Please let us know if we missed something that would warrants some
> > >> further testing.  
> > >Thanks Yoan.
> > >
> > >Can you please confirm that you tested the driver on the platform you  
> > reported using a kernel with CONFIG_CRYPTO_MANAGER_DISABLE_TESTS not set and
> > CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y and the self test >is passing?  
> > >You can check it by running
> > >ï¿½ï¿½ï¿½ $ cat /proc/crypto | grep -B 4 passed | grep -e "qat_\|qat-" | sort  
> > This should report:  
> > >ï¿½ï¿½ï¿½ driverï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ : qat_aes_cbc
> > >ï¿½ï¿½ï¿½ driverï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ : qat_aes_cbc_hmac_sha1
> > >ï¿½ï¿½ï¿½ driverï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ : qat_aes_cbc_hmac_sha256
> > >ï¿½ï¿½ï¿½ driverï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ : qat_aes_cbc_hmac_sha512
> > >ï¿½ï¿½ï¿½ driverï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ : qat_aes_ctr
> > >ï¿½ï¿½ï¿½ driverï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ : qat_aes_xts
> > >ï¿½ï¿½ï¿½ driverï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ : qat-dh
> > >ï¿½ï¿½ï¿½ driverï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ : qat-rsa
> > >
> > >Note that if you are using the HEAD of cryptodev-2.6 you will have to  
> > either revert 8893d27ffcaf6ec6267038a177cb87bcde4dd3de or apply  
> > >https://patchwork.kernel.org/project/linux-crypto/list/?series=639755 as  
> > the algorithms have been temporarily disabled.  
> > >
> > >Regards,
> > >
> > >--
> > >Giovanni  
> > 
> > Hi Giovanni.
> > 
> > Thanks for the instructions, I did not know of this test.
> > I rebuilt my kernel on arm64 with those parameter and I confirm I get the
> > same output with
> > $ cat /proc/crypto | grep -B 4 passed | grep -e "qat_\|qat-" | sort  
> Thats great. Thanks.
> 
> Is the platform where you ran the tests little or big endian?

It's definitely little endian.
The cores in there can be switched between LE and BE, but I think
realistically no one ever runs a BE configuration. Compiling the kernel
for BE is rather straight-forward, but I wouldn't know of any serious
userland to run with it (short of a self-compiled busybox or buildroot).

> If little endian, can you re-test on a big endian system?

So you can just compile a kernel with CONFIG_CPU_BIG_ENDIAN=y, but you
cannot boot it easily, since CONFIG_EFI depends on !CPU_BIG_ENDIAN,
and UEFI is the only way to boot that (server) machine.
So kexec and a KVM guest are the other options. Kexec has the disadvantage of
requiring a DT (because ACPI is also incompatible with BE), and for KVM we
would need to check whether this actually works, since BE guests are much
less tested, plus the device pass-through imposing more challenges.

So testing this in BE is a bit more involved, and the practicality of such
a setup is very questionable. If you are concerned, should we just say:
	depends on PCI && !CPU_BIG_ENDIAN
At least until we have reports that confirm proper BE operation?

Cheers,
Andre
