Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E1B4CB03C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244743AbiCBUtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244658AbiCBUtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:49:09 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0304DBD13
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:22 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id e15so1383084pfv.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V0ZCMWePvJWkfOaUYdtCCn0PNNFVE21F+X8kdTmqORE=;
        b=pzsp+pBzqQL+0QvCtG8ypnkN/n0BNwjPIriFBCtZAHJmLPfg3upixN4PFYXQeaWaxV
         G4UuVsJa0ppmHRlYLUmBEqOShDo3FiHLjF9yMMibMzphTcC+iPcGXZD77EimH7+zJeH8
         HiK/WBC/DtZJ1zan6ABbn8rI105DIrFET98//kYnYtgh6a77/ZZTcpELL3q1/era3Hcr
         MgeFM5E4aVHE8ApW3Z0lCZiRXiDM21B/PhiT9W1fGfL1xBn69PGTX+vqOMeA3lM/CM/j
         x9Sa9UonZIqrdLnkZeCbza2jNexkmP/tEkAdrUEg0GTr0TL066EctYwZuHPrL41wFS3K
         mOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0ZCMWePvJWkfOaUYdtCCn0PNNFVE21F+X8kdTmqORE=;
        b=6cM0OkS2HQ//IXvQ6j5Tn/SgaE70Mk2phoL4vftIp0X61VLh8Grtv0cZp2YqLlOBqE
         V4XBS8M/Lz4I79zHkHoWbjLI0weMP1gTbXdlB+yoTNiBXN/56fxU7Of+dRe+UPFP/pyo
         +6EtGGBZmtjamjSs/gEaXVU2UX20ChOKwxJILlx+oEX2iZCQGZZg3aCuOKfqqd0JdMK1
         m+QxDDo9IJ87e1hXoEntlYHhRldfhg/qhwfsXnCAnt938YWf8BidEzXjTdP8C1w7sgg8
         qNoj+FIlbGSX9VEcbz66gAewSnXPEraFd5VCMckp/JUv+XsYasAoytOAYK7SdPQzR5kG
         8Vog==
X-Gm-Message-State: AOAM530Zkcrjpj28/4e5WU+I6hgIlXTOlaP8X3iCPeJVTu2icQDrINC6
        xxMBvVl2NyAcxeszCBS8F44=
X-Google-Smtp-Source: ABdhPJweatSHsVHPJW9ClTDZdjweAKbKiBQafT6qQMNuAHR5zJPzuPIpy/HlwmfrAK0E3TlvXWyl7Q==
X-Received: by 2002:a05:6a00:2348:b0:4f3:bfcd:8365 with SMTP id j8-20020a056a00234800b004f3bfcd8365mr34678709pfj.38.1646254101986;
        Wed, 02 Mar 2022 12:48:21 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:21 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 06/16] staging: r8188eu: mark enqueue_reorder_recvframe as bool
Date:   Thu,  3 Mar 2022 02:17:27 +0530
Message-Id: <20220302204737.49056-7-makvihas@gmail.com>
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

Mark enqueue_reorder_recvframe as bool as it returns true/false.
Also, make it static as it's only used in rtw_recv.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 402b58a02..81ff22d0e 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1496,8 +1496,7 @@ static bool check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_
 	return true;
 }
 
-int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl, struct recv_frame *prframe);
-int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl, struct recv_frame *prframe)
+static bool enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl, struct recv_frame *prframe)
 {
 	struct rx_pkt_attrib *pattrib = &prframe->attrib;
 	struct __queue *ppending_recvframe_queue = &preorder_ctrl->pending_recvframe_queue;
-- 
2.30.2

