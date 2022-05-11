Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F65522E75
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbiEKIdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243726AbiEKIbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:31:46 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7A334653
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:34 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 7so1164388pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=Enn39BPEC4WUCYgELDojANydnjOiUN1oJPfCEc+x7uM=;
        b=Gp1gHM2j10a2iPLDhakfJsNgJKi88y9NRLaUJBNlnW78v2BGEQ6XPJOGBfu8m0uRGL
         ibNSkQX5XwNmXbNfZ/MftsJHoyONfRJ4hQWYcLl30YYlJYJ+Xg7pEcTzQDyCeTdhUTHh
         DWq8wd8Ezo9GwqLFMGv0oTzGHGR98VaxEGfsgKtehrYnB9nk3Hg1QLDYQmB7C8nyDlUU
         6XHZsSNESqI2r/wwwmz8exjfeW12g77zkQUDVncUsUKqXO2Jtg9tihNhKjZYCY9Dtqij
         0/WesLi+oyRtzIZUrxVWn8YdkRHR/wbZwgGn1vGnUclXV7MdLcIijK0Qp6+gxp8U+pnM
         xenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Enn39BPEC4WUCYgELDojANydnjOiUN1oJPfCEc+x7uM=;
        b=nk+ILKJmWh0WwoF2GDpW9r3cAE6g608k6UPkT/fouWOkidJWXuHNVj2kOvwziERw0F
         +BsssrJPvA8/3+eFcjPphhrMVNxMdLuiMnLnvYGtLiuNJukhO5slP9rPDhXbLe7zGPjN
         TimBQa/xWfxjFBB1D7PJBdbd54j30ET6UTQlE4bF8BoLZAojlJiI+xsOpzcpwQuX1mGN
         q8zVgMMen8bX/ktjTPkR4pqHtTApLzn6lmVAXgE7plLFrOGZ3B7DbXHWb6ie5EAtw4Zn
         rHNlJHtOsXqY8SfJoxwW1VFIWAxHmtK7oqAbNWlR/2/TfCJkUedpH2EeD/z/YnCkQVFR
         FkVw==
X-Gm-Message-State: AOAM530R8467ARVBVmfNtlrm+5KB3JtuCggMJq7pRnl9Wy5bNTUOl/aU
        nqGXGuRIm4J3YSPkdlihfB22Xg==
X-Google-Smtp-Source: ABdhPJzLN/nX3jESsXExXLfGAfX6dzBT5Ut7+OTmuducCoEMrkV+w/HchNMuYIp4KSucZL/AdZONwQ==
X-Received: by 2002:a05:6a00:2484:b0:510:7f57:30b7 with SMTP id c4-20020a056a00248400b005107f5730b7mr23823891pfv.70.1652257894092;
        Wed, 11 May 2022 01:31:34 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b0050dc7628170sm1020202pfo.74.2022.05.11.01.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:31:33 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
Subject: [PATCH v10 03/16] riscv: Add new csr defines related to vector extension
Date:   Wed, 11 May 2022 08:31:13 +0000
Message-Id: <5b13445101fcdef8706aaba6e5a480e31ae56e03.1652257230.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the riscv vector spec to add new csr numbers.

[guoren@linux.alibaba.com: first porting for new vector related csr]
Acked-by: Guo Ren <guoren@kernel.org>
Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index e935f27b10fd..ac95578a2908 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -24,6 +24,12 @@
 #define SR_FS_CLEAN	_AC(0x00004000, UL)
 #define SR_FS_DIRTY	_AC(0x00006000, UL)
 
+#define SR_VS           _AC(0x00000600, UL) /* Vector Status */
+#define SR_VS_OFF       _AC(0x00000000, UL)
+#define SR_VS_INITIAL   _AC(0x00000200, UL)
+#define SR_VS_CLEAN     _AC(0x00000400, UL)
+#define SR_VS_DIRTY     _AC(0x00000600, UL)
+
 #define SR_XS		_AC(0x00018000, UL) /* Extension Status */
 #define SR_XS_OFF	_AC(0x00000000, UL)
 #define SR_XS_INITIAL	_AC(0x00008000, UL)
@@ -31,9 +37,9 @@
 #define SR_XS_DIRTY	_AC(0x00018000, UL)
 
 #ifndef CONFIG_64BIT
-#define SR_SD		_AC(0x80000000, UL) /* FS/XS dirty */
+#define SR_SD		_AC(0x80000000, UL) /* FS/VS/XS dirty */
 #else
-#define SR_SD		_AC(0x8000000000000000, UL) /* FS/XS dirty */
+#define SR_SD		_AC(0x8000000000000000, UL) /* FS/VS/XS dirty */
 #endif
 
 /* SATP flags */
@@ -268,6 +274,12 @@
 #define CSR_MIMPID		0xf13
 #define CSR_MHARTID		0xf14
 
+#define CSR_VSTART		0x8
+#define CSR_VCSR		0xf
+#define CSR_VL			0xc20
+#define CSR_VTYPE		0xc21
+#define CSR_VLENB		0xc22
+
 #ifdef CONFIG_RISCV_M_MODE
 # define CSR_STATUS	CSR_MSTATUS
 # define CSR_IE		CSR_MIE
-- 
2.17.1

