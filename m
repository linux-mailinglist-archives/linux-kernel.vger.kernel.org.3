Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECC14B0719
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbiBJH3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:29:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbiBJH3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:29:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C401125
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JF4vxivs61H3BQ2kwEvqaObshMiGuhjwB0Vb6uVLhnQ=; b=pWH9G4R3FuFCi6BPR8Aydszuy2
        aVX1hsx3Q4Yx3NId7eCffi0fH+/Us5qYuZbEIvHJuojBPQx8fv7FveMHHGPrJB5WwM/STvQ99GSd9
        fsMGwLYVaj6y59WU64LRi7qS5ePWSiHI739n4y/4nQGRH4J+6Q1M8gNgQnFUkeD5Hz88KXRMsN6GZ
        AiXORMzot//UeikmdcFwmLXTc+dZb3uY7Q1fD9N/UlSAFzo56Xg8a319X3Iixge9JDzj3UN04L+O+
        /wahWZFtx/GqzxDHceLTJRONLXZYBZ39iI+ESHxbRxCmRpNQAwJ2xKTKPn+MfOfrLiTL/8mO3nDKn
        rSsF4MkQ==;
Received: from [2001:4bb8:188:3efc:8014:b2f2:fdfd:57ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nI3t8-002s3W-TU; Thu, 10 Feb 2022 07:29:11 +0000
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
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: [PATCH 14/27] mm: build migrate_vma_* for all configs with ZONE_DEVICE support
Date:   Thu, 10 Feb 2022 08:28:15 +0100
Message-Id: <20220210072828.2930359-15-hch@lst.de>
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

This code will be used for device coherent memory as well in a bit,
so relax the ifdef a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 6391d8d3a616f3..95d4aa3acaefe0 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -250,7 +250,7 @@ config MIGRATION
 	  allocation instead of reclaiming.
 
 config DEVICE_MIGRATION
-	def_bool MIGRATION && DEVICE_PRIVATE
+	def_bool MIGRATION && ZONE_DEVICE
 
 config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	bool
-- 
2.30.2

