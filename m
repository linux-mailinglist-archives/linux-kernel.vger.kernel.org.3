Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EE155413A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356751AbiFVEKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356552AbiFVEKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:10:23 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FA633E17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:10:21 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-101d96fe0a5so11527962fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjnIC6kku1LNGs5C6wxJSFgJUu5lrUfNmdEoTsf6hpw=;
        b=db4WmBtzFl7YpQwaRMaGVH01mEeJHk1VOnCuNCDdAz+y+E/zg2akJG3ZrJt8pJuyuK
         Q3MgdlGGKwDA0NuJx3w3CYfBMU2z2X6HXnIbBb/0biIf98J42AuPQzZU7V/OlYnNfkjY
         7BuB1SC4hct4PhktN8Tc5JK0xZKRFClfrnGkNFcmTA+kAGZWVgdm+5L0mAOt+cPQJOem
         LFnVPwfUCjJai39l/k0F4zcEtx6YJqDEi+597Oz8QaHqiA9L3YEvf6Eyq0OjxqwGChmq
         osC+0mYrFxpLh7jVOThvsKpoEV1wYeg9vB8YvJt3Z4fIAaignVkHODlAgjWu0sEA0sAA
         f/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjnIC6kku1LNGs5C6wxJSFgJUu5lrUfNmdEoTsf6hpw=;
        b=qLoCcIVYJg4LeJ74bY5tpAMh8TBxQZY5knpSlKgTAi57LIGSMx6r2VnG8ZSG0NZ6gf
         /DULJp8pgLjQoI+2XKAxji+cgpxQLICkJYsVvremKvpo/1oxuzRtnU6Fiv+Sp7os9e4P
         KJLKKBGIpqO5mBNDqr541/P3pUBWuWVZcDRARbd2MpHRCmRrwwEcPiMpqNp+zoICY/+M
         SF6+v1In4jckk98RAuTryKu0rT4SI4WGBOo/uSK+IOvACtUyhRdy8QumSheVe5u7wR/D
         h5+qdw6VUlxkDR94BhspfLQxAgn7re4wzKgnMOedCYMX/9+2X4Rd4yF4VFXqb/r3M+If
         y82A==
X-Gm-Message-State: AJIora9Lq8CuEHek+Czq7eTcJWpoJscwqiHdeoU7XJ2JG8c4hJwnnh8Z
        oS9WFocGwmcrK0zNkUCx+XCCPg==
X-Google-Smtp-Source: AGRyM1uajMmDarLjCSa8/IRfeCMFHaAQYL8Ln05z+DpWxeTkp08O458IB+ni2/sxws9/IsGtApaV3w==
X-Received: by 2002:a05:6871:78a:b0:101:f144:4bad with SMTP id o10-20020a056871078a00b00101f1444badmr990181oap.240.1655871021145;
        Tue, 21 Jun 2022 21:10:21 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b7-20020a056870918700b000f2455e26acsm2314718oaf.48.2022.06.21.21.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:10:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/6] dt-bindings: mailbox: qcom-ipcc: Add NSP1 client
Date:   Tue, 21 Jun 2022 21:12:20 -0700
Message-Id: <20220622041224.627803-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220622041224.627803-1-bjorn.andersson@linaro.org>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
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

Add a client for the NSP1 found in some recent Qualcomm platforms.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 include/dt-bindings/mailbox/qcom-ipcc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/mailbox/qcom-ipcc.h b/include/dt-bindings/mailbox/qcom-ipcc.h
index 9296d0bb5f34..fbfa3febc66d 100644
--- a/include/dt-bindings/mailbox/qcom-ipcc.h
+++ b/include/dt-bindings/mailbox/qcom-ipcc.h
@@ -30,6 +30,7 @@
 #define IPCC_CLIENT_PCIE1		14
 #define IPCC_CLIENT_PCIE2		15
 #define IPCC_CLIENT_SPSS		16
+#define IPCC_CLIENT_NSP1		18
 #define IPCC_CLIENT_TME			23
 #define IPCC_CLIENT_WPSS		24
 
-- 
2.35.1

