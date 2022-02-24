Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8194C25D9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiBXIOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiBXIN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:13:29 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD331662D9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:12:47 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id e7-20020a17090a4a0700b001bc5a8c533eso1002785pjh.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=C6KQ6aJHKI0dII25aQ0ze4CuACInlStiYwqSfgA5I3I=;
        b=Bdit93WWO3+4yT3mJU+gddJMM4TkBq5HHgsa2w2dpfvYcbGMYmzMtxaaQj5JvTmHqL
         e7UF4qnGyfCQT14vwhmY6VX+rbqXTNdiADyR3csjd621pX3mKh5Rhqpbw9eoqBbgeI+u
         dKelmiPG0OV2YkS7vhSSgY2El/8z//C04edJFSVd46mQku9f1eQAWO5uzlWSau7G0weJ
         FuOqt+rXYtqE08tf5e3uPn332EQ2EGRZ51bEbzmdvvDHNbrf4rtQejBzBueYcJO5mbDP
         5V8b3ccP2GsoAXl3tDzDr1RMWqGOtjq796Q256XGhsvvCcFO//1R4H7jSYxRamCeLqWA
         vu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=C6KQ6aJHKI0dII25aQ0ze4CuACInlStiYwqSfgA5I3I=;
        b=x9Z88Euya80LuPlSJHzt2FcP/eCXDRG3w09U7lujUYcbBuuHOucOJzNRVNjTz8Ya8q
         Du0GGq9DubmsQBcpxYuDeg0lVS9a2gi8jlqnEwvznaA2XnhBnMt1knqJl3z58AbemmKi
         0fmcAfRqELo5btvAxU/kfXpMUhQD7ELvRRA+CYlXCRIJzTqplLNbrUinnUJBP3m+kt2h
         2wNnP4mHohrjW3H3+AI4FM5bBJmn41gcAcvcQMeAedRXzpRaRGRRJdvPWil7vX0kY84C
         sk3I5kSHnX5PSmgXCqO8J8I4Tq6abVc8PychC+yXJ5EM1rvoU1+z4TqOPNz+ByJMyUi8
         /ZAA==
X-Gm-Message-State: AOAM533OFcUgvAtiA7ohGh255NT27zCuc3prDDkyFiinwoV69WC4lt+9
        SFWw3l6z7+X52uWlPRoWPulZeq8EU9Oefw==
X-Google-Smtp-Source: ABdhPJxTkKDtgkqTqiHtkPX7jkV85GKU+KYaUXsfBspbrXrDIO9ZerfwanHOSzOiYAL0O/DmHo81bwNOlasNZw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6a00:1d0c:b0:4e1:9846:3f34 with SMTP
 id a12-20020a056a001d0c00b004e198463f34mr1643800pfx.59.1645690366348; Thu, 24
 Feb 2022 00:12:46 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:12:33 +0800
Message-Id: <20220224081233.1765788-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH] um: Remove unused timeval_to_ns() function
From:   David Gow <davidgow@google.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-um@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
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

The timeval_to_ns() function doesn't appear to be used anywhere, as far
as I (or git grep) can tell, and clang throws up a warning about it:

../arch/um/os-Linux/time.c:21:25: warning: unused function 'timeval_to_ns' [-Wunused-function]
static inline long long timeval_to_ns(const struct timeval *tv)
                        ^
1 warning generated.

Signed-off-by: David Gow <davidgow@google.com>
---

Warning can be reproduced under clang 13.0.1-+rc1 after applying:
um: Allow builds with Clang -- https://lkml.org/lkml/2022/2/24/40

 arch/um/os-Linux/time.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 6c5041c5560b..4d5591d96d8c 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -18,12 +18,6 @@
 
 static timer_t event_high_res_timer = 0;
 
-static inline long long timeval_to_ns(const struct timeval *tv)
-{
-	return ((long long) tv->tv_sec * UM_NSEC_PER_SEC) +
-		tv->tv_usec * UM_NSEC_PER_USEC;
-}
-
 static inline long long timespec_to_ns(const struct timespec *ts)
 {
 	return ((long long) ts->tv_sec * UM_NSEC_PER_SEC) + ts->tv_nsec;
-- 
2.35.1.473.g83b2b277ed-goog

