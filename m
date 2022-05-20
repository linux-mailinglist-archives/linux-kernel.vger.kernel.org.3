Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE8B52E4DC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345783AbiETGQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345791AbiETGQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:16:08 -0400
Received: from azure-sdnproxy-2.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1DC933C488
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:16:03 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [124.236.130.193])
        by mail-app4 (Coremail) with SMTP id cS_KCgAnkCMOModigzl+AA--.18742S2;
        Fri, 20 May 2022 14:15:51 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org
Cc:     davem@davemloft.net, kuba@kernel.org, alexander.deucher@amd.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] staging: rtl8192u: Fix sleep in atomic context bug in dm_fsync_timer_callback
Date:   Fri, 20 May 2022 14:15:41 +0800
Message-Id: <20220520061541.14785-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgAnkCMOModigzl+AA--.18742S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWftF15CF13ur18Xw47Jwb_yoW8Aw1UpF
        WkC3WDCF48tFnF9w1kAw4vvryFk3Z7Ca4xGF9rZ345u3s5t3WUWFWYyFy0yr4UA3y5CFWF
        vFyYkr13Zr4DCr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUndb1UUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgAQAVZdtZyoSgAEsX
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are sleep in atomic context bugs when dm_fsync_timer_callback is
executing. The root cause is that the memory allocation functions with
GFP_KERNEL parameter are called in dm_fsync_timer_callback which is a
timer handler. The call paths that could trigger bugs are shown below:

    (interrupt context)
dm_fsync_timer_callback
  write_nic_byte
    kzalloc(sizeof(data), GFP_KERNEL); //may sleep
  write_nic_dword
    kzalloc(sizeof(data), GFP_KERNEL); //may sleep

This patch changes allocation mode from GFP_KERNEL to GFP_ATOMIC
in order to prevent atomic context sleeping. The GFP_ATOMIC flag
makes memory allocation operation could be used in atomic context.

Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/staging/rtl8192u/r8192U_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index ce807c9d421..679c362baad 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -267,7 +267,7 @@ int write_nic_byte(struct net_device *dev, int indx, u8 data)
 
 	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
 	struct usb_device *udev = priv->udev;
-	u8 *usbdata = kzalloc(sizeof(data), GFP_KERNEL);
+	u8 *usbdata = kzalloc(sizeof(data), GFP_ATOMIC);
 
 	if (!usbdata)
 		return -ENOMEM;
@@ -319,7 +319,7 @@ int write_nic_dword(struct net_device *dev, int indx, u32 data)
 
 	struct r8192_priv *priv = (struct r8192_priv *)ieee80211_priv(dev);
 	struct usb_device *udev = priv->udev;
-	u32 *usbdata = kzalloc(sizeof(data), GFP_KERNEL);
+	u32 *usbdata = kzalloc(sizeof(data), GFP_ATOMIC);
 
 	if (!usbdata)
 		return -ENOMEM;
-- 
2.17.1

