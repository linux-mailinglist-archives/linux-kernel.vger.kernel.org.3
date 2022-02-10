Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7E04B071E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbiBJH3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:29:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbiBJH3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:29:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9E2D8E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7G8J3RPmwqONc2HXCUGJwHrFv6lx9mr3fODzxz3GZ8Y=; b=uUYieNnJaHfU8LFV1HvS+chCMy
        jcAqrinM6uesfhHoQXNQ/yIbALOtnqg/X7rgXJFF6HmxAU0+4dzexPBN2EnDi2dapZPLQOWgiAeOf
        tzVORYmrL7VdJLyW6S053AW0DDzF7ZmU1dwjhi7rK+HqXEtwduphWLaaWJ2i9FXW1FL/pTVPhl6u3
        LE+m2AisM2E2hg6ORWM9biX6jJgiGfqln2ncrqHbXOopuoXLSc1S3T1+fNmZtbayRnW6HXsAIFF0m
        nvn1VGJiJ6QqjxIbHtJmIW7tSVeSa7IIbBXeRBYA674ZY5WukXl78wQ6Z+MIK6VEYF2kn6OeA5Q60
        +XxfFLEg==;
Received: from [2001:4bb8:188:3efc:8014:b2f2:fdfd:57ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nI3t3-002s0C-1N; Thu, 10 Feb 2022 07:29:05 +0000
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
Subject: [PATCH 12/27] mm: refactor the ZONE_DEVICE handling in migrate_vma_pages
Date:   Thu, 10 Feb 2022 08:28:13 +0100
Message-Id: <20220210072828.2930359-13-hch@lst.de>
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

Make the flow a little more clear and prepare for adding a new
ZONE_DEVICE memory type.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/migrate.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 30ecd7223656c1..746e1230886ddb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2788,24 +2788,21 @@ void migrate_vma_pages(struct migrate_vma *migrate)
 
 		mapping = page_mapping(page);
 
-		if (is_zone_device_page(newpage)) {
-			if (is_device_private_page(newpage)) {
-				/*
-				 * For now only support private anonymous when
-				 * migrating to un-addressable device memory.
-				 */
-				if (mapping) {
-					migrate->src[i] &= ~MIGRATE_PFN_MIGRATE;
-					continue;
-				}
-			} else {
-				/*
-				 * Other types of ZONE_DEVICE page are not
-				 * supported.
-				 */
+		if (is_device_private_page(newpage)) {
+			/*
+			 * For now only support private anonymous when migrating
+			 * to un-addressable device memory.
+			 */
+			if (mapping) {
 				migrate->src[i] &= ~MIGRATE_PFN_MIGRATE;
 				continue;
 			}
+		} else if (is_zone_device_page(newpage)) {
+			/*
+			 * Other types of ZONE_DEVICE page are not supported.
+			 */
+			migrate->src[i] &= ~MIGRATE_PFN_MIGRATE;
+			continue;
 		}
 
 		r = migrate_page(mapping, newpage, page, MIGRATE_SYNC_NO_COPY);
-- 
2.30.2

