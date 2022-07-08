Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F31E56AF44
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 02:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiGHADv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 20:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbiGHADs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 20:03:48 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C552255AB;
        Thu,  7 Jul 2022 17:03:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y8so19299658eda.3;
        Thu, 07 Jul 2022 17:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSxzmKxjlNqM9TSDpV5dH/r3annlSczSnTdVT/KLPhw=;
        b=Y4xpKzWJ150rdoYLQkrNCVmTdbKT+opqIncuCi6XAAQWCf/O9CqPuHaiV/GH9sYmpX
         7/o1ysUs3g1mFlmliPj7H6uZiCuEkqcSCYIj685Bn00iffibCxTS6NPTmlWpLrVU7XfA
         Qfxh+KK7MOitA+9cP++ujDWPtft20wECs0lUTdT1AXhqhN5I3Ly6eMYXcRSxkjfWR77w
         hnWscmSh0JFutTEAzJePwoOlh0Jz6sbhp3SpDQ6pjum652/JaIecgFMgetCNSsqmfgwx
         yUM2visa+WAPJZqYwO/lDn0pne2DPKc+OuX5KxWyFJ+8JjNvE1sVS6xVu3m0J1RKmKsh
         nWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSxzmKxjlNqM9TSDpV5dH/r3annlSczSnTdVT/KLPhw=;
        b=rwSgGMn4fq5tHJ+ZjppFQzHP7zvQZaRpa7fajhb6k82W+BF9xrJINwH4kno18PgweS
         +0tbhgJtt2VbFJBUPdyviU1A4qe0RW+D4jB7GsD3pciUszYMPpilufWbeoqAwqN0F0RC
         UEnPD5sh8wkrBZ2FxNRB7koIxl3j/GrY96/zSPJNsd/1GygldkBUpxsit62QlW5X/1Hc
         57GMK/rcneOBa2L4HSZvcvKxbDeFxodL5BucE9hldvMimMErJR2OhGAuDh/B5WrFFKWZ
         0DlRF8MFnvlAWFRzkefkSWrDQg6RebQrVsoV+mmvlCe+Lq/CVhLHkVmKclHnWWKixqW6
         bDwQ==
X-Gm-Message-State: AJIora/lRWASEuqEoJPMa+3lJMX6vWBGqM2X8DGkcvzg0umniGobG2n3
        iiYez0AxZc06EB3KlTP4RAUQCMZ312A=
X-Google-Smtp-Source: AGRyM1tyhJphCEF8w4d79Ik+3ixfdLIFmyh8AIaaYU7qjHqT1+YKFbaBEt5XfA8VMEUZZ7Z6FvnZCQ==
X-Received: by 2002:a05:6402:2985:b0:439:651b:c1f4 with SMTP id eq5-20020a056402298500b00439651bc1f4mr954113edb.276.1657238623466;
        Thu, 07 Jul 2022 17:03:43 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id f22-20020a056402069600b0043a7404314csm8093974edy.8.2022.07.07.17.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 17:03:43 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/3] dt-bindings: clock: add pcm reset for ipq806x lcc
Date:   Fri,  8 Jul 2022 02:03:36 +0200
Message-Id: <20220708000338.26572-1-ansuelsmth@gmail.com>
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

Add pcm reset define for ipq806x lcc.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
v3:
 - Added review tag
 - Added ack tag
v2:
 - Fix Sob tag

 include/dt-bindings/clock/qcom,lcc-ipq806x.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,lcc-ipq806x.h b/include/dt-bindings/clock/qcom,lcc-ipq806x.h
index 25b92bbf0ab4..e0fb4acf4ba8 100644
--- a/include/dt-bindings/clock/qcom,lcc-ipq806x.h
+++ b/include/dt-bindings/clock/qcom,lcc-ipq806x.h
@@ -19,4 +19,6 @@
 #define SPDIF_CLK			10
 #define AHBIX_CLK			11
 
+#define LCC_PCM_RESET			0
+
 #endif
-- 
2.36.1

