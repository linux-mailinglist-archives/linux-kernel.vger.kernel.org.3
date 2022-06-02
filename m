Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6C553B2B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 06:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiFBEYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 00:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiFBEYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 00:24:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAEB23354F;
        Wed,  1 Jun 2022 21:24:39 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 137so3726469pgb.5;
        Wed, 01 Jun 2022 21:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8UE4eAV06tZHoj1P3qIbNix8ApEWxlphKpy2ZumnTok=;
        b=WfYqvsjGIPh5ptj++cQYipIGSrnkhtEefpWACECgBoVP50xGlWgnBjPQCS2v8PcmM7
         e5vxYcxjVmk4yP1y1ajtM/QmIio8JOHuaMHPfoTvf32ELrLtFOGpbPKLskbH0NNt//zv
         KWCrLPIE0RQTdY0OQ8lTbdRw5Ck654bf9Yyo9m01rEUfsTOEv3MG6ldP+ctJEsiUU2Uf
         BI1CMX5J1wDA0cuxtanZlr/qISljTzM8E+4M4QG5WEbhj9o2nHFnn89Ga9G/R+7jt+Wg
         0urEIF3rxUZ75rwK6Rm+Qgg6x2LDKNWEng4gZVsK76E2MsfDKG2AHVN4evlLlGVyOXw3
         fg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8UE4eAV06tZHoj1P3qIbNix8ApEWxlphKpy2ZumnTok=;
        b=MA3ytINJJd4mH+wMZ3blg8cvynJc9RNTvA0aeeKoLkojM0VOSFvCiQSclfhD80RwpN
         E60MzvwQtsBouIsHHjGTRxw2tr1+xQMs3ypMOLHCVucbjFvF7sXlWPLMbvp844v31E6B
         1Ayz1OIu6oBGnSHEc1dbCYosZOtLOa3UnlGLif1Cp8hmq9KIib1k6vrWoSEe1fKdcfTu
         ARCPbfxtBmSf+p5QfGMe278yb8+WpDD6zBL/B0NlgzpwQEUkR4661DNQEtDByVjUkp+b
         YYKkvnslPl7tvRAKkVB9lsTBp06qqgzpmPCgpHdnnYLDCo5hryDMsYLANZf0s4zE+3dO
         l3Rw==
X-Gm-Message-State: AOAM531+kf+R3PX0sSt3aENbp4mzlNJ6EvqCdMILlo23ogtmm3vVW3hM
        j0JRm0VeE8OODP2g31u6s38eJiGbtH/6bcigOGY=
X-Google-Smtp-Source: ABdhPJwyZD5PH5XRRCmE2CU/Vnqd4lDKjH+8wa2c9qIKWTEbtELgJV92lLPBb/OaSpjMXT/I91/w3w==
X-Received: by 2002:a63:5706:0:b0:3fc:a31b:9083 with SMTP id l6-20020a635706000000b003fca31b9083mr2455527pgb.333.1654143879197;
        Wed, 01 Jun 2022 21:24:39 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id u71-20020a63854a000000b003fb92ec655esm223342pgd.34.2022.06.01.21.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 21:24:38 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] soc: qcom: ocmem: Fix refcount leak in of_get_ocmem
Date:   Thu,  2 Jun 2022 08:24:30 +0400
Message-Id: <20220602042430.1114-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
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

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.
of_node_put() will check NULL pointer.

Fixes: 88c1e9404f1d ("soc: qcom: add OCMEM driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/qcom/ocmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index 97fd24c178f8..c92d26b73e6f 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -194,14 +194,17 @@ struct ocmem *of_get_ocmem(struct device *dev)
 	devnode = of_parse_phandle(dev->of_node, "sram", 0);
 	if (!devnode || !devnode->parent) {
 		dev_err(dev, "Cannot look up sram phandle\n");
+		of_node_put(devnode);
 		return ERR_PTR(-ENODEV);
 	}
 
 	pdev = of_find_device_by_node(devnode->parent);
 	if (!pdev) {
 		dev_err(dev, "Cannot find device node %s\n", devnode->name);
+		of_node_put(devnode);
 		return ERR_PTR(-EPROBE_DEFER);
 	}
+	of_node_put(devnode);
 
 	ocmem = platform_get_drvdata(pdev);
 	if (!ocmem) {
-- 
2.25.1

