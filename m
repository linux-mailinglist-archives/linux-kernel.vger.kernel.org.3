Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5CF4B9F64
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbiBQLu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:50:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiBQLu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:50:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BD3A282E7D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:50:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C86D8113E;
        Thu, 17 Feb 2022 03:50:39 -0800 (PST)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0A463F66F;
        Thu, 17 Feb 2022 03:50:38 -0800 (PST)
Date:   Thu, 17 Feb 2022 11:50:32 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: v5.17-rc3 compile failure on aarch64
Message-ID: <Yg42iEZwHS//aFAj@lakrids>
References: <85bfe02c-9432-c5b0-04e0-8096adf37b93@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85bfe02c-9432-c5b0-04e0-8096adf37b93@gmx.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 04:37:49PM +0800, Qu Wenruo wrote:
> Hi,

Hi,

[adding LAKML so other arm/arm64 folk can chime in]

> Recently I found v5.17-rc3 kernel failed to compile on my aarch64 setup,
> it failed with the following error messages:
> 
>   AR      lib/zstd/built-in.a
>   LD [M]  lib/zstd/zstd_compress.o
> ld: __patchable_function_entries has both ordered
> [`__patchable_function_entries' in lib/zstd/common/entropy_common.o] and
> unordered [`__patchable_function_entries' in
> lib/zstd/common/error_private.o] sections
> ld: final link failed: bad value
> make[2]: *** [scripts/Makefile.build:484: lib/zstd/zstd_compress.o] Error 1
> make[1]: *** [scripts/Makefile.build:550: lib/zstd] Error 2
> make: *** [Makefile:1831: lib] Error 2
> make: *** Waiting for unfinished jobs....

Uh-oh; that doesn't look good.

In case this is configuration-dependent, could you share your .config?

> But the same code base compiles fine inside my x86_64 VM.
> 
> The aarch64 environment is an VM running on RockPro64 or RPI CM4.
> 
> With a little older gcc (v10.2.0) and bintuils (2.35).

Is this a custom-built toolchain, or one shipped by a distribution?

If possible, can you see if you can reproduce this with one of the
kernel.org cross toolchains:

  https://mirrors.edge.kernel.org/pub/tools/crosstool/

... because if you can, that will be much easier for someone else to
reproduce and analyse.

The closest builds are 9.3.0 and 10.3.0, for both arm64 and x86_64.

FWIW, I had a go building v5.17-rc3 defconfig with ftrace and zstd bits
eanbled with both GCC 9.3.0 and GCC 10.3.0, and I could not reproduce
the problem.

Thanks,
Mark.

> While for my x86_64 VM it has newer gcc (11.1.0) and binutiles (2.36.1)
> 
> I'm super happy to upgrade my tool chain for my aarch64 VM, but I'm a
> little concerned if there is something worthy fixed.
> 
> Thanks,
> Qu
