Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03624F21A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiDECti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiDECtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:49:25 -0400
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B17D298D45
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 19:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649125721;
        bh=Fi5/0/v4H6PMTzI+ECmpUXfpIn/7jccH/60tCObW+vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dFMs8PEXO8k9llYzQr5ju2Phukm0eRjsk+pH72/tWA2I6PGfuEm4naV6vPup/2Y5o
         YDAeCNHRNFHWoOahV361XYGFGkNuCG0ao3mcocaCTjrXGXBLnIBUHT9x9x0Wbz2yv6
         IIpiDNIAqvbNbvOrBFEysJ6puI1061EYNvkQrLms=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
        id 7262DA03; Tue, 05 Apr 2022 10:28:38 +0800
X-QQ-mid: xmsmtpt1649125718t4dndk6oa
Message-ID: <tencent_024087572951FED38148303BE79A7094500A@qq.com>
X-QQ-XMAILINFO: NMnM0wIZ7bQB4eljLfNrvpPvU1VldOJ8f0V9xwoiiMBcWuw4YhAMv+BOCZuRwd
         CQof1F6sQr0iCWt7GpcUgyZxuZ+tC2pExz4BAMivYbciyw+JLAqoxFlXyZ7c+KkJzUyZK+jCGu79
         PJUkFY1YkqIohmBpMZGYLVHMf0zM4j12tTx07DcZV/AQzdFVFQaGcE6z8IWX1gjVVrUsymUvLsvo
         a72yWIliL7JYNXCKzKeQL9fPy7ld7oZ5FjZsjBYE82RZVb7k4g8wuPCXYto3BtzTy6K9jTxZCKKT
         WRioXyguXfGIFYS9S6idKbeHHTsns2mENlMaujP9QwOpEcLSC/b8dQgrmblypWt22GQnz/XkjEXH
         xVBUlGEHg7178lr2+x+vh3a9C0CVRxSgQ0Dy2RVHQZKRkJDhpFfdq6caJLCJGUn7ByFlChF0XaGl
         aKXXKzXqdj+puAA6+pKvQTsx7hjSGgdIgM1IIE2k8GNi1o4wY7f5mweYCReTn1I3+MBtXkW3lV8t
         Axd4UXNaj/Hi2E6U3v5GdHpLQVqX5k9QREMwm0bmKrbsYVB1I2Wxo4zMvs5p+Qw0voAPNoHhOGgm
         SIoK0hZHX4B24Lg0VHO+Sk4K5Hz2a2X9usutYorspl3ik5lEYq2JA7SSmlKeAOktmjfmqRX3mLel
         ItMvs5FOhI6DSEFhuyEaFTUktffXN9vQF+5H+60ysa80cPSET4mvt5p7hYn0F2/ege40RQ2O6/El
         gMdowXt24AczipQDCxEzi1oWd8HljZhO5z/HsCsw8HXzFfCrPGekcEx72HN5iWAtp84whzeAk7e6
         AIRsXL59oJnm/MVvDHzG33u0bOfVxVHIElctsDoJ5mRDBLdXC/yDCwweZtuYQz266xu9eKDWj/iv
         Dl6usD7l2scg5k56+5qNNzu0ERQX9xcn6dU4n2oSFB5F4upAW7YVWqECIOzqxa8MwG6uZU4TvXTA
         1zMRrZ6ws3cvtNNxKvng==
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2 2/3] staging: rtl8712: change the type of _r8712_init_recv_priv()
Date:   Tue,  5 Apr 2022 10:28:18 +0800
X-OQ-MSGID: <20220405022818.10970-1-xkernel.wang@foxmail.com>
In-Reply-To: <tencent_FCEE3D8703C56F78B552FEFF070817736606@qq.com>
References: <tencent_FCEE3D8703C56F78B552FEFF070817736606@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

There is a memory allocation in _r8712_init_recv_priv(). Since the
original type of this function is void, now it is changed to int to
make the error of allocation failures propagate to its caller easily.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 remove kmemleak_not_leak().
 drivers/staging/rtl8712/recv_osdep.h   | 2 +-
 drivers/staging/rtl8712/rtl871x_recv.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/recv_osdep.h b/drivers/staging/rtl8712/recv_osdep.h
index d8c1fa7..f5b97c5 100644
--- a/drivers/staging/rtl8712/recv_osdep.h
+++ b/drivers/staging/rtl8712/recv_osdep.h
@@ -18,7 +18,7 @@
 #include "drv_types.h"
 #include <linux/skbuff.h>
 
-void _r8712_init_recv_priv(struct recv_priv *precvpriv,
+int _r8712_init_recv_priv(struct recv_priv *precvpriv,
 			   struct _adapter *padapter);
 void _r8712_free_recv_priv(struct recv_priv *precvpriv);
 void r8712_recv_entry(union recv_frame *precv_frame);
diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index c23f6b3..3464ee2 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -44,7 +44,7 @@ void _r8712_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
 	_init_queue(&psta_recvpriv->defrag_q);
 }
 
-void _r8712_init_recv_priv(struct recv_priv *precvpriv,
+int _r8712_init_recv_priv(struct recv_priv *precvpriv,
 			   struct _adapter *padapter)
 {
 	sint i;
@@ -60,8 +60,7 @@ void _r8712_init_recv_priv(struct recv_priv *precvpriv,
 				sizeof(union recv_frame) + RXFRAME_ALIGN_SZ,
 				GFP_ATOMIC);
 	if (!precvpriv->pallocated_frame_buf)
-		return;
-	kmemleak_not_leak(precvpriv->pallocated_frame_buf);
+		return -ENOMEM;
 	precvpriv->precv_frame_buf = precvpriv->pallocated_frame_buf +
 				    RXFRAME_ALIGN_SZ -
 				    ((addr_t)(precvpriv->pallocated_frame_buf) &
@@ -77,6 +76,7 @@ void _r8712_init_recv_priv(struct recv_priv *precvpriv,
 	}
 	precvpriv->rx_pending_cnt = 1;
 	r8712_init_recv_priv(precvpriv, padapter);
+	return 0;
 }
 
 void _r8712_free_recv_priv(struct recv_priv *precvpriv)
-- 
