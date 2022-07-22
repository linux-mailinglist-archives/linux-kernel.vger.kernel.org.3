Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E4657DF50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiGVJm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbiGVJmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:42:03 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72A9710B5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ziL0e
        DO+Itprb1jVyXzk432mqBLHi0A8HJSQe35XEnE=; b=X/zFVBe41Y0YfBHGZegYs
        wYUKRLbDDxZ+9aR6NbLN1mXUlqNtMBUkvw/+FgFFuTCHKflUFKIU3Jc5gVXBQDkX
        P/ROprVSwK0EpS0rhBTYffeh6nZeK03Zk2nc2At9SIzuLhovr3fcxjvUV1CqulyV
        hVjkjaNDPaV6lfAKaFMQSM=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp2 (Coremail) with SMTP id GtxpCgDHafRNbtpiOJJjQg--.3043S2;
        Fri, 22 Jul 2022 17:30:54 +0800 (CST)
From:   williamsukatube@163.com
To:     qiang.zhao@nxp.com, leoyang.li@nxp.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] soc: fsl: qe: Add check for platform_driver_register
Date:   Fri, 22 Jul 2022 17:30:51 +0800
Message-Id: <20220722093051.2939076-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgDHafRNbtpiOJJjQg--.3043S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4DCF47Gry3ZFyDur15urg_yoWDJrX_Cw
        4rW3W7Xr4kWF93GF17tw43Z3s29FsYvrnaqa10qasxta4xJw47Xan8ZF43C3WkXrs5XFWD
        GrnxZrySkw13WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5MMKtUUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/1tbiNw5Gg1WBo2SbIQAAsV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

As platform_driver_register() could fail, it should be better
to deal with the return value in order to maintain the code
consisitency.

Fixes: be7ecbd240b2f ("soc: fsl: qe: convert QE interrupt controller to platform_device")
Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 drivers/soc/fsl/qe/qe_ic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index bbae3d39c7be..f17de6000ff2 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -481,7 +481,6 @@ static struct platform_driver qe_ic_driver =
 
 static int __init qe_ic_of_init(void)
 {
-	platform_driver_register(&qe_ic_driver);
-	return 0;
+	return platform_driver_register(&qe_ic_driver);
 }
 subsys_initcall(qe_ic_of_init);
-- 
2.25.1

