Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A925D514000
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353806AbiD2BH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353749AbiD2BHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:07:47 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640CDBCB4A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:04:29 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id k14-20020aa790ce000000b0050d3b201122so3496886pfk.20
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7deH61mGoYB4ZlBnE8zLBoEoBMhm4K+Y8QnNJey8Q/0=;
        b=AtgS7V3zeyxambCbsaXhx5Ary8nBi0SQVaPpfWNC0aZSMltlDVmgrzsU7EDJsjINBO
         JKRzyl5HN2G+YY0a1mSCjKBmZ+jvSydnOMRCq1+eW442uSOmBIhRdAPxQYcNFiyakrvd
         H9MC6hddrrAdsSDr0NrYZClsiLlfBSE2gmWU8LNHWHS5olVGrlXFX1fxXIDGvr60NR4h
         W3piXamKgkrLECRqWEnSCwOrGXrw7h8Rzuqb/dMPLWlOa49Zje9EnVzPU6dZ2W51f+sv
         3C92b8OlztEddzGDQpayof9t8ka+aCjTPYj2bBTCyFAjoPthERXs/yw8wyBpVs8Ah4Mr
         f6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7deH61mGoYB4ZlBnE8zLBoEoBMhm4K+Y8QnNJey8Q/0=;
        b=SfARFNd9OeykJiQUb2zaxq6hjYlnefjUIc5UO6Pu2CHxphLlRIyciU8LISMdn4lyt2
         Nyqmjzu5TMAatl98Li1E97XFXi+BY823D32a0qVXtLH7TLJDrG8HZcixIbS+IBT+2R/H
         jvMjOSciFLvGRM0Bz4HW8BD8mmHZGuScjPtjfS1Eh+hjHoMXmU4iar1A3bk9cqMTU/9k
         Vwnrz9CN1iiBqWSrnl2Rr2bCg1FuEF5x815GMaCpBgHJ8lKo56gj95NtbXCwTgH3TLYb
         My8tHWD+HrOSZYyvyiCRuUUJonXGNxxrLefKW4ZGdbk/0MOnualABT0rL7ho10KSUYrP
         i7PA==
X-Gm-Message-State: AOAM530W1Ak4j7SBREeBtaVsaRHgZPvdytVS2LTbmMfQfh+aD9RkKlt0
        cJjm1sYB92zQQFpjnyDt/U+UOfuqUN8=
X-Google-Smtp-Source: ABdhPJwejiZUWaeVjKufYF31pNmMdDLWgurLb3gL2on2QnIngYC2CRcefYS1ikaCXH37G8mtbdTSCY58O/M=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:c948:b0:15d:3888:7299 with SMTP id
 i8-20020a170902c94800b0015d38887299mr15242197pla.121.1651194268900; Thu, 28
 Apr 2022 18:04:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 29 Apr 2022 01:04:12 +0000
In-Reply-To: <20220429010416.2788472-1-seanjc@google.com>
Message-Id: <20220429010416.2788472-7-seanjc@google.com>
Mime-Version: 1.0
References: <20220429010416.2788472-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 06/10] KVM: Don't WARN if kvm_pfn_to_page() encounters a
 "reserved" pfn
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop a WARN_ON() if kvm_pfn_to_page() encounters a "reserved" pfn, which
in this context means a struct page that has PG_reserved but is not a/the
ZERO_PAGE and is not a ZONE_DEVICE page.  The usage, via gfn_to_page(),
in x86 is safe as gfn_to_page() is used only to retrieve a page from
KVM-controlled memslot, but the usage in PPC and s390 operates on
arbitrary gfns and thus memslots that can be backed by incompatible
memory.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ab7549195c68..a987188a426f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2703,10 +2703,8 @@ static struct page *kvm_pfn_to_page(kvm_pfn_t pfn)
 	if (is_error_noslot_pfn(pfn))
 		return KVM_ERR_PTR_BAD_PAGE;
 
-	if (kvm_is_reserved_pfn(pfn)) {
-		WARN_ON(1);
+	if (kvm_is_reserved_pfn(pfn))
 		return KVM_ERR_PTR_BAD_PAGE;
-	}
 
 	return pfn_to_page(pfn);
 }
-- 
2.36.0.464.gb9c8b46e94-goog

