Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F3B5877BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbiHBHVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiHBHVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:21:33 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3575314D22;
        Tue,  2 Aug 2022 00:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SQ1A9
        rHYoE2LE5roYoK9D1dhwBdnDWhdPz3jmUXmsvI=; b=X3OmEQrkSgOjndmfEkswJ
        tnU90CxjS046ecbfNclCftwhVu2coa+WDTGW7fCql/jS7OeTuRnpJfMvKMCo0KZ4
        hj1NZD0wFzW4FdzS2U5Z9ZMQgAeXPRS7P6opaOOJ3fCimd/+LTE3Zl5GLGo4Caa6
        m+ZxHl+HUZT21JKXPClYvE=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp2 (Coremail) with SMTP id GtxpCgA3re9E0OhinfOTSw--.5314S2;
        Tue, 02 Aug 2022 15:20:38 +0800 (CST)
From:   studentxswpy@163.com
To:     James.Bottomley@HansenPartnership.com, deller@gmx.de,
        dmitry.torokhov@gmail.com, linux-parisc@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xie Shaowen <studentxswpy@163.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] Input: check the return value of ioremap() in gscps2_probe()
Date:   Tue,  2 Aug 2022 15:20:33 +0800
Message-Id: <20220802072033.3211980-1-studentxswpy@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgA3re9E0OhinfOTSw--.5314S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw4DZFWUtw1fXr45ZFy8uFg_yoWfurbE9a
        sYvF1Sqr4jkr4rtr1DWrnxZ3Z8tws7Zr95ZFnYyasakFy8Ww1DAa1UWF1DZw15W3Z7XrZ8
        CrZYgFZavw1fWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8JxhPUUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xvwxvv5qw024ls16il2tof0z/xtbB0wpRJFXlwVGjCQAAsm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie Shaowen <studentxswpy@163.com>

The function ioremap() in gscps2_probe() can fail, so
its return value should be checked.

Fixes: 4bdc0d676a643 ("remove ioremap_nocache and devm_ioremap_nocache")
Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: Xie Shaowen <studentxswpy@163.com>
---
 drivers/input/serio/gscps2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index a9065c6ab550..da2c67cb8642 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -350,6 +350,10 @@ static int __init gscps2_probe(struct parisc_device *dev)
 	ps2port->port = serio;
 	ps2port->padev = dev;
 	ps2port->addr = ioremap(hpa, GSC_STATUS + 4);
+	if (!ps2port->addr) {
+		ret = -ENOMEM;
+		goto fail_nomem;
+	}
 	spin_lock_init(&ps2port->lock);
 
 	gscps2_reset(ps2port);
-- 
2.25.1

