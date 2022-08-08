Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51A58C425
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbiHHHhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237875AbiHHHgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:36:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DD313E0B;
        Mon,  8 Aug 2022 00:36:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z17so9869200wrq.4;
        Mon, 08 Aug 2022 00:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uYRvhWIir+9vFNPEGPmYjeZmzQyaVDNo9OS1sri7zLc=;
        b=WqAfVIb7d+vMtao0BB28J6WxkgIjKclg9mdmpH5aZx3Kbx2WGVsa8sbi0/oJHTe7RS
         ApmPnAvfGYjJlkNxBXhdVEM0wlG7ch+K35lQwnEn+r+MsgfkPJpi7xVqvppnyhBWL1ws
         KzespaNbR2z1GqSzTEbqjpDv7bFBYewsqNLmN910NtK+FjjBoNRohCqOEd5A2Au/RYVz
         Q5LnmtJuRlMezVJQZlaAykFyJ8fmcHCMAxLGDkoQt9bkDLTmfwN9Mpj0xRS2gEyX7rbi
         vDtU0QoxEvO/iX9tcwwaeLM+1iD3hXz+cVirs51necmmWb6EoMAyFHW45Cf1GMmvrOEn
         BGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uYRvhWIir+9vFNPEGPmYjeZmzQyaVDNo9OS1sri7zLc=;
        b=yegv6PWwiQCZSvslnKnE1qwa8UkxztdShwsr6DRJBJSKEWXirmSnrBC/JUbLWRJXQS
         Pai9jMByGrbsb7avcsrWD2ICBL0giZAx1ZROIrwUHohIrUJf0mGei2wXSuJ2aXsn+LkU
         +esS/oJJwkts7BDGavlzixTeguCA7GamzvaU+0T7s0vdbogG0zvNksOKy0WHZRM4iZJK
         Nnkd5JCBLsSRzztYS43cECp9ObW0zWUjzZ4DHumrzfBIkBTtGOg2KB5zYGJMDs++w6vf
         OSNmiakQeEi+8LHjKLdyQKZQP0Bsd/jrfftrcP8xxxsQyBS6wqREVjkRHASGpJB3xyPx
         LzbQ==
X-Gm-Message-State: ACgBeo2HbPVmv2P1ixMIVkPUGqmuuDEY9AuEU+scvruji+VDyWvi50gN
        +G8PPTNWNckZoYlHH+K7Kic=
X-Google-Smtp-Source: AA6agR4gUjE6BeupG0r1l4Gy97xRsQ+e6XUf2b5okBU3JGXpFjzcvbfvD/oMHaQUm3CDBEMc3EXE1Q==
X-Received: by 2002:adf:d4c2:0:b0:21e:ddf3:8b14 with SMTP id w2-20020adfd4c2000000b0021eddf38b14mr10932162wrk.355.1659944191138;
        Mon, 08 Aug 2022 00:36:31 -0700 (PDT)
Received: from localhost.localdomain ([105.235.133.111])
        by smtp.gmail.com with ESMTPSA id cc11-20020a5d5c0b000000b002205ffe88edsm8333364wrb.31.2022.08.08.00.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 00:36:30 -0700 (PDT)
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
Subject: [PATCH 5/8] arm64: dts: qcom: msm8996-xiaomi-*: Enable SMBCHG
Date:   Mon,  8 Aug 2022 08:34:56 +0100
Message-Id: <20220808073459.396278-6-y.oudjana@protonmail.com>
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

Enable pmi8994_smbchg, and set usb-psy-name in dwc3 to point
to its USB charge path supply, allowing it to configure
the input current limit when plugged into a SDP.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 022ecbcd965a..a18c9a9baacf 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -304,6 +304,12 @@ &pm8994_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
+&pmi8994_smbchg {
+	status = "okay";
+
+	monitored-battery = <&battery>;
+};
+
 &slpi_pil {
 	status = "okay";
 
@@ -324,6 +330,8 @@ &usb3_dwc3 {
 	phys = <&hsusb_phy1>;
 	phy-names = "usb2-phy";
 
+	usb-psy-name = "qcom-smbchg-usb";
+
 	maximum-speed = "high-speed";
 	snps,is-utmi-l1-suspend;
 	snps,usb2-gadget-lpm-disable;
-- 
2.37.1

