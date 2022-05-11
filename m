Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B569523BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345765AbiEKRpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiEKRph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:45:37 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCEA219F69
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:45:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 31so2405466pgp.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wtHf7ZrAH4PrrfQ8X/4WpEmrRmE9+0nPRk+51k/x4Pg=;
        b=TOER+O7VaqpBhXcNlHd69BxSLKP+mAQh8v/s9TpZa5MJTiTfWMTtNofMl4X86hWtdA
         aPmvvUYQRQJdHmTyWI89bnCpOvtfxZwn0x/6RsNJNuzpcAVLrRr0VM+iyn4o6TRPTO2N
         caIzydcLfDBFP7zRqTvpCBUvGl9MlTlQAA8ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wtHf7ZrAH4PrrfQ8X/4WpEmrRmE9+0nPRk+51k/x4Pg=;
        b=8DLIpUp/ZJZ+GWau3L3BYv4oeCnWikV7j3DP/JjXUV1nGg4GIldtAffGvFjM61JvjF
         0WIp+vA4YR7OFm0TcZq993BoJSsYdK3cg+aoDBOrByMnBVt/i46vgXYxmJrl5I7YSdwW
         Ql5M8lChk8l2skaNfTaDa2BGU49R1+3oyFeokIsdSjX7cBQ83K7M6LXGw/jK/Mt+mMmE
         gak7MdGkS3I0f1jLFHgj8cgEQ3JvoR+eOyHF0ueZAm4oanBFpJ4wSJjWqdJrztBOCm9G
         Dp7WczaTfCOUIivcKdAx4SGK26oa8zeeaFGjGxY4CZWnwbCMNfU1XOlqKB0OaUdxgT3X
         6FMw==
X-Gm-Message-State: AOAM530UBCPGIQbE3sgen6b4EnA3QLVd37xiA70FqdetUuXM91NcfIGM
        BZfCr7ROy/ivqzRZq0SAvIfYgg==
X-Google-Smtp-Source: ABdhPJz8MafUMLMmiPh2TPfTHw+Wd/WkD7AI9rIG8ZDT690/r5bid8PrhndlVGg4fTtJglDi1J+jFg==
X-Received: by 2002:a63:cf08:0:b0:3db:2558:aa66 with SMTP id j8-20020a63cf08000000b003db2558aa66mr3459845pgg.624.1652291135961;
        Wed, 11 May 2022 10:45:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k125-20020a628483000000b0050dc7628193sm2081797pfd.109.2022.05.11.10.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 10:45:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] lib: overflow: Always build 64-bit test cases
Date:   Wed, 11 May 2022 10:45:31 -0700
Message-Id: <20220511174531.1098548-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; h=from:subject; bh=eiJn2Wl6nc4704YmTbh5pwPU8pZHWuWKyERY0Sg+mvo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBie/Y6HZp0vOkkjoDe+KyAaUAbsvxybtXQniz6E1rE zafXUnqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnv2OgAKCRCJcvTf3G3AJm+tD/ 0R/7Mm9NFYf2jEkB+SGZEyGUFEXJAnhj1jGXcuvzuiJfp0DHrTx1rIYF8Z4/UMVyKRc8BQlncO4aaY Epq9sEMb3DHlLd2gSF2p/ZWUxYTagcF0+Lt0pxFAUdZkXBzUSoJsMLsNjmCKuhzgAUJxIK4cKcnyWX mA0PLfg0p8S4XK+PFBw6IILtM0IVNH4fcJk7Q2TLaIB1YRrBrq61CVzQik0WY3jaydlKNNzq6Bz2i5 9sc9Aq+/aNTiEJ+1CNx0rVKfs9ooBkVyZgnLRawZPk/ECQNCLWgIIMn/wGpY91P1HarD7jBOUHOB0Z IMZWI/ivmPjDOjZ/EkuVCF0ukMXUmSYW8bwP4xlEqAKCdm3JG9aczfcrB+3OX4O7GN9bv2qT8u0GyU t95u8p9wOmirGCegajZg2uKy2mVv7C3M+YNcpYaBP6ftFZCgVfhFhFXqCLN6F0BPHVzB00yPa/K08d kfompYhsOTwGfkhCxlIGWcAyXW1gGEs7grESyA07sUc6K7+S6rKvRrRgLeaSAYgqVoCPdL36v0TaXI MTeEPmi7IgkGwJ7ezQcWlZyJkp6VYQFIWl0XelID4cAsZDjFmLVgOtGGxmONapigzIeSzhvV23ewgb zBojb9InwUHwvxauQ51nlBfm0JBv1kmw5z/WGgx3HOcXNllz3IT5JPkHQqzQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There shouldn't be a reason to not build the 64-bit test cases on 32-bit
systems; the types exist there too. Remove the #ifdefs.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202205110324.7GrtxG8u-lkp@intel.com
Fixes: 455a35a6cdb6 ("lib: add runtime test of check_*_overflow functions")
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Vitor Massaru Iha <vitor@massaru.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/overflow_kunit.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 475f0c064bf6..ac37bb543476 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -255,10 +255,8 @@ DEFINE_TEST_FUNC(u16, "%d");
 DEFINE_TEST_FUNC(s16, "%d");
 DEFINE_TEST_FUNC(u32, "%u");
 DEFINE_TEST_FUNC(s32, "%d");
-#if BITS_PER_LONG == 64
 DEFINE_TEST_FUNC(u64, "%llu");
 DEFINE_TEST_FUNC(s64, "%lld");
-#endif
 
 static void overflow_shift_test(struct kunit *test)
 {
@@ -650,10 +648,8 @@ static struct kunit_case overflow_test_cases[] = {
 	KUNIT_CASE(s16_overflow_test),
 	KUNIT_CASE(u32_overflow_test),
 	KUNIT_CASE(s32_overflow_test),
-#if BITS_PER_LONG == 64
 	KUNIT_CASE(u64_overflow_test),
 	KUNIT_CASE(s64_overflow_test),
-#endif
 	KUNIT_CASE(overflow_shift_test),
 	KUNIT_CASE(overflow_allocation_test),
 	KUNIT_CASE(overflow_size_helpers_test),
-- 
2.32.0

