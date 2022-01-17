Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510BE4901B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiAQFpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiAQFpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:45:41 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA7CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:45:41 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id y4so28510219uad.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y0oUOdrqx+M8py6qBVJEFpjZfRB3lbu88LpKn+n4xFE=;
        b=pmZXDEv7iSwpJpTGyxqLIzk7jhq/Vi9ZB43sj1LMdQc/OU4J7XN83dD3YojAvNsoyI
         TqcN6zwobKvHNxTKi5vAH1nvfDoOc1pDbBL6o4gXtbwFSGMHlof6TK8vVWKmSTmjIkcd
         nvbK4SrS9LCmu4jGNOaGYMT9IeNt+YHGiULQY7ccclyruK3TcJwwAE0Xzn+1spjuEXM6
         6OYTNEuggycMHr7X8BepSs7l6flHVfedcX0PIPdOdw4fLQ3tG+y5lVr2GFflpoSVhLTe
         dXLxmrv2wkeVq1su3cSyhLJtAv2ZOBo/tWJ7XThmUVmEt+uifLZ+rezqwPnP8viXmIKg
         I4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Y0oUOdrqx+M8py6qBVJEFpjZfRB3lbu88LpKn+n4xFE=;
        b=vpxxpkRuTDdl7EJkZDpNB2I7Cqy+0IMhTxIKapJrRcpiDSBuxra7R7bFkKMbjHD+TG
         NCgq+tiAfbOoFqMmFXvSsmpGdS6qOwA/hB9ieGPM9tjPSzGAjk+lkkO8AwW5Hag7eUCT
         m+SMngWQyv3jqFhR91Vs2P6PJWj2cihkC2rmQhX+dwq3dBGEcsyRoFn3Jqli0RpM3sda
         k2AU/m8PgmaGWWozjVJysuNpNpTGq6kNFUms0saJ3MBYHAwfcgUr0Mf0uBTQRyMeV/TS
         IljGT8cW1gG+PTIaonXx646ctHLGknZ5uNomW+a8DNv2T0EgbBed0GeckWSF1rj/Koc/
         0GlA==
X-Gm-Message-State: AOAM533i2IA1Rtz3E5vlkKhC32PaXhopKBnHEMp8LBSdZkdYewkgHlRo
        BOvakptkqMcgFTuZ5z38W9kQmQj19ZfkfcJc
X-Google-Smtp-Source: ABdhPJwawnuHrizaHjg8rkobDL8ONBEIo4JDdRDosuyLLDmKJanABd2iFWFhGJSt+PrgNZbWEO934A==
X-Received: by 2002:a67:c00b:: with SMTP id v11mr7339828vsi.56.1642398340807;
        Sun, 16 Jan 2022 21:45:40 -0800 (PST)
Received: from kubuntu-desktop.. ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id 41sm3262976uag.18.2022.01.16.21.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 21:45:40 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        fazilyildiran@gmail.com
Subject: [PATCH] ASoC: au1x: fix unmet dependency on SND_SOC_I2C_AND_SPI for SND_SOC_WM8731
Date:   Mon, 17 Jan 2022 00:45:39 -0500
Message-Id: <20220117054539.81757-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SND_SOC_DB1200 is selected,
and SND_SOC_I2C_AND_SPI is not selected,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for SND_SOC_WM8731
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_I2C_AND_SPI [=n]
  Selected by [y]:
  - SND_SOC_DB1200 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AU1XPSC [=y]

This is because SND_SOC_DB1200 selects
SND_SOC_WM8731 without selecting or depending on
SND_SOC_I2C_AND_SPI, despite SND_SOC_WM8731
depending on SND_SOC_I2C_AND_SPI.

This unmet dependency bug was detected by Kismet,
a static analysis tool for Kconfig. Please advise
if this is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 sound/soc/au1x/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
index 38de7c0efbc7..3dccdfddbf9d 100644
--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -54,6 +54,7 @@ config SND_SOC_DB1000
 config SND_SOC_DB1200
 	tristate "DB1200/DB1300/DB1550 Audio support"
 	depends on SND_SOC_AU1XPSC
+	depends on SND_SOC_I2C_AND_SPI
 	select SND_SOC_AU1XPSC_AC97
 	select SND_SOC_AC97_CODEC
 	select SND_SOC_WM9712
-- 
2.32.0

