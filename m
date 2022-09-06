Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AA65AE414
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238334AbiIFJYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiIFJY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:24:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CBA2735
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:24:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so7057472wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 02:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zhumN5rKHl+rJS3E436tBIxP4QCYB+3VNNyoim6GayU=;
        b=yYjZ6G7dxVaQrqwsDtWyTqGwC0GyQSdDxJbH8PcJTSekji3/w9wtxA7AG60TYd6+vm
         ezB1IoJxlbmW21w+sgqqlMqsL1/3JwjGDobmfldnQVfgGJaqmSL6BW46RauHHufkg3+S
         MmMKIDlGMh9y8D1jxaxLrqOseURPced+5VZ1JkV8e2tjdjM7HRRK+3D36BjdVwCbjbJv
         TmZlF3OmxTxTyZlK6iIxb27AJC1V4G/iYJ88K8InacNPKrXXi8bc5ji0AcKnAwfgd+k+
         4MLEjWhL1o8GBnryg64WScL0qSMcqn8LkjlNg8jkdj9RP3C5hWhjoDQAsC3619S5g35q
         Wseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zhumN5rKHl+rJS3E436tBIxP4QCYB+3VNNyoim6GayU=;
        b=p/engh4FiL+gEgnb/GOqbgqWNhLdYHat5i9DcRBODKhWtqVe6AeKdw4fEmbAHnvFCX
         HvipqRomIRQ/6BNRUrd8zfM7SnKeQgO5X9ALB+sBEXNneMmk+BbSWsYQP/iR4Ax5uar6
         /Ttseqbm/Knhs92a2xMQokpLFctlyQXo5pgLq8B9+xd8iWSiP9TFU/9IeNOXSAiC/ZtS
         Cr79I0pGpaMYxmbZFwKYNBPAcUQ7paQbR7DSUalRJlf/3oh1SpYjfqui459w5nLeBvfI
         f8Ie07OwhlN/jmFg3hP6VS4OuXV6flqvLLyRiVGSxQnrUgr6uf953qJueM5jfa28at59
         UuyA==
X-Gm-Message-State: ACgBeo3zfutG3HtbkPFYb5DuYn3lUHQELNM0dNXcGw2YqKme5zFk4n7P
        UbtPEj83kpRW47RBjlt+jmIVdw==
X-Google-Smtp-Source: AA6agR6eCeqyyMBjhzrEThYbzGzQUuqP9IQNZtGs2H09IxSYjfI0WNlD6qFILcKCDFkqtW9p3qae0w==
X-Received: by 2002:a7b:cd11:0:b0:3a8:3f6c:9abf with SMTP id f17-20020a7bcd11000000b003a83f6c9abfmr13403700wmj.30.1662456265828;
        Tue, 06 Sep 2022 02:24:25 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d6b41000000b002250c35826dsm11691236wrw.104.2022.09.06.02.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 02:24:25 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v8 2/2] MAINTAINERS: Update fastrpc documentation file from txt to yaml
Date:   Tue,  6 Sep 2022 12:24:15 +0300
Message-Id: <20220906092415.1989720-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906092415.1989720-1-abel.vesa@linaro.org>
References: <20220906092415.1989720-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Changes since v7:
 * no changes

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

