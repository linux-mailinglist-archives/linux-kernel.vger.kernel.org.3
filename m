Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9B4FAE8D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 17:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbiDJPk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 11:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiDJPk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:40:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65DA8286E4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 08:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649605125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tOw89Gf7WnffDCNYXGFd+Pu5U6hzz5IlC9y5yKDKg3A=;
        b=Ohijw9g2Z3wY3KArRZTPHnXJrn0WBfeR+WRkw4RYSpwMPIkA5cBruKy+bg7ThDmsHJw89k
        5BImXuzDjyCuqn3uxNMvsTOijXw/OzXvB+Bm671jbocGPu8eV4bJUHrlJJFVSpZaK1oAtf
        w9+IwLo/0sxcdkP9JahRdtDqPTdcxdY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-r_WJRcrhMC6LeGkFlpqv5g-1; Sun, 10 Apr 2022 11:38:44 -0400
X-MC-Unique: r_WJRcrhMC6LeGkFlpqv5g-1
Received: by mail-qt1-f198.google.com with SMTP id s17-20020a05622a1a9100b002ed3cb8acb3so1233712qtc.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 08:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tOw89Gf7WnffDCNYXGFd+Pu5U6hzz5IlC9y5yKDKg3A=;
        b=dnFOOt6wAOVXieuRlaQ8E898fBi2i80kyQIeaVBRFh9oft09wr9/+OImvxnck4Weaz
         JaLiQpqE1vadxNMbvb9cxDAWY9oBbvMiinuJQrvt8qB/CvHaQ8qEG3KS/8PcvrzW1RTa
         voGERrBGtda0hcCtabZnsWDlzICB2FXUkO7A6BAedut6vDcd7att8to6yZe2MMY9nuDE
         xlvxWM/c38eSFn7YILX92tkr065TF/KArE31p/kHQdhi1iK3gVaopzwlHyO+f7+fR8aZ
         82sgj9yFVIiiPxjNDng62q7Tkb2FryeZs9X0tX5F7s856QVzaXNbBHAyGVjcVKhANxvd
         gNKQ==
X-Gm-Message-State: AOAM533B+yrLvkZyFQ66tD36txfJ/EeY1Xj6nfGgS/XQRwJkmnjqEhVY
        ulKAl/jK0hr9GDwYUJNMZostc6UBUgQOAVtXBZvSR8gx2KFkko8uS+W6nAg76yOiQiTa53+bmd5
        BXYBzMMOVdhlMQ5wT4ha81N7Q
X-Received: by 2002:a05:6214:2301:b0:435:38af:2f87 with SMTP id gc1-20020a056214230100b0043538af2f87mr23642044qvb.83.1649605123857;
        Sun, 10 Apr 2022 08:38:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ+5M962Hrne2KDB95B2oYdS8HFx62nGUxoPSUqW2CkNgqhYH79Cy0T0/06vEj3SUtI72w1w==
X-Received: by 2002:a05:6214:2301:b0:435:38af:2f87 with SMTP id gc1-20020a056214230100b0043538af2f87mr23642039qvb.83.1649605123676;
        Sun, 10 Apr 2022 08:38:43 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k2-20020a37ba02000000b0067dc1b0104asm17024640qkf.124.2022.04.10.08.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 08:38:43 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] KVM: clean up comments
Date:   Sun, 10 Apr 2022 11:38:40 -0400
Message-Id: <20220410153840.55506-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPDX
*.h use /* */ style comments
*.c use // style comments

Spelling replacements
dimishing to diminishing
memsot to memslot

Signed-off-by: Tom Rix <trix@redhat.com>
---
 virt/kvm/dirty_ring.c | 2 +-
 virt/kvm/kvm_main.c   | 4 ++--
 virt/kvm/kvm_mm.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
index 222ecc81d7df..f4c2a6eb1666 100644
--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * KVM dirty ring implementation
  *
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b22f380e3347..90a2ccaa5b25 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -662,7 +662,7 @@ void kvm_inc_notifier_count(struct kvm *kvm, unsigned long start,
 		kvm->mmu_notifier_range_end = end;
 	} else {
 		/*
-		 * Fully tracking multiple concurrent ranges has dimishing
+		 * Fully tracking multiple concurrent ranges has diminishing
 		 * returns. Keep things simple and just find the minimal range
 		 * which includes the current and new ranges. As there won't be
 		 * enough information to subtract a range after its invalidate
@@ -1793,7 +1793,7 @@ static int kvm_set_memslot(struct kvm *kvm,
 
 	/*
 	 * No need to refresh new->arch, changes after dropping slots_arch_lock
-	 * will directly hit the final, active memsot.  Architectures are
+	 * will directly hit the final, active memslot.  Architectures are
 	 * responsible for knowing that new->arch may be stale.
 	 */
 	kvm_commit_memory_region(kvm, old, new, change);
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 34ca40823260..41da467d99c9 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only
+/* SPDX-License-Identifier: GPL-2.0-only */
 
 #ifndef __KVM_MM_H__
 #define __KVM_MM_H__ 1
-- 
2.27.0

