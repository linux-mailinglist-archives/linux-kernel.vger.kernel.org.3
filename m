Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8741659F20D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 05:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiHXDbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 23:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiHXDbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 23:31:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDC482FBE
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:31:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-334d894afd8so271882237b3.19
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 20:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:reply-to:from:to:cc;
        bh=Z54IdbizvYotozVIMDtoqcYxUHW5yuV8P5ZQf2bW8IE=;
        b=P8uxxPhqycXk5y8+6bE7bnn35SfFw7wt+BmitoV/f8mnG4iIllmtpPH3VZ4Nq176h6
         N1onL6oZGstI7LYuOM1IpKcHU2WKikT7w4rKE020OSVK/R7fDt1FsWMVJYW/RfpnESZF
         0JjkWIIDMDc8LnwBcH1FC0LwyuXmdPXogOMytTapsZo1HTWGo+/jKp0xZc+bJ0dH3u+r
         Laaa9WQCe2WLQQdZ7nDkZXIC1tis3fwJg88a/W30B4Qh2N/myIPT1gXY+tC5Z6EYjr1t
         QeMk/CnKq+w2ajvLJ5qR28Vh2hy1lfE+ZKKjsEUELo1vxRhNOQeIFdpNaafc4+H1eX6G
         tj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:reply-to
         :x-gm-message-state:from:to:cc;
        bh=Z54IdbizvYotozVIMDtoqcYxUHW5yuV8P5ZQf2bW8IE=;
        b=x388uYWBl5V/QG5BYcMEcFwkz4dp/R+3nr2ig+zXXjum22Gu0AXfIxTR4/4c4iGlrN
         sOV2z0Xh9H5Gw6Al3M+lp2hW4BjLZzGaJ0T6xMlC+k+lPLAYmi2P5GeGfy/nkWmJms7v
         z9NRm6iFQn+eKwsjIgmtspVu4iPwBpsF/mv+HQzVpGAOILDOE7A8MZFOWP1HvDFbxE2+
         rwEvspdQKD1QIpGPAE9050cCq1XJ3SUgleN3iVQZ9B/eI1GItirq2ug8dzQDhxhP0NWc
         kIPJruFEqpfr4lmyS7WbGfhltjijV9/yraf8JCsEXrShkwp+IAOEWS9afOb2WoP4Zxeu
         sm1Q==
X-Gm-Message-State: ACgBeo0+MTAWiJahdi267Pox6uGJpPPqjyQZYTTF+938sr2BtW3bnaFQ
        PRI0foNoFxDIEv0HH4+gcEg9EVitGZA=
X-Google-Smtp-Source: AA6agR56OqT2CxXRvhiqd538yjOYAS46bSpzMuNWg4ba7/icT3+yvKoKx7nOsq8lBlFC53CFtH3bTvgfc8s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:7346:0:b0:329:ca9b:a53 with SMTP id
 o67-20020a817346000000b00329ca9b0a53mr30490147ywc.377.1661311860223; Tue, 23
 Aug 2022 20:31:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 24 Aug 2022 03:30:54 +0000
Message-Id: <20220824033057.3576315-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH 0/3] KVM: x86: Fix XSAVE related bugs
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leonardo Bras <leobras@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
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

Patch 2 (from Dave) is the headliner and fixes a bug where KVM clear the
FP+SSE bits in user_xfeatures when XSAVE is hidden from the guest and thus
prevent userspace from saving/restoring FP+SSE state on XSAVE host.  This
most visibily manifests as a failed migration (KVM_GET_XSAVE succeeds on a
non-XSAVE host and KVM_SET_XSAVE fails on an XSAVE host), but also causes
KVM_GET_SAVE on XSAVE hosts to effectively corrupt guest FP+SSE state.

Patch 1 fixes a mostly theoretical bug, and is also a prerequisite for
patch 2.

Patch 3 fixes a bug found by inspection when staring at all of this.  KVM
fails to check CR4.OSXSAVE when emulating XSETBV (the interception case
gets away without the check because the intercept happens after hardware
checks CR4).

Dr. David Alan Gilbert (1):
  KVM: x86: Always enable legacy FP/SSE in allowed user XFEATURES

Sean Christopherson (2):
  KVM: x86: Reinstate kvm_vcpu_arch.guest_supported_xcr0
  KVM: x86: Inject #UD on emulated XSETBV if XSAVES isn't enabled

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/cpuid.c            | 11 ++++++++---
 arch/x86/kvm/emulate.c          |  3 +++
 arch/x86/kvm/x86.c              | 10 +++-------
 4 files changed, 15 insertions(+), 10 deletions(-)


base-commit: 372d07084593dc7a399bf9bee815711b1fb1bcf2
-- 
2.37.1.595.g718a3a8f04-goog

