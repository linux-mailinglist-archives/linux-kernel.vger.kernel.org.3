Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32A75AFB7F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIGFAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiIGE7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:59:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1804A12A80
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 21:59:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i194-20020a253bcb000000b00676d86fc5d7so10052242yba.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 21:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=c0DpBOnZ7fHKw3QNWuDsBHLUoP21ketOwjbqwElOkqs=;
        b=G3opd2Kk7smjSi01ZxULHYBb3aZEPYHUyBy3/mRzPOA7AoYOgM1AG5Hr7cycpkvp2k
         7zmIUTwbwGDC2E7T4vT/WYWusN78+R87+am64PQyPlKsAzEmY50QiKUKIAoq02QVC52q
         AeM1hmMw/deHDfPRbcEMAs2fdxfnRnwQin//MD28AjsSEt8iOmIlErdGoPa9zNXWO15A
         X4/SX+bm7r1NdOrUdFOy1qu4GZ4TxCTv6HXUl8Hqc7sWxBBNwG8BE1eVwLXfWAwS1aQw
         +0gDpWtqgpEKjBXTHa3efxgcMH+NWtwBBFv0w/mQISgkan8BA28APqByaEUis7YN7XH1
         gbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=c0DpBOnZ7fHKw3QNWuDsBHLUoP21ketOwjbqwElOkqs=;
        b=iDcprqsn6KyZ0vX8MQm00susJMUOVWyeTyPfLpUNRHp0U00g3yWsBM6SEy8IgsG+7U
         +//ZuZuae5QDSwJWLF2mw5LRE6UgdNEXECPjFmTDd3OHz45KwPle5zfvcXr1XhqhtrAW
         A5VKzxyo2fWNP7fOEbOHtcu12jlLXOAl0OM78R86zDA4U0j4pY+DrJHQuP3FrYwdBGMz
         x700Ghf7NLe6UPY9pq+c8B44MsLmaFlrhq/ZEVjrvO2NQBw0Kq4H5pWxkC+RGvv7fxn6
         H+o3v6gP6EPNSGGoTlX3khs8oFPMeifeBk8MVxneX7Y6kSjjs34mWdpZInpiX2tH7yRR
         DTbw==
X-Gm-Message-State: ACgBeo2WMZqmn9O2wrfV1vTqcYUaTucrXWaeine6e5rGxfUJikkG73Sf
        FybgjBZoa12eNpGxeOHqKRyHWwzEMX9YYSfiRzw=
X-Google-Smtp-Source: AA6agR4yqG8oXRGrN2c3vGVjKmn+ZXcqxyGd3kFbqy9a7TH8mlfm2goz1npG5dcXN3vR8r+Mk+rzj0/w3aimHdWPBSI=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:9755:c523:9dcb:2228])
 (user=ndesaulniers job=sendgmr) by 2002:a25:26c9:0:b0:6a9:922:4a6d with SMTP
 id m192-20020a2526c9000000b006a909224a6dmr1571274ybm.239.1662526775388; Tue,
 06 Sep 2022 21:59:35 -0700 (PDT)
Date:   Tue,  6 Sep 2022 21:59:07 -0700
In-Reply-To: <20220907045907.484043-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220907045907.484043-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662526746; l=2043;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=0UUXvo2ECsHljJrCvpyFZ/IOiA9qf1pxH+OXOsjnp1k=;
 b=EPZloRmrF5sgzyoix1T+c/b0M8kYWBCLqwRogtnVgQh3+LO3Uy4aqeBCu1Thtarw+ZI/xgMsperC
 QC/5HfWjCEpJsJsOsjwgYmvtS6GTbJlSsOD2ruSzWrRZsqSP2wbm
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907045907.484043-6-ndesaulniers@google.com>
Subject: [PATCH v3 5/5] Makefile.debug: set -g unconditional on CONFIG_DEBUG_INFO_SPLIT
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
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v2 -> v3:
* Pick up Nathan's RB tag.

Changes v1 -> v2:
* Add reference to 866ced950bcd, cc Andi, in commit message.

 scripts/Makefile.debug | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
index 2845145c1220..c20f8f2e76bf 100644
--- a/scripts/Makefile.debug
+++ b/scripts/Makefile.debug
@@ -1,10 +1,4 @@
-DEBUG_CFLAGS	:=
-
-ifdef CONFIG_DEBUG_INFO_SPLIT
-DEBUG_CFLAGS	+= -gsplit-dwarf
-else
-debug-cflags-y	+= -g
-endif
+DEBUG_CFLAGS	:= -g
 
 debug-flags-$(CONFIG_DEBUG_INFO_DWARF4)	+= -gdwarf-4
 debug-flags-$(CONFIG_DEBUG_INFO_DWARF5)	+= -gdwarf-5
@@ -15,6 +9,8 @@ ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_AS_IS_GNU),yy)
 KBUILD_AFLAGS	+= $(addprefix -Wa$(comma), $(debug-flags-y))
 endif
 
+debug-flags-$(CONFIG_DEBUG_INFO_SPLIT)	+= -gsplit-dwarf
+
 ifdef CONFIG_DEBUG_INFO_REDUCED
 DEBUG_CFLAGS	+= -fno-var-tracking
 ifdef CONFIG_CC_IS_GCC
-- 
2.37.2.789.g6183377224-goog

