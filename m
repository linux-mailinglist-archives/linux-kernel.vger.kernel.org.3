Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B925424D9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444170AbiFHCJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575265AbiFGX06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:26:58 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC62D682C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:38:54 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-f16a3e0529so24893764fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 14:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zdB88eF3i8XSLLLYG0iiDeptdNTdVi4N3QCkwcA2170=;
        b=zfI7ux9gTBHY1LriHzIkWCEvdSmBvTpvcDcbAjPXfZ2s6QigByqMBGNA5jwuSXavQq
         Q/VrJnaqx65qm8FwxpXNaYjRfSIzSAth3b3qC3AGKeJDRVqer6llSZDndI2QRDbVRv+l
         fZeSxJj1JfOGJxZEenywaqTBE3Fn+mZ8f5z3RcfXkYZPsAs+F8NErPgTYWFpu2jrcyy0
         Ed9NAb9waCGRrwMxkU+hRR7qSd90MFclize28k2m7G+h/fO7tggLWX4zH1LftkwE8e4s
         ne0zrmatqeTgoJPgOBeTEpIU5QU1YFkczk7WJi+lHymZ8DxL2i9z094ou+eDFXIkwiNc
         F82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zdB88eF3i8XSLLLYG0iiDeptdNTdVi4N3QCkwcA2170=;
        b=KkDOAE2iEYPTLvj6UVmQ9h1iNOh9YCfzrNi+4kL+5IOdfPTsAIDPe3MZPAMqjGCsWF
         U1HsiJcSmW4H89whn4gAdfrrFX/WPZVPoushCZWv/kUv73J51llXfUy0cBpfGLyf8J38
         tDa5tOIyOGSdlV94uMBRIJRG031olFW/lB6IMc18BfHW3EouIGbc8KWOgZcg/C7/7Ons
         Lo0bwX2hAxwegEsQILZDWHX6p7llyMITReNY1nrp5Gqo8YFL8BZcUtlUJy8GZIXtrQVR
         EHuReHGe59fqAFOFbJOvq70XR7beCx50+jdjKxto+Df8y9zLqvgK60+NXIZ8ab/HC4cp
         RxzQ==
X-Gm-Message-State: AOAM531BK0UgxmLqEK90JXlouroT9KOy2t78ugY5UFFdY+cFRI+UPHE/
        U0T/sTL0oLxxks9JeEIwNGoqgQ==
X-Google-Smtp-Source: ABdhPJzWJYJT4K/H3ClolNP09gCRkSoURkNWkEzKuKLvLtVyJkAg3IMYSML9skQOWIubBxX1umJ7VA==
X-Received: by 2002:a05:6870:434b:b0:f1:e2d9:dc66 with SMTP id x11-20020a056870434b00b000f1e2d9dc66mr571092oah.86.1654637930418;
        Tue, 07 Jun 2022 14:38:50 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id cr11-20020a056870ebcb00b000f33a37411dsm8554122oab.26.2022.06.07.14.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 14:38:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: mailbox: qcom-ipcc: Add NSP1 client
Date:   Tue,  7 Jun 2022 14:41:10 -0700
Message-Id: <20220607214113.4057684-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220607214113.4057684-1-bjorn.andersson@linaro.org>
References: <20220607214113.4057684-1-bjorn.andersson@linaro.org>
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

Add a client for the NSP1 found in some recent Qualcomm platforms.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Jassi, there's no code dependency on this constant, so it's only going to be
referenced from the dts (patch 2/4). I would appreciate if I could get an Ack
and merge this together with the dts changes.

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

