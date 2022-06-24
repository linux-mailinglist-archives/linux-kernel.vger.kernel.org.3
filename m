Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EB6559CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiFXOwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbiFXOve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:51:34 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E522848BC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:46:06 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 65so2727552pfw.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P2/ZUB7oMjRi4mWz7GISV//OG0C6Rw4pa93uJjRJoLE=;
        b=cv9VFUtYV8T4e+mp175bx7Pp36y3ZFRfAd9NS/h93UDVgSqUgMkoL4ciTDunw+KHf2
         OM9zvPx5Vc7iNh/YsP9smHPncTfprachdijQaqcgjksFYdhZlMOSPiecL/cIAlkn2b4n
         2uMOpEsQpEoPAfcYDPoLc6MB8LVMjrbMxwA6NqiCiaj6jCCFAc55mgXyT8Fmr3asI6Xr
         aGCVquLmSOkdGucSO8WE3/WH4uIV4kj1+iBDRYEaGDK9qeSGj594CUXo6t1oPVunpDc3
         EpihAHwmyn6W81eFQIzOq7YxdItnsmBDCGy/xSdNxtzvaNhHhoQ92+bdF4Ls3mkqMy15
         WJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P2/ZUB7oMjRi4mWz7GISV//OG0C6Rw4pa93uJjRJoLE=;
        b=O+7xUL9Fbm5rIGkka5jo9aBuR11XT072Igy/ZTcj+jEqHiBKL0WuVsGouU0OQx75lY
         WqRpM4au45zfCoMHVfRh7Ie2hxb3p1IoVvy4TEtxVVbc04mFCEQ2S7YfeuNdekTiE17v
         N4sIVZv3D6XJhupRt44UVU1yUTG5Zk4qUoXH08Efkbm/JDsokCHBVsw/OqB2Q6WQsGCN
         ys9f8lhMxeh2BLc+RO1swNEGWOXCTS7PrB5hcIeDr7e0fcEzikKc0CK4l8eakm500J+3
         tz9fosND/EDyjK0MSXzmuEDzdGGnDYRC2XbowdEIWPJTQudHFMOvT5vS0u//20bKk/eg
         r2KQ==
X-Gm-Message-State: AJIora+K1HV8tKL9DJPIF/e8gl/kfrUsC3YzRWOLFX+N4v0pFU0QIOoB
        DEALxMP5zRvZQcwokWS7Aii4ckyxg0nKgQ==
X-Google-Smtp-Source: AGRyM1ttyBiwFUVc/hayeCduTn6f5RWPpfxphjBVZoYPLPit1q6tiZ1Utfb86reVfJj8ASQ7rojRFQ==
X-Received: by 2002:a63:7848:0:b0:40c:a54c:f60b with SMTP id t69-20020a637848000000b0040ca54cf60bmr12363315pgc.411.1656081965726;
        Fri, 24 Jun 2022 07:46:05 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090302c700b00168e83eda56sm1928868plk.3.2022.06.24.07.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 07:46:05 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH v4] staging: r8188eu: core/rtw_recv.c: clean up nested if statements
Date:   Fri, 24 Jun 2022 07:45:26 -0700
Message-Id: <20220624144526.437322-1-marcus.yu.56@gmail.com>
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
Changes in v4:
 - Added missing change log and resend

Changes in v3:
 - Modified subject and description to be more descriptive

Changes in v2:
 - Added a pair of parentheses to make operator precedence explicit


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

