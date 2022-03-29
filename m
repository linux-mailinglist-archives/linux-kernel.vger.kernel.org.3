Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06BC4EB54E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiC2Vbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 17:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiC2Vbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:31:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C098B9198
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:29:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e689dfe112so154931027b3.20
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=P5TBHdIxT5bdh0NQZGvXp/Hfim7NoVNfBg9iw+ca+K0=;
        b=HhFAIZ94MLVFsWOVvsIkSSweYvqqN7xSSA9KtgRCmq6gyQYdJcs84SZvkqEErXkn4N
         AY4Lj7CDJATk0JC6zrjsWvQM6UbBQP35+WfovgmHaNZpWv1WXg0yLavRhl61cUxUosxW
         3lQQYaQvGKKqLMGg8HTrDTuLafjWzbfoqZ8Y337ObvoVkaW37P5REd2ug6dvF80uJWk6
         ZNe4aZw/fHGI4nRJU9UJdnFAK4IxBknkxdXelWlWcJCmuLDWTx/xAHMzIOXN6dHAZF+U
         NYkP6Mjtr7VyEzVdtDyzQb63BphW2zQ0uDgT0YsaMvQQIAn/LPdsqra5wy/tVPwWk/5o
         1v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=P5TBHdIxT5bdh0NQZGvXp/Hfim7NoVNfBg9iw+ca+K0=;
        b=LoDTqlXvcxDuvv4bpfosSZAWo1/zgw8fvusiCFFxUbZAy4y4F5c6rvawMLpczwq/h9
         MD9/G4NK0ajfFPOhTXpQtVG7SuWaCIaLG7q7MhQivfS6jsTyg8IJgt6SuB+6xh7TIuQv
         6JFmbJEstV3VOpB5QS0dpwdg+t4Qm17XCDGlnBpF+W4eVbj7XWq6+Tz8B/395Kb8+tq0
         yDtwKRmRlzby+snvsMFa57NXGjyzsDKJSe7hOtVUVG0iWRxV8mV85AV0XRY7wzg8dIgI
         k1Bu5tNXMag3JfdCjv0hgF42V7m1UFXrCpy/iz4q/0eE7G8VDFuQ+MWiRMYMp3GP8vOr
         QuQA==
X-Gm-Message-State: AOAM5322R2laovR2NzzNN2bvJqXaq3lKu5JCVKQgXhPYexnI/f8PpFQY
        qCcWFUB3AJXE8OF5ZqNUyXkJl2mndtzDqjhaI1Q=
X-Google-Smtp-Source: ABdhPJx4DYVDNRXhsBzxHfrEovi5p3Dz+VcZ+tQlnV4+qvZtjYsgBZ0ChGWdDjIZbZ39iVvA8dGCAKJfLmz/zc877NU=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:75a:7c26:987c:fd71])
 (user=ndesaulniers job=sendgmr) by 2002:a0d:f105:0:b0:2d1:1f59:80fc with SMTP
 id a5-20020a0df105000000b002d11f5980fcmr32641683ywf.77.1648589390535; Tue, 29
 Mar 2022 14:29:50 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:29:45 -0700
Message-Id: <20220329212946.2861648-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648589385; l=1718;
 s=20211004; h=from:subject; bh=puW+jMxS7VYBp0FC4lUNV4G4u9ugxnkqCqfUK1sNtjs=;
 b=jIFU9u0n6sVPD4xJZbyKcG1HWfk8Dgm8nGXkyfCihVlwRmUDpE+ROWm/SVRbyxBzNH7gVNDk+B+C
 H5Y8OtyfB/NaAG6tx1rXNaNl064F2W4jrX3a+pOoJjoXXtFJEIg5
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH] net, uapi: remove inclusion of arpa/inet.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

Testing out CONFIG_UAPI_HEADER_TEST=y with a prebuilt Bionic sysroot
from Android's SDK, I encountered an error:

  HDRTEST usr/include/linux/fsi.h
In file included from <built-in>:1:
In file included from ./usr/include/linux/tipc_config.h:46:
prebuilts/ndk/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include/arpa/inet.h:39:1:
error: unknown type name 'in_addr_t'
in_addr_t inet_addr(const char* __s);
^

This is because Bionic has a bug in its inclusion chain. I sent a patch
to fix that, but looking closer at include/uapi/linux/tipc_config.h,
there's a comment that it includes arpa/inet.h for ntohs; but ntohs is
already defined in include/linux/byteorder/generic.h which is already
included in include/uapi/linux/tipc_config.h. There are no __KERNEL__
guards on include/linux/byteorder/generic.h's definition of ntohs. So
besides fixing Bionic, it looks like we can additionally remove this
unnecessary header inclusion.

Link: https://android-review.googlesource.com/c/platform/bionic/+/2048127
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/uapi/linux/tipc_config.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/uapi/linux/tipc_config.h b/include/uapi/linux/tipc_config.h
index 4dfc05651c98..b38374d5f192 100644
--- a/include/uapi/linux/tipc_config.h
+++ b/include/uapi/linux/tipc_config.h
@@ -43,10 +43,6 @@
 #include <linux/tipc.h>
 #include <asm/byteorder.h>
 
-#ifndef __KERNEL__
-#include <arpa/inet.h> /* for ntohs etc. */
-#endif
-
 /*
  * Configuration
  *

base-commit: 5efabdadcf4a5b9a37847ecc85ba71cf2eff0fcf
prerequisite-patch-id: 0c2abf2af8051f4b37a70ef11b7d2fc2a3ec7181
-- 
2.35.1.1021.g381101b075-goog

