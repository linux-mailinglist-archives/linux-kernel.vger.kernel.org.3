Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2601252AF16
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiERAQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiERAQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:16:54 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0F337A0F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:16:53 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id z21-20020aa79595000000b00518157fadaeso300667pfj.14
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=Uk+r/Ye8RUtuFssRUQCsJAdweKBLxpWTQeK/Mqx8i5Y=;
        b=kInWvocUnGbmyRCfLMSda8KksnmvuCeV8fsa8v0H974QRIhB0Mxvp2LVxyVLAc/bpc
         P0WKHdeAmtZYY0wlEBpHkaZ0u5AY2CQToXnxugF34SRIBVYsQ/QXyWut90dEf5vrhq/3
         pwN1cFhz+CRRkfqmzuRprg2HPGrlRFE4o/QH9es2/rp8RG1IFo3tMalBP3ftdRPTg1J3
         x3LqRR7PX8hJ943BRYb/3oI96FCVAx7yDtSkZgqXLCr83Xa2VagjNIHRmKMsc5Ba5dEQ
         FS1LnPi6iH2GwaXVjd+obiVZIXuq80LzlmuDun/ydVBZZ/5YYRk/a/TJwKae2sjKgUz+
         4Zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=Uk+r/Ye8RUtuFssRUQCsJAdweKBLxpWTQeK/Mqx8i5Y=;
        b=PM6GXgI6Y59JdgB252Ffd5PsuUeTDGX0+0rzfzfQjK/cAkFk/uUxbAYnwlxFuZmaxZ
         7sq4/B6i3x2FxKnNyX5rTPITFPQoUzZPai44ioFWarJKx6AHECpogYW0RVHG36VKxCoS
         G1G0KTI+4TK3p2m6rLZIhnRulGUzyyo7R+C8r3djftk/5DWrcC6R7c+3tPN3GUfmNHaw
         d7RWOF0hgoNe77mKQmja5DBCiwuN/3+bZZgEp6FbBneY5NlT1MRN9cjijTH6zL7PgeLO
         kmenwAG1TyHcy7AlDo5vGsTxPJXWLVVyKeRX/FRJ5SIZ4OKIHdPWGvtiddYmpdnvcfLO
         ICqQ==
X-Gm-Message-State: AOAM531lLGK4BfxI4FQ2BRvO1HSKPz1feJGZS2i1wUg67JWKkX4tIi/3
        AJMh2rSL0mKosyPirJP2XkF6HLqSyfg=
X-Google-Smtp-Source: ABdhPJyk3QgPB7q1I8lY1iXLHKozmlUZ5Ce9hJ+buWepQYqa6a0UHZ1e3SqsiowAKrG2PtCwe8oKRsNJAeo=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:6d0c:0:b0:3c1:7361:b25b with SMTP id
 i12-20020a636d0c000000b003c17361b25bmr21423393pgc.449.1652833013390; Tue, 17
 May 2022 17:16:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 18 May 2022 00:16:44 +0000
Message-Id: <20220518001647.1291448-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 0/3] x86/crash: Fix double NMI shootdown bug
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

Fix a double NMI shootdown bug found and debugged by Guilherme, who did all
the hard work.  NMI shootdown is a one-time thing; the handler leaves NMIs
blocked and enters halt.  At best, a second (or third...) shootdown is an
expensive nop, at worst it can hang the kernel and prevent kexec'ing into
a new kernel, e.g. prior to the hardening of register_nmi_handler(), a
double shootdown resulted in a double list_add(), which is fatal when running
with CONFIG_BUG_ON_DATA_CORRUPTION=y.

With the "right" kexec/kdump configuration, emergency_vmx_disable_all() can
be reached after kdump_nmi_shootdown_cpus() (currently the only two users
of nmi_shootdown_cpus()).

To fix, move the disabling of virtualization into crash_nmi_callback(),
remove emergency_vmx_disable_all()'s callback, and do a shootdown for
emergency_vmx_disable_all() if and only if a shootdown hasn't yet occurred.
The only thing emergency_vmx_disable_all() cares about is disabling VMX/SVM
(obviously), and since I can't envision a use case for an NMI shootdown that
doesn't want to disable virtualization, doing that in the core handler means
emergency_vmx_disable_all() only needs to ensure _a_ shootdown occurs, it
doesn't care when that shootdown happened or what callback may have run.

Patch 2 is a related bug fix found while exploring ideas for patch 1.
Patch 3 is a cleanup to try to prevent future "fixed VMX but not SVM"
style bugs.

Guilherme and Vitaly, I dropped your Tested-by and Reviewed-by tags
since the relevant patches changed a decent amount.

v2:
  - Use a NULL handler and crash_ipi_issued instead of a magic nop
    handler. [tglx]
  - Add comments to call out that modifying the existing handler
    once the NMI is sent may cause explosions.
  - Add a patch to cleanup cpu_emergency_vmxoff().

v1: https://lore.kernel.org/all/20220511234332.3654455-1-seanjc@google.com

Sean Christopherson (3):
  x86/crash: Disable virt in core NMI crash handler to avoid double
    shootdown
  x86/reboot: Disable virtualization in an emergency if SVM is supported
  x86/virt: Fold __cpu_emergency_vmxoff() into its sole caller

 arch/x86/include/asm/reboot.h  |  1 +
 arch/x86/include/asm/virtext.h | 14 +-----
 arch/x86/kernel/crash.c        | 16 +-----
 arch/x86/kernel/reboot.c       | 89 +++++++++++++++++++++++++---------
 4 files changed, 69 insertions(+), 51 deletions(-)


base-commit: a7fed5c0431dbfa707037848830f980e0f93cfb3
-- 
2.36.0.550.gb090851708-goog

