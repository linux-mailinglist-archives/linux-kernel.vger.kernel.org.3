Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8FC54EFD1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379699AbiFQDrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 23:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379624AbiFQDrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 23:47:04 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AC57663E1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 20:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uRKrn
        tUzQoHTv4JlS/S4G178HD4gOGzZh1kem20v+Dk=; b=N1mVINlG1NV8k0fX2LD4A
        lzQQsPbs56HpYcbaYA9ZDeg4QGXrh/AtWXkXbM3hV9EXsmwGJjAEG6O57W0ZPo8c
        00OuJlBuper1zINfCQXHzQPnn3HNCz4A4HNxapdOR6rrTiGXA+33+Dd6evFUZU0v
        FtjyrcKCU8dv9bNWTBlyPk=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgBHqV0e+atiq7xeEw--.58613S2;
        Fri, 17 Jun 2022 11:46:44 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     windhl@126.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: host: ohci-ppc-of: Fix refcount leak bug
Date:   Fri, 17 Jun 2022 11:46:37 +0800
Message-Id: <20220617034637.4003115-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgBHqV0e+atiq7xeEw--.58613S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFy8GFy3WrW5try5ZFW3Awb_yoW3Wwb_Aa
        4rWr17W3ykWFn8KFWjkFWY9rZ2kr1kWF40vF1ktwnagw1qkFn8WrnFvFWDJay5WrWUJF90
        kwn7XF1xuF4S9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUyrW3UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGhUjF1-HZUMOZwAAss
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ohci_hcd_ppc_of_probe(), of_find_compatible_node() will return
a node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/usb/host/ohci-ppc-of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ohci-ppc-of.c b/drivers/usb/host/ohci-ppc-of.c
index 1960b8dfdba5..591f675cc930 100644
--- a/drivers/usb/host/ohci-ppc-of.c
+++ b/drivers/usb/host/ohci-ppc-of.c
@@ -166,6 +166,7 @@ static int ohci_hcd_ppc_of_probe(struct platform_device *op)
 				release_mem_region(res.start, 0x4);
 		} else
 			pr_debug("%s: cannot get ehci offset from fdt\n", __FILE__);
+		of_node_put(np);
 	}
 
 	irq_dispose_mapping(irq);
-- 
2.25.1

