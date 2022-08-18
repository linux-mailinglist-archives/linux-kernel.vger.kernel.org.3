Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F23F5982FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244573AbiHRMOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242389AbiHRMOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:14:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BBE9D11A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:14:31 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id l1so1358958lfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=jwxp1KAydS2ZvfU/XwwFFINkOhcLog6j6vbpvOxklTw=;
        b=KOwUos+pq/GZt4Pp+EnUX+r8mRIeYu8foSVs8MNzP4ZzoBTzdYwYCX2xVYZwDPIolA
         dzGPKpscHVbdkOzCUDUMGPyRiAutaCEz8PfJ+BZ3H0SVHuMTuSoJLDEOo1Kgmd6ZEk+Y
         HE4vrWvqNPMNuR2Hk7gPqQx2o27O2UIKRjH8Gy1yxy8xEUYmeb9aX5qf4L36cl0CEwvc
         uxvC4m9xNsPCRD3EMPPCPxo7Ac3QPngcs1Gq2KxQ87rdyB+Y00IAd5LwQ/J/P9ZqFp22
         9rmYLoOyFmx5stKdywo+k1mEQepUa2REk5eugB2n30f9iKNRrNLP3WL8IAQEUWfA5DGS
         EbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=jwxp1KAydS2ZvfU/XwwFFINkOhcLog6j6vbpvOxklTw=;
        b=GL3OdnaVacxyh9wb2EOsFKGlui12sRukXT6RzBoplpxls2ATLOpdtT2BJ87Kl7VRN7
         DOZ5DCBRDYJyBylB132GcJCibKLgbfUP2Uyj6oSHZPB198ZVy4cudj/cYDZmvnsprkl1
         0zrcSTE16mFVyJN76f9EhrR9ZLIpnrH2cTLwfOBjZn5RcAxV86jrwsw4p7q6hJy7UBAK
         PLOsnxKDonaWZ90vwSM8iNZ7e+w+NYmTKNCXNgXZ/89leD8Td7/JPb1autejDvfL+xmi
         Tca07nZXEurMAsElY99EfzKoaCdQZsMY9+uYxppFhHK+TU3KqJZZ5nF9Nmc7FHtTaZJ8
         jynw==
X-Gm-Message-State: ACgBeo27TfOz7RJbshLjRLn38QHTYYOCr4QNEImNRWmZxgFqfAWtuEbX
        tEhGfBUhFmyzVMOskTkRS6YGjg==
X-Google-Smtp-Source: AA6agR7Fv09p/IqiOD1UkobeLwovRtZnvVY78EpPdvDM4nCoz8Qw1LC/9EKnzmBIhtdKWp2wOGcKsg==
X-Received: by 2002:a05:6512:3f02:b0:48d:244e:426f with SMTP id y2-20020a0565123f0200b0048d244e426fmr816345lfa.333.1660824869292;
        Thu, 18 Aug 2022 05:14:29 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id i9-20020a056512006900b0048b064707ebsm202917lfo.103.2022.08.18.05.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:14:28 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] regmap/hexagon: Properly fix the generic IO helpers
Date:   Thu, 18 Aug 2022 14:12:27 +0200
Message-Id: <20220818121227.151016-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was too naive in just including <asm-generic/io.h> into
hexagon: one has to specify defines for every call that uses
a (static) inline or this will not work.

Fix it up by providing proper defines for all shorthands that
hexagon provides.

Compile-tested with hexagon LLVM which is the only working cross
compiler for hexagon ATM after commenting out the
-fno-inline-functions-called-once switch which isn't working
with LLVM.

Cc: Brian Cain <bcain@quicinc.com>
Cc: linux-hexagon@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Fixes: 81c0386c1376 ("regmap: mmio: Support accelerared noinc operations")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Mark: please apply this to the regmap tree as a fix on
my sloppy commit so your tree compiles on hexagon. I hope the hexagon
folks will not mind.
---
 arch/hexagon/include/asm/io.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 8e938dc1ca4b..46a099de85b7 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -308,6 +308,29 @@ static inline void outsl(unsigned long port, const void *buffer, int count)
 	}
 }
 
+/*
+ * These defines are necessary to use the generic io.h for filling in
+ * the missing parts of the API contract. This is because the platform
+ * uses (inline) functions rather than defines and the generic helper
+ * fills in the undefined.
+ */
+#define virt_to_phys virt_to_phys
+#define phys_to_virt phys_to_virt
+#define memset_io memset_io
+#define memcpy_fromio memcpy_fromio
+#define memcpy_toio memcpy_toio
+#define readb readb
+#define readw readw
+#define readl readl
+#define writeb writeb
+#define writew writew
+#define writel writel
+#define insb insb
+#define insw insw
+#define insl insl
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
 #include <asm-generic/io.h>
 
 #endif /* __KERNEL__ */
-- 
2.37.2

