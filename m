Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A010457D654
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiGUV5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiGUV5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:57:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79B79369E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:57:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-317f6128c86so24986307b3.22
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pKP7CCgXGMWOvGx6gHAf0azIJTDG1kATrVwV3TY6IK4=;
        b=Y2J6Bchnkv+CY7fj9Wg7lOCkYCImN7mDM66RaF7ySai5rB75A1FN0zw5F+fIPv9T2i
         XriQ1hOaSoMJ/M/vF/GNwl+97zU2D3oixxzVdYiRYPqltnj+aUBZK2+ugRbgZUQk6/e4
         eBT189goXoh2IdOFfAPXLycvPQfowcO0oQzEfAN1Rou+7VleNXBJcpxoHanw1EwjSrJz
         txBT+QMJhq62eoEPVOsz8/fI6snPBcyCZMoc4wJ86mLh6hu3KNt2frJgGAOUnOh3CKjA
         4w6Tg2NEIauF3wdnBVhZCGmDjYvwbGwa20MzgYOIIpludL8Xgob6vOCiezbmg0OL4axi
         dyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pKP7CCgXGMWOvGx6gHAf0azIJTDG1kATrVwV3TY6IK4=;
        b=Fi2xKyvt+Db6B8t71gaq6c+2pHq4ejOiBlNXE2RhRLNnm/XwX5I9IDLHBko5zD9ag0
         ZupC09dxzryTUk1mbOUbDw0bblN9p246UjhEoau5CYXK4QX6gGazizo2K8kn8TaWr1eZ
         m3i1teh+LLzErrKnjGUSqbo6WuhmfFi7NLBK22q06I2fUF2p3IIXOWSyNDcD1ABHXESZ
         nO5YwDG9r2PpLHLTyGQREEkk9NdgihWAOxO8LQRsH+4ug00VdA19PpDpg+vcW6pQ9X1X
         xVcZBjLVNuct2tBArWXXU3yitkY6Y8SrFUIY0I/RLsZEh+LhmC8bZSzewqJ3HdnooXvR
         Iyog==
X-Gm-Message-State: AJIora8DuCDQCD+toStCoJ1EIunzNKOmqM7Jug3gkDDWWB/YJ0eGjrPP
        dxi3rWSuZQ3/n7I4OCm/kPWUqg5FvsD0cI99dw==
X-Google-Smtp-Source: AGRyM1ucB1iTL8zgj8W57h3Rx8oXpnUalg0cp4kTWx7rwMHAc+CSjlaYwWcNIv3Tb73PXxLNcck91OaL+08S0h4qTQ==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:21e:d672:5a6a:420e])
 (user=justinstitt job=sendgmr) by 2002:a81:7c85:0:b0:31e:6c01:f06b with SMTP
 id x127-20020a817c85000000b0031e6c01f06bmr530100ywc.327.1658440632141; Thu,
 21 Jul 2022 14:57:12 -0700 (PDT)
Date:   Thu, 21 Jul 2022 14:57:06 -0700
In-Reply-To: <CAKwvOd=wn=tbX7ixs9a=4zoVSbAU1qP-6NE04hGG9dzvo0zFJw@mail.gmail.com>
Message-Id: <20220721215706.4153027-1-justinstitt@google.com>
Mime-Version: 1.0
References: <CAKwvOd=wn=tbX7ixs9a=4zoVSbAU1qP-6NE04hGG9dzvo0zFJw@mail.gmail.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2] drivers: lkdtm: fix clang -Wformat warning
From:   Justin Stitt <justinstitt@google.com>
To:     ndesaulniers@google.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, justinstitt@google.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang we encounter the following warning
(ARCH=hexagon + CONFIG_FRAME_WARN=0):
| ../drivers/misc/lkdtm/bugs.c:107:3: error: format specifies type
| 'unsigned long' but the argument has type 'int' [-Werror,-Wformat]
|                 REC_STACK_SIZE, recur_count);
|                 ^~~~~~~~~~~~~~

Cast REC_STACK_SIZE to `unsigned long` to match format specifier `%lu`
as well as maintain symmetry with `#define REC_STACK_SIZE
(_AC(CONFIG_FRAME_WARN, UL) / 2)`.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Reported by Nathan here:
https://lore.kernel.org/all/YtmrCJjQrSbv8Aj1@dev-arch.thelio-3990X/

changes from v1 -> v2:
* Use implicit division conversion with `/ nUL` instead of verbose
`(unsigned long)` ~ Thanks Nick

 drivers/misc/lkdtm/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 009239ad1d8a..48821f4c2b21 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -29,7 +29,7 @@ struct lkdtm_list {
 #if defined(CONFIG_FRAME_WARN) && (CONFIG_FRAME_WARN > 0)
 #define REC_STACK_SIZE (_AC(CONFIG_FRAME_WARN, UL) / 2)
 #else
-#define REC_STACK_SIZE (THREAD_SIZE / 8)
+#define REC_STACK_SIZE (THREAD_SIZE / 8UL)
 #endif
 #define REC_NUM_DEFAULT ((THREAD_SIZE / REC_STACK_SIZE) * 2)
 
-- 
2.37.1.359.gd136c6c3e2-goog

