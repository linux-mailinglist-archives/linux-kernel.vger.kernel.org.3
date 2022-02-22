Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7F94BFBA7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbiBVPBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiBVPAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:00:41 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2807610E555
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:59:59 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 045AC3FCAF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645541998;
        bh=AXkZYdVX5Zodn+3WZgtIGj/ZSa6Qs/Xzl3ZJQ9geNsQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ENcy3AYPdFcEFGtoER2h5QD3vZwZM6W1hH+bG1Hfkvrl8YAgoLoQZeDu/1HfyKAqM
         iIpWEyV4woCcTKPT9Jj6gzfW8kWpCZhGQyFUM82owgN5jFG7zJDoYPYv2KE69Zy8bV
         9iDMfGXnCTHczEOTaB0fv7pMJTdLW+27uxLFxhABckSZBXlHvB8+ko3phuDbrD3D9L
         pyMTLcthx2y2ImjAxpBEsWBMa8APk+Ys3mWeA/HO3W7r26EEL9S/jaAC4k/JYbXToA
         bOd90q9E3dQF4ZpHkSmHD81r9GCWyg2NCr8khrb64AkY3kk1RbcMQPyEcbz69XBK72
         e8NSrgfrj+54w==
Received: by mail-ej1-f71.google.com with SMTP id d7-20020a1709061f4700b006bbf73a7becso5862693ejk.17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AXkZYdVX5Zodn+3WZgtIGj/ZSa6Qs/Xzl3ZJQ9geNsQ=;
        b=LRjhSyeuPAhNQ8y3emO7Wd9bXoRdy/R3hUP9/1guoJtUkG2dHSv9jwaMfE1foD5GTT
         535+Nw1qz1sii/QWxMY8Fh1MvPMwvGP9j80ulJ2eWmP+pU1XzjPqwBlzXGXOOIrKnFU1
         C1K9BkdOAK8PrRCszbS3Z3/DU5RqrRbgCqS8uJ1H+QDiKm6CFn8GiXjZg/+pRxkUCzBA
         IlY9Y1tQqnIeqII/n2LFbL3aboSjdE/qRYe9ag56+dUp+dOsoDU3P+tPS58PBsbiEKQ2
         VIYlIC0PaATanwy/Vp27DRhlRR+pu6/w+LB8a6vhd/6nADzT+YiTJdtkdTfpBEbHiIAw
         6Upg==
X-Gm-Message-State: AOAM532LPqumz+EVtY1h2h7XZ3lBSH8qS2mrmqck0+aeLdlRylNZprV9
        WwNLirobFb+lEBwKXkrsysdMi8QmbqPR8gG6FE7LcbrUuhL+IZ0Z7w2EKIt5TKUrI/nJFAtC4ti
        T2q55ifaPZ8xeA0wBc8/0VvCL0tlUr0W+I6XUehoccQ==
X-Received: by 2002:aa7:c703:0:b0:410:b96a:6bf with SMTP id i3-20020aa7c703000000b00410b96a06bfmr26705735edq.439.1645541997724;
        Tue, 22 Feb 2022 06:59:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfSFtNX/a3KL4lHPEAhSPb3vHh30FiudcrzDoMBrPmGyj5vo81xOj/2DV7Q8M391vFSdj/vQ==
X-Received: by 2002:aa7:c703:0:b0:410:b96a:6bf with SMTP id i3-20020aa7c703000000b00410b96a06bfmr26705712edq.439.1645541997526;
        Tue, 22 Feb 2022 06:59:57 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id m2sm2467960ejb.20.2022.02.22.06.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:59:56 -0800 (PST)
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
Subject: [PATCH v2 11/15] arm64: dts: ti: use 'freq-table' in UFS node
Date:   Tue, 22 Feb 2022 15:58:50 +0100
Message-Id: <20220222145854.358646-12-krzysztof.kozlowski@canonical.com>
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
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 599861259a30..34aff40c6b8e 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1257,7 +1257,9 @@ ufs@4e84000 {
 			compatible = "cdns,ufshc-m31-16nm", "jedec,ufs-2.0";
 			reg = <0x0 0x4e84000 0x0 0x10000>;
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			freq-table-hz = <250000000 250000000>, <19200000 19200000>, <19200000 19200000>;
+			freq-table = <250000000 250000000>,
+				     <19200000 19200000>,
+				     <19200000 19200000>;
 			clocks = <&k3_clks 277 0>, <&k3_clks 277 1>, <&k3_clks 277 1>;
 			clock-names = "core_clk", "phy_clk", "ref_clk";
 			dma-coherent;
-- 
2.32.0

