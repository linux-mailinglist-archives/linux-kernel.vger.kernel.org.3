Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A5056CFD8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 17:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiGJPtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 11:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJPto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 11:49:44 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB06AA186;
        Sun, 10 Jul 2022 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wBpy/
        1Al1S+IcisW01w7tkfDPuEkN3RCpqdYUq79uMk=; b=L2qeanDab5hW+MJJIpYm8
        AwHM0BIZvvx6zPAZIEyFVNefvE9GrYp6jnUO1zz9p2svPvspJI+RoSxx83fNAofQ
        qHk+DdatyXsMS69ozlzcLhubohgUmCIP/Hg1bK3BUqL9pchWbFsscXzz0Yttx1Ok
        miq6BOmcdBXJyLtl5eQWLg=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp1 (Coremail) with SMTP id GdxpCgDX35_J9MpiqnY_Ng--.21432S2;
        Sun, 10 Jul 2022 23:48:29 +0800 (CST)
From:   williamsukatube@163.com
To:     dvorkin@tibbo.com, wellslutw@gmail.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] pinctrl: Add check for kcalloc
Date:   Sun, 10 Jul 2022 23:48:22 +0800
Message-Id: <20220710154822.2610801-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgDX35_J9MpiqnY_Ng--.21432S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWrKr4UKr17GF1fGr45KFg_yoWDWwc_ua
        yrWFyDXrWUKF1xtrsFqrn3W34Fvw45Zr1Fvr1vqFy3Aay7Xw1UJr1kuFs5Wwn7Wr98CFZx
        G3sFyr1Fya47KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5TWlPUUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/1tbiUQ06g2DEOjWbQAAAsV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

As the potential failure of the kcalloc(),
it should be better to check it in order to
avoid the dereference of the NULL pointer.

Fixes: aa74c44be19c8 ("pinctrl: Add driver for Sunplus SP7021")
Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 drivers/pinctrl/sunplus/sppctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sppctl.c
index 3ba47040ac42..2b3335ab56c6 100644
--- a/drivers/pinctrl/sunplus/sppctl.c
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -871,6 +871,9 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 	}
 
 	*map = kcalloc(*num_maps + nmG, sizeof(**map), GFP_KERNEL);
+	if (*map == NULL)
+		return -ENOMEM;
+
 	for (i = 0; i < (*num_maps); i++) {
 		dt_pin = be32_to_cpu(list[i]);
 		pin_num = FIELD_GET(GENMASK(31, 24), dt_pin);
-- 
2.25.1

