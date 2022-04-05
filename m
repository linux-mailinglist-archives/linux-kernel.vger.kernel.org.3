Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BFD4F216E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiDECpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiDECoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B53CDE997D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lW39+rLF3iuwrcyWFAu8xWUbxamG/E8iQp/9Q8XMaVI=;
        b=HSNJ4zpHFUTSfB84BzQnpFbkRik8AKHp1Rv+joxbvHmigM1XyQQO592lbif9Wq1Bf2+7+v
        y7c3bnSjm/yJcu+GINPqU9GqPUbWKopAMy4kX3nxx1CaPdWHnv1wqc6PLpURrKqp72YeeT
        s4vcIAZF1leDWtXQkqsZNdA3sAP7evI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-Y-IEES_gM6KYpTvQFdtZLQ-1; Mon, 04 Apr 2022 21:49:33 -0400
X-MC-Unique: Y-IEES_gM6KYpTvQFdtZLQ-1
Received: by mail-io1-f70.google.com with SMTP id w28-20020a05660205dc00b00645d3cdb0f7so7424553iox.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lW39+rLF3iuwrcyWFAu8xWUbxamG/E8iQp/9Q8XMaVI=;
        b=a+mEN3d+Qfxg2vZBzLaSG0f11jxQp3Nm6qP3jgEgnd3KVWqRWkvqUUcV2q0WpkC5h1
         aJ3M2uea9OCNEamVnCFJxT1Ir82UxX08mJBb8hD9odSHsCxHBSmz7FqjICBYwNqqfm+A
         woz7o5QJCOd+pP0Z82REc+TDojttEIIinQh841kkpA1qJAIO5ZqFJcWFv0g67euochvD
         2sLEsCJFlGxWRbJHcsY5twjj6k/cqRG4wVod6vwJHB9w/CIY3mie+NRWphOVvuB4Xdqn
         GRC14hQUcf2PKF80yMRKeCh622TX5XHUbv/PX0WdiEx4/R9qSxBPhic7sxaWjtNk3ted
         Skog==
X-Gm-Message-State: AOAM531vk4mjDOlLYQ75kCkPQ3mhPpAxO6AnX+12adwC0RReAy9sKBb6
        fBC5MsPNFaRQPfE8q6FYuMrdlQTkPF1QGfDSWcaBRtDC9fhz1ZU86tSE4ajWIFGwZKtS4K8tQuk
        sOOoP4GI5xlU+abEs//2JgzF/HrdDg773AhSNr1pADjvc0IeBP56z4V3aLvZluPdDKPiK3JbHww
        ==
X-Received: by 2002:a6b:cd0c:0:b0:649:adb8:79eb with SMTP id d12-20020a6bcd0c000000b00649adb879ebmr582217iog.138.1649123372105;
        Mon, 04 Apr 2022 18:49:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwn1jD8bZrilkR6TJdV2+HFVoMQ6KZBMcYF9DIorLbsiTZnX9G3AePuh+OKuYEiS2DRPtH+RA==
X-Received: by 2002:a6b:cd0c:0:b0:649:adb8:79eb with SMTP id d12-20020a6bcd0c000000b00649adb879ebmr582198iog.138.1649123371881;
        Mon, 04 Apr 2022 18:49:31 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id b11-20020a92c56b000000b002c76a618f52sm6657231ilj.63.2022.04.04.18.49.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:49:31 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com
Subject: [PATCH v8 22/23] mm: Enable PTE markers by default
Date:   Mon,  4 Apr 2022 21:49:29 -0400
Message-Id: <20220405014929.15158-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405014646.13522-1-peterx@redhat.com>
References: <20220405014646.13522-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PTE markers by default.  On x86_64 it means it'll auto-enable
PTE_MARKER_UFFD_WP as well.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 6e7c2d59fa96..3eca34c864c5 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -911,12 +911,14 @@ config ANON_VMA_NAME
 
 config PTE_MARKER
 	bool "Marker PTEs support"
+	default y
 
 	help
 	  Allows to create marker PTEs for file-backed memory.
 
 config PTE_MARKER_UFFD_WP
 	bool "Marker PTEs support for userfaultfd write protection"
+	default y
 	depends on PTE_MARKER && HAVE_ARCH_USERFAULTFD_WP
 
 	help
-- 
2.32.0

