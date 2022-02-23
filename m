Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242644C0CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbiBWGsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiBWGsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:48:43 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91C16D954
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 22:48:16 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id x11so17788533pll.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 22:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQkdZuW0iA6F1PJub5RLw1uipDy5PXh4MjzK0bf9siY=;
        b=hSIfpUcfiVfbUpjcdyVn27CfwOqNaNAOPFUqfEtwR2tdtsLF7rjMv6QkVaDOTIoGOf
         PzaUpNZc6jDLAbbbT4J1Vgg9zoMZ7N6k/MbpJKNi3WHi3Nw1tE7JbK6tfXXb7wUsGE1q
         C4Y0uUI5PQnQV/M5ehevdPmj0la0z8/ZSufI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQkdZuW0iA6F1PJub5RLw1uipDy5PXh4MjzK0bf9siY=;
        b=Ok5RcGA3Ow/Qz27exZSq/keVlW/QouAHtTbj/RJc+fdcf7nhcjm1VnBMh8c3+s/6lE
         vTg71dXF7YfCDXc700Ixpm0SLomHw6Pp0NcrDY3XkT9EDEObN9cPOfeGYDJ83+817yG7
         OlonvjcjsdzOftisdPe+cTbrvPSfQNEbn5A5OCdnwEHIDeBxGbKsy7UmCeqlMd607xja
         yJHYW00KttUJ99EWHdg3GGf52Yf9n8nZd5ultQ7Fewx8RLJHxvUqutHBQI3VDkR7GbQZ
         ubVUC0rJGNhi1vv3piZpfnB0ksCBlka/LrhHYNYiz2hJPg5KJiw+lfcN71MD6bWWUqoa
         FzkA==
X-Gm-Message-State: AOAM533m3f6cVMkpl9DHpy+O7WRlxXJAiaxs82FnH5GGkf27EA3ybcte
        Hl4rODViIQERZ+AN0OyTrHTnfA==
X-Google-Smtp-Source: ABdhPJwUFStu9Ofd9ZOPhC4AtPbqkqCqBNCEWbWF5QovUpN5pg36B6khO4jl1hvh/aSGU4046f07QA==
X-Received: by 2002:a17:902:b490:b0:14c:da4a:deca with SMTP id y16-20020a170902b49000b0014cda4adecamr26788557plr.134.1645598896195;
        Tue, 22 Feb 2022 22:48:16 -0800 (PST)
Received: from shiro.work (p1206043-ipngn200715sizuokaden.shizuoka.ocn.ne.jp. [118.13.44.43])
        by smtp.googlemail.com with ESMTPSA id v17-20020a17090a459100b001b93ef45c13sm1621204pjg.55.2022.02.22.22.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 22:48:15 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org, arnd@arndb.de, olof@lixom.net,
        romain.perier@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] ARM: mstar: Select ARM_ERRATA_814220
Date:   Wed, 23 Feb 2022 15:48:07 +0900
Message-Id: <20220223064807.261878-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the SoCs that are supported so far are Cortex A7 r0p5.
So it seems like this errata is present.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Arnd/Olof: Please apply this directly if acceptable.
 I don't think we'll have enough for a PR.

 arch/arm/mach-mstar/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mstar/Kconfig b/arch/arm/mach-mstar/Kconfig
index 647355a94aa9..cd0e949a4f69 100644
--- a/arch/arm/mach-mstar/Kconfig
+++ b/arch/arm/mach-mstar/Kconfig
@@ -1,6 +1,7 @@
 menuconfig ARCH_MSTARV7
 	bool "MStar/Sigmastar Armv7 SoC Support"
 	depends on ARCH_MULTI_V7
+	select ARM_ERRATA_814220
 	select ARM_GIC
 	select ARM_HEAVY_MB
 	select MST_IRQ
-- 
2.35.1

