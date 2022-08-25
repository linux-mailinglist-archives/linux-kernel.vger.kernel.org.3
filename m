Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036F25A16C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbiHYQiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiHYQiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:38:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575DCB9F88
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661445487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wHBvwoMalP4JkIrKUYzLNQpQCPRkdCcMetm62WKyV70=;
        b=FvLu7lO0ZM/6/BrLMcXqzFKxM6gVkpkPBjYzUc4lg+MQeNaS00RzM/qwdHrAAiOtIMyaTy
        52CNFO/NH57uJUZdJVPKtQjlnRjuHduQ3zZw7fa3QwVfY1CpCKmgj+gPfvVTG11SINnhg+
        EfI2Hvgvg9WtcIWxvEPDov2xwKu7jC0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-SM7lY8_uNVqHIzo_Ki6nNw-1; Thu, 25 Aug 2022 12:38:06 -0400
X-MC-Unique: SM7lY8_uNVqHIzo_Ki6nNw-1
Received: by mail-qv1-f72.google.com with SMTP id ea4-20020ad458a4000000b0049682af0ca8so12197238qvb.21
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=wHBvwoMalP4JkIrKUYzLNQpQCPRkdCcMetm62WKyV70=;
        b=Aq1Daxwe2jFL/7HSm9enAztXYK/ZtLgZj30cPFhHbF3oTL7PguQEX6ZCn0xQvc9EDY
         DP5PlGY6LE0c9nJUdjkGvDsL3EIJilyvutYIzjKFE0ZuzIIVqvBBYqSz6CnLZFUXY8dQ
         hguiChE7xtmgYkKp2KbhKad0jNBbeZyMMBlLpck1Dogl49S43u1RH0GRZ3/z3z8e/MOi
         V3Z+PYLxe9DKJRQCpOS19cVKgb+bil93Q/WWXsz9vjieFheo61g/DrChZ1YjjIwq3FW0
         xWDcXwXy0YlG8O7sXCBxtq1XY1W/m/1axM50iEgt9NJV8Yis1ttUxCW8stJ+O9wY67W5
         fvWQ==
X-Gm-Message-State: ACgBeo1AmoX7uKm+V8hyaR0rPjRaBBCjKABU2123CAh7ciKjK4jpKGnF
        x3xlopdic+7qh0lxWsq3ffg6j8QQzPlKakNOhtLZ9Xm+aKb0pEjwe6XIqfJjJMdTZOiiiQHQixy
        cQU2O6xEmJLZ2V90DnPgcUMu5
X-Received: by 2002:a05:6214:4006:b0:48d:3f52:52e7 with SMTP id kd6-20020a056214400600b0048d3f5252e7mr4245949qvb.113.1661445485412;
        Thu, 25 Aug 2022 09:38:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4AMzIB1MVesZLd1jTiFIVhtyRBdbIE4HGHoHVZClnHnZjeWAdOLo/bBWgmWCpuEVz3RrVSHA==
X-Received: by 2002:a05:6214:4006:b0:48d:3f52:52e7 with SMTP id kd6-20020a056214400600b0048d3f5252e7mr4245928qvb.113.1661445485189;
        Thu, 25 Aug 2022 09:38:05 -0700 (PDT)
Received: from xps13.redhat.com (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id u9-20020a05620a430900b006af08c26774sm18240952qko.47.2022.08.25.09.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:38:04 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: [PATCH v2] arm64: dts: qcom: sc8280xp: correct ref_aux clock for ufs_mem_phy
Date:   Thu, 25 Aug 2022 12:37:55 -0400
Message-Id: <20220825163755.683843-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first UFS host controller fails to start on the SA8540P automotive
board (QDrive3) due to the following errors:

    ufshcd-qcom 1d84000.ufs: ufshcd_query_flag: Sending flag query for idn 18 failed, err = 253
    ufshcd-qcom 1d84000.ufs: ufshcd_query_flag: Sending flag query for idn 18 failed, err = 253
    ufshcd-qcom 1d84000.ufs: ufshcd_query_flag: Sending flag query for idn 18 failed, err = 253
    ufshcd-qcom 1d84000.ufs: ufshcd_query_flag_retry: query attribute, opcode 5, idn 18, failed
        with error 253 after 3 retries

The system eventually fails to boot with the warning:

    gcc_ufs_phy_axi_clk status stuck at 'off'

This issue can be worked around by adding clk_ignore_unused to the
kernel command line since the system firmware sets up this clock for us.

Let's fix this issue by updating the ref_aux clock on ufs_mem_phy. Note
that the downstream MSM 5.4 sources list this as ref_clk_parent. With
this patch, the SA8540P is able to be booted without clk_ignore_unused.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Fixes: 152d1faf1e2f3 ("arm64: dts: qcom: add SC8280XP platform")
---
v1 of this patch can be found at
https://lore.kernel.org/lkml/20220623142837.3140680-1-bmasney@redhat.com/T/#u

Note that there's also a similar issue with the second UFS controller
(ufs_card_hc) since it separately fails with:

    ufshcd-qcom 1da4000.ufs: Controller enable failed
    ufshcd-qcom 1da4000.ufs: link startup failed 1
    ...
    gcc_ufs_card_axi_clk status stuck at 'off'

We are currently disabling the second UFS host controller (ufs_card_hc) in
our DTS at the moment. I'm still looking through the downstream code to
try to track this particular issue down.

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 49ea8b5612fc..4117ec0ffefc 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -892,7 +892,7 @@ ufs_mem_phy: phy@1d87000 {
 			clock-names = "ref",
 				      "ref_aux";
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
-				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+				 <&gcc GCC_UFS_REF_CLKREF_CLK>;
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
-- 
2.37.1

