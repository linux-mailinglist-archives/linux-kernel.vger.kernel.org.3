Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2B15A85FC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiHaSoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiHaSo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:44:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257161090
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:44:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f5960500bso209613897b3.14
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=nxmpsFmEnqVW7vmZQzr2xRuU6Ch0EkVsaTgU/u2vV4k=;
        b=SAAFmWyauBySzjpJrNvt73SE2HPay3Orf8jgDhjx36QAx7OjiDOdYgsm0SfNZdYfwR
         1aWZ13i7QRQptij6GuG9iGtF5yNsL2kRXMc/dvOv+5aTsicc+ef1Ql2h5biLg+VJPx0G
         rmMAQwuOVN9lN15VJGyMBfX+4vBc79LhEGOh+DryEgZCI6vTG2qdzrFp2UzJi1YWMD9a
         vVxzoMSlkBRJLBl9oBX4X28ujseOHFASxxhznifxHhpBPOECjZcdTeTNVIfpWNZ/Xz1a
         F2xgmh8MU7SgOqR7WoUtklnxM60uI9cp0b8xB0qwWelT9D1xKvMAqzogZGtG4cA2VV1t
         OZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=nxmpsFmEnqVW7vmZQzr2xRuU6Ch0EkVsaTgU/u2vV4k=;
        b=fXifwV0N6lqZ5sRxAkm8Pc68bTa8P3nSHmLtaarLeuNXGvdXzjLoSI59VhA9vspXCz
         qGmnbff9B9lksWtLxHoDYMLjCE8R9/3mncvI2U+he5zPIOmNa7Topz5oATaM51PI9lbA
         gmn0jjx36rpId4xQWs1l0OK68QA+pozA0xOhRoqZnu6pNOd0IX85u4EwvYAzm2PuNV8Y
         yWhRF8UlS8QjsD0yz21Y5u2uS8cEdVVpQNUcjuVGE8VSz3636vQkPT6gBC+xHFOinGFv
         GtwNQ8HPP+DFFNYd9koRETWlncewXSn+h8GxWVrasKvmPs2wStrEhr/2TmsecH3NdR55
         SCag==
X-Gm-Message-State: ACgBeo1o4zhbKw0ll/UwLSKT9e4VMVhS6lGCIIXo+pAnSYKyCIFjRlGy
        qLNh9qMg4vBacHIDVqi7LFL9Jydf/8TF6ljk12c=
X-Google-Smtp-Source: AA6agR79hkk5fE74ISpRQrASiipyjZ0iIGE2aErmcWn9sSqmbylmLaYlnrPt+lkeerueBeb+/SoRGdoJiwqeKBj6cUk=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:5f5d:95d5:9a3:d41])
 (user=ndesaulniers job=sendgmr) by 2002:a0d:e850:0:b0:33d:c65e:db0f with SMTP
 id r77-20020a0de850000000b0033dc65edb0fmr19134259ywe.253.1661971465422; Wed,
 31 Aug 2022 11:44:25 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:44:08 -0700
In-Reply-To: <20220831184408.2778264-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220831184408.2778264-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661971448; l=1621;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=vWDrWFVICt3Ai14ovaPS7sV9hqYwW1jW8tWWfH+heHY=;
 b=7NUjXNp3Kko38nPRelaw4RlNwQnLJ60Pq2Feeg9ta5r0PFwgmr+eznfGI29OX44l2Ycx4qKFO/UY
 y+0hS6/tAzQOJuSLTxlLvDIvqPKvb5NZIizBF2kXCnKd1dlp6AQn
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831184408.2778264-6-ndesaulniers@google.com>
Subject: [PATCH v2 5/5] Makefile.debug: set -g unconditional on CONFIG_DEBUG_INFO_SPLIT
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, x86@kernel.org,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andi Kleen <ak@linux.intel.com>
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

Dmitrii, Fangrui, and Mashahiro note:

  Before GCC 11 and Clang 12 -gsplit-dwarf implicitly uses -g2.

Fix CONFIG_DEBUG_INFO_SPLIT for gcc-11+ & clang-12+ which now need -g
specified in order for -gsplit-dwarf to work at all.

-gsplit-dwarf has been mutually exclusive with -g since support for
CONFIG_DEBUG_INFO_SPLIT was introduced in
commit 866ced950bcd ("kbuild: Support split debug info v4")
I don't think it ever needed to be.

Link: https://lore.kernel.org/lkml/20220815013317.26121-1-dmitrii.bundin.a@gmail.com/
Link: https://lore.kernel.org/lkml/CAK7LNARPAmsJD5XKAw7m_X2g7Fi-CAAsWDQiP7+ANBjkg7R7ng@mail.gmail.com/
Link: https://reviews.llvm.org/D80391
Cc: Andi Kleen <ak@linux.intel.com>
Reported-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Reported-by: Fangrui Song <maskray@google.com>
Reported-by: Masahiro Yamada <masahiroy@kernel.org>
Suggested-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v1 -> v2:
* Add reference to 866ced950bcd, cc Andi, in commit message.

 scripts/Makefile.debug | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
index 46e88f0ca998..b6eb532af3cc 100644
--- a/scripts/Makefile.debug
+++ b/scripts/Makefile.debug
@@ -1,10 +1,8 @@
-DEBUG_CFLAGS	:=
+DEBUG_CFLAGS	:= -g
+KBUILD_AFLAGS	+= -g
 
 ifdef CONFIG_DEBUG_INFO_SPLIT
 DEBUG_CFLAGS	+= -gsplit-dwarf
-else
-DEBUG_CFLAGS	+= -g
-KBUILD_AFLAGS	+= -g
 endif
 
 ifdef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
-- 
2.37.2.672.g94769d06f0-goog

