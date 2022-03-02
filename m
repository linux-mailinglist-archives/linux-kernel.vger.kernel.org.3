Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2894CB03B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244484AbiCBUtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244708AbiCBUtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:49:21 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19912DBD31
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:25 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id n15so2621515plf.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47enilufvb5BapansswjqF7Mys+r/uaDJhXNYG8WXSg=;
        b=XHOG96zu7g7EYkpVVmPw79Ey0bGouFPE6g2Hu6dof/IEIpXZy9wZMQZ41LjTzgoXmK
         yOvd2nsz9xRGFBF6yCyRWelXRaf6j0cq5cqh8vnGWI5EV/9h6YI7A6Lr/tZ4122I4jO6
         AquLeUk3Qtn3tdhARUtmTZq9cSdFmzOCwC4SPrnrLHOyXHndpci49F2yb5s9qJC/JP1Z
         w7UPO3wKmK+yQnn4aEtDn4SxMdrxsvU6q/AyJCtQz+UkMrTAy1iAFUpRt/+ME4+4TKXk
         TZr9xtUlRFY/DSA0xjvvEQ9ntd1ssP0+gXOPG9oNeu1H35O6wsovPUisgvajJlP1LoEZ
         z8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47enilufvb5BapansswjqF7Mys+r/uaDJhXNYG8WXSg=;
        b=giPQfk1ftT/CsJKDwVjg/t60PZTSpOCnEDaXkRz2Lv0Enxs71W/jK1s9qWnnLRG8wM
         m7UAaqsVInaLPumlG99QaO7JoeNAHCoWC8jrFZA6SvEEe1MuJsg4CNGZ8j/qJ0ai0h/9
         Z1xbGNqNrdtuWdxVk8SRCpscILN5MUwHqYDP1li2h3XSvZboQFwerteUJHygpuogFOAC
         Pk5ghLbu58im93XTT2KFonJI26aR38Qvn7aZ8T5OFYR7i/lKuhWeryfUwSSBTXuh8r7x
         DfqnW+eX9vlqGoPdJl7ikQ20YRqspeYZe213XSlTXFVneSxXChtz4YznQvf36W+AWxKI
         b/3A==
X-Gm-Message-State: AOAM533iE+/7oIqW/oTBtjkTtWdODQsc8nJ4PhUuC0f60oFG2ofUkdqw
        OK1iTQZ7Rx5/9oBbmZuzWUE=
X-Google-Smtp-Source: ABdhPJxPbzO7jugROjTOhIAlRLlpI1xSn+laZgNFggGEHyCAuiLE6/hCUJgqp+4OXDkA7Vx3rB1CXA==
X-Received: by 2002:a17:903:110c:b0:14d:8859:5c8 with SMTP id n12-20020a170903110c00b0014d885905c8mr32843238plh.156.1646254105346;
        Wed, 02 Mar 2022 12:48:25 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:24 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 07/16] staging: r8188eu: mark recv_indicatepkts_in_order as bool
Date:   Thu,  3 Mar 2022 02:17:28 +0530
Message-Id: <20220302204737.49056-8-makvihas@gmail.com>
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

Mark recv_indicatepkts_in_order as bool as it returns true/false.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 81ff22d0e..b6ab2db6d 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1525,7 +1525,7 @@ static bool enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl, s
 	return true;
 }
 
-static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reorder_ctrl *preorder_ctrl, int bforced)
+static bool recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reorder_ctrl *preorder_ctrl, int bforced)
 {
 	struct list_head *phead, *plist;
 	struct recv_frame *prframe;
-- 
2.30.2

