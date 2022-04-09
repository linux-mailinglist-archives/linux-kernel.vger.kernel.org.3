Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1524FA18C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbiDICKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiDICKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:10:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE4D1092
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 19:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=F75WgLKYZWUeJINf8+Yays5uvhvJJCETxcO2mCDDMP8=; b=lyXLxby7leOtzEIBGgGdvhg9aI
        ppN1Ti3FCmXWfMEATse9V55cNyhMl5ie97YyCk3Me6nN+EeaeKZ2J0m8RX0mbgcWnlGkpah08S0iN
        sT2I3qLUVQBzSMDV77n/r80NjnenKYglKrA0fpcymAdAentilrJMUtYmoiaei0oJngUxsotetB99X
        ICMzQgBdyltZuIYaSYsf7+zNQ3WVApWi5yjMghYG81YdO0KyR9/fjW3l231YCgebN8equojEHbBTt
        MRWS25GkXuVN9SCNlPeq43tcungXlKhRsv+LbCSIbLF5gngIjY+RO+fHi8CzTeSDHl/vkKs+0tdIn
        Ah0X6acA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nd0WV-001hkH-Ma; Sat, 09 Apr 2022 02:08:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Finn Thain <fthain@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] macintosh: fix via-pmu and via-cuda build without RTC_CLASS
Date:   Fri,  8 Apr 2022 19:08:21 -0700
Message-Id: <20220409020821.10229-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build when RTC_CLASS is not set/enabled.
Eliminates these build errors:

m68k-linux-ld: drivers/macintosh/via-pmu.o: in function `pmu_set_rtc_time':
drivers/macintosh/via-pmu.c:1769: undefined reference to `rtc_tm_to_time64'
m68k-linux-ld: drivers/macintosh/via-cuda.o: in function `cuda_set_rtc_time':
drivers/macintosh/via-cuda.c:797: undefined reference to `rtc_tm_to_time64'

Fixes: 0792a2c8e0bb ("macintosh: Use common code to access RTC")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Finn Thain <fthain@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/macintosh/via-cuda.c |    5 ++++-
 drivers/macintosh/via-pmu.c  |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -794,7 +794,10 @@ int cuda_set_rtc_time(struct rtc_time *t
 	u32 now;
 	struct adb_request req;
 
-	now = lower_32_bits(rtc_tm_to_time64(tm) + RTC_OFFSET);
+	now = lower_32_bits(mktime64(((unsigned int)tm->tm_year + 1900),
+			    tm->tm_mon + 1, tm->tm_mday, tm->tm_hour,
+			    tm->tm_min, tm->tm_sec)
+			    + RTC_OFFSET);
 	if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
 	                 now >> 24, now >> 16, now >> 8, now) < 0)
 		return -ENXIO;
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -1766,7 +1766,10 @@ int pmu_set_rtc_time(struct rtc_time *tm
 	u32 now;
 	struct adb_request req;
 
-	now = lower_32_bits(rtc_tm_to_time64(tm) + RTC_OFFSET);
+	now = lower_32_bits(mktime64(((unsigned int)tm->tm_year + 1900),
+			    tm->tm_mon + 1, tm->tm_mday, tm->tm_hour,
+			    tm->tm_min, tm->tm_sec)
+			    + RTC_OFFSET);
 	if (pmu_request(&req, NULL, 5, PMU_SET_RTC,
 	                now >> 24, now >> 16, now >> 8, now) < 0)
 		return -ENXIO;
