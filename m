Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484F64EC55C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbiC3NSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345825AbiC3NSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:18:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D930730550;
        Wed, 30 Mar 2022 06:16:16 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c62so24376627edf.5;
        Wed, 30 Mar 2022 06:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L9ZZEhaB4N93rT956KgttYvh8XmyGyWfb74vWE/N9yo=;
        b=OxCSsGJvh77imEAynSgD8C33TMeAri1Abo+xALPCW7rcixxwbhQ2Z74hwde1y40w3k
         z3fVY6Ye3uBfzDib/JTI1Vcpz3KWrS3sZxGtqrkNweTTUh0A1rS1AwDvQyN5m29wFzr3
         233qyJgruVGJFrItJXNy//gjHN48XlEc0ErcyUVmRAo6V1YTtrFc8TJNV2q2GeZZtMdC
         gPwUIrPwSMEl0f1r9lQacTHI9jTyzpLAREhVhlQQSZ4Qqgl1xjSkEjqHMYAM0cAqP1bh
         mChICRwOMldaGtUIw/L4U82ozmcGZfaTtxZit2CAibTQQJcBgV7N+PV37RikNTiklutW
         WJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9ZZEhaB4N93rT956KgttYvh8XmyGyWfb74vWE/N9yo=;
        b=Bv2jjH6OqT9ZNGWNafadWVMtzHn53iUWzQep9IJcWAdanIMVvuKLbpuK40pbPFlC1/
         vW1C/Np6LA/DF9lD9DVGffipeuczWy62BFbjaqEfzn1RyHtB5JbYoHnVrnLCx/oTd5T6
         jXFJ4dIfu4S0pcXAqAKsiLNXZZLO9/frf9ztQFJJLUSv7jWfhsaOVt7j3me0NjdS5lyK
         ZtyP4WKNIx+2yxAYoFufZ+JySHr29+HKdQE/MYGEtgwtDhk1/eB4kujLjW7r0bN+KUNn
         KOBOb/lcetKUrCkGS2zmHBjljn4BCpXgm4FMT/8CeoesWiJkuI8FxqXtfX09ymJaTx0E
         8uBA==
X-Gm-Message-State: AOAM532XwEmI97mGtX0Y+1MSWTxqiBbHFa1Cfm7Lx/wMTf9VGa88QA+w
        aJtXGdTjoTCJM4moTDacAfU=
X-Google-Smtp-Source: ABdhPJzlLbsJKtH5PEczO5sFv3FiGYYMNpOjYnwx10oP6eTlECgWSBh06Txlx+WEhmHQTw1WiVZy3Q==
X-Received: by 2002:a05:6402:54:b0:419:9b58:e305 with SMTP id f20-20020a056402005400b004199b58e305mr10545849edu.158.1648646175361;
        Wed, 30 Mar 2022 06:16:15 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ge13-20020a170907908d00b006e09a005d73sm6603476ejb.31.2022.03.30.06.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:16:15 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] ARM: dts: rockchip: add clocks property to cru node rv1108
Date:   Wed, 30 Mar 2022 15:16:07 +0200
Message-Id: <20220330131608.30040-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220330131608.30040-1-jbx6244@gmail.com>
References: <20220330131608.30040-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocks and clock-names to the rv1108 cru node, because
the device has to have at least one input clock.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rv1108.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 448254906..eceaa940b 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -456,6 +456,8 @@
 	cru: clock-controller@20200000 {
 		compatible = "rockchip,rv1108-cru";
 		reg = <0x20200000 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.20.1

