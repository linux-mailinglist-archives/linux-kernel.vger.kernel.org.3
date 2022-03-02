Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007844CB03E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244662AbiCBUt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244975AbiCBUti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:49:38 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB6BDD94B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:41 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id i1so2631692plr.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPdZrUH5dC0tchGf5qzbOv7p7DaHnxymvDfUAfQt99o=;
        b=AssglXsU9fXqZvcQQMStPSUTOqnOLUBfpeChIVkRC8RJ04DfEN1n4ffaZxZDXr/JqA
         FKhbYNI+qetaonyUNozQ+w7hZ/3WoB4eB5x/iQkQtXH7WFEnbcy9drt6e7p4O52gby+w
         xenmmadIDhsIdObouASmKIRDLJc8+B4tiSkb9aFD4g107xbfIZvSc36PqFwAxYl4EfAV
         21aWQbMLpDxXCJFb/wVVZxdNdjfd/a/EWc81aGQXdw8tmtanEQ/jX5Bff655thN1z+0+
         C26cZMKevoRieTHgLMQy3p1jW8Rt7o0rLTx23WTRDSzjo/bHDcjpZ93lYX8cvflgbVLl
         MfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPdZrUH5dC0tchGf5qzbOv7p7DaHnxymvDfUAfQt99o=;
        b=z0+Vn5/PH4MRLxIRQ97ACu77dHDEuRcm678fHp38/VeQgpWZ8SJSRpk2rIVJfLY2ee
         2hBnbawi/j7tvOwf/Dgmbq55tO3KOR2HbERPXtu+jtiSQldfnr50mymfT93mlp2wrSvm
         wXZ3ldfUucAAGduxqznYSQgytN5wf7PR45/BiC3l9akZBloA5sKxgMnHk8STi+imyLZT
         cR33W+juCEqef/b3jqpGUhzj1izJnRXwsx1koNQ+JcNI+M1SQ5tRWrOzwEYjKrc30+mX
         6EXhvRN2ZmcBOcnuODdpnrLgExnubtPaZe9xglLNSqyLqiyw5vqxTbgt+OPNwnk0sSqo
         1amg==
X-Gm-Message-State: AOAM532XhUMbrBiD3oEq713Omz1E20vMY3agjC1vkLcqiUIy3w+gXYm8
        R3l2UWwl12Jy0DCpRXpluBWSIm4QKYoUNg==
X-Google-Smtp-Source: ABdhPJxV4TiR8bEBi8TABZ3dwLLR8EJMJMQJ+fYe8mWXWi1F+cdmXEicbSFUJE6Nnf+gUdc3vLp4pg==
X-Received: by 2002:a17:902:d4c6:b0:150:15ed:3cd9 with SMTP id o6-20020a170902d4c600b0015015ed3cd9mr31948269plg.2.1646254120907;
        Wed, 02 Mar 2022 12:48:40 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:40 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 12/16] staging: r8188eu: mark rtl8188eu_xmitframe_complete as bool
Date:   Thu,  3 Mar 2022 02:17:33 +0530
Message-Id: <20220302204737.49056-13-makvihas@gmail.com>
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

Mark rtl8188eu_xmitframe_complete as bool as it returns true/false.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c    | 2 +-
 drivers/staging/r8188eu/include/rtl8188e_xmit.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 69b66eb45..55032d7ae 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -376,7 +376,7 @@ static u32 xmitframe_need_length(struct xmit_frame *pxmitframe)
 	return len;
 }
 
-s32 rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
+bool rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 {
 	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapt);
 	struct xmit_frame *pxmitframe = NULL;
diff --git a/drivers/staging/r8188eu/include/rtl8188e_xmit.h b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
index 85eb0aad8..8adb672f7 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_xmit.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
@@ -143,7 +143,7 @@ s32 rtl8188eu_mgnt_xmit(struct adapter *padapter, struct xmit_frame *frame);
 s32 rtl8188eu_xmit_buf_handler(struct adapter *padapter);
 #define hal_xmit_handler rtl8188eu_xmit_buf_handler
 void rtl8188eu_xmit_tasklet(unsigned long priv);
-s32 rtl8188eu_xmitframe_complete(struct adapter *padapter,
+bool rtl8188eu_xmitframe_complete(struct adapter *padapter,
 				 struct xmit_priv *pxmitpriv,
 				 struct xmit_buf *pxmitbuf);
 
-- 
2.30.2

