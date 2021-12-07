Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339FE46C723
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbhLGWNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242078AbhLGWNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:13:10 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFC5C061756
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:09:39 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id k11-20020a63d84b000000b003252e72da7eso145886pgj.23
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 14:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=N64d2e80RXjsLu9HXyi4jzsbOA/K3uZFRHR0r9iBdzw=;
        b=WGaFESMm0rHOPLHOaCscccW5Xq4QsN4ggUltMTNKZHvBf/2eABLl1tI88EOMoQYXnW
         59SyMwmlDBFqadJIsyV4h6AYkNZnat9wTQE/92iNi/5yR8KV42ZfwfALt3Nep8GX3k+3
         KRo3yNlSOCDV7+eD5PLuJfJiP0cTR1HjPe7voX8mS/W2LoL6mrujZU6EEk2Re9x0zKM+
         jCuQuV32J0wcLSQFQUcNWkGkRmTF4+FrJoI11KlWQq0UW4CIH1r0Vfk+Z7gKn1iQKUrG
         7CpbEneVNke56qOR4r4TMyBwIE0+klNGh8pRuujyptTEAxG5Neqjh7DmFzjaEO2YRfTL
         PTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=N64d2e80RXjsLu9HXyi4jzsbOA/K3uZFRHR0r9iBdzw=;
        b=tqUznZEdCyXlZlHlS85zwGhrHoGNYVg6/qlHG36KCzL5yO6ekKPq8hgLg3sm5qZhv3
         YmSCS25SrOK39qS8BQ7uwVuO6Pr/oZmmpDsfoS7y7uhD5VybSrsoifURroLoQg+zTjPr
         gIsy8BQaAhGeGJjh7vTKngozTjV2SNmCyxkOaenpFGjr3+0WaThvF1aJXfBCpw4oND6u
         6g749ZhuvD3vm2pIcCaBlNU2gaHeqdHox3/ucpk8IY5KCzvwbrd/Ac30UBOYkvdnSwf6
         gGkF+ZTQAr218Eb2ODkKnXkKrPDPb1CXM9zALi4XE27JFQMbb9CtFKRFLTQo2g6P16VB
         QkXA==
X-Gm-Message-State: AOAM531GY18wCKT0EYAxbmaDNzBLRcAHTBrm54o7D+NN0New9I4yebf0
        FSXIUcJD/vXYSQWlpRXuXNrzlblTK/U=
X-Google-Smtp-Source: ABdhPJwH8b0OF8qfogELS2ZziRKBddr5DJNRc7MP5TraX4amm0Qcdz6cOSy68Mtzz76VMGSCoGAUxRTT++U=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:284f:: with SMTP id
 p15mr256520pjf.1.1638914978295; Tue, 07 Dec 2021 14:09:38 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Dec 2021 22:09:19 +0000
In-Reply-To: <20211207220926.718794-1-seanjc@google.com>
Message-Id: <20211207220926.718794-2-seanjc@google.com>
Mime-Version: 1.0
References: <20211207220926.718794-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 1/8] KVM: x86: Ignore sparse banks size for an "all CPUs",
 non-sparse IPI req
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajay Garg <ajaygargnsit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not bail early if there are no bits set in the sparse banks for a
non-sparse, a.k.a. "all CPUs", IPI request.  Per the Hyper-V spec, it is
legal to have a variable length of '0', e.g. VP_SET's BankContents in
this case, if the request can be serviced without the extra info.

  It is possible that for a given invocation of a hypercall that does
  accept variable sized input headers that all the header input fits
  entirely within the fixed size header. In such cases the variable sized
  input header is zero-sized and the corresponding bits in the hypercall
  input should be set to zero.

Bailing early results in KVM failing to send IPIs to all CPUs as expected
by the guest.

Fixes: 214ff83d4473 ("KVM: x86: hyperv: implement PV IPI send hypercalls")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 7179fa645eda..58f35498578f 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1923,11 +1923,13 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 
 		all_cpus = send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL;
 
+		if (all_cpus)
+			goto check_and_send_ipi;
+
 		if (!sparse_banks_len)
 			goto ret_success;
 
-		if (!all_cpus &&
-		    kvm_read_guest(kvm,
+		if (kvm_read_guest(kvm,
 				   hc->ingpa + offsetof(struct hv_send_ipi_ex,
 							vp_set.bank_contents),
 				   sparse_banks,
@@ -1935,6 +1937,7 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
 
+check_and_send_ipi:
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
 		return HV_STATUS_INVALID_HYPERCALL_INPUT;
 
-- 
2.34.1.400.ga245620fadb-goog

