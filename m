Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2356048F63F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 11:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiAOKFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 05:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiAOKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 05:05:02 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C53EC06161C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 02:05:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso11453093wmj.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 02:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SmIvaKVJpa7yVKiGXJIL8KCxvXNwvqsGPKKzQt3K6BU=;
        b=x4VQRcH2nW2aLs3d6CEDT2zv7VcCvNnEHvU7pqNtn+7u3LOfLFXH5gebIgySCiDZmI
         WZwJwpVZCIMPYFYAqz4lq9E2GPXOcFkzyp6+s/MWhMpxyAYfizNqI0DWoxq97Ds72WAt
         xH/qqFexfb3L8OGbSfV4NgEB0K3IT3GqI3o3U0tFJLRXF7qTE8CQFKczJEDjWpypJeP5
         odYP/fBWH7GDF/tbtLkXRmAmlhkPnqSTrpmowgBhRtbLmzU7L2B/ifoeYwLx/dRalZu+
         NnGvdi539PNChMmJOcYDHQD7woa4/23XNEk6r/LgI0LyqSdiVG5k+a6hsxtYYQVCrPoD
         1fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SmIvaKVJpa7yVKiGXJIL8KCxvXNwvqsGPKKzQt3K6BU=;
        b=Ampyijf7F+G3loInxw/IGyuoe35U+bZzykinOumKdObMl4gLfxV8fTFJAET0xYi38Y
         ydFQCq6Yro2vwFQJMPNz8E+V7gJ9R41QZaio5im1yohKUS5eLezRroFyDL/5Cd2n94el
         e19W22S6crKYxPd3wKCtISNEnaE0KuuNBuaJ0U2bVjjhbKlpjWZcz/mT12sQxwogtAsU
         xgxrbD9HBCKq1jQNjd4mfhgOggsqkSGnas1fjuRdNL+AtM/KWYmHNSKwCHOvJB2EsIt1
         YIlmE2dAHqqXb6NwDSii1cKa2ZCFYfWbxClNNut105iArRT21Ra7zqNgvPWDh3lJ3JgP
         SyFw==
X-Gm-Message-State: AOAM530rkP5j/axS9CJzPEPqn0fW4GqRAx6QDnEaXSYfxGON9Qbx1zfL
        uRD8qSFSB39WgkU40s3aj7U10A==
X-Google-Smtp-Source: ABdhPJzrJOn5bv7wFJqrwa0GQY7f+HQ5ySj7zlppo7hdtWES7w/BiMzziFahDDCxsmqHPXWLOL8JFw==
X-Received: by 2002:a5d:47c2:: with SMTP id o2mr11698346wrc.73.1642241099788;
        Sat, 15 Jan 2022 02:04:59 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n8sm9110356wri.47.2022.01.15.02.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 02:04:59 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/2] ARM: dts: gemini: ssi1328: permit to use gigabit
Date:   Sat, 15 Jan 2022 10:04:44 +0000
Message-Id: <20220115100444.3014823-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220115100444.3014823-1-clabbe@baylibre.com>
References: <20220115100444.3014823-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believed that gigabit was not working due to unknown missing GPIO.
But the problem was due to Marvell PHY incorrectly setting delay.
Now it is fixed, gigabit works.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/gemini-ssi1328.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-ssi1328.dts b/arch/arm/boot/dts/gemini-ssi1328.dts
index 113feb1c4922..bb85f1febe9d 100644
--- a/arch/arm/boot/dts/gemini-ssi1328.dts
+++ b/arch/arm/boot/dts/gemini-ssi1328.dts
@@ -40,10 +40,6 @@ mdio0: mdio {
 		phy0: ethernet-phy@1 {
 			reg = <1>;
 			device_type = "ethernet-phy";
-			/* We lack the knowledge of necessary GPIO to achieve
-			 * Gigabit
-			 */
-			max-speed = <100>;
 		};
 		/* WAN ICPlus IP101A */
 		phy1: ethernet-phy@2 {
-- 
2.34.1

