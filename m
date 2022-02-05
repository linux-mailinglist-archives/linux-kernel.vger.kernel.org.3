Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AF14AA790
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 09:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbiBEIRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 03:17:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33906 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231174AbiBEIRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 03:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644049051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iAD851LcLXDVa0QUog2OipK4rBTjALzioBqLSupE+xM=;
        b=TMEWa3mcoHAF2GyNeJpZiaFPQgoK1Hidludrq90IcgTSowhLB20J6hoLCG6p1A53qqll9h
        0TFRAeerZGz3AZQc/CR0MSczXPLXtkd6uPkK8PtTLDiAxRhMzTu6aOEjm2KToTv1tDJQMn
        qZuBp4lRbDXq/DJ7ETD93Zbr/XcWZtI=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-_9LxDJL5PDiGABSIJ_WOdQ-1; Sat, 05 Feb 2022 03:17:30 -0500
X-MC-Unique: _9LxDJL5PDiGABSIJ_WOdQ-1
Received: by mail-oi1-f200.google.com with SMTP id bd39-20020a056808222700b002cd93cfaad4so5308663oib.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 00:17:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iAD851LcLXDVa0QUog2OipK4rBTjALzioBqLSupE+xM=;
        b=CqSx02mBETdEfbKvzXiqoT6f/crHI0p4xFQGwO+e5h5l3lYvxwMhQmyYJzZvJOKx8u
         KxMkK/Tv9CM4vt3lrOXnufprMzzKT8yDc6HH4Va5y39J4UBa7UwXN8WGwfWJBCiwOikL
         vxKJ4ht+8w+b7vp3+yh+fJxBsPJM5nsGGjg+UczsddD4fxdPTGwa0oQIkSkkhYBKbHln
         CjYmfeqTOi8IQINBwJa3pW2PmqbhYuGMpqKmfO3ea6JLFg1gs31NWGa/TueccXxdbbdw
         CkgYN9f1OGc0JR6W1hzjj7UPOpaGrlx034gNkkufl7+8anVKXzusXk03Vi0DZ3dNygUu
         uZZw==
X-Gm-Message-State: AOAM532Ark0NPWTs0G5ERY67cRcgeVq0jhOxfu6CXYkTfg5GmPxrJCmu
        GswLBQfZ73H4UzpIoiifAfyaPvl4DYaHbcznac0DV7mrJVAa8iCT69RScabKccynnZxSJ3McJar
        +GpA4f6WiQ5QaMGz9+8swnPlJ
X-Received: by 2002:a05:6870:8642:: with SMTP id i2mr1308993oal.303.1644049049555;
        Sat, 05 Feb 2022 00:17:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjT9AO0jjdF8yQKYY92+m4lAxKx1Yw7B9E1bCX8rTAcUrmgTgVw4DsL8DFW3YS12+vTxC0mA==
X-Received: by 2002:a05:6870:8642:: with SMTP id i2mr1308984oal.303.1644049049387;
        Sat, 05 Feb 2022 00:17:29 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7f0:b1af:f10e:1643:81f3:16df])
        by smtp.gmail.com with ESMTPSA id bg34sm1708795oob.14.2022.02.05.00.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 00:17:28 -0800 (PST)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Leonardo Bras <leobras@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] x86/kvm/fpu: Fix guest migration bugs that can crash guest
Date:   Sat,  5 Feb 2022 05:16:57 -0300
Message-Id: <20220205081658.562208-1-leobras@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset comes from a bug I found during qemu guest migration from a
host with newer CPU to a host with an older version of this CPU, and thus 
having less FPU features.

When the guests were created, the one with less features is used as 
config, so migration is possible.

Patch 1 fix a bug that always happens during this migration, and is
related to the fact that xsave saves all feature flags, but xrstor does
not touch the PKRU flag.

Patch 2 comes from a concearn I have of the same bug as above hapenning
through different means, such as a future bug in qemu, and rendering
a lot of VMs unmigratable. Also, I think it makes sense to limit the
fatures to what the vcpu supports, as if it were baremetal it would crash.

Please let me know of anything to improve!

Best regards,
Leo


Leonardo Bras (2):
  x86/kvm/fpu: Mask guest fpstate->xfeatures with guest_supported_xcr0
  x86/kvm/fpu: Limit setting guest fpu features based on
    guest_supported_xcr0

 arch/x86/kvm/cpuid.c | 3 +++
 arch/x86/kvm/x86.c   | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.35.1

