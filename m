Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA83B4BAA90
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245651AbiBQUDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:03:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiBQUDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:03:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12CB46670;
        Thu, 17 Feb 2022 12:03:27 -0800 (PST)
Date:   Thu, 17 Feb 2022 20:03:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645128205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nFIhjWAJVh6ZFlc+OBY5UeqjJhMERGEWjl6aLS1HzUs=;
        b=zDJPicaMV+JKic2iwEp2M1cgQbo0g1FmQQst2uzUi7jQNkwFKdX4LDIUqq35ti1J5IxesB
        pBbwzKhYAuyKfrlcZSVoQ8ogl6OjjvrO+pMCYjIRUL8cP2nfBvGtd/wXK4bSa/KxD+7+4P
        9/XrU0b7FchAcHgddklfZRUepMyxTui2F4tXv92aWoIUH+vN9EjU1wXHM6ORSDARxbE3gC
        0V8FCAgNJv2qb1XmUPG0TeoeGXov9HuSrLO3PU7ybpXaiRY8jAdkmewVLkwFBQkj+GcrsM
        +9rXBj60lyK/el7cwW+S6jnNl+KeUerGJNfL20vd4NvwYZFFpLe2bZGyECONYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645128205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nFIhjWAJVh6ZFlc+OBY5UeqjJhMERGEWjl6aLS1HzUs=;
        b=o6XK3V/gSV+s1LmmYMS2znaGDOEOxlZvVugkpQDIzuxBILvKZxuCB8EyDxhIvoxoRn3Y9K
        FGqac2eiFNF0uAAA==
From:   "tip-bot2 for Muhammad Usama Anjum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/x86: Add validity check and allow field splitting
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220214184109.3739179-2-usama.anjum@collabora.com>
References: <20220214184109.3739179-2-usama.anjum@collabora.com>
MIME-Version: 1.0
Message-ID: <164512820484.16921.11445103129239646952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     b06e15ebd5bfb670f93c7f11a29b8299c1178bc6
Gitweb:        https://git.kernel.org/tip/b06e15ebd5bfb670f93c7f11a29b8299c1178bc6
Author:        Muhammad Usama Anjum <usama.anjum@collabora.com>
AuthorDate:    Mon, 14 Feb 2022 23:41:08 +05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 17 Feb 2022 11:55:17 -08:00

selftests/x86: Add validity check and allow field splitting

Add check to test if CC has a string. CC can have multiple sub-strings
like "ccache gcc". Erorr pops up if it is treated as single string and
double quotes are used around it. This can be fixed by removing the
quotes and not treating CC as a single string.

Fixes: e9886ace222e ("selftests, x86: Rework x86 target architecture detection")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220214184109.3739179-2-usama.anjum@collabora.com
---
 tools/testing/selftests/x86/check_cc.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/check_cc.sh b/tools/testing/selftests/x86/check_cc.sh
index 3e2089c..8c669c0 100755
--- a/tools/testing/selftests/x86/check_cc.sh
+++ b/tools/testing/selftests/x86/check_cc.sh
@@ -7,7 +7,7 @@ CC="$1"
 TESTPROG="$2"
 shift 2
 
-if "$CC" -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
+if [ -n "$CC" ] && $CC -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
     echo 1
 else
     echo 0
