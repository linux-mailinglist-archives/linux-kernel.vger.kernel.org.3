Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E194FA560
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 08:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbiDIGU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 02:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiDIGUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 02:20:54 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88A0CDF69
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 23:18:47 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.15.192.164])
        by mail-app4 (Coremail) with SMTP id cS_KCgBHSfA8JVFiUYv3AA--.41344S2;
        Sat, 09 Apr 2022 14:18:39 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org
Cc:     linux-staging@lists.linux.dev, alexander.deucher@amd.com,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH V2 04/11] drivers: staging: rtl8723bs: Fix deadlock in rtw_surveydone_event_callback()
Date:   Sat,  9 Apr 2022 14:18:35 +0800
Message-Id: <20220409061836.60529-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgBHSfA8JVFiUYv3AA--.41344S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1Utw17GFWfKryUKrWkCrg_yoW8uw1Upr
        W0g34YkF1jqr1293Z7G3WDZr4fua18Kr47XFs3Kws8ZrZ5ZFy3XF98t34aqF4aqFnrXwsI
        yr18X34fAF1UCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v
        1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgQPAVZdtZGjxwA-s8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a deadlock in rtw_surveydone_event_callback(),
which is shown below:

   (Thread 1)                  |      (Thread 2)
                               | _set_timer()
rtw_surveydone_event_callback()|  mod_timer()
 spin_lock_bh() //(1)          |  (wait a time)
 ...                           | rtw_scan_timeout_handler()
 del_timer_sync()              |  spin_lock_bh() //(2)
 (wait timer to stop)          |  ...

We hold pmlmepriv->lock in position (1) of thread 1 and use
del_timer_sync() to wait timer to stop, but timer handler
also need pmlmepriv->lock in position (2) of thread 2.
As a result, rtw_surveydone_event_callback() will block forever.

This patch extracts del_timer_sync() from the protection of
spin_lock_bh(), which could let timer handler to obtain
the needed lock. What`s more, we change spin_lock_bh() in
rtw_scan_timeout_handler() to spin_lock_irq(). Otherwise,
spin_lock_bh() will also cause deadlock() in timer handler.

Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in V2:
  - Change spin_lock_bh() to spin_lock_irq() in timer handler.

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ed2d3b7d44d..62f140985e3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -751,7 +751,9 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	}
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
+		spin_unlock_bh(&pmlmepriv->lock);
 		del_timer_sync(&pmlmepriv->scan_to_timer);
+		spin_lock_bh(&pmlmepriv->lock);
 		_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 	}
 
@@ -1586,11 +1588,11 @@ void rtw_scan_timeout_handler(struct timer_list *t)
 						  mlmepriv.scan_to_timer);
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	spin_lock_bh(&pmlmepriv->lock);
+	spin_lock_irq(&pmlmepriv->lock);
 
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
 
-	spin_unlock_bh(&pmlmepriv->lock);
+	spin_unlock_irq(&pmlmepriv->lock);
 
 	rtw_indicate_scan_done(adapter, true);
 }
-- 
2.17.1

