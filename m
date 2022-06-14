Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0340A54BB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357313AbiFNUJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357289AbiFNUIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:08:01 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211C2403F8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:07:54 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id p123-20020a625b81000000b0051c31cc75dfso4237606pfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=6sq6rj6hOcf7RofhLuTE1YZqxCrSxa9nH7bmYla6Ve4=;
        b=gtFwbBvlNOl94V69Y69CeUBN/v/9ZsmCJYxvsdf5jkijI3TKi8zWco4zFrPlLI/Dbr
         w30+1Ydf0dlNImj7N+ySceO8//UGPhQ6n4YwAHZlqV1n/Ad679e+Io29psdRUTx5JHlg
         gOhiVphWmk7dGAi5F9BOKfNXULxDAThXEOgoVdU7lbSiZqN1GR0dN9SnoT1dkIi4rBoq
         zvu7poj57gUnNJdxcl3MJ4+7ITtlOhtgX+rNitJJwq9OHq8AFQ1JWh2kf4Z895mBUqKz
         SQUey1k/WGWPnJMkVKfugkgwf9lV0D3oNPZcadjnl3rsLAJ+hUxqdr6I66YNpOH5EJFn
         OhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=6sq6rj6hOcf7RofhLuTE1YZqxCrSxa9nH7bmYla6Ve4=;
        b=BueV7yDgWk9VuV0OO33zmAnZ7UwFNeWIRkKR384hTrmYaEq78rxIc8XrkvZGKyOK0w
         j/EL9SRfpKhAL0uzhgqLkvTADLweWmCy0XBvfilL33TIKgG2wq8flhDnSoYxgnvEaT6M
         QH+vn0xQzdScdsIzaCTpJcKb6l1Ri39IPTeiTd0Y2IaKak2Shte/HBI7IYn0eFWcrIUj
         gSj/avq5oCg5dRY2jQefp6Z7Q8A5V5548dyZncZlZLh+G+IrcgwU4jE7a8tq6Trfx2e1
         k/yaWW+EZTtipBh1I3WvnsixGE4CWPIAd/LTunNvE7O8J31/KZOPpbO+rNAV/bNobikI
         guww==
X-Gm-Message-State: AOAM530cEQ621w9/K0l/jHtQW2KRP3cFbQtlj6xKGYIwE3nkr22uy5Fx
        PKTi6lPhARQvEI90jOYcfB4+6XkuXQw=
X-Google-Smtp-Source: ABdhPJwc8Qgd57+EiS3z0qYQYX/WbkXJMJSV/lS4my02g7V+8R8qwOxGczY3Ka2H3SpOwbUW1vGd2h2xDDM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:8141:0:b0:518:425b:760e with SMTP id
 d1-20020aa78141000000b00518425b760emr6360171pfn.27.1655237273630; Tue, 14 Jun
 2022 13:07:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 20:06:48 +0000
In-Reply-To: <20220614200707.3315957-1-seanjc@google.com>
Message-Id: <20220614200707.3315957-24-seanjc@google.com>
Mime-Version: 1.0
References: <20220614200707.3315957-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 23/42] KVM: selftests: Use vm->pa_bits to generate reserved
 PA bits
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
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
index 887272a33837..5fd6563f23d1 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -221,16 +221,12 @@ static uint64_t *_vm_get_page_table_entry(struct kvm_vm *vm,
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
2.36.1.476.g0c4daa206d-goog

