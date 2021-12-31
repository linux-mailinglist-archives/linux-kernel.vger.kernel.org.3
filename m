Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74DF48253C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhLaQ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhLaQ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:56:50 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC49C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 08:56:50 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so26057240pjq.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 08:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fhqsai9/5uTpmhu9BCUGRv/iOpwY1XebeAJzkMmetAg=;
        b=DTTANcgQxP/+d+SIfU7vQgtLwKl7eY50ftYhrvl9vSh6Hu0HYf2iigJ3RKtoyq23sj
         gRii9H+9YyK62wyllPKWLhPo3BegEtpX6Yg3ZHXeUdvoOw0sH/I84xuypATf+fMk8LBH
         O4lBZrdOFmhBJQPp2875HXZ0ZVQblWDDurWrkXhIP5fG+QM8vpMSh7BpJwiVB1IQDsJg
         4m3w6u6gZPWBzgqiTJNinwfqTuL1w2cnMa/rTYP2hWmAH6sPVcVqosaxqYQSH5GxqZet
         xeSf1JN5N2AE76YbEuqRaWdJ/ngfTjedQ98lpvwYnHxRUFlTeLb3fXRkGObrPqaiDrK6
         4bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fhqsai9/5uTpmhu9BCUGRv/iOpwY1XebeAJzkMmetAg=;
        b=UQVD3cLfE4sqRLJbe3oj6XiCauX6w9qmzF3aqCIbIA8uauZGsc3m5SXk4XKEWgjU9t
         Mhw/BLnI4u0fbzaaLudrM9xisjE2F4BeyIQ9FZgKdyGWOPCJ0tbAKKz+rrHfbsp/55c7
         BsBUwytZPbXvUaX1McyO9KO+KwDgAbf04NFs+pWTFIrBG4wtg8+07EyiRp8ype6Qltjm
         m1hxZThYLL5Japf4ZdoiWy6mFG+3tHeyuBMOSHjBKEFmsPjYlnpYc2OLfAhK2lFK54Wc
         Iy6oKGhlS60flU9JmMdIc+BYwwrSZZVujF5XjZvoeGVr5ozHkJqlqw1mU7qqMQMAM9GD
         o0cw==
X-Gm-Message-State: AOAM532Q4Ej9OwMQyP6vIQe7L7PivZGoHp0gIXeB2KFJrY/6hTAUJ5LA
        XW2BfS1GS+b/Yr0fUMUsqX/lDIxY+CL5mjvC
X-Google-Smtp-Source: ABdhPJxbh1vyPADNysAidGV2ytIAgoJ8tmJoKQuoiBd2eBUqHzHGm5J35dSdoI4BZhj0Nw+Z6BHyhQ==
X-Received: by 2002:a17:902:8d8c:b0:149:4497:faab with SMTP id v12-20020a1709028d8c00b001494497faabmr36204345plo.161.1640969809949;
        Fri, 31 Dec 2021 08:56:49 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:18dd:5111:d391:607b])
        by smtp.gmail.com with ESMTPSA id mh3sm35188026pjb.26.2021.12.31.08.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 08:56:49 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        michael.h.kelley@microsoft.com, kys@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, brijesh.singh@amd.com, konrad.wilk@oracle.com,
        hch@lst.de, wei.liu@kernel.org, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, kernel test robot <lkp@intel.com>
Subject: [PATCH] Swiotlb: Add CONFIG_HAS_IOMEM check around memremap() in the swiotlb_mem_remap()
Date:   Fri, 31 Dec 2021 11:56:40 -0500
Message-Id: <20211231165640.1245751-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

HAS_IOMEM option may not be selected on some platforms(e.g, s390) and this
will cause compile error due to miss memremap() implementation. Fix it via
adding HAS_IOMEM check around memremap() in the swiotlb.c.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 kernel/dma/swiotlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b36c1cdd0c4f..3de651ba38cc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -167,6 +167,7 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
 {
 	void *vaddr = NULL;
 
+#ifdef CONFIG_HAS_IOMEM
 	if (swiotlb_unencrypted_base) {
 		phys_addr_t paddr = mem->start + swiotlb_unencrypted_base;
 
@@ -175,6 +176,7 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
 			pr_err("Failed to map the unencrypted memory %pa size %lx.\n",
 			       &paddr, bytes);
 	}
+#endif
 
 	return vaddr;
 }
-- 
2.25.1

