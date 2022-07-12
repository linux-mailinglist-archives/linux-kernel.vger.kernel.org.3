Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71665712E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiGLHOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGLHON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:14:13 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E13E52E7E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bSYm9
        C5OeuYbDhENBAdXq4HRvNSPczwQvj64WhMLeyk=; b=KB5xRyB0ILL9VqILcLd4a
        S83vIxTAf0E3sDLh+IaFKKo9mFY/+zguQaYmpGa8ukqNu1zJ6iBn0SZUzUWirtFI
        YOPnaQnz31qw+8WWU4+DTiL5vZ1KRhfduBZ7fTcYXBcj04mzReko0ehU+D5Ejw7G
        XSo8sbf8UrMi8lwLxqseb8=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp11 (Coremail) with SMTP id D8CowAAHffomH81i5anSMQ--.64515S2;
        Tue, 12 Jul 2022 15:13:44 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] component: replace ternary operator with min()
Date:   Tue, 12 Jul 2022 15:12:23 +0800
Message-Id: <20220712071223.301160-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAAHffomH81i5anSMQ--.64515S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4kXF4DJw4UAry8WFWrAFb_yoWkCFc_Cr
        nruas7Cr1fCrWrZr12vwsIyryvqayj9F1jqFnagr1fG34UZan2gFykZryrt348Cr1Yg3Zr
        Gr1qyry2yr4IkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnc_-DUUUUU==
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbizQg8+1c7NeZ7AgAAsE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix the following coccicheck warning:

drivers/base/component.c:544: WARNING opportunity for min().
drivers/base/component.c:740: WARNING opportunity for min().

min() macro is defined in include/linux/minmax.h. It avoids
multiple evaluations of the arguments when non-constant and performs
strict type-checking.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/base/component.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 5eadeac6c532..349c54694481 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -541,7 +541,7 @@ int component_master_add_with_match(struct device *parent,
 
 	mutex_unlock(&component_mutex);
 
-	return ret < 0 ? ret : 0;
+	return min(ret, 0);
 }
 EXPORT_SYMBOL_GPL(component_master_add_with_match);
 
@@ -737,7 +737,7 @@ static int __component_add(struct device *dev, const struct component_ops *ops,
 	}
 	mutex_unlock(&component_mutex);
 
-	return ret < 0 ? ret : 0;
+	return min(ret, 0);
 }
 
 /**
-- 
2.25.1

