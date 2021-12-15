Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512FF4764B8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhLOVk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhLOVk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:40:26 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B2CC061574;
        Wed, 15 Dec 2021 13:40:26 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id q14so23347729qtx.10;
        Wed, 15 Dec 2021 13:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBmNfUUXlFFGQ+sdmOWfMRZ5XVtampSpkmAvqHCdWjo=;
        b=hTSmm96IXkdb15Y51GO3v1Kob+u1eJn+H2WSF/uv9cN9AAp7lxoEwvWxKJl/HNmip2
         vn6BBbzMzC9Rrr8dUMY0fLzCzjv9t32Ak1gDCpGWLLRFeZAMTmkF0LENtDX7ElUMjLhe
         bfq4ByjYo5CGxnPbvIWHlWqsH63qwX04VGtwMXyX4gzWGFdeVBmxAoUA5rAVogxriqZG
         5HQrAP98VIz3dodS17Ufw4mx77+js4u2znfcDut4KjmhO0v8yF/kzJpPUVxgwGW/ZYZK
         MVezXOCdnAnRhLwktkrK6cbpEh+aLjrHuyOXKTFHivRhSjDRUf2iV46nWAFOZ7c3gZbi
         eVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=dBmNfUUXlFFGQ+sdmOWfMRZ5XVtampSpkmAvqHCdWjo=;
        b=RslfWNu17TjVkWX5nUXtZ/TJrKGVSmQc8gkNPWWyejLodrdJxspvOAfZqb9430riHX
         DDfnjH3B7V2QfushrQoF9mURywq2ah6SDUsrhaJtwSXc9VzM5+bwKI4i13Exo+nJaU/9
         NdZyw3FY3ucqhUuFbvDCYVGupARiAStqpxVOhg1L+zhagxSkAQYTU1TPVdFF0hSPK/nc
         pqZOmRSyFPRj+Y/2Rzvq9NHOVkm+20cs6e9B7w8a538vLFxznxP/fluXw2SCNd2KnquQ
         BfjS45UqbL9z+H2EujUdBlxXC/81td3qW+cUULMRCksR7jQIMVPc7deN169hYcOGoYVU
         ORVw==
X-Gm-Message-State: AOAM533Jq2S2OImCIPCg5APydnZhI77P8VSji/a23LFc6zIifhHrXHjD
        Lg8WNs1hT7BLTrKHx0h6D04=
X-Google-Smtp-Source: ABdhPJxsVzTqiyuhQ/gkZagHF2QD7t9F+lNGXyubtGk4s0cYRy+SqHH6fBc42phCSuvI4Kb5t3WFlw==
X-Received: by 2002:a05:622a:647:: with SMTP id a7mr13825515qtb.593.1639604425522;
        Wed, 15 Dec 2021 13:40:25 -0800 (PST)
Received: from kubuntu-laptop.. ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id h9sm1755988qkp.106.2021.12.15.13.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:40:25 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     andrew@aj.id.au, linus.walleij@linaro.org, joel@jms.id.au
Cc:     linux-aspeed@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, fazilyildiran@gmail.com
Subject: [PATCH v1] pinctrl: aspeed: fix unmet dependencies on MFD_SYSCON for PINCTRL_ASPEED
Date:   Wed, 15 Dec 2021 16:40:22 -0500
Message-Id: <20211215214022.146391-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PINCTRL_ASPEED_G* is selected,
and MFD_SYSCON is not selected,
Kbuild gives the following warnings:

WARNING: unmet direct dependencies detected for PINCTRL_ASPEED
  Depends on [n]: PINCTRL [=y] && (ARCH_ASPEED [=n] || COMPILE_TEST [=y]) && OF [=y] && MFD_SYSCON [=n]
  Selected by [y]:
  - PINCTRL_ASPEED_G4 [=y] && PINCTRL [=y] && (MACH_ASPEED_G4 [=n] || COMPILE_TEST [=y]) && OF [=y]

WARNING: unmet direct dependencies detected for PINCTRL_ASPEED
  Depends on [n]: PINCTRL [=y] && (ARCH_ASPEED [=n] || COMPILE_TEST [=y]) && OF [=y] && MFD_S>
  Selected by [y]:
  - PINCTRL_ASPEED_G5 [=y] && PINCTRL [=y] && (MACH_ASPEED_G5 [=n] || COMPILE_TEST [=y]) && O>

WARNING: unmet direct dependencies detected for PINCTRL_ASPEED
  Depends on [n]: PINCTRL [=y] && (ARCH_ASPEED [=n] || COMPILE_TEST [=y]) && OF [=y] && MFD_S>
  Selected by [y]:
  - PINCTRL_ASPEED_G6 [=y] && PINCTRL [=y] && (MACH_ASPEED_G6 [=n] || COMPILE_TEST [=y]) && O>

This is because MACH_ASPEED_G* depend on (ARCH_ASPEED || COMPILE_TEST).
ARCH_ASPEED enables the MFD_SYSCON dependency, but COMPILE_TEST doesn't.

These unmet dependency bugs were detected by Kismet,
a static analysis tool for Kconfig. Please advise
if this is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/pinctrl/aspeed/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/Kconfig b/drivers/pinctrl/aspeed/Kconfig
index de8b185c4fee..1a4e5b9ed471 100644
--- a/drivers/pinctrl/aspeed/Kconfig
+++ b/drivers/pinctrl/aspeed/Kconfig
@@ -2,7 +2,7 @@
 config PINCTRL_ASPEED
 	bool
 	depends on (ARCH_ASPEED || COMPILE_TEST) && OF
-	depends on MFD_SYSCON
+	select MFD_SYSCON
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
-- 
2.32.0

