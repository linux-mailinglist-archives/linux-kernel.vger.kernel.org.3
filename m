Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80125525575
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357954AbiELTNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357944AbiELTNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:13:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7206F4B1D4;
        Thu, 12 May 2022 12:13:48 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u23so10797237lfc.1;
        Thu, 12 May 2022 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ot1LRa7lM+k3YsGeal4v34AufyNdy0MxZF/OmP8vaTY=;
        b=fl7m+Sy2q51zLDj9YOdvZlDg3KGb+wnKtsRPRIj2/t4UMfva6opF5tXqFIRV3FOyGR
         vbLYz10hfDvS4aYSy+ysUF7AXXPQ4IJfGzxDhHon1F3YvtyPm5JQWIvoXwfWZYbz+U2N
         GItLg/8DKK2aK4fmQ8XQ/dEOx/ZRxPYMy2BQAGi99kd1zPFfu2rw1kW+Vz76qRAdscwa
         yNcrZKAU0onDKO6sd+617sp3WRMXMYOiiziHPZMoOCP2olDl8vvsYVhyHmvBlckLJSHA
         8OpkrDw3kKkT5mi/A9SegIWQH29XL2k28r02YAThWbMkM6KIsQu6f1uuj40A/QP+FL/s
         vbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ot1LRa7lM+k3YsGeal4v34AufyNdy0MxZF/OmP8vaTY=;
        b=Ki9OTMHibjNNUdTV01jMeykw9aLKdEBKMHW0Tl+gDYeiQ7bnIGS1FeMQ0QoMH6Rgc+
         I6bs6Z6g8P34RF5orr2jUElyPjPOnYUcKMnvg/FiNzB0Vck1e5Vv36KvYYsKuKFxWXSc
         jeexhl7Kn3oJFS8204MEcaI9ZLMW3ixSNCCcSIQjfPrSI7wNS3QRHoLjXE5PSbmTymQM
         f4ZdCSywZf6cKJ9ag5qDBz/IEcH1yml+1M+a+RJIFHHmWzwRJGzOZwDPzic54/oVzLMC
         OJtFQNtDLsoWPRoDBtufkNjR1+8FSjwJYKPYoWqpeOR0Kl6d63mzgF/CoAbAAouqUv4G
         z7Tg==
X-Gm-Message-State: AOAM530loty2U3KWFe2bXIvvf8tjdmkrnMHkaxGWfnM+buGixMo3okby
        kj2ZiHtEle/SUq1LWAgAGegw5VhRQKkdEQ==
X-Google-Smtp-Source: ABdhPJzYkz+yR4pFKrfCDy4hRzreNMuY/Afvmgz7zMl8qBIZJxlrbdgdT9MtoAsxUPbIHiEjs5zvTg==
X-Received: by 2002:ac2:5cdb:0:b0:471:fd36:fa56 with SMTP id f27-20020ac25cdb000000b00471fd36fa56mr829030lfq.501.1652382826649;
        Thu, 12 May 2022 12:13:46 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id y26-20020ac255ba000000b0047255d210f4sm62146lfg.35.2022.05.12.12.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 12:13:46 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 1/5] dt-bindings: proximity: vl53l0x: Document optional supply and GPIO properties
Date:   Thu, 12 May 2022 22:13:29 +0300
Message-Id: <20220512191334.61804-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512191334.61804-1-markuss.broks@gmail.com>
References: <20220512191334.61804-1-markuss.broks@gmail.com>
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

This patch adds the optional properties for the VL53L0X ToF sensor to the
device-tree binding.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../devicetree/bindings/iio/proximity/st,vl53l0x.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
index 656460d9d8c8..322befc41de6 100644
--- a/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
@@ -19,6 +19,11 @@ properties:
   interrupts:
     maxItems: 1
 
+  reset-gpios:
+    maxItems: 1
+
+  vdd-supply: true
+
 required:
   - compatible
   - reg
-- 
2.36.1

