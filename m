Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C58657D566
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiGUVCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiGUVCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:02:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEBF904F4;
        Thu, 21 Jul 2022 14:02:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m17so3672576wrw.7;
        Thu, 21 Jul 2022 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fS/nZXfCzoIrkQnCoo3AKoB3vg26TXpmf/4Iq1CbbwA=;
        b=fhutAQ2zFDM3pgiuPJuierDP9xD/G9Hhm9W5NL/hgw3wuzzhJ+QIJRyKxrcRJ4JYf9
         hS6Aeh3UygJ+nZd/McuqlbliJ+KGVavJwOGCmEv1/1gr/lQgq+Ke6vPuLMd/h5c5ER1S
         R5DNzZJiEVWvOLIK+PS5fc5yuLGnvIoVjy4FaB6GxhJL+U9oVEAWl20+Gciy0Zmj6A8h
         7ChboDDTZhwYAlJz41gfuUGRXovqooWnO7aMB56mUCmG5BIEpsFfIEdBU+4qMMf2vQrY
         pL1TbNUeebs1pCgvjO0YSKItN1VpNE79fGI2zdKPm3nZEzopN+tUSad4KjVX7LlzRMaC
         5pjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fS/nZXfCzoIrkQnCoo3AKoB3vg26TXpmf/4Iq1CbbwA=;
        b=g00hgBUTb8mNaQZLF5wvmdYlNkfI5ERqkGI5zqAZTe9MJ2pbzeU9h0bHRh55Sgrbet
         UGJamoQsKtkFkGKidb6NS4CRSN5GQprXZtgJHH2yd7UPxfV/kPwYZeehsDQOHA+wl8Dm
         eaXda8QtFvEpCWCsYtAkADfOmPbOCYgBZuoIdGJzTyNQUWqsmI/IbZ854AlArtThoZiK
         kNyIU5ZcvmtoIh5SxO6ysaK1FOgSe90dX3iSMPMTlR/r0BMAndNmXs05OSNfeB2xeXL/
         b/PHIKowruzJRn1VyqTnESkANk+rdabkRi7ykeL1oz4tVfaqp/oyfY5jL6ALEdVzCuvG
         4eGw==
X-Gm-Message-State: AJIora+EwcgZKGSA2AePGeW1hvyI99uSJF7W2OTjL3n9Ec+QT8DSyuLW
        VdnVvqzgV/gDftDOuDFa1W3ixzWap3M=
X-Google-Smtp-Source: AGRyM1vjJX4rqvk86cxrkuq/sx8bdX1cg1BHM7BBE/bgoHMZGYxwJmOp6R2i5Qxdb2xGhRl4WHKdfw==
X-Received: by 2002:adf:d1c8:0:b0:21d:a082:9290 with SMTP id b8-20020adfd1c8000000b0021da0829290mr210993wrd.246.1658437337651;
        Thu, 21 Jul 2022 14:02:17 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id d12-20020adffbcc000000b0021b8c554196sm2884383wrs.29.2022.07.21.14.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:02:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/7] highmem: Remove unneeded spaces in kmap_local_page() kdocs
Date:   Thu, 21 Jul 2022 23:02:00 +0200
Message-Id: <20220721210206.13774-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220721210206.13774-1-fmdefrancesco@gmail.com>
References: <20220721210206.13774-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the kdocs of kmap_local_page(), the description of @page starts after
several unnecessary spaces.

Therefore, remove those spaces.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 158a3a2907dc..accd286a6af5 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -60,7 +60,7 @@ static inline void kmap_flush_unused(void);
 
 /**
  * kmap_local_page - Map a page for temporary usage
- * @page:	Pointer to the page to be mapped
+ * @page: Pointer to the page to be mapped
  *
  * Returns: The virtual address of the mapping
  *
-- 
2.37.1

