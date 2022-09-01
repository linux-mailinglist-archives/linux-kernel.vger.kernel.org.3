Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8425AA172
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 23:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiIAVUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 17:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbiIAVUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 17:20:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D339EB7DF;
        Thu,  1 Sep 2022 14:19:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D59AEB828FE;
        Thu,  1 Sep 2022 21:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F67C433D6;
        Thu,  1 Sep 2022 21:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662067196;
        bh=vMb1A3guwJfkcgp2wFM6aQ+0d0wJbRK9xbl0lDcSsXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VTZhURJB7FcXq4vEMq3qYBJDhOmwcxGOTAJaqqsWSyikaZid+5ZkLas5D1py8FOp0
         WsXLHctTUrVEkZv9mrXyP0kMCsLX+eeeqa2K49qzWNFdFtIHSYoWaqNUCLe0BX+p+D
         at2eVTTJ305vZmKxzy0S4AWPtRMRp50vKl39zRfDuh2YLHpxC7AIDv4DAYIeULxL1w
         91lwTIa/VkpoZSR0y8BjhWAQFP8t5ehXbG6f+YkYe6Wcc1jRtet+KTOpdZDOkLuNbN
         8UsJ4T0Eqbl/qHvGWd/qjJb5nYOdlaZe51lC7nnnI2ROkgGVDx2vPYX9cjVdOTpiJY
         mvZeLRcfGwIFg==
Date:   Thu, 1 Sep 2022 14:19:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 00/21] KCFI support
Message-ID: <YxEh+pLyOyPalW1u@dev-arch.thelio-3990X>
References: <20220830233129.30610-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

On Tue, Aug 30, 2022 at 04:31:08PM -0700, Sami Tolvanen wrote:
> KCFI is a forward-edge control-flow integrity scheme in the upcoming
> Clang 16 release, which is more suitable for kernel use than the
> existing CFI scheme used by CONFIG_CFI_CLANG. KCFI doesn't require
> LTO, doesn't alter function references to point to a jump table, and
> won't break function address equality.
> 
> This series replaces the current arm64 CFI implementation with KCFI
> and adds support for x86_64.
> 
> KCFI requires assembly functions that are indirectly called from C
> code to be annotated with type identifiers. As type information is
> only available in C, the compiler emits expected type identifiers
> into the symbol table, so they can be referenced from assembly
> without having to hardcode type hashes. Patch 6 adds helper macros
> for annotating functions, and patches 9 and 19 add annotations.
> 
> In case of a type mismatch, KCFI always traps. To support error
> handling, the compiler generates a .kcfi_traps section for x86_64,
> which contains the locations of each trap, and for arm64, encodes
> the necessary register information to the ESR. Patches 10 and 21 add
> arch-specific error handlers.
> 
> To test this series, you'll a ToT Clang toolchain. The series is
> also available in GitHub:
> 
>   https://github.com/samitolvanen/linux/commits/kcfi-v4

I took this series for a spin on arm64 and x86_64.

I did not see any runtime issues on my arm64 or AMD test machines but I
do see a set of failures on my two Intel test machines when accessing
the files in /sys/devices/pci0000:00/0000:00:02.0/drm/card0/gt/gt0:

  $ ls -1 /sys/devices/pci0000:00/0000:00:02.0/drm/card0/gt/gt0
  id
  punit_req_freq_mhz
  rc6_enable
  rc6_residency_ms
  rps_act_freq_mhz
  rps_boost_freq_mhz
  rps_cur_freq_mhz
  rps_max_freq_mhz
  rps_min_freq_mhz
  rps_rp0_freq_mhz
  rps_rp1_freq_mhz
  rps_rpn_freq_mhz
  throttle_reason_pl1
  throttle_reason_pl2
  throttle_reason_pl4
  throttle_reason_prochot
  throttle_reason_ratl
  throttle_reason_status
  throttle_reason_thermal
  throttle_reason_vr_tdc
  throttle_reason_vr_thermalert

  $ cat /sys/devices/pci0000:00/0000:00:02.0/drm/card0/gt/gt0/*
  ...

  $ sudo dmesg | rg "CFI failure at"
  [  481.234522] CFI failure at kobj_attr_show+0x19/0x30 (target: max_freq_mhz_show+0x0/0xe0 [i915]; expected type: 0xc527b809)
  [  481.234699] CFI failure at kobj_attr_show+0x19/0x30 (target: act_freq_mhz_show+0x0/0xe0 [i915]; expected type: 0xc527b809)
  [  481.235067] CFI failure at kobj_attr_show+0x19/0x30 (target: boost_freq_mhz_show+0x0/0xe0 [i915]; expected type: 0xc527b809)
  [  481.235194] CFI failure at kobj_attr_show+0x19/0x30 (target: min_freq_mhz_show+0x0/0xe0 [i915]; expected type: 0xc527b809)
  [  481.235320] CFI failure at kobj_attr_show+0x19/0x30 (target: punit_req_freq_mhz_show+0x0/0x40 [i915]; expected type: 0xc527b809)
  [  481.235447] CFI failure at kobj_attr_show+0x19/0x30 (target: throttle_reason_bool_show+0x0/0x50 [i915]; expected type: 0xc527b809)
  [  481.235570] CFI failure at kobj_attr_show+0x19/0x30 (target: id_show+0x0/0x70 [i915]; expected type: 0xc527b809)
  [  481.235694] CFI failure at kobj_attr_show+0x19/0x30 (target: throttle_reason_bool_show+0x0/0x50 [i915]; expected type: 0xc527b809)
  [  481.235821] CFI failure at kobj_attr_show+0x19/0x30 (target: throttle_reason_bool_show+0x0/0x50 [i915]; expected type: 0xc527b809)
  [  481.235945] CFI failure at kobj_attr_show+0x19/0x30 (target: cur_freq_mhz_show+0x0/0xe0 [i915]; expected type: 0xc527b809)
  [  481.236075] CFI failure at kobj_attr_show+0x19/0x30 (target: throttle_reason_bool_show+0x0/0x50 [i915]; expected type: 0xc527b809)
  [  481.236201] CFI failure at kobj_attr_show+0x19/0x30 (target: rc6_enable_show+0x0/0x40 [i915]; expected type: 0xc527b809)
  [  481.236327] CFI failure at kobj_attr_show+0x19/0x30 (target: throttle_reason_bool_show+0x0/0x50 [i915]; expected type: 0xc527b809)
  [  481.236453] CFI failure at kobj_attr_show+0x19/0x30 (target: RP0_freq_mhz_show+0x0/0xe0 [i915]; expected type: 0xc527b809)
  [  481.236582] CFI failure at kobj_attr_show+0x19/0x30 (target: throttle_reason_bool_show+0x0/0x50 [i915]; expected type: 0xc527b809)
  [  481.236707] CFI failure at kobj_attr_show+0x19/0x30 (target: throttle_reason_bool_show+0x0/0x50 [i915]; expected type: 0xc527b809)
  [  481.236836] CFI failure at kobj_attr_show+0x19/0x30 (target: throttle_reason_bool_show+0x0/0x50 [i915]; expected type: 0xc527b809)
  [  481.236958] CFI failure at kobj_attr_show+0x19/0x30 (target: RPn_freq_mhz_show+0x0/0xe0 [i915]; expected type: 0xc527b809)
  [  481.237079] CFI failure at kobj_attr_show+0x19/0x30 (target: RP1_freq_mhz_show+0x0/0xe0 [i915]; expected type: 0xc527b809)
  [  481.237224] CFI failure at kobj_attr_show+0x19/0x30 (target: throttle_reason_bool_show+0x0/0x50 [i915]; expected type: 0xc527b809)
  [  481.237377] CFI failure at kobj_attr_show+0x19/0x30 (target: rc6_residency_ms_show+0x0/0x270 [i915]; expected type: 0xc527b809)

The source of those is drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c. I
have not looked too closely yet but the fix should be something along
the lines of commit 58606220a2f1 ("drm/i915: Fix CFI violation with
show_dynamic_id()"). I will note that the 'dev' variable does appear to
be used so the fix might not be as trivial as that one. Not sure I will
have a chance to look into it before Plumbers but I am happy to test a
patch if you happen to see an obvious fix.

Interestingly, I do not see the KVM failure [1] that I reported anymore.
I do not see an obvious fix for it in this series or -next though, could
it have been an issue with an earlier revision of kCFI on the compiler
side?

I do see a few new objtool warnings as well:

vmlinux.o: warning: objtool: apply_relocate_add+0x34: relocation to !ENDBR: memcpy+0x0
vmlinux.o: warning: objtool: ___ksymtab+__memcpy+0x0: data relocation to !ENDBR: memcpy+0x0
vmlinux.o: warning: objtool: ___ksymtab+memcpy+0x0: data relocation to !ENDBR: memcpy+0x0

As a result of the above:

Tested-by: Nathan Chancellor <nathan@kernel.org>

[1]: https://github.com/ClangBuiltLinux/linux/issues/1644

Cheers,
Nathan
