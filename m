Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99E2531741
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbiEWST0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343491AbiEWSSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:18:25 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8535F9CC8D;
        Mon, 23 May 2022 10:57:10 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id j10so3421691lfe.12;
        Mon, 23 May 2022 10:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z53+eSm48FvQ1MayBXB2WM7d2cfczvsN4KH91gkl1Tc=;
        b=D+LheF9tJ+G2+sPuMJyPM37G4lLnteKMvYqM2fJ4+085f5WfhWQAabLOfi6oTFp92f
         kErnZMjRgG5wfUUAUBlr3pkZortlOzO9MX7kFcXePwUg02bvtun7ooXR3Pg9bAo7mmKy
         /KpGqWBkcMDqxzM/Ji2KJKzr8ty7D4xvaFMIjulqOfAQ5+KgCues4ikFBxpGCFLnrEy4
         jqPqx07NoL1GvmAJpBhGT5tmRYL0xtFOVselz5QtLNfoHk8lzNFGIG6fvCfibrEYyXL9
         ax/DpIniFzWPItHb2mtEmTVFZLXPIv7iihM68YgD7otuv9Ii94MwfulMBhftBEZu75EH
         pJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z53+eSm48FvQ1MayBXB2WM7d2cfczvsN4KH91gkl1Tc=;
        b=3JMsR/ghsbb0tGPCH++P09oBeUij7G4Nwl/N0W8FdzwDngQTbnWHkZ61wrItNBdq3r
         jz26N7zcQLqlN8aYBn4a7Kc/XMs4npLc8b6C/NER/9DbQPucQ5Rt2yqkA8FFn6FaU3fo
         r6qW9MlyC8Tl0/12TjjGwTEHO4CuoJLN6eWDPvITUVoqLKSSevE/59gH6tHaHFf4TujK
         yWaG4pVTGGZzQnbpG2R5jwDbvkBslkeSgn3PnJyfyckFv57aXyIjWHC+478O18KtogKy
         snUap4jZZkw+DGHddpd2+jvYspLoFKaO5/vUGZl/dzHa/jAH89xNnQypigX83zgbvPYp
         y5ZQ==
X-Gm-Message-State: AOAM531XLB7cfwale8DTFnPvzBu29r1IQY1dmR5xouDPMP8HGffJrtq4
        MD/2SoGnpwW4tUdUTlxG3PwzgnTNZm9Kng==
X-Google-Smtp-Source: ABdhPJxLu/v7OzDk6ZnpH5afsp0D2wHmiFzXEmYOjBLbIOZwDx07R9CCDbSPr1BKPSjJbtfBPGfZhA==
X-Received: by 2002:a05:6512:449:b0:477:cb59:9fe5 with SMTP id y9-20020a056512044900b00477cb599fe5mr15593407lfk.40.1653328470964;
        Mon, 23 May 2022 10:54:30 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id x9-20020a056512078900b0047255d211f9sm2087743lfr.296.2022.05.23.10.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 10:54:30 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org, jic23@kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/5] dt-bindings: proximity: vl53l0x: Document optional supply and GPIO properties
Date:   Mon, 23 May 2022 20:53:40 +0300
Message-Id: <20220523175344.5845-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220523175344.5845-1-markuss.broks@gmail.com>
References: <20220523175344.5845-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the optional properties for the VL53L0X ToF sensor to the
device-tree binding.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

