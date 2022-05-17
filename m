Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C30A529A47
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbiEQHCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbiEQHBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:01:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33D346675
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:01:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id p26so4924332eds.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MAlRyJ0IHfdwsaWhxry6um/UE2vHbyKkhoLXrIb+qPA=;
        b=Yesb7UuUkpV5Q4fE9VtD/On6PSh4j5XE+KrEJu3WVX1qp58pp25T3Cr2gV21EhVhB8
         q4VNIKTsQtEnqPLtreCqDLot7X5+n9DeQzsEa3xNzvQhxuD5nik2Ch24Cmyg9sn/PXgP
         Ap9ExebtqSbb5ojtVrn2eA6JSeOGXtx1TBUuiFlepryT9pIMKBHKNQ/NmIcM/teOFtRs
         Lx4708xV/UsLsarENaPb8M7ep0prEgVbQWFjg/YflbDmTT/+dRb2g8+VKzpqxJPdBb0k
         FOKc6z5EcLeodd9BpKJxCnuRAyK6gKg44VAdb4w5Yns9zCjdnbrCowounwp5Fplv6/Nl
         syGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MAlRyJ0IHfdwsaWhxry6um/UE2vHbyKkhoLXrIb+qPA=;
        b=ReufLMi/jr8XFZkMnSGiKU6qqyciIUIJ4DWAxkT053FnXaCWBEqjmx4Y0sONe9Xo82
         Atvls/iYWDLWExzdxzBkMwW7LDFQRPM68ifvXeXIO85K08sioS/Ze1iSJO4xg29XUNN0
         WzAc+ZSoM+fRiJbAxM4Dbga9rkliTNRBz0wdYP2kbXDl3iB1sfnbGm5Vp9KShno3LRLi
         H8pq6jMiHZ2qDENVViNHXSSV4jxKZSepna7M2YcYcMQDT70ziRuoTm6i2h3UTWJqm00s
         MDKXrQxZTMcFyGuNzqzA3kCuFyOwQBJWqgddJfmX9RCxL7XdRuh7LmNLDrcLTscXxJY0
         f7ag==
X-Gm-Message-State: AOAM531aG1OyXglJbsxHQJ7EVa94ruhLsVeNrTilEEXUHzhV5sDstTBU
        S9ZkrK84BhQacjf1h4x/rXeqDCc6sHuciKbt
X-Google-Smtp-Source: ABdhPJySZbPsZoeL90Ixgleh8/wwW1Fl8h3hW8PH2fBiwpqroH7HjsP32Zz9S6Sh8+6YTkF+w8NgOQ==
X-Received: by 2002:a05:6402:1d48:b0:427:dfa3:2272 with SMTP id dz8-20020a0564021d4800b00427dfa32272mr17378050edb.333.1652770889845;
        Tue, 17 May 2022 00:01:29 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b5-20020a056402138500b0042617ba637esm6487016edv.8.2022.05.17.00.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 00:01:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 10/12] arm64: dts: qcom: sdm630: remove unneeded address/size cells in glink-edge
Date:   Tue, 17 May 2022 09:01:11 +0200
Message-Id: <20220517070113.18023-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220517070113.18023-1-krzysztof.kozlowski@linaro.org>
References: <20220517070113.18023-1-krzysztof.kozlowski@linaro.org>
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

glink-edge node does not have children with unit addresses:

  sdm630-sony-xperia-ganges-kirin.dtb: glink-edge: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index b72e8e6c52f3..8e32eb3ed599 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -2158,8 +2158,6 @@ glink-edge {
 				label = "lpass";
 				mboxes = <&apcs_glb 9>;
 				qcom,remote-pid = <2>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 
 				apr {
 					compatible = "qcom,apr-v2";
-- 
2.32.0

