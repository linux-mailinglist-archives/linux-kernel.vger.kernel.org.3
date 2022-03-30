Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784314EC96F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348687AbiC3QRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiC3QRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:17:43 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4F9AE57
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:15:58 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-dee0378ce7so12169184fac.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HmtpU+iKeqqs1Tum0ObqFls2q0zemhd+lsKd6q135Is=;
        b=B8pkD9RwGTCaNZUS/K1UWK/0J7doiMqEmJFC5d3l4Rl8RXN4moZDl+LJbFyB5EjdEc
         iI8g0b+BcU+hYJFqDnhJz+sZhp4Qj8OOypg73DDvJPfLwsX8l0IDHbgWCbGtJXjBSlMK
         Epbl2nnRX9ZUusz8m40G2uMZSuihkDQ6YmJ2yAKyMxODf7MOl1e6YWypavlDkjgQMkRS
         Qw/f2qi6USZyvIN1CsXTAn/6GsR3832CctlVvK+x2g/Fqs4OpE4AxFeHvleeg+Y4cG9Y
         z2Lq6FM+DiPB9tHfo0+dXoK2Y338+e9CZULBQOHb9w61TjL/eic3frY8+j0G8JQ+ofEv
         m6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HmtpU+iKeqqs1Tum0ObqFls2q0zemhd+lsKd6q135Is=;
        b=w8XK72XaQQ9HTGj487aBW6/a2/mHr3Tcw+13CJjUUC9wAZz0Ea8HF3bCvSyFgy+7Qu
         w6hug5mDgUaGgsWNg6xR9oVNutPwOCJKMbEsM2fj2ayDm+V3QSdu899OF9/KvftHcwM6
         ioCuV2J3UG6I+eUM+LIGWSj8yjzjMEFAdGGEHGvdVO9hZux8uxTh5PuTS2wNY8BS3nS+
         2pj34I6lyOR+0ruGFq3wz5vFLOTsWLfAfuFqw/j7USpmlVifR6lgG1IYysZg26zFUNx0
         Tu2GwvbvUKrOxvMqgaby+sGJUx3Rb5t1j8tco6FsfWkgSuVRHfA0YNsI/ol/wH6p2jfR
         Lelw==
X-Gm-Message-State: AOAM532Ri6L5HqVNHp0M/hmgs+yfaJBLwMt9LaD4+wsENi7aKcqHKdGo
        NDuOZNbVp/RwQL1wjvvblhmj8qUYbxs=
X-Google-Smtp-Source: ABdhPJygH8VYCLm/rZWowqvlG5Hkb9RuADdaf+ZZxHyhfhaWHkcOCEnFcKkUj9toCG7zGHjMkxAHYg==
X-Received: by 2002:a05:6870:1496:b0:dd:fe5c:4bbc with SMTP id k22-20020a056870149600b000ddfe5c4bbcmr175101oab.166.1648656957653;
        Wed, 30 Mar 2022 09:15:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.19.239.165])
        by smtp.gmail.com with ESMTPSA id w8-20020aca3008000000b002ef7e3ad3b8sm10293103oiw.29.2022.03.30.09.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 09:15:56 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9F5D240407; Wed, 30 Mar 2022 13:15:53 -0300 (-03)
Date:   Wed, 30 Mar 2022 13:15:53 -0300
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH FYI] tools headers UAPI: Sync linux/kvm.h with the kernel
 sources
Message-ID: <YkSCOWHQdir1lhdJ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

---


To pick the changes in:

  6d8491910fcd3324 ("KVM: x86: Introduce KVM_CAP_DISABLE_QUIRKS2")
  ef11c9463ae00630 ("KVM: s390: Add vm IOCTL for key checked guest absolute memory access")
  e9e9feebcbc14b17 ("KVM: s390: Add optional storage key checking to MEMOP IOCTL")

That just rebuilds perf, as these patches don't add any new KVM ioctl to
be harvested for the the 'perf trace' ioctl syscall argument
beautifiers.

This is also by now used by tools/testing/selftests/kvm/, a simple test
build succeeded.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc: Oliver Upton <oupton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index bbc6b7c2dc1b3a54..91a6fe4e02c08c4b 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -562,9 +562,12 @@ struct kvm_s390_mem_op {
 	__u32 op;		/* type of operation */
 	__u64 buf;		/* buffer in userspace */
 	union {
-		__u8 ar;	/* the access register number */
+		struct {
+			__u8 ar;	/* the access register number */
+			__u8 key;	/* access key, ignored if flag unset */
+		};
 		__u32 sida_offset; /* offset into the sida */
-		__u8 reserved[32]; /* should be set to 0 */
+		__u8 reserved[32]; /* ignored */
 	};
 };
 /* types for kvm_s390_mem_op->op */
@@ -572,9 +575,12 @@ struct kvm_s390_mem_op {
 #define KVM_S390_MEMOP_LOGICAL_WRITE	1
 #define KVM_S390_MEMOP_SIDA_READ	2
 #define KVM_S390_MEMOP_SIDA_WRITE	3
+#define KVM_S390_MEMOP_ABSOLUTE_READ	4
+#define KVM_S390_MEMOP_ABSOLUTE_WRITE	5
 /* flags for kvm_s390_mem_op->flags */
 #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
 #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
+#define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
 
 /* for KVM_INTERRUPT */
 struct kvm_interrupt {
@@ -1137,6 +1143,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_AIL_MODE_3 210
 #define KVM_CAP_S390_MEM_OP_EXTENSION 211
 #define KVM_CAP_PMU_CAPABILITY 212
+#define KVM_CAP_DISABLE_QUIRKS2 213
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.35.1

