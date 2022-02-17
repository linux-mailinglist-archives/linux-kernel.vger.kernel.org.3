Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4A64BA1C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbiBQNmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:42:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241160AbiBQNl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:41:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27C9C21A2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:41:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42F0812FC;
        Thu, 17 Feb 2022 05:41:30 -0800 (PST)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64E553F66F;
        Thu, 17 Feb 2022 05:41:29 -0800 (PST)
Date:   Thu, 17 Feb 2022 13:41:26 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: v5.17-rc3 compile failure on aarch64
Message-ID: <Yg5QhoMP9fKjvHQ8@lakrids>
References: <85bfe02c-9432-c5b0-04e0-8096adf37b93@gmx.com>
 <Yg42iEZwHS//aFAj@lakrids>
 <797f79cb-3b9b-e8b1-b2c3-5f9aba270ae7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <797f79cb-3b9b-e8b1-b2c3-5f9aba270ae7@gmx.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 07:59:10PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/2/17 19:50, Mark Rutland wrote:
> > On Thu, Feb 17, 2022 at 04:37:49PM +0800, Qu Wenruo wrote:
> > > Hi,
> > 
> > Hi,
> > 
> > [adding LAKML so other arm/arm64 folk can chime in]
> > 
> > > Recently I found v5.17-rc3 kernel failed to compile on my aarch64 setup,
> > > it failed with the following error messages:
> > > 
> > >    AR      lib/zstd/built-in.a
> > >    LD [M]  lib/zstd/zstd_compress.o
> > > ld: __patchable_function_entries has both ordered
> > > [`__patchable_function_entries' in lib/zstd/common/entropy_common.o] and
> > > unordered [`__patchable_function_entries' in
> > > lib/zstd/common/error_private.o] sections
> > > ld: final link failed: bad value
> > > make[2]: *** [scripts/Makefile.build:484: lib/zstd/zstd_compress.o] Error 1
> > > make[1]: *** [scripts/Makefile.build:550: lib/zstd] Error 2
> > > make: *** [Makefile:1831: lib] Error 2
> > > make: *** Waiting for unfinished jobs....
> > 
> > Uh-oh; that doesn't look good.
> > 
> > In case this is configuration-dependent, could you share your .config?
> 
> Sure, attached.

Thanks!

> > > But the same code base compiles fine inside my x86_64 VM.
> > > 
> > > The aarch64 environment is an VM running on RockPro64 or RPI CM4.
> > > 
> > > With a little older gcc (v10.2.0) and bintuils (2.35).
> > 
> > Is this a custom-built toolchain, or one shipped by a distribution?
> 
> Shipped by distro (ArchlinuxARM), native, no cross chain.
> 
> And it's mostly upstream, or very lightly backported.
> 
> > If possible, can you see if you can reproduce this with one of the
> > kernel.org cross toolchains:
> > 
> >    https://mirrors.edge.kernel.org/pub/tools/crosstool/
> > 
> > ... because if you can, that will be much easier for someone else to
> > reproduce and analyse.
> > 
> > The closest builds are 9.3.0 and 10.3.0, for both arm64 and x86_64.
> 
> Sorry, not cross tool chain but native toolchain.

I understood that; the page has builds for arm64 hosts. :)

> > FWIW, I had a go building v5.17-rc3 defconfig with ftrace and zstd bits
> > eanbled with both GCC 9.3.0 and GCC 10.3.0, and I could not reproduce
> > the problem.
> 
> After the incident, I tried the following things, and got it solved:
> 
> - Upgrade to gcc 11.1.0 and binutils 2.36.1
>   The same kernel base, no "make clean"
> 
>   And got the same error.
> 
> - "make clean" for the kernel and recompile
>   Now the failure is gone.
> 
>   Thus I guess it's mostly some old .o is being re-used...
> 
> Sorry for the inconvenience, I should just re-compile (even it's super
> time-consuming) before reporting...

No worries; thanks for confirming!

Thanks,
Mark.
