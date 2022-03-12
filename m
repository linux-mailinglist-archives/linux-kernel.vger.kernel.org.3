Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9552E4D704D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 19:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiCLSHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 13:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiCLSHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 13:07:31 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4004071EE4;
        Sat, 12 Mar 2022 10:06:25 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so10934713pju.2;
        Sat, 12 Mar 2022 10:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rg+SMFQ7I6btufFbQp88Hcx5Wyx4dzXyqKTTiQmvp0k=;
        b=RQvjp4ycwxIQwR2GBMP9qI1VmQoyYIfRKVaysG/rk2FXb6x/IlpVdi32uOnlSd3XTh
         EgduNBzRR9eZsOtgO42eW56lPYAP23OoBLGah1SzFCO8pikykHakY37ewwKPGNCR0w3U
         ff0pyrNivvpmD/M2Fqnf/ztr7CbxDdRBpglFZmakKAWBJqI2xF3Tl4XG/l0B6GQHEr74
         iS/yZCWv7NgEnpiEmXQGm7FibHx/UGgXGqH6iGGj6oLUzxt9Cv5DMl/kHk5nQU/nnORC
         tDf7FWdceMPVaU9U/eT6BmcgnXv8Y5tgtrkBNv8nHCUdDAZSf8NPivEFrQgi0zIx1oZO
         kcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rg+SMFQ7I6btufFbQp88Hcx5Wyx4dzXyqKTTiQmvp0k=;
        b=fIrVh1xr5S1LqQ4H46LVipMNxCamgZmYrQePAvfiGvgDXvTpKRiWz5M/plTh/imc2N
         mWmAK93n9KgZ7I+zNhi4uazePTG2/UOLXDSIo+gyAVrk6WjzKTX/540blJ/4a8Kj+ULK
         FJIKHNt2QmsJBpcS32sVexK4vdWPOnPUCT7hOB+6H4Ex9B0oLgRrCmsEHMhO+T/77n3j
         XfvaR8YEoi7bBIqJpJjHFIjhNL9awXEKxKVpPvLve5eB0DK1LjNZZ24Axj3BhOiKjufI
         HvqfB93X8vk/iqr+cv8JzKQ/HgNOfG8LUPxZmfJ0XAALXs3i4v+yzewlQx9e1m6qJJb0
         CxJw==
X-Gm-Message-State: AOAM530GAu+lsONEts57ElAmB0vSUMCq2FdVLVuDJGlHmBONswbwhcF2
        zNlAvWU81TqK3u2NJwXsvOmr+CIAHZM=
X-Google-Smtp-Source: ABdhPJyh5JaL7NhXCYJ+47rVd51aiB32DpTuUTxS95UI46CPhXiHeb55UFRusMqFam5ZCHkpGYRVzQ==
X-Received: by 2002:a17:90a:5291:b0:1bb:ef4d:947d with SMTP id w17-20020a17090a529100b001bbef4d947dmr27752846pjh.243.1647108384583;
        Sat, 12 Mar 2022 10:06:24 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id z72-20020a627e4b000000b004f70cbcb06esm14017951pfc.49.2022.03.12.10.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 10:06:24 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: spear13xx: Update SPI dma properties
Date:   Sat, 12 Mar 2022 23:36:14 +0530
Message-Id: <20220312180615.68929-2-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220312180615.68929-1-singh.kuldeep87k@gmail.com>
References: <20220312180615.68929-1-singh.kuldeep87k@gmail.com>
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

Reorder dmas and dma-names property for spi controller node to make it
compliant with bindings.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm/boot/dts/spear13xx.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index c87b881b2c8b..45f0b2a33e02 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -284,9 +284,8 @@ spi0: spi@e0100000 {
 				#size-cells = <0>;
 				interrupts = <0 31 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 4 0 0>,
-					<&dwdma0 5 0 0>;
-				dma-names = "tx", "rx";
+				dmas = <&dwdma0 5 0 0>, <&dwdma0 4 0 0>;
+				dma-names = "rx", "tx";
 			};
 
 			rtc@e0580000 {
-- 
2.25.1

