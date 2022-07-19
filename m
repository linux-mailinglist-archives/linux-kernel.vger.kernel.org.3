Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA11579599
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbiGSIwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbiGSIwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:52:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E485BF58D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:52:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b26so20568969wrc.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Onw17Nb+fWMR70f7amM53CbVA6Q8rQEE5Z7WWmFHpIY=;
        b=IgJeETCCe8Lew/f+9cKntoX6o03iuaGfw8/E2/aHKmBZedK0aNpJSPvjBFjcZh5ZuW
         eDfHXjq+0DT2tcPv1kq9FwKLP8ljFFAIoTXEXA7VFMptGz795kW27X7xFu3NNh4jKszB
         ZbPAUVy290m55jk//k5YYV6Kq4KGCyqQYr3GiHOliCWsbxykLZ+E+VoDJuehiqlFwapl
         sjVjE3GkCDHAsJ416VSIQwqeWS1yhqZGvGyOLshDyE3KS4/Wb/2heBbITcgs2wrs8bV5
         P1MZB6YiE9IL6Sd+qaovUQvwfIZNIPFoEYeezY+OPFn/PXQiisb3imj8HS74FE/DseLP
         fnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Onw17Nb+fWMR70f7amM53CbVA6Q8rQEE5Z7WWmFHpIY=;
        b=o+Oo9Od62Bfl0tuJC3XI33UxK/s9aRUVGkmv69oAzFc1uYNSzROzZQ1P+hrwWjqlsM
         A83cJ++3naX0F5iS2q3Tw8EFrpSb/njDp3XVP2F6ra5o/Vc2ck299L8wGGA5rWtXQc3n
         zAwoUag6o1Aal0hVo+8ILRpqYED16XolBG9nyvUTc3Xa5Mvpn1EI3ldyRFw3HRVzY4ii
         wepPF+uJ3u+Xx76+9byutDZrx8B38sIITpN8ewzvuIPh5ij4sbdDOW5vu6RyVwYnlema
         aLtH3fqWF8j9V2ZqWctFXo2R2wJn4S2R2d47f4m3YaUbMz9tPLtiGJDtK8V2RDvkTGTx
         FMdA==
X-Gm-Message-State: AJIora/s3kgoDsFnYVB3/9c0cqhmrHRbSgaYfUqtOfiQ2foiUhKgYXDZ
        eZHpKnXs9qqqktyPLQ/Mj6hZDpc9kkKZlxDb
X-Google-Smtp-Source: AGRyM1sx3cemCITWnErarz+h8bYnJ4PyvqOj3ck/+z0Yh6y4VjpcNKXomlcVwLC/j0xnmbg0IaLQZA==
X-Received: by 2002:a5d:584c:0:b0:21d:a4b1:6f77 with SMTP id i12-20020a5d584c000000b0021da4b16f77mr25266902wrf.662.1658220722504;
        Tue, 19 Jul 2022 01:52:02 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id a6-20020adfdd06000000b0021b970a68f9sm12626416wrm.26.2022.07.19.01.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 01:52:02 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] reset: reset-simple should depends on HAS_IOMEM
Date:   Tue, 19 Jul 2022 09:52:00 +0100
Message-Id: <20220719085200.203688-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <202207190150.mf4rb4VG-lkp@intel.com>
References: <202207190150.mf4rb4VG-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset-simple driver does not build on all architecuters as it requires
devm_ioremap_resource() which is only built when CONFIG_HAS_IOMEM is enabled
in the kenrel. Fix the following error by depending on CONFIG_HAS_IOMEM:

drivers/reset/reset-simple.o: in function `reset_simple_probe':
 reset-simple.c:(.text+0x3aa): undefined reference to `devm_ioremap_resource'

Fixes: e87998582b50 ("reset: allow building of reset simple driver if expert config selected")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/reset/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index f40d9bbb686a..26c81bddf950 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -202,6 +202,7 @@ config RESET_SCMI
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST || EXPERT
 	default ARCH_ASPEED || ARCH_BCM4908 || ARCH_BITMAIN || ARCH_REALTEK || ARCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC
+	depends on HAS_IOMEM
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
-- 
2.35.1

