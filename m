Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FD358C41E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbiHHHgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbiHHHgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:36:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BB012756;
        Mon,  8 Aug 2022 00:35:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l4so9823290wrm.13;
        Mon, 08 Aug 2022 00:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nxDN09Ygs/+kfgUzrdcRt7MgfF4b0EgoFDM0Fa3eds0=;
        b=fSaFrLk2IbdELb3DX0cj67xgMPIBbv5anGQCYCuDZuSPCC8Vc3DO1fr/RK30CEslz8
         /nh6SVHvBehnPo/h8SxGdXMrvktLJjm0i9uaUAggn4UMnD23Ck/voqPzqR0eMT8gNQmD
         HAqKXrU3Eo4Ul4TNcniTyu4sDYQL1rZbARwW6UqxcGEOb5xmea8LKJeCZLiigIXh/0cR
         iMGlbAEOJ3tJ6mgpGYcsmkbcLYgvSRAbIih+n7UPjD9tBWNobu68hB1vLYzoxSfsgW7e
         0E57RUqRWicutxbhts8rMbGt6bJYpzsrnVMtXQmcoavfn2gIl/KPhIy0cmqJRyeS6bVS
         7DnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nxDN09Ygs/+kfgUzrdcRt7MgfF4b0EgoFDM0Fa3eds0=;
        b=JSF1DE0F3bE46UOOuiobWqQ9HJx1xnVvtXNDUDNM2gNIRHSMG/QxJnu+sPKI5UZiNM
         nf6d4Y2/3YTIR1AXmecUimZmxPgM/kUD/NHlNgu86l0wOOqoeTumnxXhbtLBBG+xxRfW
         +VyOb2FGzJXCgAQlDj40qlvlRP1WA4dapt+TA2d7pxCzeuNLreX1EFaxoD+2QS3q5DU2
         mE1s/gUqMOzh1xlnUkLkXWa8lepGVTGzbcTcvqcP+ZTSxRpzR727wVG8bPEwZjAGg7XA
         LRpOPpKFe4ALq9MPoICRWO99VX8NaMC6pLfcs55z/XZYq+n9Q/LjrYZu4rfBRg4uUkiP
         rjaw==
X-Gm-Message-State: ACgBeo1s013i8o9IBErzfBSyPy8pVi/oWMBOuYtc7BknmR+feuipGk2S
        JMneLctqmw872bv9V++O5FM=
X-Google-Smtp-Source: AA6agR5mGRuDHhUkHchb3IT2ypFG1OYigw+UxvXFL1K879qmHnFTV3ZzHKQt1xjfrcbptY45dcqv0A==
X-Received: by 2002:a05:6000:888:b0:21f:bc6:cc12 with SMTP id ca8-20020a056000088800b0021f0bc6cc12mr10813775wrb.90.1659944153225;
        Mon, 08 Aug 2022 00:35:53 -0700 (PDT)
Received: from localhost.localdomain ([105.235.133.111])
        by smtp.gmail.com with ESMTPSA id cc11-20020a5d5c0b000000b002205ffe88edsm8333364wrb.31.2022.08.08.00.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 00:35:52 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Alejandro Tafalla <atafalla@dnyon.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] arm64: dts: qcom: pmi8996: Add SMBCHG
Date:   Mon,  8 Aug 2022 08:34:54 +0100
Message-Id: <20220808073459.396278-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808073459.396278-1-y.oudjana@protonmail.com>
References: <20220808073459.396278-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

The SMBCHG block on PMI8996 is slightly different from the one
on PMI8994, making a different compatible string required.
Change the label and compatible of pmi8994_smbchg to match PMI8996.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/pmi8996.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8996.dtsi b/arch/arm64/boot/dts/qcom/pmi8996.dtsi
index 31b47209e261..ea8d86d12bb8 100644
--- a/arch/arm64/boot/dts/qcom/pmi8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8996.dtsi
@@ -13,3 +13,7 @@
 / {
 	qcom,pmic-id = <0x20009 0x10013 0 0>;
 };
+
+pmi8996_smbchg: &pmi8994_smbchg {
+	compatible = "qcom,pmi8996-smbchg";
+};
-- 
2.37.1

