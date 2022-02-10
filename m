Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAFE4B06FA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiBJH2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:28:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbiBJH2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:28:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B25275
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kwsvzUopQYmLEvfJMWiUtpLaBV1PgK/k5zUYKi0uPVU=; b=4pvndCL1lsKtjRKUxsi/J7Dxvo
        nVmiNGk6UXupKHW1OLXR+4B82dW07jzHZuBVo0KXBKlc1qNmC8wL4iAMhe88kOdH+ywDPbwwF9isJ
        zbF7vyHcH7ZB+oAO5RJzYzy8W71AUbpN1yu6LoRPEFGk3WGoUPuwiizHeTv5+Dxm5s9U8hzEyCOt8
        I8EI2xE1INgu5bUL41ku3jeeQ+CB/t+j7R8IMGT6MS1jG+SWAmjnYIKA+e1oWVu8ukLRztAFH6T7V
        8EjsqXGdggi7lWnCIIbd6CMvnXjnA8fpTkgrBHYPiQATMsskbuYK1ZK5kbfbgLh9UO0N1uGxviSbZ
        SSBDKEhw==;
Received: from [2001:4bb8:188:3efc:8014:b2f2:fdfd:57ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nI3sa-002rlD-Of; Thu, 10 Feb 2022 07:28:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 02/27] mm: remove the __KERNEL__ guard from <linux/mm.h>
Date:   Thu, 10 Feb 2022 08:28:03 +0100
Message-Id: <20220210072828.2930359-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220210072828.2930359-1-hch@lst.de>
References: <20220210072828.2930359-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__KERNEL__ ifdefs don't make sense outside of include/uapi/.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mm.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b19223..7b46174989b086 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3,9 +3,6 @@
 #define _LINUX_MM_H
 
 #include <linux/errno.h>
-
-#ifdef __KERNEL__
-
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
 #include <linux/bug.h>
@@ -3381,5 +3378,4 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 }
 #endif
 
-#endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
-- 
2.30.2

