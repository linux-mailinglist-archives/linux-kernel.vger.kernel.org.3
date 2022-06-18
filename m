Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ADC550366
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 09:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbiFRHiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 03:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiFRHh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 03:37:58 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A987131DDC
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 00:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cwvrM
        twwaf2eGhHlVdwPwEDf4EW4aPt9uaNxslFq5Iw=; b=AtTFpsS6NRsz6EmMRKouh
        FFIeJbtaM85094GmIAs4K4+wMLl4w44kaU7Uf1oIeRPQUp8y1WCNVfoof1C9fTRm
        RPquwtVvXxqDsL/qdXzjgjUV59S9ByVBUZ7/ARs05oUhRJZYVHSLcTgsAqG3LkM/
        qwgqBoVnEBk2aMJ8W3FqiI=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgCH51vLgK1iiG+cEw--.30712S2;
        Sat, 18 Jun 2022 15:37:47 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     davem@davemloft.net
Cc:     windhl@126.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sbus: char: Fix refcount leak bug in openrom.c
Date:   Sat, 18 Jun 2022 15:37:46 +0800
Message-Id: <20220618073746.4059541-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgCH51vLgK1iiG+cEw--.30712S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW8Jr1fCF45WF1fCrW5trb_yoWxtrb_CF
        1xXryxtr1ktFsxC3sFvws3uryFyF1FgrZYvFnIqa45t3WYqrWfWryjvr95WryUAFW8Jry7
        A39rZFyrArnrtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU3fH5UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2gskF1uwMOngXAAAss
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In opiocgetnext(), we need a of_node_put() to keep refcount balance
for device_node pointer returned by of_find_node_by_phandle() or
of_find_node_by_path().

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/sbus/char/openprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 30b9751aad30..701978db0f0f 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -518,6 +518,7 @@ static int opiocgetnext(unsigned int cmd, void __user *argp)
 	}
 	if (dp)
 		nd = dp->phandle;
+	of_node_put(dp);
 	if (copy_to_user(argp, &nd, sizeof(phandle)))
 		return -EFAULT;
 
-- 
2.25.1

