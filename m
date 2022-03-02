Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D70A4CB037
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiCBUt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244522AbiCBUtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:49:04 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52438C3C2C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:19 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so2763274pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/diaxepVKqVQthgHB5ZLX1zYhY6vcKwtc5iIGOs+iuI=;
        b=A1Yjo71UWe6hgMcsjR1IWM8cQzcCoNwnu9VyLeQfWccND1GYPHMr1BLDSI/IRqRAGQ
         U8ZLhb+5Od8F9sMchKYbf3aSZwWZRdziYGSwj9mXhA3gKez76HoFixasTJZVfMxXZH/Q
         bPHBa4YoRvMOQ/KaNBRB7rVk+mS0EBLg+K77qz4TXgOUNlHiQGkbUlVQj4X1YLtyvIWm
         1Z8JU3xAyiQmmJ9H1Eb+2TQXlzFygu0Q3QJyBktA7M/XL8rCzA7bSYgdoG9eLgxXOKKR
         PckgyFRHWKpmLuK9CbmrIaMcRFioOBexKYHfUcAJFyA2joghqk07g/ldKCBd0eCc/+qY
         /XEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/diaxepVKqVQthgHB5ZLX1zYhY6vcKwtc5iIGOs+iuI=;
        b=3u9HV2i9U2JurI0nqgT02J42zEsXeEgQesiBimR46GPssLndHyl/2rxxr8EVU/kyPN
         0AldAw8bsSzVj5hKjzqwfMkP2rqkGcx2MkVqV6FSZt/UzVM9U6fwieX8cpwVDAh5BlQ1
         rOlj5+4JQMs00cAVv3QEtv4a2GGCaQeWsEjDKt9QEjRJuT1eD419N0yOPAxCuq5gg9Vn
         cZt+BX2G6BWSbxeBMMu6ZozY2kSqWAgqDi4uxfGnbmZzloENUlYXBMk1IMqDfDwM26Ew
         4OsHCyYHJAeVYy/PjJg0liUgvffJHyZHc8g+uBm0pSuv1TtWShEgzI+amy/woQn9q5zU
         KC9g==
X-Gm-Message-State: AOAM531MYbQaYxZ6p/KpsBDgDC0rSBHUNgmoPJqNOcLU0st0pXkHFu9d
        9iGqErriG1cM9nKAhiT8E5o=
X-Google-Smtp-Source: ABdhPJyi78ocWvndFMAaXGfhKdoPgJOWrt/C4izHFWGzfu72ny+IMV83ShOjCTfF5iEdZx2eqoRxHg==
X-Received: by 2002:a17:90a:b00d:b0:1bc:5d68:e7a8 with SMTP id x13-20020a17090ab00d00b001bc5d68e7a8mr1657182pjq.59.1646254098817;
        Wed, 02 Mar 2022 12:48:18 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:18 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 05/16] staging: r8188eu: mark check_indicate_seq as bool
Date:   Thu,  3 Mar 2022 02:17:26 +0530
Message-Id: <20220302204737.49056-6-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220302204737.49056-1-makvihas@gmail.com>
References: <20220302204737.49056-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark check_indicate_seq as bool as it returns true/false.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index d77d98351..402b58a02 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1466,7 +1466,7 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 	return ret;
 }
 
-static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_num)
+static bool check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_num)
 {
 	u8	wsize = preorder_ctrl->wsize_b;
 	u16	wend = (preorder_ctrl->indicate_seq + wsize - 1) & 0xFFF;/*  4096; */
-- 
2.30.2

