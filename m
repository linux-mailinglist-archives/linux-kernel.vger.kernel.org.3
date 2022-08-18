Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBB2598C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344613AbiHRTIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiHRTIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:08:37 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890EB65673
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:08:36 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id x12so1032116uaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc;
        bh=Nk/TSk6npACedUkDRKBdfkyA8nrRp6tv3CfMxkua8M8=;
        b=TeLH3knRpD86yyCWkf3u6UY4g5yake+4GXZUxUE43r+RGpMzv6xjh1HeumfSbXa+2v
         AiG3uATukDaTeffq8+p8VynFz1V4GHjpZ7vBwrCdNpuZVLjGuSv5OjZjvMfjuDqA44sq
         JSbo++IQA0XdoqEO0+RefLyA3pnpEyRAEJU5RhV3kjzhOPWkPln7mtteU1+C+IT6jTx5
         skqFwglAYih6/PlAWYm245S95A+gQWanT0M9qr6EbmbKwcYK39z/psRyCYE2kiO0wt6o
         OFIEmTT5fnFGKsUe0pcnwzIMlHoj1gxyk8UoNSWkcWy9r8TSqtdQxOOJy7yY2Y8jbmgx
         8CeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc;
        bh=Nk/TSk6npACedUkDRKBdfkyA8nrRp6tv3CfMxkua8M8=;
        b=xRDUodT/TAC1B13d+aaEBCqoi8MKjmGB0TSevpYQxnSo2AO43GnFyarjptBlXcp535
         cCZwZlxuuP83ZkCq0x8dBXQpVb5zjMpns1A65T9qqRTn/soQk3D5kWeQ81qWBiosg0V+
         5A2xr3mRqQ/B5TEsajQffNs2/9a9CG/3pACqPZIzF3VCVH2eQj2ngmIqhgKUzzv6knXW
         hiz60chuxmPeBLESwJU2a5NbTScb6oKZk7wOItKIDXJ8GvvqQUrsyw7HFiaDmvH+AhTV
         xBqVTNajKl9318Q17ekaN0oy0Ro1NCoP2qeQ36KKbJRodwqbi4HJa1Jdc8O16086+FNa
         PnmA==
X-Gm-Message-State: ACgBeo3QZ62Rmn0jhZo5kFUS4xUzkymd7xtdtQ2UnEpR3IOasrGQ+eZK
        fzaStzLFpqVcdC1oolnMRhI=
X-Google-Smtp-Source: AA6agR4aU85in+KQYK4uJRjhGpcgKe4zWWyyJiC9LJzfEAiLEDk3RIQ3gHgAhN5WOzhqtZ0f63Fd1w==
X-Received: by 2002:ab0:7706:0:b0:399:17f3:fef1 with SMTP id z6-20020ab07706000000b0039917f3fef1mr1643953uaq.72.1660849715565;
        Thu, 18 Aug 2022 12:08:35 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.19.239.32])
        by smtp.gmail.com with ESMTPSA id f11-20020ab0300b000000b003693e4797f6sm1285395ual.15.2022.08.18.12.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 12:08:35 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6520E4035A; Thu, 18 Aug 2022 16:08:32 -0300 (-03)
Date:   Thu, 18 Aug 2022 16:08:32 -0300
To:     linux-kernel@vger.kernel.org
Cc:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Durrant <pdurrant@amazon.com>
Subject: [PATCH FYI 1/1] tools headers UAPI: Sync x86's asm/kvm.h with the
 kernel sources
Message-ID: <Yv6OMPKYqYSbUxwZ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
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

To pick the changes in:

  43bb9e000ea4c621 ("KVM: x86: Tweak name of MONITOR/MWAIT #UD quirk to make it #UD specific")
  94dfc73e7cf4a31d ("treewide: uapi: Replace zero-length arrays with flexible-array members")
  bfbcc81bb82cbbad ("KVM: x86: Add a quirk for KVM's "MONITOR/MWAIT are NOPs!" behavior")
  b172862241b48499 ("KVM: x86: PIT: Preserve state of speaker port data bit")
  ed2351174e38ad4f ("KVM: x86: Extend KVM_{G,S}ET_VCPU_EVENTS to support pending triple fault")

That just rebuilds kvm-stat.c on x86, no change in functionality.

This silences these perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
  diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h

Cc: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Durrant <pdurrant@amazon.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/kvm.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index ec53c9fa1da967d6..46de10a809ecbd81 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -306,7 +306,8 @@ struct kvm_pit_state {
 	struct kvm_pit_channel_state channels[3];
 };
 
-#define KVM_PIT_FLAGS_HPET_LEGACY  0x00000001
+#define KVM_PIT_FLAGS_HPET_LEGACY     0x00000001
+#define KVM_PIT_FLAGS_SPEAKER_DATA_ON 0x00000002
 
 struct kvm_pit_state2 {
 	struct kvm_pit_channel_state channels[3];
@@ -325,6 +326,7 @@ struct kvm_reinject_control {
 #define KVM_VCPUEVENT_VALID_SHADOW	0x00000004
 #define KVM_VCPUEVENT_VALID_SMM		0x00000008
 #define KVM_VCPUEVENT_VALID_PAYLOAD	0x00000010
+#define KVM_VCPUEVENT_VALID_TRIPLE_FAULT	0x00000020
 
 /* Interrupt shadow states */
 #define KVM_X86_SHADOW_INT_MOV_SS	0x01
@@ -359,7 +361,10 @@ struct kvm_vcpu_events {
 		__u8 smm_inside_nmi;
 		__u8 latched_init;
 	} smi;
-	__u8 reserved[27];
+	struct {
+		__u8 pending;
+	} triple_fault;
+	__u8 reserved[26];
 	__u8 exception_has_payload;
 	__u64 exception_payload;
 };
@@ -434,6 +439,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_OUT_7E_INC_RIP		(1 << 3)
 #define KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT	(1 << 4)
 #define KVM_X86_QUIRK_FIX_HYPERCALL_INSN	(1 << 5)
+#define KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS	(1 << 6)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1
-- 
2.37.1

