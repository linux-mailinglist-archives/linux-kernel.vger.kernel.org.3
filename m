Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B0A57C149
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 02:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiGUADe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 20:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiGUAD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A5C874783
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658361805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17Vp4Ex87tn6Uk/BpRm2TxdVL2JJUXYS9NeIPo0wplg=;
        b=UDsmtfX0EdSR08D44pNPZmFZvulFKFocX36Q1HrJ3elBtvCdD1+1HVnhPqJZIV3hWAEh3s
        hnKUz8E/W1I6TKUA5RP4Cjg1U2oNugZE+g6wUbPMK/xZ3IBdPP2zCVMdJK/G8biKqhWH5X
        QqM3GcuhRzTNxRsbkFkLV/2Uq9NkSU4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-dHHClmZuNdK5k4jBVzP6iQ-1; Wed, 20 Jul 2022 20:03:24 -0400
X-MC-Unique: dHHClmZuNdK5k4jBVzP6iQ-1
Received: by mail-qv1-f72.google.com with SMTP id ne15-20020a056214424f00b004737e7bcfa6so14046qvb.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=17Vp4Ex87tn6Uk/BpRm2TxdVL2JJUXYS9NeIPo0wplg=;
        b=PlfFZIaIG78eFw4G29T81/34Ir/UYoK1p5VqTqr/hx3LIiEA7p7l39vMazRVjicMtJ
         BgctCPRGnrVTSrv67YCmqOHhYcvhkwheS4AmqyRh0LZW0IJx/zOns4ujBoPcM9IAStqR
         SPRsmxkx3Oj+aXTnnTnsWutdM5hUt/cI4+fJ+R2qGVnlZTprJfL/w8LhKDr38hMPZr8p
         IMYC5EjMrwYW3K9+fZcmljmDKZX5p0lubO/JkYM71pXB0lHfOo6wVQJlLcruPlz3klQx
         nadXFN01TeFHgIv4HVRzbaznNr8xqSMXCZ0lFPHSmTRtmQiOQQwomj8x+/Q4th8PsjXU
         H2FA==
X-Gm-Message-State: AJIora8zBfaJE39ikXtAsCBuMyUeDxmxx0MzARBhw8gX7nZIZsLb3NIx
        9FMQnaN14RFhXtFmjWOnderZ5bSqum+kkr4e3c6FI5d7rnRs9pLmYt6K2qftmgQDYdOOUa7TILg
        yF0ihwjh0lWRK8aVTXLIxrdhZdci9BtAR+jb13aNc3+r7NZfki9W2+OdBcrGDrybnlehymgUr7A
        ==
X-Received: by 2002:a0c:b284:0:b0:472:6e5e:e2f0 with SMTP id r4-20020a0cb284000000b004726e5ee2f0mr32318000qve.90.1658361803341;
        Wed, 20 Jul 2022 17:03:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s1+KU5FgF3m6vx4q4MlpqxGLoNsyQhiNfjM06PJt/2rXTILbIrwzzfnLXh7xwYd1LxLFugOw==
X-Received: by 2002:a0c:b284:0:b0:472:6e5e:e2f0 with SMTP id r4-20020a0cb284000000b004726e5ee2f0mr32317973qve.90.1658361803125;
        Wed, 20 Jul 2022 17:03:23 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87f44000000b0031eb3af3ffesm418640qtk.52.2022.07.20.17.03.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Jul 2022 17:03:22 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v2 2/3] kvm: Add new pfn error KVM_PFN_ERR_SIGPENDING
Date:   Wed, 20 Jul 2022 20:03:17 -0400
Message-Id: <20220721000318.93522-3-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220721000318.93522-1-peterx@redhat.com>
References: <20220721000318.93522-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one new PFN error type to show when we got interrupted when fetching
the PFN due to signal pending.

This prepares KVM to be able to respond to SIGUSR1 (for QEMU that's the
SIGIPI) even during e.g. handling an userfaultfd page fault.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 83cf7fd842e0..06a5b17d3679 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -96,6 +96,7 @@
 #define KVM_PFN_ERR_FAULT	(KVM_PFN_ERR_MASK)
 #define KVM_PFN_ERR_HWPOISON	(KVM_PFN_ERR_MASK + 1)
 #define KVM_PFN_ERR_RO_FAULT	(KVM_PFN_ERR_MASK + 2)
+#define KVM_PFN_ERR_SIGPENDING	(KVM_PFN_ERR_MASK + 3)
 
 /*
  * error pfns indicate that the gfn is in slot but faild to
@@ -106,6 +107,16 @@ static inline bool is_error_pfn(kvm_pfn_t pfn)
 	return !!(pfn & KVM_PFN_ERR_MASK);
 }
 
+/*
+ * When KVM_PFN_ERR_SIGPENDING returned, it means we're interrupted during
+ * fetching the PFN (a signal might have arrived), we may want to retry at
+ * some later point and kick the userspace to handle the signal.
+ */
+static inline bool is_sigpending_pfn(kvm_pfn_t pfn)
+{
+	return pfn == KVM_PFN_ERR_SIGPENDING;
+}
+
 /*
  * error_noslot pfns indicate that the gfn can not be
  * translated to pfn - it is not in slot or failed to
-- 
2.32.0

