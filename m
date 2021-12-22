Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFF647CC2C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 05:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242457AbhLVEdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 23:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242435AbhLVEdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 23:33:21 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB324C061746;
        Tue, 21 Dec 2021 20:33:20 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 207so1693698ljf.10;
        Tue, 21 Dec 2021 20:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CtU4haHJjak+VaU1PmG3bQD5ISO+lnNjTJtGj7kjbsI=;
        b=ZSsLWuhprMfxX1jId025LMdzTGcfCHPwvPpTnLTL1w1i1nmk3L4rxmSVSQVeI53wye
         ffA5lpF9l9BL41NIONDBKmOMucXqfqL5DR1lq4vheoqfQwbp+svYawvSu/udDDDF1OfD
         c18YrHxdL76L9gms2Ubc2I4wAAALYb4q3bIFpPhVMBWCOTUbsl5yvJY0wRfHzEgoCrqq
         voPue/YjxihPa7DVX8KD59ma1+3FuGTUj7wRcCOT1ANi3OvoQOO3Yp/HIOjcSV3IdG60
         IRQDLQNjT2UbY4xKotFwZhv8Gr+6cB5vt4VEjiLceHWNWLPB4WIHcfBgZ1X2o94LsZlz
         X1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CtU4haHJjak+VaU1PmG3bQD5ISO+lnNjTJtGj7kjbsI=;
        b=TKwDYWmPUkRiElerEPkR5Sc/WusZX2ANc0i5/vrDzleS/4FjOvqnoMB76LX0EPbrJ8
         q9wqsYfuway2Y+d5G4RsBsrqlY8dl9n1m1EmK0898UfPSHLknWpZ9QBvKeafB7DTuPbM
         u0LWhUgK7w+yR1Gn3Lpkz7FIrmdbWJakNpcB4I+CW6cjnLzZxDry3UW/to4I0z3L01hP
         ecBrKsZaA7RgDABB/7WydBLvMHWrB1efw6DZ92P+9TPhIbN4GZCWhJMHP+W3OBv+Pbcb
         wAsF8tdXVSo4oRFs/AVeVy3fj0s00AhjSYfhroGBXKrZmnvnaCckGFI6iBuMqlPsY8tq
         hX7g==
X-Gm-Message-State: AOAM530ES0GfQt4uFLGJPDgJHGLqHkQAyfQ4X36j9JqfcuPYrFJ+ndyA
        irzZAWDyMSyKQyxbIDg4K4VuJ2vfwlk=
X-Google-Smtp-Source: ABdhPJz3y7WPs7qljig+1wRLuRm45Fxk/5OypNJFNUtPW6G3ZOgQxxYO1+xnFLalZXQZKT0tU6zoqw==
X-Received: by 2002:a2e:9206:: with SMTP id k6mr1032093ljg.117.1640147599037;
        Tue, 21 Dec 2021 20:33:19 -0800 (PST)
Received: from localhost.localdomain (46-138-43-24.dynamic.spd-mgts.ru. [46.138.43.24])
        by smtp.gmail.com with ESMTPSA id p20sm90640lfr.132.2021.12.21.20.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:33:18 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 2/2] memory: tegra20-emc: Correct memory device mask
Date:   Wed, 22 Dec 2021 07:32:15 +0300
Message-Id: <20211222043215.28237-2-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222043215.28237-1-digetx@gmail.com>
References: <20211222043215.28237-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory chip select is swapped when we read mode register, correct it.
We didn't have devices that use a single LPDDR chip and both chips are
always identical, hence this change is just a minor improvement.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - New patch in v2.

 drivers/memory/tegra/tegra20-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 497b6edbf3ca..25ba3c5e4ad6 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -540,7 +540,7 @@ static int emc_read_lpddr_mode_register(struct tegra_emc *emc,
 					unsigned int register_addr,
 					unsigned int *register_data)
 {
-	u32 memory_dev = emem_dev + 1;
+	u32 memory_dev = emem_dev ? 1 : 2;
 	u32 val, mr_mask = 0xff;
 	int err;
 
-- 
2.33.1

