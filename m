Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65714500AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbiDNKGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239658AbiDNKGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:06:46 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF202B0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:04:20 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 14 Apr
 2022 18:04:20 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 14 Apr
 2022 18:04:18 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <bp@suse.de>, <brijesh.singh@amd.com>, <liam.merwick@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] virt: sevguest: Fix bool function returning negative value
Date:   Thu, 14 Apr 2022 18:04:17 +0800
Message-ID: <1649930657-10837-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

function enc_payload() is bool but return signedness value.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/virt/coco/sevguest/sevguest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
index 15afb6ce8d19..07adf3145d76 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -276,7 +276,7 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
 	return dec_payload(snp_dev, resp, payload, resp_hdr->msg_sz + crypto->a_len);
 }
 
-static bool enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
+static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
 			void *payload, size_t sz)
 {
 	struct snp_guest_msg *req = snp_dev->request;
-- 
2.7.4

