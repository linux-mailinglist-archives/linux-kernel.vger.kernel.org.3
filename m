Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74C5563D12
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 02:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiGBArQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 20:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiGBArO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 20:47:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32083433AD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 17:47:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d17so3865988pfq.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 17:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ydfmhCPdxcY7HC4KYfTUs9I5BLUbEdORLJ1xN3NO3c0=;
        b=Pn6rbdnEreupJh6cagECvWIv5W7uE64xLFBf9w2/CzNe2bYiSHgUx/bRcO/ERs4RoY
         +LRKjPbu/lQY3xKFZLF/wZic0VDzFJ63361hJBdOFoHVh9+2mRHXk1k4whOiinMbIuvr
         KA3MVnU4n51h0yJb2DP3FpNyKZU70CrOvGbkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ydfmhCPdxcY7HC4KYfTUs9I5BLUbEdORLJ1xN3NO3c0=;
        b=oJKX8DkD5N4YjFZ3HSqw8iJVAKbk5ipKi0gcDGgX36vtd1riH5N+wyp/vXzGWLkpxA
         BBBbo+MeL34Nb3QaBmIY2xCPxRnHqKa7sbxnUD9qC1q8QnkmGtG6/7Wo3cHHi8oIL+fc
         7MGe3qDFvRaTixjZ6gD7G88quHy68sIG+ed3Ev087bt9J0eAbj8SMxmdEqPCvCbSJ7mp
         PFMCAtrFT555OX01LeGerX+v/wEd6tCXuUTmVXTsu6E5WSwBbdOsFmZyWi/FJNwnBWLC
         yhEZ22f+QVJTkNcxIpm1Xa3/iaWJrGTXuaofCjUrVv5rd7JPzABfhsoFAdq07LAwfdTI
         8EVw==
X-Gm-Message-State: AJIora9PBMJPgDxGcJwD4rOidHrrx4JGAW756wakA21FIJpVOrN9PR2Q
        PIQX2TmXflGTKGmCe5tPZhUEuQ==
X-Google-Smtp-Source: AGRyM1uBeFo+bjB2I+Ygn+SNDgSbkptXkY8QVoGwfntENn02qYuizKGSH3t5ScZfTEjqHKDxQRgQ9g==
X-Received: by 2002:a63:80c8:0:b0:411:73dd:809b with SMTP id j191-20020a6380c8000000b0041173dd809bmr14507767pgd.441.1656722833703;
        Fri, 01 Jul 2022 17:47:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w187-20020a6362c4000000b0040dad0ac789sm14115748pgb.88.2022.07.01.17.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 17:47:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] lib: overflow: Do not define 64-bit tests on 32-bit
Date:   Fri,  1 Jul 2022 17:47:10 -0700
Message-Id: <20220702004710.2486218-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3230; h=from:subject; bh=fCKfebT6u713W7j3kCKpEzPYBwJifxyWcZ7a9TvB98o=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiv5WOYAqcRIQBpaDNFrBRv5R9qnrmGV+dPGGR/tCF vQws7kiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYr+VjgAKCRCJcvTf3G3AJlhJD/ 4vnxX3ctiu4c18L2F+1tg3d0YmRc6peRWcbX3QEeMtf1CWaH1A6RshNbOYZiQqG4kWWC8jaGnRCVsN swG2MFxuXLdnZyLQPXCRf/y5ijYYseI+Sxmi7WqFwZuGBg7YiTXazps8qU33XSbvIlzv0430APpN3Y 8bDvqubTFkUATXLLbYZ7ZcV7rUqJvp25p7E9UjL/6VYEuA/AEBICB8EtuIMAhcO4pNfMPA/L9Ac1Dd e+eHVT9+XUibVdd5XYf4C10LImSczs6MXa9sPqjJw3UOd2xmWJIduhzTz97jt3izqiXkJUHZ2UTcBh dXXocWNnI43o3qhsHsjYiPaL/qJF4BiCEnEFaKjKk9OipzrrPaDBKOPY9lcgBboO87A2XCwp4qDtzG Wx0KYdgGr5Sqt1IB1lDvy0NMpTBq3UoGAN0UbxfOGy6XCD/T4BtVF9JMcCwclREgwEtbBvx53w+AG7 pcEbJEoLPa6o8KiwUQ5d84CWA+hTq7pMl35QO12KpIsp1GubdJ1WKpFUWpXxfBQ2CkjVSWPUgz3Zfu 2u2ipNUscuNnmllEKWAYIGf9J1OM44F8MBZs6aYODuHwDsWyWdBDIKlycYqpFQ47wZv4Y76fqva0gV 13CyVFXL9Ch55m26Zoqtld1wJkFMrQJEDcZRB6+tBqclFM2e//FVhflS86Qg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 64-bit overflow tests will trigger 64-bit division on 32-bit hosts,
which is not currently used anywhere in the kernel, and tickles bugs
in at least Clang 13 and earlier:
https://github.com/ClangBuiltLinux/linux/issues/1636

In reality, there shouldn't be a reason to not build the 64-bit test
cases on 32-bit systems, so these #ifdefs can be removed once the minimum
Clang version reaches 13.

In the meantime, silence W=1 warnings given by the current code:

../lib/overflow_kunit.c:191:19: warning: 's64_tests' defined but not used [-Wunused-const-variable=]
  191 | DEFINE_TEST_ARRAY(s64) = {
      |                   ^~~
../lib/overflow_kunit.c:24:11: note: in definition of macro 'DEFINE_TEST_ARRAY'
   24 |         } t ## _tests[]
      |           ^
../lib/overflow_kunit.c:94:19: warning: 'u64_tests' defined but not used [-Wunused-const-variable=]
   94 | DEFINE_TEST_ARRAY(u64) = {
      |                   ^~~
../lib/overflow_kunit.c:24:11: note: in definition of macro 'DEFINE_TEST_ARRAY'
   24 |         } t ## _tests[]
      |           ^

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202205110324.7GrtxG8u-lkp@intel.com
Fixes: 455a35a6cdb6 ("lib: add runtime test of check_*_overflow functions")
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Vitor Massaru Iha <vitor@massaru.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Tested-by: Daniel Latypov <dlatypov@google.com>
Link: https://lore.kernel.org/lkml/CAGS_qxokQAjQRip2vPi80toW7hmBnXf=KMTNT51B1wuDqSZuVQ@mail.gmail.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/overflow_kunit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
index 475f0c064bf6..7e3e43679b73 100644
--- a/lib/overflow_kunit.c
+++ b/lib/overflow_kunit.c
@@ -91,6 +91,7 @@ DEFINE_TEST_ARRAY(u32) = {
 	{-4U, 5U, 1U, -9U, -20U, true, false, true},
 };
 
+#if BITS_PER_LONG == 64
 DEFINE_TEST_ARRAY(u64) = {
 	{0, 0, 0, 0, 0, false, false, false},
 	{1, 1, 2, 0, 1, false, false, false},
@@ -114,6 +115,7 @@ DEFINE_TEST_ARRAY(u64) = {
 	 false, true, false},
 	{-15ULL, 10ULL, -5ULL, -25ULL, -150ULL, false, false, true},
 };
+#endif
 
 DEFINE_TEST_ARRAY(s8) = {
 	{0, 0, 0, 0, 0, false, false, false},
@@ -188,6 +190,8 @@ DEFINE_TEST_ARRAY(s32) = {
 	{S32_MIN, S32_MIN, 0, 0, 0, true, false, true},
 	{S32_MAX, S32_MAX, -2, 0, 1, true, false, true},
 };
+
+#if BITS_PER_LONG == 64
 DEFINE_TEST_ARRAY(s64) = {
 	{0, 0, 0, 0, 0, false, false, false},
 
@@ -216,6 +220,7 @@ DEFINE_TEST_ARRAY(s64) = {
 	{-128, -1, -129, -127, 128, false, false, false},
 	{0, -S64_MAX, -S64_MAX, S64_MAX, 0, false, false, false},
 };
+#endif
 
 #define check_one_op(t, fmt, op, sym, a, b, r, of) do {		\
 	t _r;							\
@@ -650,6 +655,7 @@ static struct kunit_case overflow_test_cases[] = {
 	KUNIT_CASE(s16_overflow_test),
 	KUNIT_CASE(u32_overflow_test),
 	KUNIT_CASE(s32_overflow_test),
+/* Clang 13 and earlier generate unwanted libcalls on 32-bit. */
 #if BITS_PER_LONG == 64
 	KUNIT_CASE(u64_overflow_test),
 	KUNIT_CASE(s64_overflow_test),
-- 
2.32.0

