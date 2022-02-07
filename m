Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075E74AB730
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243642AbiBGIx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243194AbiBGIoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:44:18 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7A8C043185
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:44:16 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8C8BA3FE4B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644223450;
        bh=TJNZ+zUd3S8HoAhxtcYJss8tid7CleqrdrazIaaybsg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=qSuLgpv8gWA6Pd15Dy2HxaWHHIU2G+tsKgPWNHeAcWbdIsrcmAm2ZeavNwp2ea4KH
         wJDsb0nMMwgg+YEc6BfwyxUa90PCe0ye26YINwX59uXUatrJqxJl1BmR4kWfG0LlzN
         57g6AMqFeCWpk4sKCjX7qEPIFIXk1EsIPAY2qBjWLIkcDJOF7tuTWDCDUzZTAuiMsX
         74VhOTF0CAf2F9tm8u7kdIUpk7bbkkmmkjbY8B+MgNfA+115rhj9KTv+WRikQZLnX3
         Ert/g4mzfBXM08P+HrDviqAiEV9X12/eY1sCD0nUsZWSCKUMwq8/wBdYMzK5rE9Fsk
         EBdo6JvSUTxGg==
Received: by mail-ej1-f72.google.com with SMTP id z26-20020a1709067e5a00b006cbe0628826so337934ejr.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 00:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJNZ+zUd3S8HoAhxtcYJss8tid7CleqrdrazIaaybsg=;
        b=UP6V3nxmUQzfxjaHDoZJQaAe0AaYvxw3jetnLXdrDUGBCMBLqAHK9+A0AsCRVMCyCm
         dsl+/lghp6bldkOv3Pbveld2O9l9j69h3En2i7nQ+UmddVMB4SkIitRATexN769CpohD
         RonCV7svg9xnmquwhmkyvexq66VXe/G2W4y4cmzhhBKshYOkFLG5KZCw9dN+wjrB2a1X
         pTJHL7Sf1Cmw8VfsTOgUJgNR/BVGIFssyjzykVDg32vFCrr0MM2hMLgmCJ2fQvZpB1R5
         EEvn//GXyZY+Hr/c8eB81X7OKAgL3UjCT2XnS513Cx4Ay5m8xNa5HriYSwyyCNW0XdAM
         UdQw==
X-Gm-Message-State: AOAM5311MFb5ZJyuxt3gj/TMjNM5N7ZHfqJUHhcyR0+FYIDsnajGPb7Y
        OvRHNyUKItSXezaHv9sjKbez7tTPjxUhW0RqbWaeK4tCFSMajyTjgO6X/afMWh18tDRBIkoM9VD
        twYuZGclEn+DYv1117sw2IH5qX9Hs0AmcHI+0CYXMYA==
X-Received: by 2002:a17:907:1c9f:: with SMTP id nb31mr9276005ejc.24.1644223450274;
        Mon, 07 Feb 2022 00:44:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxR/JRVVOHBqPXj/NpqeWB6ncqoJamzNzUx/kg+twC2HcWYf4L37Jq+4pk44F+v6qIcq4BTmA==
X-Received: by 2002:a17:907:1c9f:: with SMTP id nb31mr9275993ejc.24.1644223450061;
        Mon, 07 Feb 2022 00:44:10 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id y11sm1636935edu.2.2022.02.07.00.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 00:44:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: [PATCH] ARM: socfpga: fix missing RESET_CONTROLLER
Date:   Mon,  7 Feb 2022 09:44:04 +0100
Message-Id: <20220207084404.212017-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SocFPGA machine since commit b3ca9888f35f ("reset: socfpga: add an
early reset driver for SoCFPGA") uses reset controller, so it should
select RESET_CONTROLLER explicitly.  Selecting ARCH_HAS_RESET_CONTROLLER
is not enough because it affects only default choice still allowing a
non-buildable configuration:

  /usr/bin/arm-linux-gnueabi-ld: arch/arm/mach-socfpga/socfpga.o: in function `socfpga_init_irq':
  arch/arm/mach-socfpga/socfpga.c:56: undefined reference to `socfpga_reset_init'

Reported-by: kernel test robot <lkp@intel.com>
Cc: <stable@vger.kernel.org>
Fixes: b3ca9888f35f ("reset: socfpga: add an early reset driver for SoCFPGA")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/mach-socfpga/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 43ddec677c0b..594edf9bbea4 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -2,6 +2,7 @@
 menuconfig ARCH_INTEL_SOCFPGA
 	bool "Altera SOCFPGA family"
 	depends on ARCH_MULTI_V7
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
@@ -18,6 +19,7 @@ menuconfig ARCH_INTEL_SOCFPGA
 	select PL310_ERRATA_727915
 	select PL310_ERRATA_753970 if PL310
 	select PL310_ERRATA_769419
+	select RESET_CONTROLLER
 
 if ARCH_INTEL_SOCFPGA
 config SOCFPGA_SUSPEND
-- 
2.32.0

