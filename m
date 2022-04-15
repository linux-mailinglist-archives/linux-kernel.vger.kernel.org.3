Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB155502973
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353140AbiDOMNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353114AbiDOMNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:13:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EDDBF025
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:10:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g20so9709333edw.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BF4TCbU6C9xeKRNJJ36SItYcPCun9OHmo5cQ4fb+y9k=;
        b=qjo3DLwg9IXADd5tJrJKtAAdwCMePL5P9soz7DcU1LjaRpFAPwzuc5TpKRkNV21G0F
         0o5SDEmEoL5TTyybVcnMNdCDaYU1wOamNsgmVDeQe2xJ25CLRmscVqizRHa2quGkAqjz
         Mhww8Vr9mbW1R9d9404wXEfaOw+jbDf6ucYc8RCLrkCC4LKo/hcD8Z6IEc0ho3uKOjLN
         xshmY9dTw9We1NCex4sSDpSHb6+2Op0ECQhCg3FbT5OtZl5B5PQHAa5Bm0UA0nkJnHim
         0Dora0lvDuHJ6PXx0LfS8S452/MinMHBx/5ykoclCiM4UB99S5Kpzl/q6R3gIqJEC4xU
         N59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BF4TCbU6C9xeKRNJJ36SItYcPCun9OHmo5cQ4fb+y9k=;
        b=bhB4C2iD0uCMHiVKoIXoLfQrQui6MjbYfREnbsyDJqqmHGMGUeM06pzkh1Mk6WTaAN
         S0sXu3UOxodVvsRbLhQd4hxCir5LBmzOQndyaacjLJFgEvfU+5Uqofk81k3VZmeRgN4G
         7HNjrfbLlDbpUDn09PFJedw0P5rPsU+uC4AHU9noYztv44PnClhpNbZaErzzGjXht6K6
         Nb+1jFSpQ9o1nucpt/Nd/sAct+5NhU/aU0QLAR1OF2u9MqasgXNcVrX6gp1EocnfOZ/9
         4B9n59C1mo3Y0mk0ThC1BsoyZbDsTuct4uTxb8FjbZaW+Sxjfy+G8VIszq5sp7da4RRd
         NQaA==
X-Gm-Message-State: AOAM531Js+5EXp/9jmFgB/ljAd7lnSJAaoa9rC7O2WSUM5SReae7bpeK
        ZS7oXyY/tLhy0xe7zt2eo24=
X-Google-Smtp-Source: ABdhPJyTK4fb4HivgjaWIOeg0Bxb+kDmDFFgJKXoXKFGvf1eYxH9vLx3g9pz8JRMRMFoQZbdtgPUnQ==
X-Received: by 2002:a05:6402:26c7:b0:41b:7aef:bdf6 with SMTP id x7-20020a05640226c700b0041b7aefbdf6mr8074085edd.210.1650024636413;
        Fri, 15 Apr 2022 05:10:36 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id z22-20020a1709063ad600b006e8867caa5dsm1626114ejd.72.2022.04.15.05.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:10:36 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 2/8] staging: r8188eu: convert u32 fields of rt_firmware_hdr to __le32
Date:   Fri, 15 Apr 2022 14:10:17 +0200
Message-Id: <20220415121023.11564-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415121023.11564-1-straube.linux@gmail.com>
References: <20220415121023.11564-1-straube.linux@gmail.com>
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

Convert the u32 fields of struct rt_firmware_hdr to __le32 for
consistency.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v3:
- this patch was part of patch 1/8 in v2

 drivers/staging/r8188eu/core/rtw_fw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index eb4ab11f6b28..7cd08268f3b9 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -42,11 +42,11 @@ struct rt_firmware_hdr {
 
 	/*  LONG WORD 2 ---- */
 	__le32		SvnIdx;	/*  The SVN entry index */
-	u32		Rsvd3;
+	__le32		Rsvd3;
 
 	/*  LONG WORD 3 ---- */
-	u32		Rsvd4;
-	u32		Rsvd5;
+	__le32		Rsvd4;
+	__le32		Rsvd5;
 };
 
 static void fw_download_enable(struct adapter *padapter, bool enable)
-- 
2.35.1

