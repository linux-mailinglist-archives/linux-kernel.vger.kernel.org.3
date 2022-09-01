Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8C65A9987
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbiIAN53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiIAN5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:57:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955C8357D4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:57:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id az27so22494217wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=c9ZUGn6ses9HPyvq9e/NzCNdBEc5E/knBGWlwYd1Tus=;
        b=bE/nZBqeJ2souFDdZbS3OgrXyjAWhaQ697q1QYSc0udNg/WEb+IZGvQ8AN5ggOm/Vv
         ypN6l09kffv08bpEOI7dNBAThdYtUk3wbdohm1m4/y12f3gsP1wPCQLRXH4i7Uiu13wQ
         mlF37OZnD1prQdvo4bJ/1XDu0JcwLV4SKlogBImHOyE0xj2bZSfFz+JkZNuoxYVurT19
         AX9Yit1mrA+7Uz0YKT4jqmNfkOzaSGFZ85md7qgMf+33nMphfBYM7KwtPXDMqfN22yBt
         IZKrvhkqDHXbk4ouGFqidBtFVtSBP2UIc1N1bA4T6PpA/Ro4wPPTJJfw59Vn49ggEe7y
         BSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=c9ZUGn6ses9HPyvq9e/NzCNdBEc5E/knBGWlwYd1Tus=;
        b=cUnS3s3+oE5h7omt96SDGyslNF7QX6wezBT41Gmorrr50HHTCGUcUcdhfBR2nLn3OB
         eyJZ7nQ/34E7Js2ASWG2y+XUZQPOV/Nk2CafHAWbKP0Iulw+9SHjJ3KL5tYDZYUxLK6X
         BX/anGJ0311aEn1n93WtIWUN6GoEvOHiARIZODDP0B4TThhYayRVPGLsDbDKnyVVXTcL
         SmleRqwlFjXViIQBSAhQnUzue9YDrQ0oLeXj/SiPI7CWh8vfrTvBQup+3WdNGFWljp/T
         Yzk4xJKQ3tlP71lsHAlsWbOqDqPV3ckoGOoyBj98rFxXJ9YRAJEtwdXpv83K+CgpfF49
         Hz6A==
X-Gm-Message-State: ACgBeo2biPANbnMrZHWkhqvHojwkIDYThvNP3PbAM4ykM/fg0K/JVmaZ
        DqT/uX5Or1W4U7SnD3tjC5E=
X-Google-Smtp-Source: AA6agR7VY4WEkptfJIBlnMh98zqvJSve1tAjqfJQi3iSOnMepxSeF8sv4Fut3CyeOpRzAw2j4b3ZnA==
X-Received: by 2002:adf:f642:0:b0:226:d4b1:8502 with SMTP id x2-20020adff642000000b00226d4b18502mr13358795wrp.553.1662040639961;
        Thu, 01 Sep 2022 06:57:19 -0700 (PDT)
Received: from localhost.localdomain (host-87-1-103-238.retail.telecomitalia.it. [87.1.103.238])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d6a06000000b00226d3e9f8f4sm13227343wru.98.2022.09.01.06.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:57:18 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Bryan Tan <bryantan@vmware.com>,
        Rajesh Jalisatgi <rjalisatgi@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] misc/vmw_vmci: Use kmap_local_page() in vmci_queue_pair.c
Date:   Thu,  1 Sep 2022 15:57:14 +0200
Message-Id: <20220901135714.16481-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in vmci_queue_pair.c is safe everywhere, replace kmap() with
kmap_local_page().

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index 8f2de1893245..e71068f7759b 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -324,7 +324,7 @@ static void *qp_alloc_queue(u64 size, u32 flags)
 
 /*
  * Copies from a given buffer or iovector to a VMCI Queue.  Uses
- * kmap()/kunmap() to dynamically map/unmap required portions of the queue
+ * kmap_local_page() to dynamically map required portions of the queue
  * by traversing the offset -> page translation structure for the queue.
  * Assumes that offset + size does not wrap around in the queue.
  */
@@ -345,7 +345,7 @@ static int qp_memcpy_to_queue_iter(struct vmci_queue *queue,
 		size_t to_copy;
 
 		if (kernel_if->host)
-			va = kmap(kernel_if->u.h.page[page_index]);
+			va = kmap_local_page(kernel_if->u.h.page[page_index]);
 		else
 			va = kernel_if->u.g.vas[page_index + 1];
 			/* Skip header. */
@@ -359,12 +359,12 @@ static int qp_memcpy_to_queue_iter(struct vmci_queue *queue,
 		if (!copy_from_iter_full((u8 *)va + page_offset, to_copy,
 					 from)) {
 			if (kernel_if->host)
-				kunmap(kernel_if->u.h.page[page_index]);
+				kunmap_local(va);
 			return VMCI_ERROR_INVALID_ARGS;
 		}
 		bytes_copied += to_copy;
 		if (kernel_if->host)
-			kunmap(kernel_if->u.h.page[page_index]);
+			kunmap_local(va);
 	}
 
 	return VMCI_SUCCESS;
@@ -372,7 +372,7 @@ static int qp_memcpy_to_queue_iter(struct vmci_queue *queue,
 
 /*
  * Copies to a given buffer or iovector from a VMCI Queue.  Uses
- * kmap()/kunmap() to dynamically map/unmap required portions of the queue
+ * kmap_local_page() to dynamically map required portions of the queue
  * by traversing the offset -> page translation structure for the queue.
  * Assumes that offset + size does not wrap around in the queue.
  */
@@ -393,7 +393,7 @@ static int qp_memcpy_from_queue_iter(struct iov_iter *to,
 		int err;
 
 		if (kernel_if->host)
-			va = kmap(kernel_if->u.h.page[page_index]);
+			va = kmap_local_page(kernel_if->u.h.page[page_index]);
 		else
 			va = kernel_if->u.g.vas[page_index + 1];
 			/* Skip header. */
@@ -407,12 +407,12 @@ static int qp_memcpy_from_queue_iter(struct iov_iter *to,
 		err = copy_to_iter((u8 *)va + page_offset, to_copy, to);
 		if (err != to_copy) {
 			if (kernel_if->host)
-				kunmap(kernel_if->u.h.page[page_index]);
+				kunmap_local(va);
 			return VMCI_ERROR_INVALID_ARGS;
 		}
 		bytes_copied += to_copy;
 		if (kernel_if->host)
-			kunmap(kernel_if->u.h.page[page_index]);
+			kunmap_local(va);
 	}
 
 	return VMCI_SUCCESS;
-- 
2.37.2

