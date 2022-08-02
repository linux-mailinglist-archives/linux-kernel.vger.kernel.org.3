Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3535D587812
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbiHBHnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbiHBHnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:43:02 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57A6A5FFA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DNakM
        8KxiYtvg6qSWyaAM8M+Rao4NDhg/QTEDD4Tz1A=; b=iO8q7J2uY2+W4GAacA88e
        b3jRb1ul1eb5ZC80FXfLBYkvHLGaWI8JttFPT2skA9xZ0Lh/mkmZ9h93ySICPVNC
        bqK7R8d2vmJCglcS3Zco1nE5aH/bW4JWXHjrQFTmxTcgTl7JZo5yFgZpcRCOzKfF
        sy+6lVS4/KKzAwq0awN+NY=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp7 (Coremail) with SMTP id C8CowABHmrpD1ehiPIRqRg--.2476S2;
        Tue, 02 Aug 2022 15:41:57 +0800 (CST)
From:   studentxswpy@163.com
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Xie Shaowen <studentxswpy@163.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] mm: check the return value of ioremap() in macio_init()
Date:   Tue,  2 Aug 2022 15:41:48 +0800
Message-Id: <20220802074148.3213659-1-studentxswpy@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowABHmrpD1ehiPIRqRg--.2476S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw4kuF45tF15trWDXryrWFg_yoW3KrXEya
        4SvFs7XanFk3WUtr1DKF1fX34UKF18uFyDXa15KrZxCa48CFyxXFs5ZryDWa4UZF40ya9x
        CFs5XFyvywsFkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8gVy7UUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xvwxvv5qw024ls16il2tof0z/1tbiHQVRJGI66PZqHgAAsf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie Shaowen <studentxswpy@163.com>

The function ioremap() in macio_init() can fail, so
its return value should be checked.

Fixes: 36874579dbf4c ("[PATCH] powerpc: macio-adb build fix")
Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: Xie Shaowen <studentxswpy@163.com>
---
 drivers/macintosh/macio-adb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/macintosh/macio-adb.c b/drivers/macintosh/macio-adb.c
index 9b63bd2551c6..cd4e34d15c26 100644
--- a/drivers/macintosh/macio-adb.c
+++ b/drivers/macintosh/macio-adb.c
@@ -108,6 +108,10 @@ int macio_init(void)
 		return -ENXIO;
 	}
 	adb = ioremap(r.start, sizeof(struct adb_regs));
+	if (!adb) {
+		of_node_put(adbs);
+		return -ENOMEM;
+	}
 
 	out_8(&adb->ctrl.r, 0);
 	out_8(&adb->intr.r, 0);
-- 
2.25.1

