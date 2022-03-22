Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998AB4E3670
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 03:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiCVCNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 22:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiCVCM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:12:56 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60431D0F9;
        Mon, 21 Mar 2022 19:11:16 -0700 (PDT)
X-UUID: dd3f82672986463ea90bc96c9671ccc3-20220322
X-UUID: dd3f82672986463ea90bc96c9671ccc3-20220322
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <zhouzongmin@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1776092599; Tue, 22 Mar 2022 10:10:26 +0800
X-ns-mid: postfix-6239303C-8089562461
Received: from localhost.localdomain (unknown [172.20.12.156])
        by cs2c.com.cn (NSMail) with ESMTPA id A2351383C640;
        Tue, 22 Mar 2022 02:11:08 +0000 (UTC)
From:   Zongmin Zhou <zhouzongmin@kylinos.cn>
To:     linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouzongmin@kylinos.cn
Subject: [PATCH] input/vmmouse: Add vmmouse_reset() function to disable vmmouse before entering suspend mode
Date:   Tue, 22 Mar 2022 10:10:46 +0800
Message-Id: <20220322021046.1087954-1-zhouzongmin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Details:
When I use VirtualPS/2 VMMouse on virtual machine,There will be an error message after resume from suspend mode.
like below:
psmouse serio1: vmmouse: Unable to re-enable mouse when reconnecting, err: -6
And vmmouse will be unusable，so have to do full rescan to find a another driver to use for the port.

This error is due to QEMU still generate PS2 events to notify kernel driver to read from queue,
but kernel can't process the data in suspend mode, resulting a surge of s->nb_queue value,
which ultimately led to an error getting VMMOUSE_VERSION_ID after resume.

Test scenario:
1)virtual machine started with qemu command "vmport=on",it will use VirtualPS/2 VMMouse
2)click suspend botton to enter suspend mode
3)resume and will get the error message from dmesg

Fixed by:
Disabling the vmmouse in its reset handler,It will notify qemu to stop vmmouse and remove handler.

Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
---
 drivers/input/mouse/vmmouse.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
index 42443ffba7c4..ea9eff7c8099 100644
--- a/drivers/input/mouse/vmmouse.c
+++ b/drivers/input/mouse/vmmouse.c
@@ -365,6 +365,19 @@ int vmmouse_detect(struct psmouse *psmouse, bool set_properties)
 	return 0;
 }
 
+/**
+ * vmmouse_reset - Disable vmmouse and reset
+ *
+ * @psmouse: Pointer to the psmouse struct
+ *
+ * Tries to disable vmmouse mode before enter suspend.
+ */
+static void vmmouse_reset(struct psmouse *psmouse)
+{
+	vmmouse_disable(psmouse);
+	psmouse_reset(psmouse);
+}
+
 /**
  * vmmouse_disconnect - Take down vmmouse driver
  *
@@ -472,6 +485,7 @@ int vmmouse_init(struct psmouse *psmouse)
 	psmouse->protocol_handler = vmmouse_process_byte;
 	psmouse->disconnect = vmmouse_disconnect;
 	psmouse->reconnect = vmmouse_reconnect;
+	psmouse->cleanup = vmmouse_reset;
 
 	return 0;
 
-- 
2.25.1

