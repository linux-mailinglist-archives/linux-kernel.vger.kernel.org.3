Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF19550B09
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 15:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiFSNyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 09:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiFSNyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 09:54:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D9C6586
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:54:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22DBB6115D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 13:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699B9C34114;
        Sun, 19 Jun 2022 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655646853;
        bh=NnpI+ZCgGJFEgEK/8QJ7nN1VaISd9SxAU0YXZ8LzRYA=;
        h=Date:From:To:Cc:Subject:From;
        b=Be2izO3IAI3IbRUhOZYKI1E7aFMikCvQ++9eKec3inllgOIxYwTOCZ2KE7MX5F2xo
         Nm08RkXojxXcGIZA3C+x1mPX9gOK8+4rNACglZuOQAijmNG6nvEmqAxTk5tUE2+0uj
         93G46SAx7RxU815GO/jtZ1H1Xt13+mPAtVETO00yERMgdiY9dKBK8VoQuV3ZHpuJ8T
         oIWN7jMfzTVGd9RAuW6t/0YxycIHJvW4TjLv/CABvNLDS/nOLpJaSIkVMk97MhK6AR
         Re7E1+O0cYglg25Bxavj5kKL+GRZ3KgtpHQBPt+UWbmZMNstvs7nzHTdc44sfIcfoZ
         HUwHeaSpXGUBQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8A49E4096F; Sun, 19 Jun 2022 10:54:10 -0300 (-03)
Date:   Sun, 19 Jun 2022 10:54:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 FYI] tools headers UAPI: Sync x86's asm/kvm.h with the
 kernel sources
Message-ID: <Yq8qgiMwRcl9ds+f@kernel.org>
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

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used not to be copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick the changes in:

  f1a9761fbb00639c ("KVM: x86: Allow userspace to opt out of hypercall patching")

That just rebuilds kvm-stat.c on x86, no change in functionality.

This silences these perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
  diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h

Cc: Oliver Upton <oupton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/kvm.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index bf6e96011dfed4e2..21614807a2cbb359 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -428,11 +428,12 @@ struct kvm_sync_regs {
 	struct kvm_vcpu_events events;
 };
 
-#define KVM_X86_QUIRK_LINT0_REENABLED	   (1 << 0)
-#define KVM_X86_QUIRK_CD_NW_CLEARED	   (1 << 1)
-#define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	   (1 << 2)
-#define KVM_X86_QUIRK_OUT_7E_INC_RIP	   (1 << 3)
-#define KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT (1 << 4)
+#define KVM_X86_QUIRK_LINT0_REENABLED		(1 << 0)
+#define KVM_X86_QUIRK_CD_NW_CLEARED		(1 << 1)
+#define KVM_X86_QUIRK_LAPIC_MMIO_HOLE		(1 << 2)
+#define KVM_X86_QUIRK_OUT_7E_INC_RIP		(1 << 3)
+#define KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT	(1 << 4)
+#define KVM_X86_QUIRK_FIX_HYPERCALL_INSN	(1 << 5)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1
-- 
2.36.1

