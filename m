Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C24565EF6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiGDVYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGDVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:24:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF37310FE1;
        Mon,  4 Jul 2022 14:24:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eq6so13024538edb.6;
        Mon, 04 Jul 2022 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6YK0Qy2E/EJZUmG508VlvTboIMY5FeBTto36YOpoAJM=;
        b=cLyxJ9nj0B6idyzePiQTDbd6GrawwqiqBL9J4RALJGSQ43ljmxmygR5n7wsNroZWcX
         W5rEl/8NFZRmqtWfj5AparSqGPanCoqRoKR4kZ6mb1QwzLYxf/LEb9k6KT44ionRxDj5
         s+O2t9YhcHQxg2KfYm0Qvnn2f3W5zrnIOJ7OKYZceWKI0YIqGrMug+xA6H82UgcyLn/k
         6sRPNk6iPHo8xee94DhS7PoUw73HAMZK4M2UBqW3IR4orLpjsXIRsT3U1yGUMsKfzlY8
         axLp1G0bEVGAk46nAdtOU2d/qTtKWLYnte7rzozi6rwHLW2Z/ngCwlSNCH5vnaoX0Vif
         zI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6YK0Qy2E/EJZUmG508VlvTboIMY5FeBTto36YOpoAJM=;
        b=ZmHnnfkSVfx2OQLQVe+iDP6eJUY/hsBiHDUTgjDJnwygUbIVH/FACBSk2DFj/IX5nw
         EBT9QFTMokyxBYRQdyLh+S1NIPiYa8tlVnNFSweXr+xPeo1j3xmPoxQX3xSiDm/ddvcm
         vntjsG7+9KAANO7wFkYAcFlMXI5cCB05EygVA+lybLREbP30L4yAcpk8WEPGosH25fQD
         Ygyemyq00oVfzZIQcv1PqesjkbaZ594gAvTOlEkEfqyLh5guGzZhtl3Su3UcTBKMZfBd
         yiJlMrR+vUE/lj4calMyk89cGc3jss4HJj9fApDLfY3X8FzMlAqRMimR1nestB+YOSNR
         6nmQ==
X-Gm-Message-State: AJIora99Qn3mhABPBAvk3qdC8tha3lR7060Ua0pwF0R4/LIsHzMLepiF
        g8Ve7GAP0IGMZl5CFoGhp7k=
X-Google-Smtp-Source: AGRyM1s0uahroH7j430DAMUMmeCYbOJfpqgBJL7TKvrQ10BOSx53TueNzEINxulMH4uj6aeQwz00VA==
X-Received: by 2002:a05:6402:84a:b0:423:fe99:8c53 with SMTP id b10-20020a056402084a00b00423fe998c53mr42552801edz.195.1656969845581;
        Mon, 04 Jul 2022 14:24:05 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id k18-20020a056402049200b0042dcbc3f302sm20131117edv.36.2022.07.04.14.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 14:24:05 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jic23@kernel.org, lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 01/12] dt-bindings: mfd: qcom-spmi-pmic: add support for PMP8074
Date:   Mon,  4 Jul 2022 23:23:51 +0200
Message-Id: <20220704212402.1715182-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Document compatible for the PMP8074 PMIC.

I planned to convert the bindings to dtschema, but there is already a
patch to do so [1].
I will make a patch to add the compatible to dtschema once it gets
accepted.

[1] https://lore.kernel.org/linux-arm-msm/20220626191630.176835-1-david@ixit.cz/

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
index eb78e3ae7703..c46d17609f3a 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
@@ -46,6 +46,7 @@ Required properties:
                    "qcom,pmi8998",
                    "qcom,pmk8002",
                    "qcom,pmk8350",
+                   "qcom,pmp8074",
                    "qcom,pmr735a",
                    "qcom,smb2351",
                    or generalized "qcom,spmi-pmic".
-- 
2.36.1

