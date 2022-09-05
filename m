Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F20B5ACD12
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbiIEHsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiIEHsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:48:20 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B46D399F7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KMZ+r
        4yNZ+3+A+Lv7ylA9VmV3lPspBo1F6/XdxNKy6E=; b=cxqql0m5RHBoH5R7LbZDq
        N3qphVre3S8k4vrIOtoX68ONMAQvxQUZADE44cLZF/MjaQf0c5uVND4DGYstW4+c
        Hl5PCb9kTcgU6sKJ5fSxZCXDXWQjw9p+UDNlCxlxYgfuTEkbZiia9K+HJAx+Wl1z
        QHfWu5yze2rQ9OurLWgo5E=
Received: from localhost.localdomain (unknown [36.112.3.113])
        by smtp5 (Coremail) with SMTP id HdxpCgCnwCyzqRVjfhjSZw--.34220S4;
        Mon, 05 Sep 2022 15:48:11 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     sre@kernel.org, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] HSI: ssi_protocol: fix potential resource leak in ssip_pn_open()
Date:   Mon,  5 Sep 2022 15:48:01 +0800
Message-Id: <20220905074801.46167-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgCnwCyzqRVjfhjSZw--.34220S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wry8trW7Xw18Jw15CFWfKrg_yoWfuFgEkF
        y0qFy7WF4UGFnIka4FyrySvrWfCr4v9FZxJF1aqF13J34kZrnrCrnrtrZrAayxZFW0q34F
        yrn5uw1vyw43WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRt6wZJUUUUU==
X-Originating-IP: [36.112.3.113]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiWxtzjGI0WHHwEwAAsj
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ssip_pn_open() claims the HSI client's port with hsi_claim_port(). When
hsi_register_port_event() gets some error and returns a negetive value,
the HSI client's port should be released with hsi_release_port().

Fix it by calling hsi_release_port() when hsi_register_port_event() fails.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/hsi/clients/ssi_protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hsi/clients/ssi_protocol.c b/drivers/hsi/clients/ssi_protocol.c
index 21f11a5b965b..49ffd808d17f 100644
--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -931,6 +931,7 @@ static int ssip_pn_open(struct net_device *dev)
 	if (err < 0) {
 		dev_err(&cl->device, "Register HSI port event failed (%d)\n",
 			err);
+		hsi_release_port(cl);
 		return err;
 	}
 	dev_dbg(&cl->device, "Configuring SSI port\n");
-- 
2.25.1

