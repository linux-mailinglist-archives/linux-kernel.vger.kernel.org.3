Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDD0580F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbiGZIe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbiGZIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:34:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C830557
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 563AFB8120F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6241C341C0;
        Tue, 26 Jul 2022 08:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658824451;
        bh=DUYTDoq1jHjKTj++71miVKY1KqsLvjaMgOiKbqjXSOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GY2pK/jTFzhsBNlfbT0Mh6BT3cmiDRCpssCK9TaRSbupz9Hz1krtm540gaYeOkpqs
         y1Ope8Lg/OXobCyTbM/Ln35EzdMffupELE5+BAXTSjmGAFagB2Uh65oNLzBjoLlHBe
         skIFE/jHnwXGOUExRczYfGeC5EJhckZixRBHKkdcZEAX1xnp5yf6fZwIzY+pGx8Q4k
         zJAJ4h6Ds3cVlzfgiOB0b57TJypL1A41HPdrqizTpCqcKjx2QbTwqxNd1bFeKZXIki
         FwUoC4CIsVklxIh17FeWV1XxKalLplG3UOKEX324e5rlNfwbyY1dINdzO2e1AsnWeF
         dQ4NWiIdOhzRw==
Received: by pali.im (Postfix)
        id A316282D; Tue, 26 Jul 2022 10:34:06 +0200 (CEST)
Date:   Tue, 26 Jul 2022 10:34:06 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regression: Linux v5.15+ does not boot on Freescale P2020
Message-ID: <20220726083406.tcjvny6d2di6q7ar@pali>
References: <20220722090929.mwhmxxdd7yioxqpz@pali>
 <6b227478-73b8-2a97-1c78-89570d928739@csgroup.eu>
 <20220723150702.jecerkhxhy65dgww@pali>
 <875yjld2oe.fsf@mpe.ellerman.id.au>
 <20220725125256.cg6su4d2ageylvp6@pali>
 <e2487668-b6d9-9ddb-1bb4-9f4d37fae1a7@csgroup.eu>
 <20220725201009.gwuchzswcqaxntrk@pali>
 <20220725215416.GV25951@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220725215416.GV25951@gate.crashing.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 July 2022 16:54:16 Segher Boessenkool wrote:
> On Mon, Jul 25, 2022 at 10:10:09PM +0200, Pali Rohár wrote:
> > On Monday 25 July 2022 16:20:49 Christophe Leroy wrote:
> > Now I did again clean test with same Debian 10 cross compiler.
> > 
> > $ git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git && cd linux
> > $ git checkout v5.15
> > $ make mpc85xx_smp_defconfig ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnuspe-
> > $ make vmlinux ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnuspe-
> > $ cp -a vmlinux vmlinux.v5.15
> > $ git revert 9401f4e46cf6965e23738f70e149172344a01eef
> > $ make vmlinux ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnuspe-
> > $ cp -a vmlinux vmlinux.revert
> > $ powerpc-linux-gnuspe-objdump -d vmlinux.revert > vmlinux.revert.dump
> > $ powerpc-linux-gnuspe-objdump -d vmlinux.v5.15 > vmlinux.v5.15.dump
> > $ diff -Naurp vmlinux.v5.15.dump vmlinux.revert.dump
> > 
> > And there are:
> > 
> > -c000c304:      7d 20 f8 29     lwarx   r9,0,r31,1
> > +c000c304:      7d 20 f8 28     lwarx   r9,0,r31
> > 
> > I guess it must be reproducible this issue as I'm using regular
> > toolchain from distribution.
> 
> The kernel had
> 
> #define PPC_RAW_LWARX(t, a, b, eh)       (0x7c000028 | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b) | __PPC_EH(eh))
> 
> and
> 
> #define PPC_LWARX(t, a, b, eh) stringify_in_c(.long PPC_RAW_LWARX(t, a, b, eh))
> 
> and
> 
> #ifdef CONFIG_PPC64
> #define __PPC_EH(eh)    (((eh) & 0x1) << 0)
> #else
> #define __PPC_EH(eh)    0
> #endif
> 
> but Christophe's 9401f4e46cf6 changed
> 
> -"1:    " PPC_LWARX(%0,0,%2,1) "\n\
> +"1:    lwarx           %0,0,%2,1\n\
> 
> no longer checking CONFIG_PPC64.  That appears to be the bug.

Nice catch!

Now I have tried to apply following change on master (without reverting
anything)

diff --git a/arch/powerpc/include/asm/simple_spinlock.h b/arch/powerpc/include/asm/simple_spinlock.h
index 7ae6aeef8464..72d3657fd2f7 100644
--- a/arch/powerpc/include/asm/simple_spinlock.h
+++ b/arch/powerpc/include/asm/simple_spinlock.h
@@ -51,7 +51,7 @@ static inline unsigned long __arch_spin_trylock(arch_spinlock_t *lock)
 
 	token = LOCK_TOKEN;
 	__asm__ __volatile__(
-"1:	lwarx		%0,0,%2,1\n\
+"1:	lwarx		%0,0,%2,0\n\
 	cmpwi		0,%0,0\n\
 	bne-		2f\n\
 	stwcx.		%1,0,%2\n\
@@ -158,7 +158,7 @@ static inline long __arch_read_trylock(arch_rwlock_t *rw)
 	long tmp;
 
 	__asm__ __volatile__(
-"1:	lwarx		%0,0,%1,1\n"
+"1:	lwarx		%0,0,%1,0\n"
 	__DO_SIGN_EXTEND
 "	addic.		%0,%0,1\n\
 	ble-		2f\n"
@@ -182,7 +182,7 @@ static inline long __arch_write_trylock(arch_rwlock_t *rw)
 
 	token = WRLOCK_TOKEN;
 	__asm__ __volatile__(
-"1:	lwarx		%0,0,%2,1\n\
+"1:	lwarx		%0,0,%2,0\n\
 	cmpwi		0,%0,0\n\
 	bne-		2f\n"
 "	stwcx.		%1,0,%2\n\

and with this change, objdump showed exactly same result as if I revert
that problematic commit on top of master branch.

I guess that simple_spinlock.h should be fixed to pass 1 to lwarx for
CONFIG_PPC64 and 0 otherwise.

Christophe, are you going to look at it?

> The EH field in larx insns is new since ISA 2.05, and some ISA 1.x cpu
> implementations actually raise an illegal insn exception on EH=1.  It
> appears P2020 is one of those.
> 
> 
> Segher

P2020 has e500 cores. e500 cores uses ISA 2.03. So this may be reason.
But in official Freescale/NXP documentation for e500 is documented that
lwarx supports also eh=1. Maybe it is not really supported.
https://www.nxp.com/files-static/32bit/doc/ref_manual/EREF_RM.pdf (page 562)
At least there is NOTE:
Some older processors may treat EH=1 as an illegal instruction.
