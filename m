Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03415AEFEB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiIFQHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiIFQHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:07:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360A798D13;
        Tue,  6 Sep 2022 08:30:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id az27so16025643wrb.6;
        Tue, 06 Sep 2022 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TzfY9hsKE+/NMaAr86KQtgckRDntIH8+oY7tsTfeowI=;
        b=G1z6RtYS4iEJ22psOaMaQE8+oWOg2j5Y9DvwtqNGc2mxRnXdrnKjzbDDwsi1XOqs3u
         xCA7f0i1vFUdiwAvNJBs7vOW3OzYBYcLQ3zdvjSq+fCAzXd6xHLCWep5vEPfapdH6yoR
         dZRiKmgypproeCw3VicU1D9DM3CP7n6xjPU2X05/OM6wgAnkJaiO3wib1Lx5gKI6YJ2P
         Q/xn34rJW5DgahH0BbGkfPfjGhGhhS4mpDPBnjBRwXq0RIckXs9eiHxxbusCVKMteVlv
         OO2qhBR1hXqVWzp9LYAtzMJrco4RupWBfPsHprVLdUpq6zB5idOiwd6QsB3i4OliAcJZ
         Nd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TzfY9hsKE+/NMaAr86KQtgckRDntIH8+oY7tsTfeowI=;
        b=udf4Xd4Z5cLLt/0BkdqTk3XpkpBXCdugKMaJiem4ccaXk8SBl7U8lhaGnlUgk8oeOF
         /6KrAPvKyO1c+bUVaEcEKk+N45Q06ASfhelGp7gZlCGWogKVrVXvdg2LR5mIz99BfR9J
         85IiQl8dbqtUTsaa5Yr4zi6UQzaJKw7J7PF2s4GsqlZnpi8RfehVjcod38toSrY1wJ5K
         m+5yBcM4Q3jMAH/YS4GIUeUJfe19B0RvqLpzJSVNyAPgu9LTl9nG2UkyM0FiW3RdSyAJ
         RgK6QOObejUz+ILWPcSrMNvRevTebAacqRRe3fDTeWOxnGvzurdK1InB4dPMXP+ozjAq
         yQKA==
X-Gm-Message-State: ACgBeo0FmEz+ZQ769//nQ6722xKoOa0uxEhVz1we6La5xWHt57a3MAUz
        Aowsn5sISfhsmirb+Vhs09E=
X-Google-Smtp-Source: AA6agR4fDTUAPj150MWqbk6q/AO0tVAXOO+fiKS6HJfjSQzIqcMzESayHrNPSB2h99kexJGm0WHKrA==
X-Received: by 2002:adf:e706:0:b0:228:61dc:3dfa with SMTP id c6-20020adfe706000000b0022861dc3dfamr8410720wrm.265.1662478238552;
        Tue, 06 Sep 2022 08:30:38 -0700 (PDT)
Received: from Clement-Blade14.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a6125562e1sm14922731wmg.46.2022.09.06.08.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 08:30:37 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 1/5] arm64: defconfig: Enable devfreq cooling device
Date:   Tue,  6 Sep 2022 17:30:30 +0200
Message-Id: <20220906153034.153321-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906153034.153321-1-peron.clem@gmail.com>
References: <20220906153034.153321-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Devfreq cooling device framework is used in Panfrost
to throttle GPU in order to regulate its temperature.

Enable this driver for ARM64 SoC.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 91e58cf59c99..e557ccac8d9c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -582,6 +582,7 @@ CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
+CONFIG_DEVFREQ_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_IMX_SC_THERMAL=m
 CONFIG_IMX8MM_THERMAL=m
-- 
2.34.1

