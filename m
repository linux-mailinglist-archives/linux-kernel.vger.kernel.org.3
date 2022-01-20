Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56B949538A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiATRuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:50:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232647AbiATRuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642701021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PX67YbF8eMZTe9OThRlcIQJMcAFWnuGSg3N6hvzpSBg=;
        b=HOsdDDmx4LPgXPrqUFynPvzlyel5pDSaLvLEhScWlvr7EHgIBfikr1m4Pb5yUdUzQwrG4/
        ygPHzGjTnd36Jw26nQAM7wMErgx8HGBiyLfM+kw29xVJ/UIDT/N6zVLtr7Avv91QH+T3O8
        uHQzFOm39qfFRkqZkb0eO7eWLa+DL6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-ifg5JFc5MCSfOeVqF4U9iQ-1; Thu, 20 Jan 2022 12:50:18 -0500
X-MC-Unique: ifg5JFc5MCSfOeVqF4U9iQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 395C5100C661;
        Thu, 20 Jan 2022 17:50:17 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED63E7DE41;
        Thu, 20 Jan 2022 17:50:16 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] KVM: x86: skip host CPUID call for hypervisor leaves
Date:   Thu, 20 Jan 2022 12:50:15 -0500
Message-Id: <20220120175015.1747392-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hypervisor leaves are always synthesized by __do_cpuid_func.  Just return
zeroes and do not ask the host, it would return a bogus value anyway if
it were used.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/cpuid.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3902c28fb6cb..fd949e89120a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -692,9 +692,17 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
 
 	entry = &array->entries[array->nent++];
 
+	memset(entry, 0, sizeof(*entry));
 	entry->function = function;
 	entry->index = index;
-	entry->flags = 0;
+	switch (function & 0xC0000000) {
+	case 0x40000000:
+		/* Hypervisor leaves are always synthesized by __do_cpuid_func.  */
+		return entry;
+
+	default:
+		break;
+	}
 
 	cpuid_count(entry->function, entry->index,
 		    &entry->eax, &entry->ebx, &entry->ecx, &entry->edx);
-- 
2.31.1

