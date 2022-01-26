Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AE449D09E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243671AbiAZRWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiAZRW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:22:29 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8774CC06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:22:29 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id ga20-20020a17090b039400b001b536800e04so181487pjb.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=4zdqvDRcKscDm+lnZv7gUuJZV8rrHFi40CWOKIaL7JI=;
        b=aB+N+NsJ2bzr0imFihYSeflE2CQvIUancoVRwZRxvgRXBSsvH6WyZ4qorMMtoLiPoK
         mzU/8QfNGqpuc9LHzoEr0ykFebxxw3UdHeAUjPE8+Rnk98TZ7rismWQmnL2dkhEm/DrQ
         gxyeHvYimaS3vwQC7N5m0RQJbtvlsIwxSfO2PRpyBNAebd8JqcWrS7jIADG2tLt0S1A4
         6hFjoxBfbK7q0JkSH25T6AggzpUyqVFCaV9SnZiqXbwSk0+9/iBu5FscSkAKbXQMbsc/
         TE5ZL0VeANPHRAMEdwJDaSe3NmT+vJWASJNoM/1QADyxXrUcruPmPe4fFOcmtufrlRcQ
         dxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=4zdqvDRcKscDm+lnZv7gUuJZV8rrHFi40CWOKIaL7JI=;
        b=g6lLQkLs71ptiDIfzKOeMhcNa2uk4CCi/jH+CDmetfMhQDk99HlfwL6xKzLEQVzesc
         /Lw/o3TFqCVQyd5x1DBRJsKeEG8TyTCXUlU75/UoihRwDvD4oaD37TYT3Qrxyi6CSRaE
         lwCnpIbHIhfqGxuUbcdydsev807MSQ7UF9EuCm0p6J8/a56q8Iev3DmSvp82tKl1WmyV
         /BNlXkA+y9P1OpRlb0G40uuk35o/o0Vw1zAwbgCJ71yeYxCJeAInRXW0MqroKsI0i5ld
         ABntxBAiXLIdCXvozF+KMMonyKE9lWv15liGDlgmcVbxs+ewBbRXen9NAdzdaxDke9AQ
         1uTw==
X-Gm-Message-State: AOAM5315QnWrXWcOzA5+7daUtTcZgmt0mkdjKdB9P5hbz99rodO73UGc
        Lse2yVnDpMP3BEVCrURUWkDwFbsd8Bo=
X-Google-Smtp-Source: ABdhPJze6iHI9zyjeiCDEqcUR8gsQq0yQvuwzmzW1OiviDNX4h/PXCj4/Sox6hvyBgl/o0xftcyY4xt5PJM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:bf08:b0:14a:bb95:6980 with SMTP id
 bi8-20020a170902bf0800b0014abb956980mr24265454plb.139.1643217749066; Wed, 26
 Jan 2022 09:22:29 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 26 Jan 2022 17:22:23 +0000
Message-Id: <20220126172226.2298529-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 0/3] KVM: x86: XSS and XCR0 fixes
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For convenience, Like's patch split up and applied on top of Xiaoyao.
Tagged all for @stable, probably want to (retroactively?) get Xiaoyao's
patch tagged too?
 
Like Xu (2):
  KVM: x86: Update vCPU's runtime CPUID on write to MSR_IA32_XSS
  KVM: x86: Sync the states size with the XCR0/IA32_XSS at, any time

Xiaoyao Li (1):
  KVM: x86: Keep MSR_IA32_XSS unchanged for INIT

 arch/x86/kvm/x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


base-commit: e2e83a73d7ce66f62c7830a85619542ef59c90e4
-- 
2.35.0.rc0.227.g00780c9af4-goog

