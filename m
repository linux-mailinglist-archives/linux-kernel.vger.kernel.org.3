Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0401493752
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353034AbiASJaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:30:16 -0500
Received: from smtp1.axis.com ([195.60.68.17]:62642 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351878AbiASJaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1642584615;
  x=1674120615;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fVAwHaS1X7k3SDlOAWurnc8ko2g4X9eIjVrR29heTW0=;
  b=mp0E++yT//XRuWTp4puaoxtdcK0RMESQEeEJPgTsGLJyEThSm+eCHWe1
   fPr0zk2/v9I3JYIZAMiJeSLVpH3sht4p7NOh9HBFIMCQeLoA/AJCqOkU4
   lU8VVT6fQ5eiscFAw9Y6Iu4ibm8tLx7VKr5IUGhAUECdrvsI17m11b8d8
   oJsWII0qsjE2TUsBD8fv9DtOOpLdU7x4121S6248MxLNaL62VwqSHyPoH
   DzPqyC8++E7PN08MCF1pYQWC7LM4ethWg8Gb/6BH3zi7cI/C5BMY3Iia4
   wSommrN5DBprwNxlFb6IjJ/V93f3pMhCTNs+eAKfiNZ6lqgJdYdPFzv96
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC:     <kernel@axis.com>, <devicetree@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Rob Herring <robh@kernel.org>, <linux-um@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] um: Fix order of dtb unflatten/early init
Date:   Wed, 19 Jan 2022 10:29:34 +0100
Message-ID: <20220119092934.5285-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scan the tree for reserved memory before unflattening it.  As Rob
Herring said:
| These should be reversed. early_init_fdt_scan_reserved_mem() works on
| the flat tree. Reserved memory needs to be reserved before
| unflatten_device_tree() starts allocating memory. Though I imagine that
| doesn't really matter for UML.

Suggested-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/lkml/YeF%2FVbxo6fAt0WLp@robh.at.kernel.org/
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/kernel/dtb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
index ca69d72025f3..484141b06938 100644
--- a/arch/um/kernel/dtb.c
+++ b/arch/um/kernel/dtb.c
@@ -25,8 +25,8 @@ void uml_dtb_init(void)
 		return;
 	}
 
-	unflatten_device_tree();
 	early_init_fdt_scan_reserved_mem();
+	unflatten_device_tree();
 }
 
 static int __init uml_dtb_setup(char *line, int *add)
-- 
2.34.1

