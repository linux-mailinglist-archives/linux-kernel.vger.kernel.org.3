Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C3A55A378
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiFXVax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiFXVaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:30:52 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BD97FD0E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:30:51 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id j10-20020aa783ca000000b00518265c7cacso1647811pfn.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=zMPtClkNy/rRRFXv8P9eDIPEjyOeV59e+BT5wJdtnTI=;
        b=UzL3u/9KI/PTLzCg/P+tuJKTRZT0mfc25ekz6upxcv9OfUHPNAylLKxx6yYmXOBnLi
         USobz+Ex9DSU2fpFB659H0rDnBmur9AjTjyAfscyFsAEiwgof/WG81MGCJr7D+KhSsyo
         cxnIaSTlBRgEoF/q2DI4UC5eU2YU14q1EhqaF0QcLfimm5iBvlRh7ZiOaRW+utsujlP1
         yx5d8N2Dqy0X8eXmrovFnTNpK6IhqtYr6YnqCRSXMDpTi0fvBYicFp+51HeYCkHo+xPn
         Cv6wYXL9C5ICsMmyDaf9TlvteF3rbOpSneFcAIvbNBdFNGoyGXXtQQjQ2ZoUniiWeJxz
         8E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=zMPtClkNy/rRRFXv8P9eDIPEjyOeV59e+BT5wJdtnTI=;
        b=NtZ/t4IsxLc0oyiYUCTHQiZ34c3gzVcD83AzUoe7lV63QIRNXVaVu6MY0n635CxWLd
         lj/5y2aNzvOBaeJo1eITAo22EXe+MS0+oNXjF1xL85yJNUH3ctoHCb490vgjm2oOp+kS
         HJV7mdfPdkTSx4Swj7Erq+GH2dVMB7vaGHp+qva21gRqoTK20QL+jIGXSMDKet63Ff9j
         Ywas8ELVWcMvGxDeAVKa+6yDFZPWpnhyDtjxlfKGfqwTJ4uwrO8AaZh3mnVH5QFkWXkN
         Ajzm+4WLU4U/P+XqgowObRQh7UB/wM2Zoo/CzTikOmim54wkl+mk+HMbvyu40ovwj+Y8
         B/gw==
X-Gm-Message-State: AJIora+BUC6RlPrcnyTIBcQ7JSP8UygilxtompHlmhdHncPAebpbUWsY
        mhzcx2heGc1qlqgbmNL7G7nxBSJMUkM=
X-Google-Smtp-Source: AGRyM1tkcN2VjS7vtoEyCYilN3tph0RZx7u8qAibppLJACIOeYHd2iTFQfTI8+Wqe43vwTgU2shU56fEf74=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:8c51:0:b0:525:4141:fe5e with SMTP id
 e17-20020aa78c51000000b005254141fe5emr962347pfd.51.1656106250779; Fri, 24 Jun
 2022 14:30:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 24 Jun 2022 21:30:35 +0000
Message-Id: <20220624213039.2872507-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 0/4] KVM: x86/mmu: Cleanups for eager page splitting
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>
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

Eager page splitting cleanups for a few minor things that were noted in
code review but didn't make it into the committed code.

Patch 1 goes beyond the eager page splitting series, but it's still very
much relevant.

The last patch in particular is a bit more urgent than I first realized.
I had forgotten that pte_list_desc is now 128 bytes, and I also had a
brain fart and thought it was just allocating pointers, i.e. 8 bytes.
In other words, I was thinking the 513 object buffer was "only" wasting
~8kb per VM, whereas it actually costs ~64kb per VM.

v2:
 - Add helper to compute SPTE's index into its parent. [David].
 - Collect reviews [David].
 - Tweak the comment in the last patch after more analysis.

v1:
 - https://lore.kernel.org/all/20220624171808.2845941-1-seanjc@google.com

Sean Christopherson (4):
  KVM: x86/mmu: Add optimized helper to retrieve an SPTE's index
  KVM: x86/mmu: Expand quadrant comment for PG_LEVEL_4K shadow pages
  KVM: x86/mmu: Use "unsigned int", not "u32", for SPTEs' @access info
  KVM: x86/mmu: Buffer nested MMU split_desc_cache only by default
    capacity

 arch/x86/kvm/mmu/mmu.c         | 74 +++++++++++++++++++++-------------
 arch/x86/kvm/mmu/paging_tmpl.h |  4 +-
 arch/x86/kvm/mmu/spte.h        |  6 +++
 3 files changed, 53 insertions(+), 31 deletions(-)


base-commit: 4b88b1a518b337de1252b8180519ca4c00015c9e
-- 
2.37.0.rc0.161.g10f37bed90-goog

