Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793C9593420
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiHORlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHORlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:41:08 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F37714D21
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:41:07 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id g186-20020a636bc3000000b0041c3d64031cso2789866pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=uqDZcM016hXRGYfR4wY7ZEdvO7koGL4G86BOqml7ex0=;
        b=rweMxJmIUOdgUL1IAU0Q2Ca2R/ts/H/3sZNxnhgEaKMFs+Lci9yOUyvqnzMr8qOD/D
         naNtwrNwOFjjm7FIS871T4k/5t05D2esPbk56rz+WF8qpmZXjWooPyld4b1ANpWSy+A7
         muSeAnqewl51OVT5Uqw0Ezv+km3Iywrs2WFfAVwM3aCcha0ECWH/UouOS/MwfcXyVWJJ
         VcUL+x92EpBIyBuziwHUw4n1L5V4RvyvScrqVdwP2C3wqoaBRaVBPbULVgkkG+8xp0u0
         dXlm+N+EAiJDHnTtRgLkzNJeRKzlmc77R4hpyIUYgWOfLkKxpAbxbON6orFW0GKmrdUu
         rXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=uqDZcM016hXRGYfR4wY7ZEdvO7koGL4G86BOqml7ex0=;
        b=LZJGYq6J44lroB31GePWEMY0xEgVKASCRTYfCCEqolY7ZcQj9VbctKU7USb2PhH5y+
         3jM0W6zpwWvfObCBpBQC+jk9XlSnFFKUVmOejF7QcQPYjta8IHXlt76sDtiSys8KmVv4
         +TQLDq/jahONwKobEbt7PVKmjpqIm2t4zxz8Q3uh0RdzgFMJ6kN8AqXcksnxUv4zCF29
         kCX/yi974Hlo0aPTRb1/CcsFCE6JeAvKDcdXDIKOC8NnSZV97u4NrGhpvpxiEZpIkxab
         4WoFJIg/592CR8hgMvDRD5r6DlOj7pmLCYAmfmdmXb36o72iEJbm3z3wJzWEtnxEPirE
         UeyQ==
X-Gm-Message-State: ACgBeo3t0LRziWO/IfOk8zqTZLsNWwuC71iqkiBJokn94JTGX/IMIiVv
        P9WTEYMRTrp1WjDtBFnIosIXnYa+f9XU1KA=
X-Google-Smtp-Source: AA6agR6W/IoY8sn+WnggCmFT5TvMbbugptS9JHaz3/JaHRRySO786tge82iC9BKksRgTkfcMRNbREzZogMa2gHP6
X-Received: from joefradley-custom-96.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:831])
 (user=joefradley job=sendgmr) by 2002:a17:90b:2791:b0:1f3:c48:19d5 with SMTP
 id pw17-20020a17090b279100b001f30c4819d5mr19135726pjb.219.1660585266958; Mon,
 15 Aug 2022 10:41:06 -0700 (PDT)
Date:   Mon, 15 Aug 2022 10:41:02 -0700
Message-Id: <20220815174102.14807-1-joefradley@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] tools: Add new "test" taint to kernel-chktaint
From:   Joe Fradley <joefradley@google.com>
To:     corbet@lwn.net, david.gow@google.com
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        Joe Fradley <joefradley@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c272612cb4a2 ("kunit: Taint the kernel when KUnit tests are run")
added a new taint flag for when in-kernel tests run. This commit adds
recognition of this new flag in kernel-chktaint.

Signed-off-by: Joe Fradley <joefradley@google.com>
---
 tools/debugging/kernel-chktaint | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index f1af27ce9f20..279be06332be 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -187,6 +187,7 @@ else
 	echo " * auxiliary taint, defined for and used by distros (#16)"
 
 fi
+
 T=`expr $T / 2`
 if [ `expr $T % 2` -eq 0 ]; then
 	addout " "
@@ -195,6 +196,14 @@ else
 	echo " * kernel was built with the struct randomization plugin (#17)"
 fi
 
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "N"
+	echo " * an in-kernel test (such as a KUnit test) has been run (#18)"
+fi
+
 echo "For a more detailed explanation of the various taint flags see"
 echo " Documentation/admin-guide/tainted-kernels.rst in the Linux kernel sources"
 echo " or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"
-- 
2.37.1.595.g718a3a8f04-goog

