Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1A34A6F74
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbiBBLD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343698AbiBBLDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:03:49 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F172C06173D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:03:49 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x23so39972021lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPBQi8ycxhPpw53EXEIDBSTw4oWSjfC+savcVruO6uA=;
        b=WwJEQWCdRXYwuNZHU31R7DkmCRUmetwI212MToybeZfZl73Z2bgI61i/prVZBsmiMv
         xLpe0VeJ9vRbMAGPPCvd7iBO334mUeCA6rfmbR/nU60j0PVn7zIR59eNG5ynX2BmxDL3
         nJ4lVVET9OgPdIh2k19zLRytNiCzdIYBaIkZuyY8PxEWdcU4JsNh0wfhBW399E0RYxQ+
         A68Q2zug2k05hy4980Dqwd6WdkNGDse4KSnPgnw8GBZ97EuKD19OrmEu1j7CyT48xpMd
         0pbitjUTNkkZLCDDmGU1pMcNUR6EeKIXq6dZE/XAP424Uies6IKpxL+3LAf/LDrHRf9z
         9qHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPBQi8ycxhPpw53EXEIDBSTw4oWSjfC+savcVruO6uA=;
        b=C0c7VgrQq9fH/HyJX/C9zvIACPWIHZ6Xftd8MWAybNqJ1dRGEgPPQYUEoJ330BmuaC
         47199dZbj2CP1howRat+itJPGq/GW53y+zzW4EdxfWZ0Q+nX2Fv24BISqFbBkQo9XgGu
         xuDbTz1SZAeEBl4pEas3wnnYTDMGHUFGcevvRKTkqyYvouj4NEWpP+VwJxPMmFXM/yEL
         DYomb+cZy9djcmkSvvGAffZ7FpBZIoVst6oiVQHIER1mkOeLYllljC7ie/hHspCfVyYl
         x/Jmov7ZBl4oJyUkgYPPX5Wl7J6sfO/mVSdAla/9UBwnKrs9STzZecj3RISBZTa7uVMd
         ceNQ==
X-Gm-Message-State: AOAM5319ennB+/3Il/opc1rRudiC7zMy+hC1C1r2UoeXI5ygDtCfO93I
        CjtjEi8VD2vT2njygvB8fFs=
X-Google-Smtp-Source: ABdhPJzcHdDlLm5cSeqsRu39mdUwsKjFNhyPaj1lsd6ekCzFFQSkkTiYv1Rsuj484bEvkf4aF7RqCw==
X-Received: by 2002:a05:6512:32cd:: with SMTP id f13mr22538137lfg.306.1643799827782;
        Wed, 02 Feb 2022 03:03:47 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:03:47 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 02/16] tools/include: Add phys_addr_t to types.h
Date:   Wed,  2 Feb 2022 12:03:01 +0100
Message-Id: <f0b42be7d1fe2eb9cd299532676d9df2df9ef089.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update types.h file to include phys_addr_t typedef so it can
be used in testing.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/include/linux/types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index 6e14a533ab4e..35cedaf191e8 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -64,6 +64,12 @@ typedef __u64 __bitwise __be64;
 typedef __u16 __bitwise __sum16;
 typedef __u32 __bitwise __wsum;
 
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+typedef u64 phys_addr_t;
+#else
+typedef u32 phys_addr_t;
+#endif
+
 typedef struct {
 	int counter;
 } atomic_t;
-- 
2.30.2

