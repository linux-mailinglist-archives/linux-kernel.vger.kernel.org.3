Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9E64FA998
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 18:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbiDIQfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 12:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241904AbiDIQej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 12:34:39 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB25223F3B7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 09:32:30 -0700 (PDT)
Received: from ipservice-092-217-091-111.092.217.pools.vodafone-ip.de ([92.217.91.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ndE0g-0006Rg-RV; Sat, 09 Apr 2022 18:32:26 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 10/10] staging: r8188eu: remove unused timer functions
Date:   Sat,  9 Apr 2022 18:32:12 +0200
Message-Id: <20220409163212.241122-11-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220409163212.241122-1-martin@kaiser.cx>
References: <20220409163212.241122-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_get_passing_time_ms and rtw_systime_to_ms are not used any more.
Remove them.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/osdep_service.h |  3 ---
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 11 -----------
 2 files changed, 14 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 1e55a8008acc..f1a703643e74 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -77,9 +77,6 @@ void *rtw_malloc2d(int h, int w, int size);
 		spin_lock_init(&((q)->lock));			\
 	} while (0)
 
-u32  rtw_systime_to_ms(u32 systime);
-s32  rtw_get_passing_time_ms(u32 start);
-
 void rtw_usleep_os(int us);
 
 static inline unsigned char _cancel_timer_ex(struct timer_list *ptimer)
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 7b177d50eee2..812acd59be79 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -42,17 +42,6 @@ Otherwise, there will be racing condition.
 Caller must check if the list is empty before calling rtw_list_delete
 */
 
-inline u32 rtw_systime_to_ms(u32 systime)
-{
-	return systime * 1000 / HZ;
-}
-
-/*  the input parameter start use the same unit as jiffies */
-inline s32 rtw_get_passing_time_ms(u32 start)
-{
-	return rtw_systime_to_ms(jiffies - start);
-}
-
 void rtw_usleep_os(int us)
 {
 	if (1 < (us / 1000))
-- 
2.30.2

