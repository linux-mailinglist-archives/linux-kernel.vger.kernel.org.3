Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2AB49F005
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345012AbiA1Axr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344884AbiA1Ax3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:53:29 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2D7C061759
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:53:24 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id g21-20020a056a0023d500b004cc3a6556c5so1972178pfc.22
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=0eMfYCih7vaFuBJ8EMuOAoXTDwMjKd4f4Kk7vbGbBek=;
        b=UobE1XhGxotFV1a2F+P38rwwjwaCv2Et8zUI3jzIa4+8hMEkEMYcuvA8iIkX+fKLKn
         ysUsmJ2VFXBxBM23y8Z4UQMUV+lu1ouJQsw/m+N+KyzNl4oYOmL73lqiCSnpWInTuM2b
         qfiESD8hcmbVZUDKJ+tB8B9u117ixbWeRI0x6Nu5aLlY/Hwisl4ESULKgQUwAgGnseBC
         5vk7+V6Ha0MUdElrnKzkA2qHjlygi7maBN9CWaYnkpLF3fy7knVX77qVZtENq7wEViy2
         XACyQi4yu++tl4zrQfO3HULgHey1FeJEE72ZEWb2+odXP4JeP4K5r6i87Z+Hr+zElTA+
         zg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=0eMfYCih7vaFuBJ8EMuOAoXTDwMjKd4f4Kk7vbGbBek=;
        b=yNebNpLCfP/GtJZBAcGQ7NdDR4qrdOrI2erpuFunRCz/AKs84OyVzVKD6vKEJI3Jgy
         lo0U1Rlh8182CgeJDiutMtcHxOBThQyiZync81MzbrFcIeggaH2tJYvWgtVYq0RVw7He
         MfvYugBkRw5ZdLDJo/rtKti2t+bVKbZqHHGt0Tu71rpYBRjjrcsMfX8bbULwU7JL0kJX
         YEh0Ee7EHmqMQlNbeY702aPO1pCQkKCUUDy1brgUeGCO+CmvAqwJ9iVCKQ5cqee6lLv/
         pZ4umkOk437AY04dkonNrRPjMp/a77CYDMn6Paz/wjVOizdrAl7vvZo0ycn1Dgb+KnIi
         fqww==
X-Gm-Message-State: AOAM532aqKnQhj5vhY2UUjxLWQp969CEvGGYi6FRLy5TfhO+xZwmkwit
        8ftSTOOQRAzvSoNlFsBZAQACEYgVrC0=
X-Google-Smtp-Source: ABdhPJz7pZs1Ceyo+NRWY7GpWcoS2ruelsiAb+55NOdScJRBCbqI54L2vUBn/KJ2p/BlO2vgm9Mt4MU6OuM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:dac4:: with SMTP id
 q4mr6635369plx.22.1643331203897; Thu, 27 Jan 2022 16:53:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jan 2022 00:51:52 +0000
In-Reply-To: <20220128005208.4008533-1-seanjc@google.com>
Message-Id: <20220128005208.4008533-7-seanjc@google.com>
Mime-Version: 1.0
References: <20220128005208.4008533-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 06/22] KVM: VMX: Call vmx_get_cpl() directly in handle_dr()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vmx_get_cpl() instead of bouncing through kvm_x86_ops.get_cpl() when
performing a CPL check on MOV DR accesses.  This avoids a RETPOLINE (when
enabled), and more importantly removes a vendor reference to kvm_x86_ops
and helps pave the way for unexporting kvm_x86_ops.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1d2d850b124b..de66786396bd 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5184,7 +5184,7 @@ static int handle_dr(struct kvm_vcpu *vcpu)
 	if (!kvm_require_dr(vcpu, dr))
 		return 1;
 
-	if (kvm_x86_ops.get_cpl(vcpu) > 0)
+	if (vmx_get_cpl(vcpu) > 0)
 		goto out;
 
 	dr7 = vmcs_readl(GUEST_DR7);
-- 
2.35.0.rc0.227.g00780c9af4-goog

