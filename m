Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAB64CCCE6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbiCDFSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiCDFSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:18:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 250484EF51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DWHI+KLiCdBad7t4Fcw0RAEljy7M5LeKI3evjgamGnQ=;
        b=B+bXlQG4u/9FTHhB/z+DVzxi/MCY6BMiBknsjQb4BaUk56A7ef7lyyyagWwXYPvCyDt196
        lrMm8PmgtcNuoLddAOybflH7plV2Do0cxoisaRoroDqUWc3UrbgUnlSMQHfEaZ2iiTsQGa
        YWqWzmTnoUsAcQc5gIanYEqI6Jz+n3k=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-MUrnkqA7MsiTPrWNFAGLSQ-1; Fri, 04 Mar 2022 00:17:48 -0500
X-MC-Unique: MUrnkqA7MsiTPrWNFAGLSQ-1
Received: by mail-pl1-f197.google.com with SMTP id x18-20020a170902b41200b0014fc2665bddso4129776plr.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:17:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWHI+KLiCdBad7t4Fcw0RAEljy7M5LeKI3evjgamGnQ=;
        b=AwwBMCjxdnMpAeHthF2BI4q5oyW1qNC81PDyQ+EYE+L5G3QFw0MjOnUO1qqoObVm8/
         UjRMh9lLTHcrtV88DhUPvsn6K18b5yYN3ywbWhHYtON+dcQBb64xpfq2awQpsMFysyGr
         yB3h3hGeWQZ4KG6jOJJbySWaNZMWZa9hHVh2oBzA2mcDVAE1ATBGtDc2eSfvuPmAa7Jh
         B0rn14oXvwSUSsPUO4okjis808nZzQXNfoX8t3Oegmz+TnDU9UZxV0k6XcXiJK7ehvre
         GTnWyqGDFwH7tKqZPNvusW/6xkKJa3MBSRcF642XDllCIhjX+jquaJXDOb/QZjQ34znj
         jvDw==
X-Gm-Message-State: AOAM5311ZOj/4scirP/orvf0vaRdm/SIk43QiQGG0T9tN0AzOkwFkWl/
        kCoPCKXuU7iTXWHlirg+/XxhqQVnJUKs0FDsFRbVa6RXqBw1VTiMWp3PkVE9AvimcEoGQl2l9Nm
        YD3WfOdZFkf65acdv/ocdCYBY
X-Received: by 2002:a17:902:d894:b0:151:64c6:273 with SMTP id b20-20020a170902d89400b0015164c60273mr24307292plz.150.1646371066904;
        Thu, 03 Mar 2022 21:17:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBDtDn1Z3wbdPzigbaBlDKAgZd/ChJa3km/enVI+LZTN2c4X2t5bAMomnNrL0k2Ir186+95Q==
X-Received: by 2002:a17:902:d894:b0:151:64c6:273 with SMTP id b20-20020a170902d89400b0015164c60273mr24307281plz.150.1646371066620;
        Thu, 03 Mar 2022 21:17:46 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.17.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:17:46 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 03/23] mm: Check against orig_pte for finish_fault()
Date:   Fri,  4 Mar 2022 13:16:48 +0800
Message-Id: <20220304051708.86193-4-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304051708.86193-1-peterx@redhat.com>
References: <20220304051708.86193-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to check against none pte in finish_fault(), with the assumption
that the orig_pte is always none pte.

This change prepares us to be able to call do_fault() on !none ptes.  For
example, we should allow that to happen for pte marker so that we can restore
information out of the pte markers.

Let's change the "pte_none" check into detecting changes since we fetched
orig_pte.  One trivial thing to take care of here is, when pmd==NULL for
the pgtable we may not initialize orig_pte at all in handle_pte_fault().

By default orig_pte will be all zeros however the problem is not all
architectures are using all-zeros for a none pte.  pte_clear() will be the
right thing to use here so that we'll always have a valid orig_pte value
for the whole handle_pte_fault() call.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 22d24ea7b87d..cdd0d108d3ee 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4135,7 +4135,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 				      vmf->address, &vmf->ptl);
 	ret = 0;
 	/* Re-check under ptl */
-	if (likely(pte_none(*vmf->pte)))
+	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
 		do_set_pte(vmf, page, vmf->address);
 	else
 		ret = VM_FAULT_NOPAGE;
@@ -4600,6 +4600,13 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 * concurrent faults and from rmap lookups.
 		 */
 		vmf->pte = NULL;
+		/*
+		 * Always initialize orig_pte.  This matches with below
+		 * code to have orig_pte to be the none pte if pte==NULL.
+		 * This makes the rest code to be always safe to reference
+		 * it, e.g. in finish_fault() we'll detect pte changes.
+		 */
+		pte_clear(vmf->vma->vm_mm, vmf->address, &vmf->orig_pte);
 	} else {
 		/*
 		 * If a huge pmd materialized under us just retry later.  Use
-- 
2.32.0

