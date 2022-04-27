Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01233510E41
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356859AbiD0Bn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbiD0BnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:43:22 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EE765FC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:40:12 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id j24-20020a637a58000000b003ab45990247so169499pgn.17
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=fm2jFbot54PvFH20t4TxzybP3OE84ejhq1XxWwapvtM=;
        b=ILHHX56EFCxezIq3EQk2itS0pXFDo1O6lEKmmvkKR5gKRVOl2Y+a4cJXIzRR+zJaTI
         mcTvkTLdjSSKxzcNk+wvZqMLVYKVUvmqX5Ar8l913XfsqrlF3UGpDeHKdnfL9GqzfLdU
         nnE1FIo6IZvCB9kbYWzaJvNDeEb9KHxLvej6/tAWNl274K8TDUgqG7u2YsfP8oIuqINE
         7d4eX0CnNCJINrjYW+DvVx19wlg0t2ar56EG9pze/viUxCWpaOu7ypXXah2+7HMmhtti
         nmX55ONv5BW7spf9BUS/qWHpSrJ6+jGLuU4cfuH/Cmu5Xbg32MdrBE4dGFdDfbRFmq/W
         YfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=fm2jFbot54PvFH20t4TxzybP3OE84ejhq1XxWwapvtM=;
        b=me+FODgJuNXu2BboV8OFOE7E1zPHLpPG7zPDS0bLCw7hU0BALvLtcPMgrIpeUf87Yo
         L3Yy5kWVK6W9UwQ9T9GKiRJ2kYrmnK6Lu5Fceaci3Wcj/1zH5K21z+73Kif6gnDwUlNa
         2C9HXZp8FSQk1QI9JtKuK1gRofByGI7eaLGowndHRL0F+sY1EmZaVVrgjFIeo0Hlyn7K
         eZWJsY8EeIle4ZP5aPhFRb5wIxJ/SdLp4uHKT84d9d+5lcilHrS6nvGXesezaaby7QR4
         Fq1mM4db6E13tlvUpMhertjGvgZQDO1gaiy9EgoCWoUuC5DC7EBotBbts9z3qdVKCQww
         b0zw==
X-Gm-Message-State: AOAM531ZcNrx3wrR0YNFac3Qy1zaizbNFCAuydenIoPiqGR0b1iF/14z
        7idLub7MqdiXPEYIaPSIWLO3iWrZ/L8=
X-Google-Smtp-Source: ABdhPJwUekR1b6h0Z9yFRwjtbUYBs62GSJESl9pr1sbEnNpewT52TkTR2aZh+tu7EXL0TS1Cfa7TQ9YX2B8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:b590:b0:153:a243:3331 with SMTP id
 a16-20020a170902b59000b00153a2433331mr27227659pls.129.1651023611573; Tue, 26
 Apr 2022 18:40:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 27 Apr 2022 01:39:57 +0000
In-Reply-To: <20220427014004.1992589-1-seanjc@google.com>
Message-Id: <20220427014004.1992589-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220427014004.1992589-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v2 1/8] Revert "KVM: Do not speculatively mark pfn cache valid
 to "fix" race"
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Mingwei Zhang <mizhang@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 55111927df1cd140aa7b7ea3f33f524b87776381.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/pfncache.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 72eee096a7cd..71c84a43024c 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -81,8 +81,6 @@ bool kvm_gfn_to_pfn_cache_check(struct kvm *kvm, struct gfn_to_pfn_cache *gpc,
 {
 	struct kvm_memslots *slots = kvm_memslots(kvm);
 
-	lockdep_assert_held_read(&gpc->lock);
-
 	if ((gpa & ~PAGE_MASK) + len > PAGE_SIZE)
 		return false;
 
@@ -228,6 +226,11 @@ int kvm_gfn_to_pfn_cache_refresh(struct kvm *kvm, struct gfn_to_pfn_cache *gpc,
 	if (!old_valid || old_uhva != gpc->uhva) {
 		void *new_khva = NULL;
 
+		/* Placeholders for "hva is valid but not yet mapped" */
+		gpc->pfn = KVM_PFN_ERR_FAULT;
+		gpc->khva = NULL;
+		gpc->valid = true;
+
 		new_pfn = hva_to_pfn_retry(kvm, gpc);
 		if (is_error_noslot_pfn(new_pfn)) {
 			ret = -EFAULT;
@@ -256,7 +259,7 @@ int kvm_gfn_to_pfn_cache_refresh(struct kvm *kvm, struct gfn_to_pfn_cache *gpc,
 			gpc->pfn = KVM_PFN_ERR_FAULT;
 			gpc->khva = NULL;
 		} else {
-			gpc->valid = true;
+			/* At this point, gpc->valid may already have been cleared */
 			gpc->pfn = new_pfn;
 			gpc->khva = new_khva;
 		}
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

