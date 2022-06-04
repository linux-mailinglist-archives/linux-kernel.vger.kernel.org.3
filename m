Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB07253D487
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350246AbiFDBX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346233AbiFDBWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:22:33 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC46B1C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:21:53 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id q13-20020a65624d000000b003fa74c57243so4559900pgv.19
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=fEtaJeNPMLGJ/eGkpGlOpofTkW2QGNDDuGU/ZlXwm9s=;
        b=PWUuQyFQ0cb3xfkqq4zlJ7Oad3BKjmzjKlg31Ey4NS/AnNeLSb3E8qehZAMYcH7XCY
         74xj8JWZPd0FH4w+79Mxohjo9stx9NZNG9QDok8L7RpnBOS0wBks6cEkHCNIflkEB6+4
         82DfnKCLW490G/Gk9UAE0spgsnxs0vfNZ2QxUF5UfGMUUTxMxigCTC6rx2xbrgchNkN6
         rM1GkVmZKVUQ5/nQCXKLQ+OhgSCHschbjC+BZ2O8YQDn4dhv6guu/DxjZsFIY+MDgF0L
         liIOYoHqZC+fDXAUcC3xGQaQTemTWN7IgS9Vj1i4+05psSeGqAymYJG2329//7OTh0EO
         QOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=fEtaJeNPMLGJ/eGkpGlOpofTkW2QGNDDuGU/ZlXwm9s=;
        b=r/ExJcjxu8zm+0AP1TgqL0D7srFFVapX1fBozGm4ekcWpXJsl2aXtrA15SDSWxyKN+
         OwNwyGM7+RAB1WDuZKSyDAn1VW1y3VQe6/V0T+f7TZZtHq+o6LIal8h/yAKKVhaBtuPD
         gIH5avs7mJZ/nQy0u4WFHOw3Y9mUjlZiSBcTvknEBK437qhpinyUg2m5C+pSVwog6te1
         u8csvSk2kVvmkgkGsk7LzbnlpgJtiH43t3GfXWvxk73+XBmK0lRTLaBpOyGLM/N5RXgk
         cDsgauy81gN75Il/XTft81+HrubtPnMqCsSo+Q81HX/CguBuoQVrW4GuXgM6qEBRf8AK
         IlGw==
X-Gm-Message-State: AOAM531A04lfL71P4GDbYFc4o83HJ4A5XBRP9Gvpg7jZ2FXnV9XUP3q+
        eDlHMhZfuIju6RbOH3tXf3iZTZIm9vU=
X-Google-Smtp-Source: ABdhPJw7a5VWey3nupaM34wl9wZIoJpZ3nkG6SpJ2KXXyR7kAHtXZyRbej3UxyVdSXlQ3l687VNltPilckU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:b58c:b0:163:920c:6164 with SMTP id
 a12-20020a170902b58c00b00163920c6164mr12927685pls.58.1654305700533; Fri, 03
 Jun 2022 18:21:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Jun 2022 01:20:39 +0000
In-Reply-To: <20220604012058.1972195-1-seanjc@google.com>
Message-Id: <20220604012058.1972195-24-seanjc@google.com>
Mime-Version: 1.0
References: <20220604012058.1972195-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 23/42] KVM: selftests: Use vm->pa_bits to generate reserved PA bits
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vm->pa_bits to generate the mask of physical address bits that are
reserved in page table entries.  vm->pa_bits is set when the VM is
created, i.e. it's guaranteed to be valid when populating page tables.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 6c21893f5038..5383ccdeb8e2 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -222,16 +222,12 @@ static uint64_t *_vm_get_page_table_entry(struct kvm_vm *vm,
 	uint16_t index[4];
 	uint64_t *pml4e, *pdpe, *pde;
 	uint64_t *pte;
-	struct kvm_cpuid_entry2 *entry;
 	struct kvm_sregs sregs;
-	int max_phy_addr;
 	uint64_t rsvd_mask = 0;
 
-	entry = kvm_get_supported_cpuid_index(0x80000008, 0);
-	max_phy_addr = entry->eax & 0x000000ff;
 	/* Set the high bits in the reserved mask. */
-	if (max_phy_addr < 52)
-		rsvd_mask = GENMASK_ULL(51, max_phy_addr);
+	if (vm->pa_bits < 52)
+		rsvd_mask = GENMASK_ULL(51, vm->pa_bits);
 
 	/*
 	 * SDM vol 3, fig 4-11 "Formats of CR3 and Paging-Structure Entries
-- 
2.36.1.255.ge46751e96f-goog

