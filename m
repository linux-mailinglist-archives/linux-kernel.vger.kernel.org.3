Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA19A502C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354779AbiDOPDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354771AbiDOPDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:03:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CA792876
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:01:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g18so10930129wrb.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PtPXEY81siOH4zQnv7yuS1B2bLj4CL7R4ay4pE9Q5sQ=;
        b=5ZS39VGnE9aChJzp3PjXpBvbY7slPEH4UX0Q4/yH+xs86UzzR/DI5CWB8IGEAFogwy
         8AzJCVt+FOxiSfrJMyXSnAFNdZZWmb0FpBUK+zciCibEh9AgGZAUdFD7C05Q933mxA7K
         vy3bJhI/U63w1CL38Tb7KewlG9jiNyakMngXeC+NFJFV95F/752VWuXS6wBLFt+pxWO8
         tDU3Qg0wm5dpetl+PXKW+FM/XHpnno12O89UvlSHITt4wO0OV5HawZ6jF8RXYejI5U6H
         TTUphecxu+gME6t3X3APk+oNyjgQDCFmTeSG+LwnbZxA2q/9JQxtG5E+te3dtl3AbHDp
         pCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PtPXEY81siOH4zQnv7yuS1B2bLj4CL7R4ay4pE9Q5sQ=;
        b=6CKjMpU6WgFEpJyc4JpVfAUxMcT5dwxj3SX0mC31bJmPH5o1MAYiQ7U4fjZHRFhtti
         NF9pL0V4H5XQu+IxCn5jeqs+CVX4rKhma8MC0kyUeRq6ES0SID+Il7TmN78OBvq2tcyv
         4AJmFPxSFbuA9bvL5quIqXMI/tZmNJZZMFTFQJn7esdkYJMR3kj28Idh5rSIYv72ZJoA
         So8h3qnnIDRV7r7WMj41i+1UMluwoWzL/kYHgjFx982srU8Qj3XHpS4NDkWG9JAv424L
         lVJNNBoxncMOkNV9IwqqVj+vtUZK/doMdlBD3AS/1Zcy8HDUH66ATzQQjwrgTlL1ZvzD
         iBLw==
X-Gm-Message-State: AOAM530NVpb8RvyCGF9X0Eqi8dhnNAKjBKnhY95ixPwdUM7FQo88HsMU
        bMRJodCQTFsEZ8Uofl0cz/PZhw==
X-Google-Smtp-Source: ABdhPJyQTRwtKFcCd130f+3f+FTm/8pTE2X09oFkxD4aIi/qF2W1IB3icCw3Nyq5BGHo+22pRYlOXw==
X-Received: by 2002:a5d:6449:0:b0:207:a1f4:b52 with SMTP id d9-20020a5d6449000000b00207a1f40b52mr5713618wrw.511.1650034880117;
        Fri, 15 Apr 2022 08:01:20 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d6b82000000b0020a7e34ef20sm1579664wrx.47.2022.04.15.08.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:01:19 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] arm64: defconfig: enable MT6359 regulator driver
Date:   Fri, 15 Apr 2022 17:00:02 +0200
Message-Id: <20220415150003.1793063-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415150003.1793063-1-fparent@baylibre.com>
References: <20220415150003.1793063-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC regulators are essentials to be able to
boot MediaTek MT8195 based boards to userspace.
Like the other MediaTek PMIC regulator driver,
let's enable as well the one for the MT6359 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
v3: no changes
v2: no changes

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 50aa3d75ab4f..1e521f17cb39 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -644,6 +644,7 @@ CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MP8859=y
 CONFIG_REGULATOR_MT6358=y
+CONFIG_REGULATOR_MT6359=y
 CONFIG_REGULATOR_MT6397=y
 CONFIG_REGULATOR_PCA9450=y
 CONFIG_REGULATOR_PF8X00=y
-- 
2.35.2

