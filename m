Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352444ED17B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352436AbiCaCCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiCaCCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:02:10 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD12E59A54;
        Wed, 30 Mar 2022 19:00:22 -0700 (PDT)
X-UUID: ee198aa9a1fa471997daaec4c548884a-20220331
X-UUID: ee198aa9a1fa471997daaec4c548884a-20220331
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <zhouzongmin@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1578035730; Thu, 31 Mar 2022 09:59:24 +0800
X-ns-mid: postfix-62450B31-852272900
Received: from localhost.localdomain (unknown [172.20.12.156])
        by cs2c.com.cn (NSMail) with ESMTPA id AAEC6383C640;
        Thu, 31 Mar 2022 02:00:17 +0000 (UTC)
From:   Zongmin Zhou <zhouzongmin@kylinos.cn>
To:     linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouzongmin@kylinos.cn
Subject: [RESEND PATCH] input/vmmouse: Add vmmouse_reset() function to disable vmmouse before entering suspend mode
Date:   Thu, 31 Mar 2022 09:59:55 +0800
Message-Id: <20220331015955.1066872-1-zhouzongmin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220322021046.1087954-1-zhouzongmin@kylinos.cn>
References: <20220322021046.1087954-1-zhouzongmin@kylinos.cn>
MIME-Version: 1.0
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
When I use VirtualPS/2 VMMouse on virtual machine,
There will be an error message after resume from suspend mode.
like below:
vmmouse: Unable to re-enable mouse when reconnecting, err: -6

And vmmouse will be unusable,so have to do full rescan
to find a another driver to use for the port.

This error is due to QEMU still generate PS2 events
to notify kernel driver to read from queue,
but kernel can't process the data in suspend mode,
resulting a surge of s->nb_queue value,
which ultimately led to an error getting VMMOUSE_VERSION_ID after resume.

Test scenario:
1)virtual machine started with qemu command "vmport=on",
  it will use VirtualPS/2 VMMouse.
2)click suspend botton to enter suspend mode.
3)resume and will get the error message from dmesg.

Fixed by:
Disabling the vmmouse in its reset handler,
It will notify qemu to stop vmmouse and remove handler.

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

