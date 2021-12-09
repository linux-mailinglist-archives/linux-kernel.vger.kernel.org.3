Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0A646F25D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbhLIRqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbhLIRqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:46:23 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBF0C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:42:49 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o29so4862151wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XABwerEJ1r58rLpIXIhr+f5x85U3HpOmXlluc99SprI=;
        b=N6XGEcHmTVXm+KH8z8BzeuvaTjsIL2caxR1L2sER8pOOj2g01gG8ZoAs8lGCu9zV+e
         CRVOh9jyr+rK8oOPVd1KlgbB7rOGAxMT4EhorRhoLgYaabH91wSmi1On9UyE7KPoDPaV
         Llw62/VuEynvGRVznWzgSOTkCeSaw3imnnRP1FnQi3X6uWKCgJo9Cp0iLIPA4KM2syQo
         JwSxeB29yFGUmvL0BA5VijJPG83KMdwYF0FNm8IiGyC3N8LCMV3IoF1lVmh5UhJFHna3
         XiAZyzVSM0Yzf/VGcaDQVygXireXGGS9aH0xxYDCbsrlCEsZZXGznYun7PNpPhNswOfd
         xoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XABwerEJ1r58rLpIXIhr+f5x85U3HpOmXlluc99SprI=;
        b=rAQf502dkGsnBVj2ap+G9xgvsrTbSZELIjbLQx6G/zS5gmCI1Aj75XgU3TQyWJ+DjT
         dnyi3yyLLhQG+Ws93BNzc6qfg3q8WmF/H+qJbXiBCNMpKXqIN68Whj13q0LGgtABI8lA
         L2xeBMD/V4blCFml1DcaTgXuPUo4UbglsJvw+1WmT8/f2q6ThKd67HJWPKriyNXcs255
         MI2tMfsDjqralxH6uarygWACCjck0NtLpanyIGAsUZZVCVqpPioipK0mg/jycB7VAUm0
         ILHADRtPPp9c2A9jmYLm7kWfWrObm1QP5/m3wtiNCZG8WNC02N4s44nFnBnUa8ye0pHl
         z0fQ==
X-Gm-Message-State: AOAM5322AuKGDr2hNQ5c4SP0fQtoL3uDyS6SMGTnZB68XgSFk4y8pesC
        /RS1wgPlwi5YHiUtKwY3NK3D2A==
X-Google-Smtp-Source: ABdhPJyMdWOH9YX1RmqTPsp0cLCuHAx1vReTTQ3Deh/AIf0xp4IhLcbOYFMMvrSGr5U3K9CEqOvxPg==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr8929350wma.30.1639071767999;
        Thu, 09 Dec 2021 09:42:47 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id w4sm308666wrs.88.2021.12.09.09.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:42:47 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] dt-bindings: nvmem: mediatek: add support for mt8195
Date:   Thu,  9 Dec 2021 17:42:33 +0000
Message-Id: <20211209174235.14049-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211209174235.14049-1-srinivas.kandagatla@linaro.org>
References: <20211209174235.14049-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

Add compatible for mt8195

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
index ec70c5b7a340..39d529599444 100644
--- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
+++ b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
@@ -8,6 +8,7 @@ Required properties:
 	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
 	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
 	      "mediatek,mt8192-efuse", "mediatek,efuse": for MT8192
+	      "mediatek,mt8195-efuse", "mediatek,efuse": for MT8195
 	      "mediatek,mt8516-efuse", "mediatek,efuse": for MT8516
 - reg: Should contain registers location and length
 - bits: contain the bits range by offset and size
-- 
2.21.0

