Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C214559366
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiFXG2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiFXG2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:28:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706D1E86
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:27:53 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id m2so1289450plx.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=souzsk9ifgaOyhU9GyyRqJqftjYrRuWLP0PcFjYsfu8=;
        b=KyEw12z175h99BsAPf+680LU1Vw0hBAVoNyKMZ4NUwuf+4nIXSThxl/0N55GHg2y8o
         8kqU6KP7vF31ek/SIIZRj9KSjD/p1SdUc5XKkR96tv+Y9Qg01Sx3YAlD72NtYheZP38s
         oZp2QBfDJMcfcinxmS0Z7OwvrTrjkH7/MPN3Y4c3pousqF3/jt3oleM2Hld5QUgs/8lD
         kAsyOSG2uPj2YKcNzqWtciHRUKouUkgILH84cBIwuJJYfvQU/Ba9tM1uPcXErka4hru0
         T41gFV8rGj2MDjE7p3GKz0jeG91od8JHErxUiac3XQgmIG9xTto7syEnX6HeFVDoHsjY
         md8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=souzsk9ifgaOyhU9GyyRqJqftjYrRuWLP0PcFjYsfu8=;
        b=48lpVyi4+Q68xF7CbROwvj1oZgkWXsvzAEA2/OP+17v6WUIDh4e3inoq9UovJmkkie
         uSr7VqTVooxihS4L6iE026uHnTvvx8YHM0snd93NpOE0fDZSblb8x3fbSfGUW7qdxDi9
         Kl2yRSSZOFVIajuTjXEKfj/FSZksB+wYcRqrQzeSnCKlSvfkq+TwZvbplj8utNgrF9dn
         7Y3xrKKrDf5FNOOQKyCzQaVhU0X+0/VEQH5UIqLIVn8WqgMVtYzRCrSP23GmW/0EgOji
         /SXR29ibhh7Js+ePspEUUni/QwgwN5iwVDCpixxOrOJLkuhNajgjHmbQ2U8K0vi0Z/cA
         PgNw==
X-Gm-Message-State: AJIora+OLiMb4LD/d3VkiDUfmJPVleAqdtSmLZ77TQW1tXWuTc5GyjUf
        kgfsjCq5u1VHwuYXbfRV/w4=
X-Google-Smtp-Source: AGRyM1vFrewjQ48AKeMSGqOtzS022Czh3FVGN2IYms/9D0wWur/GvFJ9xtZEUMTZOtbLzkC9uhM7SA==
X-Received: by 2002:a17:902:e5d0:b0:16a:6f96:ec5 with SMTP id u16-20020a170902e5d000b0016a6f960ec5mr109836plf.72.1656052072909;
        Thu, 23 Jun 2022 23:27:52 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id n22-20020a17090a161600b001ecd48b80a2sm3118421pja.5.2022.06.23.23.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 23:27:52 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH v3] staging: r8188eu: core/rtw_recv.c: clean up nested if statements
Date:   Thu, 23 Jun 2022 23:27:05 -0700
Message-Id: <20220624062705.436690-1-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623031515.402691-1-marcus.yu.56@gmail.com>
References: 
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

Combine two nested if statements into a single one to fix indentation
issue and improve readability, as suggested by checkpatch.pl

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 6564e82ddd66..020bc212532f 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -166,10 +166,8 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
 
 	list_add_tail(&precvframe->list, get_list_head(pfree_recv_queue));
 
-	if (padapter) {
-		if (pfree_recv_queue == &precvpriv->free_recv_queue)
-				precvpriv->free_recvframe_cnt++;
-	}
+	if (padapter && (pfree_recv_queue == &precvpriv->free_recv_queue))
+		precvpriv->free_recvframe_cnt++;
 
 	spin_unlock_bh(&pfree_recv_queue->lock);
 
-- 
2.36.1

