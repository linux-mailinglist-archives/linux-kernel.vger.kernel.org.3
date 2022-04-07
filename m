Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428F34F7223
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbiDGCjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiDGCjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:39:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5643A18DA9A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 19:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kgDQ0x9PzIJO+UDMqsy6uHWPV2myzYqJHPpaULldhHc=; b=Nw5C0wWx7J6HtbRkZf6yUMPlv/
        lqizwFjhgcu3V2Rpm7giEpd6nq9GKOSnhCN+QapuQ8+FDHIVjDCv3pqR+4bXs6Iv5gi+Ad4JBmg0Z
        WrvulMfEM2/vepzgQi7IIunk7JyM/5yzTsyWdzaajnEPUAWYRO7bWzvBzrkrdpBghyxMxPu2kv0Oq
        QxFGWVIuYdtsszCAnxKxYYPEJ7axiIDC60atrPRWA5aMYTj+++xfuCZ0cyzPYC+9hVJB4RmljOVVk
        XxXtsLoT4beOtkiVMf9Ez8NZ67n2QTRtjjr4Nhh5ecaNg6jYo4o3sSgHDBjMVj4+hUCytIlf8bUIe
        TQQMvNcQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncI17-008taA-9K; Thu, 07 Apr 2022 02:37:01 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Finn Thain <fthain@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] macintosh: fix via-pmu and via-cuda build errors
Date:   Wed,  6 Apr 2022 19:37:00 -0700
Message-Id: <20220407023700.7216-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_INPUT=m, the input_*() family of functions is not
available to builtin drivers.

When CONFIG_RTC_CLASS is not set, rtc_tm_to_time64() is not defined.

Fix multiple build errors by making these Kconfig symbols required by
ADB_CUDA (RTC_CLASS) and ADB_PMU (RTC_CLASS and INPUT).

m68k-linux-ld: drivers/macintosh/via-pmu.o: in function `pmu_set_rtc_time':
drivers/macintosh/via-pmu.c:1758: undefined reference to `rtc_tm_to_time64'
m68k-linux-ld: drivers/macintosh/via-pmu-event.o: in function `input_report_key':
include/linux/input.h:425: undefined reference to `input_event'
m68k-linux-ld: drivers/macintosh/via-pmu-event.o: in function `input_report_switch':
include/linux/input.h:445: undefined reference to `input_event'
m68k-linux-ld: drivers/macintosh/via-pmu-event.o: in function `via_pmu_event_init':
drivers/macintosh/via-pmu-event.c:38: undefined reference to `input_allocate_device'
m68k-linux-ld: drivers/macintosh/via-pmu-event.c:53: undefined reference to `input_register_device'
m68k-linux-ld: drivers/macintosh/via-pmu-event.c:55: undefined reference to `input_free_device'
m68k-linux-ld: drivers/macintosh/via-cuda.o: in function `cuda_set_rtc_time':
drivers/macintosh/via-cuda.c:797: undefined reference to `rtc_tm_to_time64'

Fixes: 0792a2c8e0bb ("macintosh: Use common code to access RTC")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Finn Thain <fthain@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
This is a big hammer type of patch. We could possibly do (a) some
conditional code blocks for RTC_CLASS and (b) only build via-pmu-event
if CONFIG_INPUT=y if needed.

 drivers/macintosh/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -44,6 +44,7 @@ config ADB_IOP
 config ADB_CUDA
 	bool "Support for Cuda/Egret based Macs and PowerMacs"
 	depends on (ADB || PPC_PMAC) && !PPC_PMAC64
+	depends on RTC_CLASS
 	help
 	  This provides support for Cuda/Egret based Macintosh and
 	  Power Macintosh systems. This includes most m68k based Macs,
@@ -57,6 +58,8 @@ config ADB_CUDA
 config ADB_PMU
 	bool "Support for PMU based PowerMacs and PowerBooks"
 	depends on PPC_PMAC || MAC
+	depends on INPUT=y
+	depends on RTC_CLASS
 	help
 	  On PowerBooks, iBooks, and recent iMacs and Power Macintoshes, the
 	  PMU is an embedded microprocessor whose primary function is to
