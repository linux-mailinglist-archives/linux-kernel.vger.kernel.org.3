Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0E94D4F13
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243520AbiCJQXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244036AbiCJQWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:22:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93720194144;
        Thu, 10 Mar 2022 08:20:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF38AB826BD;
        Thu, 10 Mar 2022 16:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C11C340E8;
        Thu, 10 Mar 2022 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646929225;
        bh=a93gAwwuRaMdx+LeMidQ2gboZH9pO+gKAeYJd4lUHr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ff/rsOwFUZtQTB7RsovNGrr7AQWgG02Qq5n2Egz6N2tbuwMJk9ULhCrU5khFNqRIq
         hTG4l7v7zYfbfiRNT/YJV8PWVThg1Di+zVuIZC6afMGF7StzE7kaff1NYzxOKkKbj7
         1fYqaOwbdplom0TpvYonjfTDaVPTHeVRHpKm3cSJJtajDJBsNI2GJC0QOzOB7sg9nw
         Trn5BSq7jIYM9/LhFcP0iEt0sW4aaL2xw7QWmWGfKcNK5qbeoByDTwrKBoS/R3GJ5Q
         JddMSo94Qttd1a9PaHQsegKWh6RUS63igbGkyw0+FUutM6CngPwuClnriPcza53FzK
         YzWNnuDRe2+Qg==
Date:   Thu, 10 Mar 2022 09:20:18 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        llvm@lists.linux.dev,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [next] ld.lld: error: ./arch/arm/kernel/vmlinux.lds:34: AT
 expected, but got NOCROSSREFS
Message-ID: <YiolQp58KrkNkj5R@dev-arch.thelio-3990X>
References: <CA+G9fYsz7+Ooc8L-Dpfjp6mMDdw43=SjqiE0ryABy3t6qEzRoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsz7+Ooc8L-Dpfjp6mMDdw43=SjqiE0ryABy3t6qEzRoQ@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 05:07:36PM +0530, Naresh Kamboju wrote:
> Linux next-20220310 arm clang builds failed due to following errors/warnings.
> 
> metadata:
>     git_describe: next-20220310
>     git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>     git_sha: 71941773e143369a73c9c4a3b62fbb60736a1182
>     git_short_log: 71941773e143 (\Add linux-next specific files for 20220310\)
>     target_arch: arm
>     toolchain: clang-14
>     Kconfig: https://builds.tuxbuild.com/26BmBgHzW9MFZ3R0kIwL0Ce2r09/config
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
> ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- 'HOSTCC=sccache clang'
> 'CC=sccache clang'
> clang: warning: argument unused during compilation: '-march=armv7-a'
> [-Wunused-command-line-argument]
> clang: warning: argument unused during compilation: '-march=armv7-a'
> [-Wunused-command-line-argument]
> clang: warning: argument unused during compilation: '-march=armv7-a'
> [-Wunused-command-line-argument]
> clang: warning: argument unused during compilation: '-march=armv7-a'
> [-Wunused-command-line-argument]
> clang: warning: argument unused during compilation: '-march=armv7-a'
> [-Wunused-command-line-argument]
> clang: warning: argument unused during compilation: '-march=armv7-a'
> [-Wunused-command-line-argument]
> clang: warning: argument unused during compilation: '-march=armv7-a'
> [-Wunused-command-line-argument]
> clang: warning: argument unused during compilation: '-march=armv7-a'
> [-Wunused-command-line-argument]
> clang: warning: argument unused during compilation: '-march=armv7-a'
> [-Wunused-command-line-argument]
> ld.lld: error: ./arch/arm/kernel/vmlinux.lds:34: AT expected, but got
> NOCROSSREFS
> >>>  __vectors_lma = .; OVERLAY 0xffff0000 : NOCROSSREFS AT(__vectors_lma) { .vectors { *(.vectors) } .vectors.bhb.loop8 { *(.vectors.bhb.loop8) } .vectors.bhb.bpiall { *(.vectors.bhb.bpiall) } } __vectors_start = LOADADDR(.vectors); __vectors_end = LOADADDR(.vectors) + SIZEOF(.vectors); __vectors_bhb_loop8_start = LOADADDR(.vectors.bhb.loop8); __vectors_bhb_loop8_end = LOADADDR(.vectors.bhb.loop8) + SIZEOF(.vectors.bhb.loop8); __vectors_bhb_bpiall_start = LOADADDR(.vectors.bhb.bpiall); __vectors_bhb_bpiall_end = LOADADDR(.vectors.bhb.bpiall) + SIZEOF(.vectors.bhb.bpiall); . = __vectors_lma + SIZEOF(.vectors) + SIZEOF(.vectors.bhb.loop8) + SIZEOF(.vectors.bhb.bpiall); __stubs_lma = .; .stubs ADDR(.vectors) + 0x1000 : AT(__stubs_lma) { *(.stubs) } __stubs_start = LOADADDR(.stubs); __stubs_end = LOADADDR(.stubs) + SIZEOF(.stubs); . = __stubs_lma + SIZEOF(.stubs); PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
> >>>                                          ^
> make[1]: *** [/builds/linux/Makefile:1225: vmlinux] Error 1

Hi Naresh,

Thank you for the report! This is already fixed in mainline with
commit 36168e387fa7 ("ARM: Do not use NOCROSSREFS directive with
ld.lld"). This should be in next-20220311.

Cheers,
Nathan
