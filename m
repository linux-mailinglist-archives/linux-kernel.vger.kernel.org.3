Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E5D5571DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiFWEnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiFWDPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:15:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1709B344C5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:15:35 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so1288019pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5bbDJzaPEeyqFN7WwD+EORQ7ilgccQy1ek7UFlep3No=;
        b=X5sqadBIfeoEVVqfCQqIihmyJ/vNxor6/7OLtJXs2ojCze2fPOZSGzn9+U46DpQVNz
         zavmEZn/EKQIYUU8Jh7go63SfAzPN3ST9Ug8kFR9QUb7a9FMQyBAdOSL2k0Fs6Dxq/d/
         SMsKZwCZLZblNzbXasWWin1+T/2DuVY7oXOPYhfBaY666vERTeiXdAwakZDqTCXe+Zpb
         SE6hSJzM1gwCNC833ipQNwtkM0w9waPIXQpmkK9ysfpl0Cct0/0nRrP559XKURs/MhRg
         4rZPkz259IpOxNMZBMC6ZGry5lc+jXn1xKtux2pLUJLf6MaBCFGCZxlkclU73D0LKgnT
         d7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5bbDJzaPEeyqFN7WwD+EORQ7ilgccQy1ek7UFlep3No=;
        b=kzP9dKCMNTx7GlS0L1388OR2CYGxL7BP0EO9DG21PFDJl7WnFSuFUKzRSwlXa1u8Zi
         qAFw+3nwsuHNAz1ePAiHvoRWZhDQd0UxYCp0+DmGqm7IIS0M8FOCJ5K+ThaIneFnoz1R
         +rm74gtqFuWS9bEUTph5xcK1PeN2r4yGkrDqQbzF5JbNfQB/pzbNwd4yCxiHxFy9vRNe
         5pgLmz4iaDvdgvGPwVJJzXE+jJrVwUbkI6kPOvHeNG8H0artRTFU4ChBnOX74NnMQ0Nq
         OxYMPEoXu8zmSWfSVeNj+XoBQx2XwIBaqqVtiF2ZtviS32jIvhEW+UQm/d4vSRll7cmH
         OrZQ==
X-Gm-Message-State: AJIora/T8RSKOc3EzVZgxcBMSo77q1LPtHgk8Jmgkv9q7CpZVh9GDNIU
        6AQYlsaSIGU6v3u5MU9+kJC/KUdPgmlZIQ==
X-Google-Smtp-Source: AGRyM1t0HBVkrwZfOWux9s4jXHJ/Rbgt0brzGNBEeAIi0/0tjlE84bnQrXSt6fJQdOz/dL6F1PnofQ==
X-Received: by 2002:a17:902:db10:b0:168:f71a:2fcb with SMTP id m16-20020a170902db1000b00168f71a2fcbmr36910923plx.165.1655954134610;
        Wed, 22 Jun 2022 20:15:34 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id v16-20020aa78090000000b0051bd9981ccbsm14234328pff.39.2022.06.22.20.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 20:15:34 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH] staging: r8188eu: combine nested if statements into one
Date:   Wed, 22 Jun 2022 20:15:15 -0700
Message-Id: <20220623031515.402691-1-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine two nested if statements into a single one

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 599d3e55be76..c7564af39023 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -166,10 +166,8 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
 
 	list_add_tail(&precvframe->list, get_list_head(pfree_recv_queue));
 
-	if (padapter) {
-		if (pfree_recv_queue == &precvpriv->free_recv_queue)
-				precvpriv->free_recvframe_cnt++;
-	}
+	if (padapter && pfree_recv_queue == &precvpriv->free_recv_queue)
+		precvpriv->free_recvframe_cnt++;
 
 	spin_unlock_bh(&pfree_recv_queue->lock);
 
-- 
2.36.1

