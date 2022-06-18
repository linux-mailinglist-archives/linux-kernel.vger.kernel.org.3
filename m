Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDD0550233
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiFRC5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiFRC5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:57:12 -0400
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1AC26C0E0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Y2R0w
        LWoS3MlLi/kilNMf914qQrU9POFF5jg8cOKHx0=; b=LYPCGa8upCP5Yy3flrbhF
        D1nrL9Wfzi1wUM0sUooiKt8cwngQ0YCjUSOaiebuLI2yQPlmuXJ1+Z4CQe0lg0Et
        cXx/kxJP24Y8kVwPKelIMPXCRMYLrMaPc0H/4Sy3hQrlyypsKEyO2CViDmDDn9iz
        XhmCtObl+7tmlZplZNWdgI=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp2 (Coremail) with SMTP id DMmowAD3SATvPq1ifd5nDg--.23620S2;
        Sat, 18 Jun 2022 10:56:48 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     deller@gmx.de, christophe.leroy@csgroup.eu
Cc:     windhl@126.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: Fix refcount leak bug in valkyriefb.c
Date:   Sat, 18 Jun 2022 10:56:47 +0800
Message-Id: <20220618025647.4057077-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowAD3SATvPq1ifd5nDg--.23620S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4UJF17Jw1kWw1fCFyrCrg_yoW3Krb_uF
        1kZrZrGryUtr10gw1vgr45uryYvFWxWF1xZFn7t393Cry7Zr15Xr1Ivr1Ik34DW348GF98
        ZrnFgr10yw1S9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtLvKUUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgEkF1-HZUnXDAAAsH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In valkyriefb_init(), of_find_node_by_name() will return a node pointer
with refcount incremented. We should use of_node_put() in fail path or
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/video/fbdev/valkyriefb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index a6c9d4f26669..20d727a8069d 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -334,10 +334,13 @@ int __init valkyriefb_init(void)
 			return 0;
 
 		if (of_address_to_resource(dp, 0, &r)) {
+			of_node_put(dp);
 			printk(KERN_ERR "can't find address for valkyrie\n");
 			return 0;
 		}
 
+		of_node_put(dp);
+
 		frame_buffer_phys = r.start;
 		cmap_regs_phys = r.start + 0x304000;
 	}
-- 
2.25.1

