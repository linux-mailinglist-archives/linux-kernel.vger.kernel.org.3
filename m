Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2320946F25C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbhLIRqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbhLIRqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:46:22 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C89BC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:42:48 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p18so4817641wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wjw4Bu6EUjU1zpP9ya6xH5mcDbGLO4ixoCn1PhNZcXA=;
        b=aQ3ZrBxOuAstSouXBg7DysY10rC4gZRBE0cYMSZx7+WW+tddp5jQl6DBLFbZZBDuYl
         XvqHJBT4XiCnkaHUse6P3dqR11DtsIaUAtnrRghhJ/EtthLfyCyOgQASyAyrF1FtMVCj
         qK5pH26+H0uRLu4q/MU6J4bfKDXyVVrAUz7K2wetqNl4QBFFXp81MH+VqWz4m1iGUts3
         bMsdV3pqxUb+o9Ee94FZl1QhV2f6wNUuLG308MFE4t0ynX84OKVJwQe/dTOmVwPsvoxf
         gC0LlvVzUuVYsBiFOWVVhdGyLbzLJJEMvvDb1yRalzmw48QCf8HZvajs3/7W5nKgOZei
         hdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wjw4Bu6EUjU1zpP9ya6xH5mcDbGLO4ixoCn1PhNZcXA=;
        b=grbcrO3+VbV4blCijxzBunEqNLLIH2Lq5Z8i9BT1rmrHTy1CTkdh1Xeo/qG/u5w43+
         06f5nrn2XDAF1HN0yGWtBRj7Zy/xi0l1Sb/ZZjG17f2C2C/dqrPq1XVwoNkOURZOOOkf
         Vy52C18Wf56XR9A0+Mxdt5+S0w2BqDW/ajnF/EGvYl4adB6V8Xcqiy+tZI/jcXZEfMLZ
         LZi+aGKuCe9fSF/bsbmlAkF0k95hWv8ul8XcT6/rk4YTUB55xR96lceku15Bsr8wu0hM
         k1y5pPE4GQx60R3EPFQFZSjq3HLE1/IRW3SjZWTGuL/fq79q4QNyTZTuvqoVjkA2H1F1
         uu8A==
X-Gm-Message-State: AOAM532u0iCNjMK5/qhLYqPxSGoX2bPk29TVjMP0eX3OCNhFz5E8YQEe
        J3lvd90L9aMKCehRoXM3dNFFJQ==
X-Google-Smtp-Source: ABdhPJyO2e4CQiap0raoDwdCwC7i6fEJDq2e5p7jAmd4/BwMz0WvT/WVfSfj4xNqhg8PjZJFVRZxVw==
X-Received: by 2002:a7b:c1d5:: with SMTP id a21mr9133915wmj.14.1639071766812;
        Thu, 09 Dec 2021 09:42:46 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id w4sm308666wrs.88.2021.12.09.09.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:42:46 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] dt-bindings: nvmem: mediatek: add support bits property
Date:   Thu,  9 Dec 2021 17:42:32 +0000
Message-Id: <20211209174235.14049-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211209174235.14049-1-srinivas.kandagatla@linaro.org>
References: <20211209174235.14049-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

Add support bits property, will satisfy more consumers.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
index b6791702bcfc..ec70c5b7a340 100644
--- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
+++ b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
@@ -10,6 +10,7 @@ Required properties:
 	      "mediatek,mt8192-efuse", "mediatek,efuse": for MT8192
 	      "mediatek,mt8516-efuse", "mediatek,efuse": for MT8516
 - reg: Should contain registers location and length
+- bits: contain the bits range by offset and size
 
 = Data cells =
 Are child nodes of MTK-EFUSE, bindings of which as described in
-- 
2.21.0

