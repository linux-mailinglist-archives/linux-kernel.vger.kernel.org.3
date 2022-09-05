Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309D05AD57B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiIEOrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238324AbiIEOrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:47:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E1AE56
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:47:12 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id az27so11676194wrb.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IJOnhwwzRsVseSJrzo8/DS7wx+sQBQac4zRpiRsGkDo=;
        b=U9143da/WdVUblk21I1X+vFiVwDlbfSAx66bjWUQeS5UbfVs6Btd17iYEUvPyLAWcG
         bIJnjO7AzfJO1GQFXM1SdE4kCInxojlQCasuRMfQb2XbsNx48WGg1fnL6aiWeeYarCnf
         FRnHVrRDju79sFhtIsDskKbyX+gUAMq5GSFSOhIJcBk90otBwG5fWbFx2DVI4cgTUHm2
         VBCVI0l2XOrOVQLJPr1lBxeS1pEOFj+2+ThbahTk1rpLqY4/AkmrOXmhNumvDIIMqZWY
         4PPGWhEU4030u/7PILYdn7W8wOu1xaOgf4+bQN/Z4Fb/EwGrQCr03iP3+ug94yL6YKqa
         xqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IJOnhwwzRsVseSJrzo8/DS7wx+sQBQac4zRpiRsGkDo=;
        b=2HlpbcUdjSh102fMQwufRI4F8ZVm/scRNYbZw70qcXcOSS1mg83x1Y3+RtM3FY8bJl
         DYBFs/x0k2bnXC4AUcMaQE8UWSqr08EZfIpy/TbnarsWCce/eu2TI4J307Xm5AxPfR71
         fht1YRz8FokynRPgpM4ClJ7oJROaVJQB7/5QUDB1vk4444+q13SILVVmYqmmVyt6Mge4
         q8xN8R86uxRX8PWZ1Z4dU8lrJtQuE/Qi8mMUcs6N76kewODFHa251nwU9dWaWR9TzBzM
         6cxr0vYr6lBCSkWkquUey8bNUmWO0cZJ+95zM2vTN28a5OQ7cV9rrnUutoXpdYJDiokI
         vDMg==
X-Gm-Message-State: ACgBeo3UnMVX48wDrVf0QbpBSqogZnAk+rJma5Faz8zyztX5+5UjicsZ
        XM+7JrwZUotJHbmJJ6w37w4tJjSrc9K4JIr+
X-Google-Smtp-Source: AA6agR7HkIpVkRVwR24W2H8jZIYnAmc84QOOZRT5sktlhgyghzdxjHSc65BOQemJlrFTxiPjQtYbgQ==
X-Received: by 2002:a5d:468a:0:b0:226:d78a:6af with SMTP id u10-20020a5d468a000000b00226d78a06afmr23107394wrq.339.1662389231104;
        Mon, 05 Sep 2022 07:47:11 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003a846a014c1sm18990244wms.23.2022.09.05.07.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 07:47:10 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/2] MAINTAINERS: Update fastrpc documentation file from txt to yaml
Date:   Mon,  5 Sep 2022 17:45:54 +0300
Message-Id: <20220905144554.1772073-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220905144554.1772073-1-abel.vesa@linaro.org>
References: <20220905144554.1772073-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for fastrpc bingings is now YAML. So update the
MAINTAINERS file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v6:
 * no change

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96f47a7865d6..ad697195fc59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16863,7 +16863,7 @@ M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 M:	Amol Maheshwari <amahesh@qti.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
+F:	Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
 F:	drivers/misc/fastrpc.c
 F:	include/uapi/misc/fastrpc.h
 
-- 
2.34.1

