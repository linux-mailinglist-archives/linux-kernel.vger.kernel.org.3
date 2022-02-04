Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BCE4A98B0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358619AbiBDL5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:57:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358549AbiBDL52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643975848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Aa81Pa80imIk4UaTF0wxzL7ZPYrOTOis7eBwCIeEGQ=;
        b=CCSyzt3hPhk5AifpcS5xLS1SK6/gS2j6cdnA2GphCb+S1FC4pipk7XuHPbxkpNWSiReNba
        fq89xNP8La3MURv40Orlm+n6h4s+UYvOr4Uz9hr8On+0OpOIaSoFlH7/znUl4k1uFbRZLD
        yjABxrPLUgUjpbVyipO3dWTUXmOmTMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-qj1A0x2mMGyZvYX7FywFtQ-1; Fri, 04 Feb 2022 06:57:24 -0500
X-MC-Unique: qj1A0x2mMGyZvYX7FywFtQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6F0061280;
        Fri,  4 Feb 2022 11:57:23 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BCA11084184;
        Fri,  4 Feb 2022 11:57:23 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     dmatlack@google.com, seanjc@google.com, vkuznets@redhat.com
Subject: [PATCH 08/23] KVM: MMU: rephrase unclear comment
Date:   Fri,  4 Feb 2022 06:57:03 -0500
Message-Id: <20220204115718.14934-9-pbonzini@redhat.com>
In-Reply-To: <20220204115718.14934-1-pbonzini@redhat.com>
References: <20220204115718.14934-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If accessed bits are not supported there simple isn't any distinction
between accessed and non-accessed gPTEs, so the comment does not make
much sense.  Rephrase it in terms of what happens if accessed bits
*are* supported.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 5b5bdac97c7b..6bb9a377bf89 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -193,7 +193,7 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
 	if (!FNAME(is_present_gpte)(gpte))
 		goto no_present;
 
-	/* if accessed bit is not supported prefetch non accessed gpte */
+	/* if accessed bit is supported, prefetch only accessed gpte */
 	if (PT_HAVE_ACCESSED_DIRTY(vcpu->arch.mmu) &&
 	    !(gpte & PT_GUEST_ACCESSED_MASK))
 		goto no_present;
-- 
2.31.1


