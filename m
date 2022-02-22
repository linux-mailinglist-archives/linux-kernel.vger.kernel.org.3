Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D28C4BFB91
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiBVPB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiBVPAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:00:53 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC9C10EC54
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:00:05 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 265AE407BE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645542002;
        bh=4OhXJxblf34wMx5+uRUs16cf2JFWMcvDQKlBG/4EIbg=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=p+wnGLCvsbOb87QeTLqlZB/v/Ve2mBRK/rWPGaMxid57TPQTwUXU52BihKhfeUu8l
         wRysbcIKNQjk1AcRKjsLPVLZywKZ+y3istht4WZThF2H1ClKQzECZAue9SZJpaIIir
         62am/OgW3f8Cwg+UGJk7U4QkAHn20cumLmSCXZaBuoRznCZEcCqqaL6ZUa8zrYDTVh
         fDxZlH0O6TJAWexitvJ3fKDJXZPgS1rovZLHLBAgmP4ZXeDrPfzBds+VlKRlyLpU7w
         7oiMspBZogpqf2vMz7TX7Chz8sy7sSTTLeYo4aZPGOEGesn0kzXjmaDr4PoPU6JPLh
         NpcHGp37ul2IQ==
Received: by mail-ed1-f70.google.com with SMTP id eq13-20020a056402298d00b00412cfa4bb0eso7279347edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4OhXJxblf34wMx5+uRUs16cf2JFWMcvDQKlBG/4EIbg=;
        b=PB1hfa01Esj3gHUq49olVDH1e6VjbWgvsAPVG+KVhbXKFRzonFIVpPdZ6hS09Cr7Jf
         f1hnxljsRGbLgRn+Y/s6xNP6n+6vYM3357ayRhHcq7+kZ5W01IyhHbDKf4IlZbzRTMyR
         f6oFcyZx57PmOSqHaacblGOeEt0eQGa/tVg2oOE+GZ7hD3Cv26x+rfOE1Ymw22IOs6FW
         sosd2I6lB1PT/GiNioG0m922fXZxmu3x7QSRyTS6h9PW8HZH+Az/OXixUQgcKeyrtq8D
         wcvBpdRmDIjQL4E9IpFiiRDKIGyW+AgNKdcA6NTVrtIifBVbNYJfNyo2bbPZFZqrHF4d
         7IOw==
X-Gm-Message-State: AOAM532jjblbAXpixTiLQgYqQCgnCV1cQdwYKNHCWXrdMaqB9mwdftfk
        f51HkoAUeMrUArjEwu7R5I1vFuBAYBPaYZKaXTSQ7DzrrmTR4aIwghlc1JAtLJyuMZBnpZDkg/L
        pkPV4LYcsPIpMbZ3pc9/vlpxbDUAYzKhTcL0Z/tt12w==
X-Received: by 2002:aa7:cd81:0:b0:410:d64e:aa31 with SMTP id x1-20020aa7cd81000000b00410d64eaa31mr26939014edv.167.1645541995665;
        Tue, 22 Feb 2022 06:59:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyaJdWHb8xk+e2xSEaK1p8tjIOgBKlnOjh9riknUovYkgJh1fsrFc3SbrR3EFVhnzBs85hG8A==
X-Received: by 2002:aa7:cd81:0:b0:410:d64e:aa31 with SMTP id x1-20020aa7cd81000000b00410d64eaa31mr26938989edv.167.1645541995521;
        Tue, 22 Feb 2022 06:59:55 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id m2sm2467960ejb.20.2022.02.22.06.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:59:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jan Kotas <jank@cadence.com>, Li Wei <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 10/15] arm64: dts: hi3670: use 'freq-table' in UFS node
Date:   Tue, 22 Feb 2022 15:58:49 +0100
Message-Id: <20220222145854.358646-11-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'freq-table-hz' property is deprecated by UFS bindings.
The uint32-array requires also element to be passed within one <> block.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 636c8817df7e..754b3a66ec0d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -671,8 +671,8 @@ ufs: ufs@ff3c0000 {
 			clocks = <&crg_ctrl HI3670_CLK_GATE_UFSIO_REF>,
 				 <&crg_ctrl HI3670_CLK_GATE_UFS_SUBSYS>;
 			clock-names = "ref_clk", "phy_clk";
-			freq-table-hz = <0 0
-					 0 0>;
+			freq-table = <0 0>,
+				     <0 0>;
 			/* offset: 0x84; bit: 12 */
 			resets = <&crg_rst 0x84 12>;
 			reset-names = "rst";
-- 
2.32.0

