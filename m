Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E52514497
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355880AbiD2Ip4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbiD2Ipy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:45:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8942EA7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:42:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p18so8246936edr.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJkVawFXvwQH7kz0CHPfmxuFkQ6+ipcLhCSvCaul0jQ=;
        b=HSFxl4yM5hEns1ZYq8D5pL88/nYNfulhELpJyhaF8XIrymlck2o40/lATRsLIEWMyb
         8MiL8d5eAOEMSb7rUrqWodLDPZld7ZzCvoVt6XQeVmJLkAw0teNdQXvlCZgu/3Q6MwUw
         Wx+QkzqUjCODOLk224RVZGvnKY9YRu/WmZEnWqBjzQIF90DLNXyni+yS7XbUn8CnPbdM
         M3s/Ty7YsgPGsibKem1EI6yma15sXRNi1Vz1o0ArcPpsB/6x/ym8sCQemxSvrmer5ps9
         wrBnmlH558mrlj7rSHK9l5SmsGlkJiXB3DTLSrnynxHTY9gX9lSBsQxxjiqu1sEMvDVY
         toUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJkVawFXvwQH7kz0CHPfmxuFkQ6+ipcLhCSvCaul0jQ=;
        b=kNpDbgJVtF6aoo0+1rxO21SohfxF9mWe5PkpAdPISledgWc3fbLrtc7kc/2Byq3pwU
         o1VsAxkIIOMbui9mYcrH0T7cX8fFh1JULQZGR0ou/tqsAvULy7+wlGCPUvl+NOIYydWv
         is1aFacyJN/efT3+4nY7IhTRZt/sjXcSt7jlV4cFIb8DnssAfCrQZ2CEetvOgXgEw8x5
         TzEoqFVM4FZ5pB1/IAIjRABSjmEcNTI08rNf6IGxWKH3rh7EozZJBsBIlAPtouHwTRRi
         hLjEgyv3bl/Sv6dPcJWgy+3wTWTdUFQJJ+a5yd26d1doq6AcjZZNynsKy6qvP8g2lesQ
         6GYg==
X-Gm-Message-State: AOAM5309sAFAamygADrva4EejMclhDjd6zuAVPTs1CNRdYW32yLOMSrV
        zTteqwOxuKyburrUQQenXA==
X-Google-Smtp-Source: ABdhPJxU9goI5zXE0GQP90hO7TH0IDw++6UHpkGFSUH/chvzvE0L/pQF0XqDkdwzbbTmxsOBUMGcZg==
X-Received: by 2002:a05:6402:84c:b0:423:e5a2:3655 with SMTP id b12-20020a056402084c00b00423e5a23655mr40374113edz.28.1651221752304;
        Fri, 29 Apr 2022 01:42:32 -0700 (PDT)
Received: from crystalwell.adg.lan (a109-49-0-175.cpe.netcabo.pt. [109.49.0.175])
        by smtp.gmail.com with ESMTPSA id el10-20020a170907284a00b006f3ef214e32sm429064ejc.152.2022.04.29.01.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:42:31 -0700 (PDT)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, ryder.lee@mediatek.com,
        daniel@makrotopia.org, Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH] arm64: dts: mt7622: specify the number of DMA requests
Date:   Fri, 29 Apr 2022 09:42:25 +0100
Message-Id: <20220429084225.298213-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT7622 device tree never bothered to specify the number of virtual DMA
channels for the HSDMA controller, always falling back to the default value of
3. Make this value explicit, in order to avoid the following dmesg notification:

mtk_hsdma 1b007000.dma-controller: Using 3 as missing dma-requests property

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 3d6eaf6dd078..5551f004945b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -924,6 +924,7 @@ hsdma: dma-controller@1b007000 {
 		clock-names = "hsdma";
 		power-domains = <&scpsys MT7622_POWER_DOMAIN_ETHSYS>;
 		#dma-cells = <1>;
+		dma-requests = <3>;
 	};
 
 	eth: ethernet@1b100000 {
-- 
2.36.0

