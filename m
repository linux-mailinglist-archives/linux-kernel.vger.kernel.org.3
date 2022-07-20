Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6305D57C0D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiGTXXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGTXXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:23:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8273B96B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:23:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31cbe6ad44fso838047b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=R+/1pbXuzmkVkOVy5qVFEBVHEW28THt6o2fZNxe3Mxk=;
        b=PdnjK40uqE0rlZAfyoGITLGrx0eRz5JxZ7VRQIerUO+mUtU6DdggO5Ajy3NGMqmKow
         IeTieM6BTy5sLQqE8tqL1gpZrGtnd8WELTcYjwIotVkVpwAmvUXJSnkmcFGeAh4xIinb
         7RBd2n0ycGcN6sTR2j6mt5AOt68f/L+sYICQWEAnAyOAx2po/n6Ub2jx+vDZ3Ys7cOR/
         cLNwNFxXPYWtryBkP+jxU/WJARD+Up+a9L3wTOxEIWs6amWDeG9gjWhf2pMlFsiXhGCB
         qqDicb5nVMv2sAlb/DqGazIarpYZDaOi91FxuwIMwuUd+WPztxwagBMiWLBinCi1D6Sw
         34MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=R+/1pbXuzmkVkOVy5qVFEBVHEW28THt6o2fZNxe3Mxk=;
        b=eTVNwYM0pGqMM47D32LT/sMYgx612EHANOPRzWoYkmVbMBhs/LHaeSJ3kYTxEFNhKX
         LILEP7viEm7MFNxEdFzoWqpN+FEP8vacObdfjBvRa2jDi1tetiEx2DjwmIZ9xAnHiZT/
         jADBSsWb7D/QGUBGuefezaq3jXO4LcfWhnFAlJ3UJEJQ4cCxHSGi8hy708vSADrH2g7F
         9eNFgDEV03j1JNuu5JTQsCIu9SiQA7+Iao68YQe0n/tWk418bM6Y2RlMGZC3FmjbFuuQ
         7oD222NzmgA9D6H0MyoiM3yTOpoxGDlKBOP2Qn1ClqBMNRiDV+nvM6oFiPZYLtjm6Rzo
         LSmQ==
X-Gm-Message-State: AJIora8eEC3VZs9+AKpgxUUnqC9KC/k9E2iUQ9V4epTvFzymh6TD9UQ1
        gBClzLkjr6pTGJLOl+xjw/Kdbh0qaoqhLq+olQ==
X-Google-Smtp-Source: AGRyM1s5yy+h6QaK+AjrtLq6y3FlnydodI5uH79guzSZhcFTGxDYwsSbdfDP6/AXl1R0X9J2R2ETP9lL6nC7QgPDCw==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:c00d:c17d:52be:ff65])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:102f:b0:66f:1145:af6e with
 SMTP id x15-20020a056902102f00b0066f1145af6emr38142323ybt.509.1658359420516;
 Wed, 20 Jul 2022 16:23:40 -0700 (PDT)
Date:   Wed, 20 Jul 2022 16:23:32 -0700
Message-Id: <20220720232332.2720091-1-justinstitt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH] Makefile.extrawarn: re-enable -Wformat for clang
From:   Justin Stitt <justinstitt@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's been an ongoing mission to re-enable the -Wformat warning for
Clang. A previous attempt at enabling the warning showed that there were
many instances of this warning throughout the codebase. The sheer amount
of these warnings really polluted builds and thus -Wno-format was added
to _temporarily_ toggle them off.

After many patches the warning has largely been eradicated for x86,
x86_64, arm, and arm64 on a variety of configs. The time to enable the
warning has never been better as it seems for the first time we are
ahead of them and can now solve them as they appear rather than tackling
from a backlog.

As to the root cause of this large backlog of warnings, Clang seems to
pickup on some more nuanced cases of format warnings caused by implicit
integer conversion as well as default argument promotions from
printf-like functions.


Link: https://github.com/ClangBuiltLinux/linux/issues/378
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Previous attempt: (https://patchwork.kernel.org/project/linux-kbuild/patch/20190201210853.244043-1-jflat@chromium.org/)

Note:
For this patch to land on its feet, the plethora of supporting patches that
fixed various -Wformat warnings need to be picked up. Thanfully, a lot
of them have!

Here are the patches still waiting to be picked up:
* https://lore.kernel.org/all/20220718230626.1029318-1-justinstitt@google.com/
* https://lore.kernel.org/all/20220711222919.2043613-1-justinstitt@google.com/

 scripts/Makefile.extrawarn | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index f5f0d6f09053..9bbaf7112a9b 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -47,7 +47,6 @@ else
 
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CFLAGS += -Wno-initializer-overrides
-KBUILD_CFLAGS += -Wno-format
 KBUILD_CFLAGS += -Wno-sign-compare
 KBUILD_CFLAGS += -Wno-format-zero-length
 KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
-- 
2.37.0.170.g444d1eabd0-goog

