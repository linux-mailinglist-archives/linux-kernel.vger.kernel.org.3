Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D32354BC19
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358207AbiFNUso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353181AbiFNUsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:48:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7598320F53
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:47:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-313e5c642dcso35463627b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Avux3DXm0eZx/sc8tRS1iEmdb18s5R6TM2wIGHbP9EE=;
        b=hrvKljUtWXL5ARSt7y6G/u+Cs1N4fvLQdgAPmuGJAo70I9tNF11gUdsg0zfJK50aUl
         oRTZbtU2TQYJTOMImRyszjHNTJuF0HSmb+JUSQc9V+mJpttvpvM0qR4ZAxHjF6Qu58o9
         +72fwqKsaV25Bb0kChYcEipTDB7hN7RklAfUPTCeiC4DFLnjeqY09eoVDvaHjkdk6jXY
         EelGGRK0+tFrpWrtlARq+fTP3BOMenKSgTJsFtqT8wN1gkT5p5FKenfoFB1oS2VRhyne
         oCcro7cFFHidqUHztkv6FWHYeFuG/7awI1JcudKnbPBzOwpMZM1hj9oW/jXuzu4giiHg
         3W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Avux3DXm0eZx/sc8tRS1iEmdb18s5R6TM2wIGHbP9EE=;
        b=ezm7i9QkqQBTicjo01vVcMimT1eSzAGDGI01k3EKmMDHQU17OWyg8nD6gjQ/vARUl9
         M2XI3JJQpwskmfVW43kIvHtCjucAXBmyleITSmD6nqwBcWybFrtTa1weegUFCsGK4ulL
         I72xDB1c1UczvcH7cWCWCnqDq255inOZ7BbuU6NgxMMwMYs7Qn8ghIq5AdxB0Zgn4JVp
         KiBenz6kPPYJOPuehtCMyqSgEN+zoJjCOdoKwDQYnG37idPFkq8QdYjjsT2lWq6TP6GY
         6/kSga7n2RhlsU5CrDiPS8i15bmRf2CohNJUxi2vTis8JrnPb3PaJT2Xm3YlpUzW5Op5
         x5OQ==
X-Gm-Message-State: AJIora+eFQrSib1FkwH4gcS7i2qzm+gyXVPZPsSpQOm1SV5y1wwJlSUT
        /6QWhVpMHpIIjfKygH7afCRj6+++/GA=
X-Google-Smtp-Source: AGRyM1vw5g+ASJFYQ4nCkrht/P3qA6AcoGmTK2nrJJTdttY2KNgAVLMaywKrC1SXjEIP8xAPr5qN38Uee48=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:7447:0:b0:667:b7a8:902a with SMTP id
 p68-20020a257447000000b00667b7a8902amr656805ybc.518.1655239670856; Tue, 14
 Jun 2022 13:47:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 20:47:17 +0000
In-Reply-To: <20220614204730.3359543-1-seanjc@google.com>
Message-Id: <20220614204730.3359543-9-seanjc@google.com>
Mime-Version: 1.0
References: <20220614204730.3359543-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 08/21] KVM: nVMX: Ignore SIPI that arrives in L2 when vCPU
 is not in WFS
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fall through to handling other pending exception/events for L2 if SIPI
is pending while the CPU is not in Wait-for-SIPI.  KVM correctly ignores
the event, but incorrectly returns immediately, e.g. a SIPI coincident
with another event could lead to KVM incorrectly routing the event to L1
instead of L2.

Fixes: bf0cd88ce363 ("KVM: x86: emulate wait-for-SIPI and SIPI-VMExit")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index e794791a6bdd..d080bfca16ef 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3936,10 +3936,12 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 			return -EBUSY;
 
 		clear_bit(KVM_APIC_SIPI, &apic->pending_events);
-		if (vcpu->arch.mp_state == KVM_MP_STATE_INIT_RECEIVED)
+		if (vcpu->arch.mp_state == KVM_MP_STATE_INIT_RECEIVED) {
 			nested_vmx_vmexit(vcpu, EXIT_REASON_SIPI_SIGNAL, 0,
 						apic->sipi_vector & 0xFFUL);
-		return 0;
+			return 0;
+		}
+		/* Fallthrough, the SIPI is completely ignored. */
 	}
 
 	/*
-- 
2.36.1.476.g0c4daa206d-goog

