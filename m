Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7074FA591
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 09:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbiDIHYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 03:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiDIHYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 03:24:00 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4034429F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 00:21:52 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.15.192.164])
        by mail-app3 (Coremail) with SMTP id cC_KCgAXScj_M1FiXry4AQ--.49990S2;
        Sat, 09 Apr 2022 15:21:39 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org
Cc:     linux-staging@lists.linux.dev, alexander.deucher@amd.com,
        kuba@kernel.org, broonie@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        Larry.Finger@lwfinger.net, Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] drivers: staging: rtl8192eu: Fix deadlock in rtw_joinbss_event_prehandle
Date:   Sat,  9 Apr 2022 15:21:35 +0800
Message-Id: <20220409072135.74248-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgAXScj_M1FiXry4AQ--.49990S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF15Zr48urWUKFWkGw15Jwb_yoW8tF4rpF
        Wjgr1fuF1vqr429F4kJ3WDXF13Za18WryUJFWrG3yku3s5Arn3ZFW5trWftF4aqFn7W39I
        9r1kW3sxAF4DCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgQPAVZdtZGjxwBTsQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a deadlock in rtw_joinbss_event_prehandle(), which is shown below:

   (Thread 1)                |      (Thread 2)
                             | _set_timer()
rtw_joinbss_event_prehandle()|  mod_timer()
 spin_lock_bh() //(1)        |  (wait a time)
 ...                         | rtw_join_timeout_handler()
                             |  _rtw_join_timeout_handler()
 del_timer_sync()            |   spin_lock_bh() //(2)
 (wait timer to stop)        |   ...

We hold pmlmepriv->lock in position (1) of thread 1 and
use del_timer_sync() to wait timer to stop, but timer handler
also need pmlmepriv->lock in position (2) of thread 2.
As a result, rtw_joinbss_event_prehandle() will block forever.

This patch extracts del_timer_sync() from the protection of
spin_lock_bh(), which could let timer handler to obtain
the needed lock. What`s more, we change spin_lock_bh() to
spin_lock_irq() in _rtw_join_timeout_handler() in order to
prevent deadlock.

Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 6f0bff18647..76cf6a69bf0 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1071,8 +1071,10 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 				rtw_indicate_connect(adapter);
 			}
 
+			spin_unlock_bh(&pmlmepriv->lock);
 			/* s5. Cancel assoc_timer */
 			del_timer_sync(&pmlmepriv->assoc_timer);
+			spin_lock_bh(&pmlmepriv->lock);
 		} else {
 			spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 			goto ignore_joinbss_callback;
@@ -1310,7 +1312,7 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
 	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 		return;
 
-	spin_lock_bh(&pmlmepriv->lock);
+	spin_lock_irq(&pmlmepriv->lock);
 
 	if (rtw_to_roaming(adapter) > 0) { /* join timeout caused by roaming */
 		while (1) {
@@ -1329,7 +1331,7 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
 		rtw_indicate_disconnect(adapter);
 		free_scanqueue(pmlmepriv);/*  */
 	}
-	spin_unlock_bh(&pmlmepriv->lock);
+	spin_unlock_irq(&pmlmepriv->lock);
 
 }
 
-- 
2.17.1

