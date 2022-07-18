Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF2B578DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiGRXBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbiGRXBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:01:36 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD5E33412
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:01:14 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id q207-20020a4a33d8000000b0043572da7bdfso2544622ooq.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JDOsPkpBt0yBFvxmD0VQrjJ3A/DSC78G0MmeXlyl41o=;
        b=AzEDJgdi3w35odv6I3sQevP2HejEcOXH4UKSHoABFWu+q9gpnuzzP/+r7+aAXyctus
         XGwUoP936Uk68Xuza8Cx/HFAhvKcwqMQxBvjdaCjTGjnyERUJtUKqlcBN6I+ecCT+50y
         Z0dJaV3xp/HSO4S6Ml1EadiIERW9XKYpPKZVzerHmhQ9uswT3V03US+r1nQ3DnhsAU5U
         DdGS+5bKcm/Q6iQituyxWvxhtyLgaJYa+rV4a+Q0Ed1hiTCVlfjN7eTFlHEQ4njD8zDj
         gLKRYYAeC9B3oO3QI2Rncz0FBHhwiP32o9i8WjQhmnwluA+L2iadwhsw58vaE8dJqBks
         /lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JDOsPkpBt0yBFvxmD0VQrjJ3A/DSC78G0MmeXlyl41o=;
        b=DxYFWxreyJz8SW01nH22qho3s6Y7Yxnbxmufg5KpT+YVAb2hfjq7ShYa9TiU+RdHpk
         bsBLPfTxggh3xOkf4Xe9qdNmDEJfz5kif1nChLBGIvwEcpYfV1Xo2BIklgOrvWMNwa7s
         Xl1L8jER2xLNb5L7IeyMNbUrM9v23ZTq1VaKfVIb8Bhx0iCmB6oyrH+TUjKFpHhfxijJ
         WBTDGa8hjWcFZbVMMfa0lBn09WwX/FBqFhN3uAnm00LrMEuwtJSeJgf3SNrEY5P7Ghg4
         7sJFtFByscUoHbctdlo6m4hgZDjRc5T45T55IqOyX4m2rO3tcrES0ezspnWx8Tuxg37Q
         pDXA==
X-Gm-Message-State: AJIora9NJZtGtB7cVNuX0JZQ5GQ7mFr+xvMS3AcCY6KmzIfvivqm1S8W
        fLErlqcEAkItKH2NHnSakrZQRA==
X-Google-Smtp-Source: AGRyM1s1gXoQiyIyutlHBtnlTi/Vg5TSqDFrjW60AgTVYJ6/M15/41V8g+gwdWD7hznBTGWI3QNsrg==
X-Received: by 2002:a4a:d786:0:b0:425:8317:657f with SMTP id c6-20020a4ad786000000b004258317657fmr10401912oou.86.1658185274143;
        Mon, 18 Jul 2022 16:01:14 -0700 (PDT)
Received: from localhost (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id c11-20020a056870478b00b0010c8b6e70ffsm6848019oaq.37.2022.07.18.16.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 16:01:13 -0700 (PDT)
From:   Steev Klimaszewski <steev@kali.org>
To:     steev@kali.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: sdm850: Remove unnecessary turbo-mode
Date:   Mon, 18 Jul 2022 18:01:08 -0500
Message-Id: <20220718230109.8193-1-steev@kali.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom-cpufreq-hw finds turbo-mode in the LUT hardware tables
and slaps the flag on the last element, so there's no reason
to add it in the dts, so remove it.

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
 arch/arm64/boot/dts/qcom/sdm850.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm850.dtsi b/arch/arm64/boot/dts/qcom/sdm850.dtsi
index b1c2cf566c7a..da9f6fbe32f6 100644
--- a/arch/arm64/boot/dts/qcom/sdm850.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm850.dtsi
@@ -16,6 +16,5 @@ cpu4_opp33: opp-2841600000 {
 	cpu4_opp34: opp-2956800000 {
 		opp-hz = /bits/ 64 <2956800000>;
 		opp-peak-kBps = <7216000 25497600>;
-		turbo-mode;
 	};
 };
-- 
2.30.2

