Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17515A6B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiH3SCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiH3SBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065EFA2238
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661882492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=B4ruO31PHkrlH5v1gXJkpOHPSYcHLtyneSEzcjXO5Ho=;
        b=DlMZGshwcN4/i4+370XO/DBPIkv3yM5skJYtQlgnMiM4KAcWw7YARrBtiVMBSD/akh/iuH
        dM690b85iVZ+1l48CgSku93jhpwHbe1jTdxe186+Wcd8vcX2MgO30O6HdoRCBApuvc3PZ8
        KwbsqNo58gmPw6zlRrpO1Gv7tjpYSQ4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-247-f7wFDy8dM4CXZ3KMd9RupA-1; Tue, 30 Aug 2022 14:01:30 -0400
X-MC-Unique: f7wFDy8dM4CXZ3KMd9RupA-1
Received: by mail-qv1-f70.google.com with SMTP id d15-20020a056214184f00b00498efcf3965so7182604qvy.15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=B4ruO31PHkrlH5v1gXJkpOHPSYcHLtyneSEzcjXO5Ho=;
        b=sT7wR2p6IKd8kqY1+wFrq+wEQrHHLdt+UGf2zVMFTD0IuP/e4eN2/LTJnEb3Wqa9aJ
         Oyd+WWLHY4edO/QyqA8maKxKUC4/gHLpe+6ykdF9uptpcblEyEYo91kXeiB9PMnzUvsh
         KENZtUaB7nK1AVGMVMZY6/XdEcKAQesJ6ftvjsuOuSZBVmyZF5ICY4ia2X9TR6uEoAmd
         raDBR7GdRHduBnSonqIOTx4b8AOcb6fHwK99aZv+jcXV+9+IvLk5uq7QqnBGUx4XDmo8
         q62gWH9lifeQRNm/HNVi3tkEZvKyS6SNori4ziYkvJSaJoIayjwfB/N8UWEo/ePtynHG
         Bltw==
X-Gm-Message-State: ACgBeo1/fa+gJvmUlv04eO0w7Vh0AdTpJsClTI4VxyIhCSeTAnkYDIj1
        QYGyMuwVhceilCCjiBKHWcvh6nyDraSPXdGlEkoMDLGEPVinD/8clgaVuULY86XOrKLLGezSCB6
        DcaYo2YLQqRJbdAX2I64eh1Lr
X-Received: by 2002:a05:620a:2452:b0:6bb:d8ba:ca65 with SMTP id h18-20020a05620a245200b006bbd8baca65mr12862210qkn.263.1661882489883;
        Tue, 30 Aug 2022 11:01:29 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4FDpHPGTAEXt4hym2rCFYYguOK7NgS2axRiD3nKOflngOJy2QWn639ZrCJ/MLxORdMitK6Nw==
X-Received: by 2002:a05:620a:2452:b0:6bb:d8ba:ca65 with SMTP id h18-20020a05620a245200b006bbd8baca65mr12862167qkn.263.1661882489395;
        Tue, 30 Aug 2022 11:01:29 -0700 (PDT)
Received: from xps13.redhat.com (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id bm2-20020a05620a198200b006b5f06186aesm8599670qkb.65.2022.08.30.11.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:01:29 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: [PATCH v3] arm64: dts: qcom: sc8280xp: correct ref_aux clock for ufs_mem_phy
Date:   Tue, 30 Aug 2022 14:01:20 -0400
Message-Id: <20220830180120.2082734-1-bmasney@redhat.com>
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

Let's fix this issue by updating the ref clock on ufs_mem_phy. Note
that the downstream MSM 5.4 sources list this as ref_clk_parent. With
this patch, the SA8540P is able to be booted without clk_ignore_unused.

Signed-off-by: Brian Masney <bmasney@redhat.com>
Fixes: 152d1faf1e2f3 ("arm64: dts: qcom: add SC8280XP platform")
---
v2 of this patch can be found at
https://lore.kernel.org/lkml/20220825163755.683843-1-bmasney@redhat.com/T/#u

v1 of this patch can be found at
https://lore.kernel.org/lkml/20220623142837.3140680-1-bmasney@redhat.com/T/#u

Note that there's also a similar issue with the second UFS controller
(ufs_card_hc) since it separately fails with:

    ufshcd-qcom 1da4000.ufs: Controller enable failed
    ufshcd-qcom 1da4000.ufs: link startup failed 1
    ...
    gcc_ufs_card_axi_clk status stuck at 'off'

We are currently disabling the second UFS host controller (ufs_card_hc) in
our DTS at the moment. I haven't had any luck so far tracking this one
down and it's particularly tough without docs access.

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 49ea8b5612fc..2bdde4b8f72b 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -891,7 +891,7 @@ ufs_mem_phy: phy@1d87000 {
 			ranges;
 			clock-names = "ref",
 				      "ref_aux";
-			clocks = <&rpmhcc RPMH_CXO_CLK>,
+			clocks = <&gcc GCC_UFS_REF_CLKREF_CLK>,
 				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
 
 			resets = <&ufs_mem_hc 0>;
-- 
2.37.1

