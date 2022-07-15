Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DF1576775
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiGOTbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiGOTaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:30:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53C9655BA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:30:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31c972f5f84so46616947b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TAzWPzxWt/xQfClUKSK8iVRAelG3qw/M2QmSChpgMSI=;
        b=YNM9JNlWqYCDiOo3N8HlI4kB6O7IiOnhbpDLU5h7U/5DOLcS/NETWbGtl2M5UsAjeU
         5FQs1H/BQZETak+scuHq+3xxRENuOnxo3ZmnHKeUYLxlRlA94cNAd8IT2pFoqRcmPIKK
         0o+27bCLWXWn2JJ0w10g5lPDoerBxd2qYVjX8W0aAkiNCeA7OC53VkZo84reYKvo98vM
         +KGohTOxpTC1z0XG4DcXsZCENDMLVxCcONr7EYF+BTbtMzbe1cGhG0onOvPAgH4QM+Yv
         3hRGC/jitECNYZz7Ls9gWgR4kWwNkm+YYB2DCJSIhRyYrHMrRKHDe0Hw3hqv6da++U02
         Ytaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TAzWPzxWt/xQfClUKSK8iVRAelG3qw/M2QmSChpgMSI=;
        b=zynYa+f4ecMhl+WafiyDmRP/KPMtyG2VuFPaUtsBh+Y6VkRO+1Qy3ghyP6vWnhRrLZ
         PU1jlPTLejai8gIQuv0gS4w1PkR0oJQksPctTA0wWFehCTuqv70EJ5RjpXR8ptLEy56C
         YPVjRVJ+jzHlIpXpR9SsPblExp9MVDDDnupwWljcjejgdelTrtcsh9hbYIT4HT/PpoHd
         pojey7vbbiQ5Rn2eN4QPptGYdZ1GSn5xvG2czbpY8q1BRtom8S9cxwWLxnKFZFkUlUMw
         C6KHN+BTrju26it2DdfnAuLJ/DqqyKvmd8SIp+0agXyQdblc3w2/QZ1WVFmBcyrEOTnA
         R/Sg==
X-Gm-Message-State: AJIora8F0jLzRZEKFVfdhAqMJRkxzredochkaUgyfYPJnU/RWoM2YIBB
        KlfCQnzHd8I03F69x2kciX1UjsfddT0=
X-Google-Smtp-Source: AGRyM1tRj6psVB1GLADfUquHWkwvBdbCnSPQ69Mq1ZfxyCnynBeVXK2A+5crNaMaFlFr3oKyKuVU8aftytc=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:bd4e:b81d:4780:497d])
 (user=pgonda job=sendgmr) by 2002:a81:6cf:0:b0:31c:913c:144c with SMTP id
 198-20020a8106cf000000b0031c913c144cmr17753756ywg.437.1657913420660; Fri, 15
 Jul 2022 12:30:20 -0700 (PDT)
Date:   Fri, 15 Jul 2022 12:29:53 -0700
In-Reply-To: <20220715192956.1873315-1-pgonda@google.com>
Message-Id: <20220715192956.1873315-9-pgonda@google.com>
Mime-Version: 1.0
References: <20220715192956.1873315-1-pgonda@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [RFC V1 07/10] tools: Add atomic_test_and_set_bit()
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, marcorr@google.com,
        seanjc@google.com, michael.roth@amd.com, thomas.lendacky@amd.com,
        joro@8bytes.org, mizhang@google.com, pbonzini@redhat.com,
        Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atomic_test_and_set_bit() allows for atomic bitmap usage from KVM
selftests.

Signed-off-by: Peter Gonda <pgonda@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>

---
 tools/arch/x86/include/asm/atomic.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/arch/x86/include/asm/atomic.h b/tools/arch/x86/include/asm/atomic.h
index 1f5e26aae9fc..45ea15c98957 100644
--- a/tools/arch/x86/include/asm/atomic.h
+++ b/tools/arch/x86/include/asm/atomic.h
@@ -8,6 +8,7 @@
 
 #define LOCK_PREFIX "\n\tlock; "
 
+#include <asm/asm.h>
 #include <asm/cmpxchg.h>
 
 /*
@@ -70,4 +71,10 @@ static __always_inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 	return cmpxchg(&v->counter, old, new);
 }
 
+static inline int atomic_test_and_set_bit(long nr, volatile unsigned long *addr)
+{
+	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(bts), *addr, "Ir", nr, "%0", "c");
+
+}
+
 #endif /* _TOOLS_LINUX_ASM_X86_ATOMIC_H */
-- 
2.37.0.170.g444d1eabd0-goog

