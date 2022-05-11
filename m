Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF5052412D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349450AbiEKXnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349431AbiEKXnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:43:40 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC3E61632
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:43:38 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id h19-20020aa796d3000000b0050d3c025470so1785846pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=AhvIfbu9X3YULPVlS1YjRn191iB1PujI5/9ME6nYCik=;
        b=DnUML6wIBadul/FL+4pRJQuZEM5l6O4nJeDvMnUI2YmzUb5rJkLIU5kj4yL33RBi68
         XmEnmdGjOIKbDmFdndazf0qw3r1Puu5ZRWgCeCepx0Gr7Hpo5yesHaMttzAPhoN926r4
         xiKXTzs/zPVheNDGZgxa2LhbtnD1ObIQxYdSphU8ZdE8pb9UvIcKMmYnenrl4QzrRbHa
         o6gKqb6LHg2TwKOPC6Xa5ZnxKNH6kwt9KUALkZVGgcxfVxs/TOP6Cy4rDHINHITNcQay
         mSfYrjo29jeKzq+xkuLVNfS4mObtMcVpxP+3Z0WXaqusndoBeuX6ywKFXft9gB/IFJKO
         hTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=AhvIfbu9X3YULPVlS1YjRn191iB1PujI5/9ME6nYCik=;
        b=oJwI52j+naKrFb4NR2B9jMuLZgDs2Z6pO+GPDEDKY1UXLqQCbxkrh5NKoCo6DmIiBz
         vRGF7Zp0gzuVFg2dNYxd0vXnlU8hVP5+Amfhed2OcRTAYbPmuUbCPer/Pcpu7519HOzB
         oD1pwRFCwgc2DIZh6vHlvP+3B7Wk5wmOwAGIapOAUQTij1zWxD/fCj1Kip4nOud78UiR
         /1IlxcDC/E+bMxMXRjBVmmPgvCZ58ClXxyJpamZjKJsCL4sHJOnN1+IfI/PCsbAYuvD7
         5wNP/MVldSGLO7NZ/pBsdvqUdobNqrbrEJlA+lcZlDmnkEPZXIMwPQutDWeS6C/XKdb7
         fnfw==
X-Gm-Message-State: AOAM530etaU/qA0tLgRGTeLvDsD8/iIM7/Q6jZCGivGWjxa9WpbDn6y5
        CBb4lv9OOZeSwaQQ6BEoYkhi280uUVs=
X-Google-Smtp-Source: ABdhPJx9RKaiblAmdK5c2KrAPjFFUQWMXndsKum748UpvEOIMnytBalgOMcalvT2ieYzfC8dZyjhjFbO394=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:b41:b0:50d:35fa:476d with SMTP id
 p1-20020a056a000b4100b0050d35fa476dmr27527530pfo.33.1652312618270; Wed, 11
 May 2022 16:43:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 11 May 2022 23:43:30 +0000
Message-Id: <20220511234332.3654455-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 0/2] x86/crash: Fix double list_add nmi_shootdown bug
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
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

Fix a double list_add() bug found and debugged by Guilherme, who did all
the hard work.  nmi_shootdown_cpus() doesn't play nice with being called
more than once.  With the "right" kexec/kdump configuration,
emergency_vmx_disable_all() can be reached after kdump_nmi_shootdown_cpus()
(the two users of nmi_shootdown_cpus()).

My solution is to turn the emergency_vmx_disable_all() shootdown into a
nop of sorts, and move the disabling of virtualization into the core
crash_nmi_callback() handler.  The only thing emergency_vmx_disable_all()
cares about is disabling VMX/SVM (obviously), and since I can't envision a
use case for an NMI shootdown that doesn't want to disable virtualization,
doing that in the core handler means emergency_vmx_disable_all() only
needs to ensure _a_ shootdown occurs, it doesn't care when that shootdown
happened or what callback was run.

This obviously punts on making nmi_shootdown_cpus() truly multi-caller
friendly, but notifier chains tend to be messy, and it's not obvious to
me what would be the desired/correct behavior for a true multi-shootdown
use case.

Patch 2 is a related bug fix found while exploring ideas for patch 1.

Sean Christopherson (2):
  x86/crash: Disable virt in core NMI crash handler to avoid double
    list_add
  x86/reboot: Disable virtualization in an emergency if SVM is supported

 arch/x86/include/asm/reboot.h |  1 +
 arch/x86/kernel/crash.c       | 16 +--------
 arch/x86/kernel/reboot.c      | 64 +++++++++++++++++++++++++++--------
 3 files changed, 51 insertions(+), 30 deletions(-)


base-commit: feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
-- 
2.36.0.512.ge40c2bad7a-goog

