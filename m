Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB6D4AE87D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346091AbiBIEMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347554AbiBIDvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:51:33 -0500
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2469EC061578
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=YvOhP
        o6ymYclh5k4417PVKOkRi78cNnblip3oZXJi9w=; b=EvB8v6eIZiPZcMFLgJBC8
        XZjomhJCJKc3MCB1/xa+vMyA8743IkmYQBRoQcNoXDc50AkOrOpY7OqgZFrV5f9r
        VHmYy318ywQKCDkQguf0+ZMTF/kg9nylPSI29uBXYUn5Dc+eKsOXIHBMwtFuGJbu
        ylu9mg+AN1i1R9B2p86yRI=
Received: from sysgbj8.hosso.cc (unknown [42.62.85.2])
        by smtp13 (Coremail) with SMTP id EcCowACnPAovOgNin9hKCA--.39192S2;
        Wed, 09 Feb 2022 11:51:11 +0800 (CST)
From:   chengchaohang@163.com
To:     leon@kernel.org, maorg@nvidia.com, jgg@ziepe.ca,
        logang@deltatee.com, thunder.leizhen@huawei.com
Cc:     linux-kernel@vger.kernel.org,
        "chaohang . cheng" <chaohang.cheng@horizon.ai>
Subject: [PATCH] lib/scatterlist: Provide scatterlist hexdump.
Date:   Wed,  9 Feb 2022 11:51:11 +0800
Message-Id: <20220209035111.28365-1-chengchaohang@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowACnPAovOgNin9hKCA--.39192S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF18ZF4xJF48AF48WFWkXrb_yoWkCrb_Ca
        47Jw45Gr4fGF4IqFW3WFWftFy8WFZ8ZF1I9F1Igr93W3s8urs8X34vqr9rAF45Way8Ca1D
        Gasaqas7XF1UXjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU57UUUUUUUU==
X-Originating-IP: [42.62.85.2]
X-CM-SenderInfo: xfkh0wpfkd0xxdqjqiywtou0bp/xtbBEw+ivF3l-1bNiwAAsV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "chaohang.cheng" <chaohang.cheng@horizon.ai>

A scatterlist hexdump is essential during debug, sometimes.

Signed-off-by: chaohang.cheng <chaohang.cheng@horizon.ai>
---
 include/linux/scatterlist.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 7ff9d6386c12..ef8ecaac0016 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -563,4 +563,21 @@ bool sg_miter_skip(struct sg_mapping_iter *miter, off_t offset);
 bool sg_miter_next(struct sg_mapping_iter *miter);
 void sg_miter_stop(struct sg_mapping_iter *miter);
 
+/*
+ * Hexdump scatterlist
+ *
+ * @sg: struct scatterlist* .
+ * it stands for the head of a scatterlist .
+ *
+ * note: print_hex_dump_debug is a dynamic debug .
+ *
+ */
+#define SG_HEXDUMP(sg)							\
+do {									\
+	struct scatterlist *sg_tmp = NULL;				\
+	for (sg_tmp = sg; sg_tmp; sg_tmp = sg_next(sg_tmp))		\
+		print_hex_dump_debug("", DUMP_PREFIX_OFFSET,		\
+			16, 1, sg_virt(sg_tmp), sg_tmp->length, true);	\
+} while (0)
+
 #endif /* _LINUX_SCATTERLIST_H */
-- 
2.25.1

