Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0B156C555
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbiGHXXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbiGHXXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:23:09 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65861419AE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:23:08 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h11-20020a170902f54b00b0016bfdca124fso28569plf.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 16:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=+6AcP1HWw661Qpr+lBZwEqnetiODARhUxEJKO0pVxWU=;
        b=j/tiBmyZblQHV+HNo+8wJ4bia1A4rlEbbmJw7VT15wepVlBA4N3bOcEu5H7Sa5994x
         L0yl+Csc6g1gSFJUeVfxdH9pf4Q4QkPqD17crVXXtT6VyIFLPhUIRF4tV5cfbfkU6wam
         1JlFyQmvSc9lyOtPpXudz0Zkr7v11SbJJupEeV4n9D4geJC0CEoj7cSGQ3bNEwYLytGp
         L52TxW867lXpOW5wNg5ZbMqr7Lwc9o3yi0HB9dxcWi5xKC6iGwRYB0OIGEEbKvhhmjsm
         8ZDo5kSt11btuPU8dH8kPUbsE4W+27qYlWWWi6VvnVEoqoxAX7/BPMj5f3Lyy2FYmRvM
         W53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=+6AcP1HWw661Qpr+lBZwEqnetiODARhUxEJKO0pVxWU=;
        b=t6OFOULCl6K3VsP1Htik2oPN+/33WjnOdlhWI6ynTdQBrMNt4P4M/OexV9AXF9vCcx
         7PzExaE59Wjk+/MvbMrqFEHYmA6/MD5tEQkA+3+v5jauuuXOko0fkVN+1sO8DXZapdyr
         e73FLhstC2nlySQSveXBf7nFUgEMoZ8ypVota/TH25tGxCTpTgl2su5TDR+IoFeUvyTv
         p4LxRpw2aDICEhOxiojJ3fTqr21lvNYVwcc/27Tw+lCsrPOHslrd40N5mPNjOni/EeK+
         1vtTnvu1Xtf9hDq5OvPwVUZPjU2buy+tMf5fXxGSffnDzsqJ6r7Q3xirhFoxfFJJCvJb
         F3jw==
X-Gm-Message-State: AJIora+6fKZdMAUP+/5jYUp/slhd4tHHPiEwRsmmOvwmOguxhGK0YxG4
        cAnJAEVXnjZ8+UllS/KOWhcaKhTlHoa6
X-Google-Smtp-Source: AGRyM1sMnSAK5x1LioJXvUOqDZwyZnrYbj/8VTx9+GqrlJTmSFDKn1x7xTu9SL5jVQzzY+TCHZA1W8+Brf/3
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a63:ea05:0:b0:411:f94f:b80f with SMTP id
 c5-20020a63ea05000000b00411f94fb80fmr5116719pgi.189.1657322587944; Fri, 08
 Jul 2022 16:23:07 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Fri,  8 Jul 2022 23:23:02 +0000
Message-Id: <20220708232304.1001099-1-mizhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH 0/2] Extend KVM trace_kvm_nested_vmrun() to support VMX
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>
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

This patch set update trace_kvm_nested_vmrun() to support VMX:
 - Change the print of EPT/NPT enabled boolean to print of nested
   EPT/NPT address in the trace;
 - Add a caller from vmx/nested.c.
 - Fix some minor format fixes from the callsites and Update the trace
   output naming according to the x86 vendor.

David Matlack (1):
  kvm: nVMX: add tracepoint for kvm:kvm_nested_vmrun

Mingwei Zhang (1):
  KVM: nested/x86: update trace_kvm_nested_vmrun() to suppot VMX

 arch/x86/kvm/svm/nested.c |  4 +++-
 arch/x86/kvm/trace.h      | 19 +++++++++++++------
 arch/x86/kvm/vmx/nested.c |  9 +++++++++
 3 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.37.0.144.g8ac04bfd2-goog

