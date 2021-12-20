Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CA347A950
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhLTMSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLTMS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:18:29 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA84C061574;
        Mon, 20 Dec 2021 04:18:29 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y13so37369779edd.13;
        Mon, 20 Dec 2021 04:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MjoT1+0/DxfRaDrfHuq3G2Ro753TQHUQ3NJ1EInTB8=;
        b=asURLhslDYv8u0hz6/SuebhiWI//nat9NpB5kq+pN2d/aqhC5+afz5SOacZPovSP66
         7cY7zLIL7S7AZJ9Dwaqg01QDZNhcAVYpCgHycHZ5TuxttzMBSIzFB6s2OPqebRYKMte+
         erBqtVDd3un7xI5DwnjGoqu/g2okL212HUGUlP46zHzdyPIKIUy5l+6JhnVwuYBFtb4c
         6aqv2eAsnBdz3AMcxQfBCKSWAyF6A8wPSPOQ5bajcTPybLum+4mbNpsYEzAbLZBSP1D7
         P0zQ6emNdMHp7ZnzrzI9nf1KViTJOB/jP/vNcWELh0W/UaNwf0CKe6dkLCKMH8H9RL9f
         Yk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=5MjoT1+0/DxfRaDrfHuq3G2Ro753TQHUQ3NJ1EInTB8=;
        b=IixQTS0HHDwZFQde1KCsZV9NQIY5jKPEHNzQ9qZmDRSyAg7aH0H8MvU4bF2T83RYz+
         1eFmYmuUSNwHlXSCAkykTsz+0DbcM63cXv7JDOSwvsF9xmLy92URlK3HWTs96OMHuFIh
         11z8aGDWcui025U7yLLPKBh/RnKRoMlnvCIPuLIGdrONT17s4qNhphtdnaxUA6Q1SY1G
         Ltxb3VVdysrmqKL9nymE7QMnK01+S2M48KE4aBYf8tzHjIYXDdiZ+yUKoUaxYaSbjuVZ
         JBcrR6G2oglJdDUVEO4vsbmR4HRARsbSsrf2dBW2+WPe+X1igdyOKrLWyTAhjmrtbc9A
         Lraw==
X-Gm-Message-State: AOAM532AO+8ARaqCMtLsg7QHscqPTvmwewZjjKVQTc/XgS+kdN3oLf1w
        pTClquxath3W0MpWwk/rk4g=
X-Google-Smtp-Source: ABdhPJwLa4NjwySpR/porApfQAJrCybZbduz+D2HcKXFHEdJNYhPN4f3H+xMJ0pPM2T94UiqCR4raQ==
X-Received: by 2002:a17:907:6d99:: with SMTP id sb25mr7780586ejc.540.1640002707716;
        Mon, 20 Dec 2021 04:18:27 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id i22sm2549481ejw.75.2021.12.20.04.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 04:18:27 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     soc@kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH -next] reset: starfive-jh7100: Fix 32bit compilation
Date:   Mon, 20 Dec 2021 13:17:59 +0100
Message-Id: <20211220121800.760846-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to include linux/io-64-nonatomic-lo-hi.h or readq/writeq won't
be defined when compiling on 32bit architectures:

On i386:

../drivers/reset/reset-starfive-jh7100.c: In function ‘jh7100_reset_update’:
../drivers/reset/reset-starfive-jh7100.c:81:10: error: implicit declaration of function ‘readq’; did you mean ‘readl’? [-Werror=implicit-function-declaration]
  value = readq(reg_assert);
           ^~~~~
../drivers/reset/reset-starfive-jh7100.c:86:2: error: implicit declaration of function ‘writeq’; did you mean ‘writel’? [-Werror=implicit-function-declaration]
  writeq(value, reg_assert);
  ^~~~~~

On m68k:

drivers/reset/reset-starfive-jh7100.c:81:17: error: implicit declaration of function 'readq'; did you mean 'readb'? [-Werror=implicit-function-declaration]
drivers/reset/reset-starfive-jh7100.c:86:9: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
cc1: all warnings being treated as errors
make[3]: *** [scripts/Makefile.build:289: drivers/reset/reset-starfive-jh7100.o] Error 1
make[2]: *** [scripts/Makefile.build:572: drivers/reset] Error 2
make[1]: *** [Makefile:1969: drivers] Error 2
make: *** [Makefile:226: __sub-make] Error 2

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 0be3a1595bf8 ("reset: starfive-jh7100: Add StarFive JH7100 reset driver")
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/reset/reset-starfive-jh7100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-starfive-jh7100.c b/drivers/reset/reset-starfive-jh7100.c
index e28a19d271cb..fc44b2fb3e03 100644
--- a/drivers/reset/reset-starfive-jh7100.c
+++ b/drivers/reset/reset-starfive-jh7100.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iopoll.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
-- 
2.33.1

