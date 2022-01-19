Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12A4494017
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356867AbiASSnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356857AbiASSnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:43:20 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC02C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:43:20 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id h13so2489013plf.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=/Cfe1873xO1xXDXTVkWc+/TfrkTu3OhMH8ndAhhKuV8=;
        b=zxr8zMQ/v6hklXsy25B8aji47s03VEDDq7tlii0h51fyxYtnizKlUP8z//SsQkRCVJ
         POMCZf6PzITCxlYYc/Kyz0ex7PQUFPkrLym8ZKdtQLIJ429E/Bx4t6giTvTJWxafudw7
         ljXoCHWLKV4vwlzNg3vyYbn3Pl3ibKvvkPvzRrCp8pQLMICF/6sjy1NMYqtdeFVRQ/sW
         EKlYMx1xO06giz9PP6xa1/c6r2I0dzGzxf6R2PDvzA/Gnhl69zn2dH29NhHEvCvA1cUH
         A57i2xVuky30ApXa7jX4/OTKHHe5H+hRQ6y7qIIhYGERMmdbSbzXlPAnS5DrF8cflA3d
         u+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=/Cfe1873xO1xXDXTVkWc+/TfrkTu3OhMH8ndAhhKuV8=;
        b=6+wwvaCChKos1zjkjSBl+XPjMKy4gYmzC2ZCrFsoY6hfpkVZ2r6beq4zH1FA5YEY6t
         uuKGHfym5jy3ZgXi+5M5FEeQMOtaxWwFNLQoY+y7VTaJFlfrH4xxy3nD5tkDrPCBrhLa
         aXmH+Fo8nVWifMTXh98dw4kFoI/0P6rcvGHNvsEufJsrbf+h5VyqxiwVSm2XcBkSY4kn
         fF/C3/Kn9n436I+3FhYqKzLOwNji+vfH4b9v2sfguaB+OkG+3IPFVhau1C70/sXVxNkZ
         XYzckcfCOkprR6p/N7ZfNsVaj6Mx9fswAwzv35/25UH+sjAvaHt+Mdsw7u9id1gnCwYT
         YuwA==
X-Gm-Message-State: AOAM532A7f+yfRfl3Lpxo2dokwBapDxWbnKNXtvgSRu9fbOH/6UGP1EJ
        FOVX4uUnYUwWHJ1pBH/AiJUCrw==
X-Google-Smtp-Source: ABdhPJxHzUywvLngC9h5BepVMrgb0A6N9EplGMmY9S8f0T/lugWlcTR7yUS+ts/TTrD6Yjoos+sZEA==
X-Received: by 2002:a17:902:8695:b0:14a:f006:db03 with SMTP id g21-20020a170902869500b0014af006db03mr4985763plo.173.1642617799505;
        Wed, 19 Jan 2022 10:43:19 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id ga21sm5618700pjb.2.2022.01.19.10.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 10:43:19 -0800 (PST)
Subject: [PATCH] RISC-V: nommu_virt: Drop unused SLAB_MERGE_DEFAULT
Date:   Wed, 19 Jan 2022 10:42:26 -0800
Message-Id: <20220119184226.15867-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Our nommu_virt_defconfig set SLOB=y and SLAB_MERGE_DEFAULT=n.  As of
eb52c0fc2331 ("mm: Make SLAB_MERGE_DEFAULT depend on SL[AU]B") it's no
longer necessary to set the second, which appears to never have had any
effect for SLOB=y anyway.

This was suggested by savedefconfig.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/nommu_virt_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index 385cca741b01..3bfd063b70c5 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -24,7 +24,6 @@ CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLOB=y
-# CONFIG_SLAB_MERGE_DEFAULT is not set
 # CONFIG_MMU is not set
 CONFIG_SOC_VIRT=y
 CONFIG_MAXPHYSMEM_2GB=y
-- 
2.32.0

