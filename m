Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7503054EEE4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 03:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379601AbiFQBmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 21:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379592AbiFQBmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 21:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E72563BCF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 18:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655430118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ghHac7UV1N6vPGfjk7ojRXZFbMUyEtSeJQo5S/wAoOg=;
        b=NrOv7d3XvSDGb0fYfbi7wP1PoaH7k/6zz5b27rM4b4vBGKehgt+FutkOsW5Xm3jwREuXMO
        kl4pb6WiiCLKesYQkwfEqy09WwPDc3Mh//J5Q6LTbZO/LLhC0TICRncdzNLLTEv6Oa8Mlq
        xx4D9Bw6WCvmb5vUpa4VSjHaH7e9Ej4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-YX1aOd_yOPOPDycBO1AHUw-1; Thu, 16 Jun 2022 21:41:57 -0400
X-MC-Unique: YX1aOd_yOPOPDycBO1AHUw-1
Received: by mail-il1-f200.google.com with SMTP id p12-20020a056e02144c00b002d196a4d73eso1811863ilo.18
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 18:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghHac7UV1N6vPGfjk7ojRXZFbMUyEtSeJQo5S/wAoOg=;
        b=7T17WT3M3wPeLpoq75PzFtv/b+M2u6PdEzvEQnN8zvWG84men9E44VmK8sT5w0mAwu
         2qX/Vs8a3SgiF1XOjhnD9TKT/aBjgSF2Lg91wj+sIxWjWfFdDD6mcS5axMB56jLZEJOI
         kv/4EIFQoRCYpXdLRui9I/qLrp+vcfR2IN5GDq2zwHv5GimFu7BPeYsPB7vT5u8zrjfr
         SCJyJvVfv00UEoYlefIOWuy8C9gdz/Ykk7qTFoeM97NVe+ewiryU3/3Wen+qyLs1J0QW
         pmajCteLCJZsZ6XKTHtQYIPJNfF+8HEoy0FLq77qY4ly0M9bUlGvx5Q/sQvrlTp/IWpF
         s/7Q==
X-Gm-Message-State: AJIora9n0iz/DfEq/SIrpKkjreOETDBV/p0ONjXmHbPr0+AUFXfWE2p4
        d0gChAyYT66j96YVbeMm0fMuPe8Q4B1jKnRGUxgUoNejBAbgv4cF5Dd96+Y+/VKkPYC7XV6a2W8
        l5PgtM4yw368+wrJvhm1KDDC1
X-Received: by 2002:a05:6e02:811:b0:2d5:2294:ff37 with SMTP id u17-20020a056e02081100b002d52294ff37mr4319990ilm.249.1655430116763;
        Thu, 16 Jun 2022 18:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vkkfMz7cqp5MF8GJOCZIECqzgeFNO0MvlQHMdn1ovMhxzPuVoVfsfN47FOLsLaed4L90CO1w==
X-Received: by 2002:a05:6e02:811:b0:2d5:2294:ff37 with SMTP id u17-20020a056e02081100b002d52294ff37mr4319979ilm.249.1655430116477;
        Thu, 16 Jun 2022 18:41:56 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id n4-20020a056e02140400b002d522958fb4sm1726538ilo.2.2022.06.16.18.41.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jun 2022 18:41:56 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com
Subject: [PATCH RFC 3/4] kvm: Add new pfn error KVM_PFN_ERR_INTR
Date:   Thu, 16 Jun 2022 21:41:46 -0400
Message-Id: <20220617014147.7299-4-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220617014147.7299-1-peterx@redhat.com>
References: <20220617014147.7299-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one new PFN error type to show when we cannot finish fetching the PFN
due to interruptions.  For example, by receiving a generic signal.

This prepares KVM to be able to respond to SIGUSR1 (for QEMU that's the
SIGIPI) even during e.g. handling an userfaultfd page fault.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b646b6fcaec6..4f84a442f67f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -96,6 +96,7 @@
 #define KVM_PFN_ERR_FAULT	(KVM_PFN_ERR_MASK)
 #define KVM_PFN_ERR_HWPOISON	(KVM_PFN_ERR_MASK + 1)
 #define KVM_PFN_ERR_RO_FAULT	(KVM_PFN_ERR_MASK + 2)
+#define KVM_PFN_ERR_INTR	(KVM_PFN_ERR_MASK + 3)
 
 /*
  * error pfns indicate that the gfn is in slot but faild to
@@ -106,6 +107,16 @@ static inline bool is_error_pfn(kvm_pfn_t pfn)
 	return !!(pfn & KVM_PFN_ERR_MASK);
 }
 
+/*
+ * When KVM_PFN_ERR_INTR is returned, it means we're interrupted during
+ * fetching the PFN (e.g. a signal might have arrived), so we may want to
+ * retry at some later point and kick the userspace to handle the signal.
+ */
+static inline bool is_intr_pfn(kvm_pfn_t pfn)
+{
+	return pfn == KVM_PFN_ERR_INTR;
+}
+
 /*
  * error_noslot pfns indicate that the gfn can not be
  * translated to pfn - it is not in slot or failed to
-- 
2.32.0

