Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4396A57D5C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiGUVRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiGUVRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:17:36 -0400
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A048AB07
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:17:35 -0700 (PDT)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1oEdY2-001tWR-2q;
        Thu, 21 Jul 2022 22:17:30 +0100
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux@armlinux.org.uk, Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH 2/3] arm: dma-mapping: fix pointer/integer warning
Date:   Thu, 21 Jul 2022 22:17:28 +0100
Message-Id: <20220721211729.451731-3-ben-linux@fluff.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721211729.451731-1-ben-linux@fluff.org>
References: <20220721211729.451731-1-ben-linux@fluff.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the use of a pointer assignment from integer where false
is being used instead of NULL. Fix the following warning by
usign NULL:

arch/arm/mm/dma-mapping.c:712:52: warning: Using plain integer as NULL pointer

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 059cce018570..1483b6a4319d 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -709,7 +709,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 
 	*handle = DMA_MAPPING_ERROR;
 	allowblock = gfpflags_allow_blocking(gfp);
-	cma = allowblock ? dev_get_cma_area(dev) : false;
+	cma = allowblock ? dev_get_cma_area(dev) : NULL;
 
 	if (cma)
 		buf->allocator = &cma_allocator;
-- 
2.35.1

