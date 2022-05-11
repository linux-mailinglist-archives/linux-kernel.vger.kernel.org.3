Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E07523697
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245341AbiEKPCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245507AbiEKPBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:01:23 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FD833A2D;
        Wed, 11 May 2022 08:01:23 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id k2so2189268qtp.1;
        Wed, 11 May 2022 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIuqiJ1KMfrOcWNf9PXlKzJzt4BdNRB8d9UpwdKjhTg=;
        b=NCzkQwFBqTgjN2haflpZFtU9ln1qti58wlBmjyabCDEnIDABpqWN8KKc7Yk2dl5r9b
         G93UPkCXT+ez1IHFaJc+8wWsjnhKlFLJeHrI95UcMYb1nyYOZiobATYkSSehWO3vCLPM
         WXL3tQA3nAYzkTD5Hb0uJLv6oQYtF0IeAUd7iMX1nKkAzBBCKnogIQR/tPiTbkCprLGD
         bgdHz4IxIx+czXjSNaEoRLcw6b3ZLNrYpLKvzV63rTRA+w4R6NAHqop5JsMq/hIjG3ph
         ViX94MBP4Fc+DPjGDZAZcCS/2eaRDXpfPdn7uYMlraELnbTwnW0pUYN4yxy4tz9MnWCj
         F4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIuqiJ1KMfrOcWNf9PXlKzJzt4BdNRB8d9UpwdKjhTg=;
        b=pYS77Om+QvZv6dcSyMOMfwLWy8tSduE3dxNlt+GF6Z3nciDb3UsZFjuVmejWOLLSjb
         zykOq4poCmQJ4swiFRW/t4ryWhUi/05kwOLrMwGmFRbGEQUxG2HRJVVaR3RmryPdffmN
         fqtASuy4tAJNh3u20VzmdlNZfJdGxsXQQMLPWMqEBbWE8upxgBL07RZdkJCkgmhK11JH
         f6uTEIqrYBKCrDJmy/zVaiHziCxecO/7y8h6uPWz2hp+EEtj8iX48lV/fgwwHRMFl2ao
         GWc7qLdq2SRnihvyIjggiiv9vozxNQYJU7EwzCsgp3wOJIIUm/8ykHExcm8jVc+G44aH
         VDKQ==
X-Gm-Message-State: AOAM531g78UgzjDqYYXDa1ltXYJJ5b8DY2DUenSbyu+BOMR6alzODWms
        X3+qi1jSKQQuZWTTh+MI4Jo=
X-Google-Smtp-Source: ABdhPJyVrJE9bBpSUy3Gw712E094ZqLK5sBcNBbpE1kENODFBSPxCFrfFyw5qfMfgH/qBnxn71/cog==
X-Received: by 2002:a05:622a:4ca:b0:2f1:f386:4377 with SMTP id q10-20020a05622a04ca00b002f1f3864377mr24510020qtx.156.1652281281906;
        Wed, 11 May 2022 08:01:21 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id h1-20020a05620a244100b0069fc6484c06sm1487134qkn.23.2022.05.11.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:01:21 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 2/6] arm64: dts: rockchip: add clocks to rk356x cru
Date:   Wed, 11 May 2022 11:01:13 -0400
Message-Id: <20220511150117.113070-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511150117.113070-1-pgwipeout@gmail.com>
References: <20220511150117.113070-1-pgwipeout@gmail.com>
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

The rk356x cru requires a 24m clock input to function. Add the clocks
properties to the cru to clear some dtbs_check warnings.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 7cdef800cb3c..fd9e8a854328 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -336,6 +336,8 @@ pmucru: clock-controller@fdd00000 {
 	cru: clock-controller@fdd20000 {
 		compatible = "rockchip,rk3568-cru";
 		reg = <0x0 0xfdd20000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 		assigned-clocks = <&cru PLL_GPLL>, <&pmucru PLL_PPLL>;
-- 
2.25.1

