Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95CC575A27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 06:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbiGOEEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 00:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241322AbiGOEEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 00:04:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4DC13F88
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 21:04:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31d17879672so31642217b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 21:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dOShst8oggqOssAr1ulsAnblCITkep7trvJdY0C5eLU=;
        b=Of15lLAbml49VYHRN9m0VDbCfogr3SovyJGfgCQ7iaWxO2/arZgSm1JkWoAtfuWQlX
         luM3GfvnpmaLCfLXFRTXVP3skXL2hUMumL8ELP8qkLOb1o1ll5w6FN6C0XjjNbS9TDdN
         PsqVD12No9NSstS6gjWYJmxvG6m6l5eJSTmC4BXr+uKXuWjOQIM6AsEDP/qr9/oqEkP3
         zufyGVCthz1+/0+RbafqMV5x2ThixKyaYAePnveQzH/m8OkFCG4EgRf+6VnW42hlEdhv
         4dTf12NWb9TPo54ObWif+TwN/RlIsIBtA8+dlDJXCAmbeUPx84nRTKncRwJc0ouSdHDt
         eMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dOShst8oggqOssAr1ulsAnblCITkep7trvJdY0C5eLU=;
        b=zhIWyeWPKY+QqL7G0W/KTC6+U2n0b3oC2VO2GwBk6li3ubHNnxtWLfR2hm0SWxCN59
         uWgB7mUZ2W+kw01gchNeRlunp3TaU8FgP18DrrMsmH4cSioy1QvZfTbjuj8VO6p1/e4g
         SvQ5ui+3ERNIv/E2Kyv5Fnoau+r1QCNtKngkgjmzMRoq5OiE47/KKIhC2aN+MRS433Ai
         lwy+SswsUPnxLLLNKc1Nq+Fbrff6g7lOwnSVaJDNHLFvrmiZsIqy9Ar7wr9Yg8saM7Ve
         OD5SH5l6zLUxqQ9lHPD2VWRcYF+S/7fPiG7WQmW/eq/ySG9PXCpcMTT0UWWDgptZGrZ1
         0WUQ==
X-Gm-Message-State: AJIora8Adw/WmIPKBkN4oWUnkciV1G/25ER4SCAgatJHbd1S1FsdXPPO
        aIjAZMdbwLbAlbDszQQV8guqq5CR2DkpcQ==
X-Google-Smtp-Source: AGRyM1vFpZrFOoq2yapQ0vGl3znNKM4Dn0ax0wtn3S4i2Fs4lp4ajUnIeHklnWD7RiS+zlb4i05wgHyYdzKpWw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a5b:bc2:0:b0:66e:4a75:e5ff with SMTP id
 c2-20020a5b0bc2000000b0066e4a75e5ffmr12004512ybr.642.1657857840574; Thu, 14
 Jul 2022 21:04:00 -0700 (PDT)
Date:   Fri, 15 Jul 2022 12:03:54 +0800
Message-Id: <20220715040354.2629856-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH] mmc: sdhci-of-aspeed: test: Fix dependencies when KUNIT=m
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, Sadiya Kazi <sadiyakazi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the sdhci-of-aspeed KUnit tests do work when builtin, and do work
when KUnit itself is being built as a module, the two together break.

This is because the KUnit tests (understandably) depend on KUnit, so a
built-in test cannot build if KUnit is a module.

Fix this by adding a dependency on (MMC_SDHCI_OF_ASPEED=m || KUNIT=y),
which only excludes this one problematic configuration.

This was reported on a nasty openrisc-randconfig run by the kernel test
robot, though for some reason (compiler optimisations removing the test
code?) I wasn't able to reproduce it locally on x86:
https://lore.kernel.org/linux-mm/202207140122.fzhlf60k-lkp@intel.com/T/

Fixes: 291cd54e5b05 ("mmc: sdhci-of-aspeed: test: Use kunit_test_suite() macro")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 10c563999d3d..e63608834411 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -171,6 +171,7 @@ config MMC_SDHCI_OF_ASPEED
 config MMC_SDHCI_OF_ASPEED_TEST
 	bool "Tests for the ASPEED SDHCI driver" if !KUNIT_ALL_TESTS
 	depends on MMC_SDHCI_OF_ASPEED && KUNIT
+	depends on (MMC_SDHCI_OF_ASPEED=m || KUNIT=y)
 	default KUNIT_ALL_TESTS
 	help
 	  Enable KUnit tests for the ASPEED SDHCI driver. Select this
-- 
2.37.0.170.g444d1eabd0-goog

