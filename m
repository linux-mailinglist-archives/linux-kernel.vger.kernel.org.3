Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73E64DA52A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352152AbiCOWSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbiCOWSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 840E15C378
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647382653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tiYGJm3UbO/klDlUYHxrZ6ytVcRthWy0ZAHOYegAymg=;
        b=YkmXsF7NQHCUblN+0jZ2JPvKLft5/XFqwSRhzoWw+XmLMb/Lfa/MP/tpF5tizJE5WIAIOe
        C+TjYcTH1I3ANAD7grCL0Y2gSx1MOVA6dbsLjrNEp1WG57mVWsp2i93V6n9gA+CFzuEEbw
        N981f5C5+DoMEVV12nDf6RlV9xLnSaY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-MYCpbvJPOrCcNKRBIUTWMg-1; Tue, 15 Mar 2022 18:17:30 -0400
X-MC-Unique: MYCpbvJPOrCcNKRBIUTWMg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D251101AA77;
        Tue, 15 Mar 2022 22:17:30 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E2724B8D49;
        Tue, 15 Mar 2022 22:17:30 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Subject: [PATCH] KVM: x86: document limitations of MSR filtering
Date:   Tue, 15 Mar 2022 18:17:29 -0400
Message-Id: <20220315221729.2416555-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSR filtering requires an exit to userspace that is hard to implement and
would be very slow in the case of nested VMX vmexit and vmentry MSR
accesses.  Document the limitation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/api.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 0e08253b003f..8911a4310406 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4091,6 +4091,11 @@ x2APIC MSRs are always allowed, independent of the ``default_allow`` setting,
 and their behavior depends on the ``X2APIC_ENABLE`` bit of the APIC base
 register.
 
+.. warning::
+   MSR accesses coming from nested vmentry/vmexit are not filtered.
+   This includes both writes to individual VMCS fields and reads/writes
+   through the MSR lists pointed to by the VMCS.
+
 If a bit is within one of the defined ranges, read and write accesses are
 guarded by the bitmap's value for the MSR index if the kind of access
 is included in the ``struct kvm_msr_filter_range`` flags.  If no range
-- 
2.31.1

