Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857A7573A70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiGMPsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbiGMPsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940E54F1A6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:48:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2403261972
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F54C3411E;
        Wed, 13 Jul 2022 15:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657727280;
        bh=P/y1kSZWrmMveCY0nergqiCux1bbGMRtY4xVx4kPGGQ=;
        h=Date:From:To:Cc:Subject:From;
        b=o/c0IfS29fTaXvDU7EwJtnTo8GUzzlHqm/LoCuYcWW2tE6MUR277/25Ti+n/k3K/L
         elZzki4S0Ac5aCSONwgypwcie7hYwxrSH5zFY1LbyOwyScozGWnjYUwjJXsJ2S4+im
         vZ4gv/cJt51qbJybybqZw+Ndjk+1TS5zytC3t7S8gljRKZvR+kG75+WZp1Jkm8Te5V
         DR2WQnRWo1VAcK7iBRcwS6rkFghiYxHF9m4vhs9Sos6u1smme3ZBmsu0O6TkzB4ttp
         jlGnECxlEbSuMrrKFGknXE37tbc9YzeOhAZl2Q4EotjaQnlF4fGRvVOgTjM4eP1u5A
         HdVMJqPXVNj4g==
Date:   Wed, 13 Jul 2022 08:47:58 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: objtool "'naked' return found in RETHUNK build" with clang +
 CONFIG_K{A,C}SAN=y
Message-ID: <Ys7pLq+tQk5xEa/B@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh and Peter,

After commit 9bb2ec608a20 ("objtool: Update Retpoline validation") and
commit f43b9876e857 ("x86/retbleed: Add fine grained Kconfig knobs"), I
see a spew of objtool warnings when building certain configurations with
clang. Examples below, they appear to trigger in every single file.

With x86_64_defconfig + CONFIG_KASAN=y:

arch/x86/ia32/audit.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
arch/x86/ia32/audit.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
init/version.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
init/version.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
arch/x86/kernel/cpu/rdrand.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
arch/x86/kernel/cpu/rdrand.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
arch/x86/kernel/fpu/bugs.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
arch/x86/kernel/fpu/bugs.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build
arch/x86/kernel/platform-quirks.o: warning: objtool: asan.module_ctor+0x0: 'naked' return found in RETHUNK build
init/calibrate.o: warning: objtool: asan.module_ctor+0x11: 'naked' return found in RETHUNK build
init/calibrate.o: warning: objtool: asan.module_dtor+0x11: 'naked' return found in RETHUNK build

With x86_64_defconfig + CONFIG_KCSAN=y:

arch/x86/ia32/audit.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
init/calibrate.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
init/version.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
arch/x86/kernel/fpu/bugs.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
arch/x86/kernel/cpu/rdrand.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
arch/x86/events/probe.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build
arch/x86/kernel/apic/ipi.o: warning: objtool: tsan.module_ctor+0x5: 'naked' return found in RETHUNK build

If there is any additional information I can provide or patches I can
test, I am happy to do so!

Cheers,
Nathan
