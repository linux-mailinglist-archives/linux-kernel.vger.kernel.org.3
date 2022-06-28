Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DA655E83F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346577AbiF1Ozw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiF1Ozu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:55:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812B4CDD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D453B81EA3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DB8C341C6;
        Tue, 28 Jun 2022 14:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656428146;
        bh=4Ufyo57x4qp12qtTAejxANXQobsL4Ktlm5qYEXg3Bks=;
        h=Date:From:To:Cc:Subject:From;
        b=TwO3bRqh1VAOhF9XhHNocq7hmkVYibDzI35dDTJFYiVsqC8ZWS2qKTnlIVErxoCoD
         fZ/v4PlbqeDtcb7wOCQom4JiaHpygBpzXiL4EThzpn3mnQqhgD2UGE/Yz9pxQffLVC
         HwUdKB6ZbVXolXmmomuXF32tzGhfR6hMfEsQhfEcNVYsAMMszSPG5xDXx6ehghdU7Y
         +CcoHDiIa05vdEyh+3Vk4omB00uwyMTqd2Po6uaGa01cM9hfQkCAJYUONI+zNSbfnr
         4NROEFs0r1nDvlWjw64xjQJmY6tacHribDtVE0AAAuAjVLtwpZj2ku84veNkwSWVzC
         opZMiz23X3Qfg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5EC9A4096F; Tue, 28 Jun 2022 11:55:44 -0300 (-03)
Date:   Tue, 28 Jun 2022 11:55:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Raghavendra Rao Ananta <rananta@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 FYI] tools kvm headers arm64: Update KVM headers from the
 kernel sources
Message-ID: <YrsWcDQyJC+xsfmm@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used not to be copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
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

To pick the changes from:

  2cde51f1e10f2600 ("KVM: arm64: Hide KVM_REG_ARM_*_BMAP_BIT_COUNT from userspace")
  b22216e1a617ca55 ("KVM: arm64: Add vendor hypervisor firmware register")
  428fd6788d4d0e0d ("KVM: arm64: Add standard hypervisor firmware register")
  05714cab7d63b189 ("KVM: arm64: Setup a framework for hypercall bitmap firmware registers")
  18f3976fdb5da2ba ("KVM: arm64: uapi: Add kvm_debug_exit_arch.hsr_high")
  a5905d6af492ee6a ("KVM: arm64: Allow SMCCC_ARCH_WORKAROUND_3 to be discovered and migrated")

That don't causes any changes in tooling (when built on x86), only
addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
  diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Raghavendra Rao Ananta <rananta@google.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/uapi/asm/kvm.h | 36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index c1b6ddc02d2ff96e..3bb134355874c8bf 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -139,8 +139,10 @@ struct kvm_guest_debug_arch {
 	__u64 dbg_wvr[KVM_ARM_MAX_DBG_REGS];
 };
 
+#define KVM_DEBUG_ARCH_HSR_HIGH_VALID	(1 << 0)
 struct kvm_debug_exit_arch {
 	__u32 hsr;
+	__u32 hsr_high;	/* ESR_EL2[61:32] */
 	__u64 far;	/* used for watchpoints */
 };
 
@@ -332,6 +334,40 @@ struct kvm_arm_copy_mte_tags {
 #define KVM_ARM64_SVE_VLS_WORDS	\
 	((KVM_ARM64_SVE_VQ_MAX - KVM_ARM64_SVE_VQ_MIN) / 64 + 1)
 
+/* Bitmap feature firmware registers */
+#define KVM_REG_ARM_FW_FEAT_BMAP		(0x0016 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM_FW_FEAT_BMAP_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
+						KVM_REG_ARM_FW_FEAT_BMAP |	\
+						((r) & 0xffff))
+
+#define KVM_REG_ARM_STD_BMAP			KVM_REG_ARM_FW_FEAT_BMAP_REG(0)
+
+enum {
+	KVM_REG_ARM_STD_BIT_TRNG_V1_0	= 0,
+#ifdef __KERNEL__
+	KVM_REG_ARM_STD_BMAP_BIT_COUNT,
+#endif
+};
+
+#define KVM_REG_ARM_STD_HYP_BMAP		KVM_REG_ARM_FW_FEAT_BMAP_REG(1)
+
+enum {
+	KVM_REG_ARM_STD_HYP_BIT_PV_TIME	= 0,
+#ifdef __KERNEL__
+	KVM_REG_ARM_STD_HYP_BMAP_BIT_COUNT,
+#endif
+};
+
+#define KVM_REG_ARM_VENDOR_HYP_BMAP		KVM_REG_ARM_FW_FEAT_BMAP_REG(2)
+
+enum {
+	KVM_REG_ARM_VENDOR_HYP_BIT_FUNC_FEAT	= 0,
+	KVM_REG_ARM_VENDOR_HYP_BIT_PTP		= 1,
+#ifdef __KERNEL__
+	KVM_REG_ARM_VENDOR_HYP_BMAP_BIT_COUNT,
+#endif
+};
+
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
-- 
2.36.1

