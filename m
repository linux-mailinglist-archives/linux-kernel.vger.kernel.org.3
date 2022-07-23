Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE93457EBBA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 05:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiGWDmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 23:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGWDmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 23:42:36 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EE6B71BD0;
        Fri, 22 Jul 2022 20:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=E5bSd
        3wPwM3u95WU8fODTOt0SYOO2PuBYzObYqAQDrI=; b=iRv+6pW8Hr3VHiGikm4HG
        R+lmJR6UlD6EMcerIkQENZMupg+rll2pmRbQfTP6sjOlPGaAVMn7DeuBgoSiSh4s
        SZT9E0WQnB2POkS2luRvVTbFtgJWD3spN3dNCoTgGw3XQ7W/6HGRTucBaEpUV+Ol
        s3u8lmdK/WvELVbGrOan7Q=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp2 (Coremail) with SMTP id GtxpCgD3sQvrbdtiiq_7Qg--.36884S2;
        Sat, 23 Jul 2022 11:41:33 +0800 (CST)
From:   williamsukatube@163.com
To:     linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jckuo@nvidia.com, kishon@ti.com, vkoul@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] phy: tegra: xusb: check the return value of devm_kzalloc() in tegra_xusb_setup_usb_role_switch()
Date:   Sat, 23 Jul 2022 11:41:30 +0800
Message-Id: <20220723034130.2952016-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgD3sQvrbdtiiq_7Qg--.36884S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWrZrWftw17Cw1kKw1ftFb_yoWDXrg_uw
        s5Zr97Xw4qgFy7Cw1jyrsxZrWSyrW0qF1IgFsYqFy3CrW09F40yrWDZFy3u3yxC3Z5GFZr
        G34kZF1Fvr13GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5tsqJUUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbBew1Hg2AZAZahXgAAsj
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

The function devm_kzalloc() in tegra_xusb_setup_usb_role_switch()
can fail, so its return value should be checked.

Fixes: f67213cee2b35 ("phy: tegra: xusb: Add usb-role-switch support")
Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 drivers/phy/tegra/xusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index aa5237eacd29..e3611fb4c779 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -668,6 +668,8 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
 	port->dev.driver = devm_kzalloc(&port->dev,
 					sizeof(struct device_driver),
 					GFP_KERNEL);
+	if (!port->dev.driver)
+		return -ENOMEM;
 	port->dev.driver->owner	 = THIS_MODULE;
 
 	port->usb_role_sw = usb_role_switch_register(&port->dev,
-- 
2.25.1

