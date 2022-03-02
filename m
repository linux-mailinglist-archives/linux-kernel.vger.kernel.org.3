Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF54CB044
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244686AbiCBUuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245009AbiCBUtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:49:41 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E9CDE2C5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:47 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so485574pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=diwGqdVYQiz2F+5ByyijR4Y4A/4HzWpPakvUGGYkewA=;
        b=Ol9rwv0pFTOMtN0ZbFoiXm/Uqcz7nNVd81xvC5yl6AnhXJkGwxP+S2feHz4Z6C5I6Q
         5E5ZqsxbFK2+a7tSj4qhk1uvXgVeLJ9PVC/FwhwAwlRR4R/Ngr2VfLaRMqiFxUojBiYs
         cIOF53APdW2D7rLYlTJvCZ8+DvD7Qjc4wtA8myYfHFwhE3u9/DQO61XqDMSSFRGw9Y9l
         zVjTI7qRNCuF83S/IOg2WN/Bn8XXVKGPPKlyoIEEXVbj/JCQ6JscLyG2d3MlW+ZOKUzg
         mIo7cEXZrvn2SQ25zpEvLyXjdS8dHOpI71g0tUGTUVJIjmbOqfAxIgnY4YGOAIILlLtK
         mcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=diwGqdVYQiz2F+5ByyijR4Y4A/4HzWpPakvUGGYkewA=;
        b=Qf3YX+BnGrZCKgk7CH9BC2kg061NHGQ4CVivWjiNNBifdpbchfCpEeD0/CHtFY+F8L
         uahQgQZc1RIk9SIWFGEXYdN8AR8bPqJTCZDozKJ9QkcD8sgw0yNJmQ0h6cqdMURoMJzn
         GiHFhVpH0QnRZILei9z8ai6p2Has4xd7LIoo+keknWnHfHx3WUDR7IeX6Zs16FDOFfw/
         LTAH2aOHQZhntId7OwIbC1Sg2YcB07e74AtLG3qeucQKBUD+5wPStEKoaUIhal9Sjn5q
         O6XfkhyXDsJ7YgjHw8gLMvIHFhHBR66S7AQskfufgOGE3D5MmlLsPcwc2kqOMhylJxdN
         fxsQ==
X-Gm-Message-State: AOAM531vVVicyH289N+oU2MDwo/e4lHlBoQDAUQgK/DcbNw7h4Y1gn6g
        cvbtLYcTxR+HCQHHQJso/lg=
X-Google-Smtp-Source: ABdhPJzoTyHXNLjd+giSdub8RkYLX1CzD8/sMLQMiWwmnrlqJDnJLYHQW9DV7h8RIlAJGG/7CStDXg==
X-Received: by 2002:a17:90a:4f0f:b0:1bc:54b8:c3 with SMTP id p15-20020a17090a4f0f00b001bc54b800c3mr1686937pjh.110.1646254127171;
        Wed, 02 Mar 2022 12:48:47 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:46 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 14/16] staging: r8188eu: mark IS_MCAST as bool
Date:   Thu,  3 Mar 2022 02:17:35 +0530
Message-Id: <20220302204737.49056-15-makvihas@gmail.com>
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

Mark IS_MCAST as bool as it returns true/false.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 39b7a596e..df3331b13 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -295,7 +295,7 @@ enum WIFI_REG_DOMAIN {
 
 #define GetAddr4Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
 
-static inline int IS_MCAST(unsigned char *da)
+static inline bool IS_MCAST(unsigned char *da)
 {
 	if ((*da) & 0x01)
 		return true;
-- 
2.30.2

