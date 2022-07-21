Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4149057D5D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiGUVU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiGUVUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:20:25 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724501DA67
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:20:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dc7bdd666fso24204407b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xoz21j2Dj3N22i5I3c/WmVlJjyxmAgsmaF7YGZS1igQ=;
        b=r0CrshHTamGdv7nAX2cKNcCLazSyYJyvvzY4UhayDPzGRMDwZRP7CHkXtY4j+xI9wF
         wtfbR1Y2qehU4i7DplHqn+PpyQUavJTWnmwWvvaN87Zcni1NiCma4ABFCtdPyQi9z2UL
         FN/euEa7ngpeu88Fz5KwJH9v2re3f5vdSUOhr+07dc5waTJt70WFEXamTQHH90oEZ8Ez
         s2nmMpA/rQCiffiSNRmt8tRrpGndqSw5TiPqDXRqg+V+4fFPVBvSgmj8C4NLk1/sZz/b
         6iAzxWzIN5vOGy9krYodMG+7pglSQZI4H3v+0MYZO0uuggFCy+8oSczOhCMvL9xAP4Ft
         f2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xoz21j2Dj3N22i5I3c/WmVlJjyxmAgsmaF7YGZS1igQ=;
        b=F5xnhsOL5fO91EptTrRj/6troonf1t3cSUC+mlloYyaw90ZJS5vDE1Clum3maLKSPD
         +VJsSxtYIh/SbWLxc9a0BwU9vJRI35HXd15rZwsHF2RVkm4tbBU2VmHtFcCPkYhmY4S+
         9jOYvNzQaBanTkrpdfJDAmpju2ttIBWjCg73TP9hOgENze/4DAGxWbjm7k8mvTqi4kyn
         ladICndzqn3wAwMwLLjzid+hIansv0o0aSUR0foaP0RWKZGwEwiI91sPbnDTBn/9C16A
         vE1HKS2ct/ZXu12T0ogkH5lnRTypxu52Ugx9hkNAngVxxM9M8wXLgh+DEZzvVdhs4Npc
         rRNA==
X-Gm-Message-State: AJIora9c8ASxrf4L6cHVC92Mh/luUS89S1dq00guG8HnyDY4/kWYupxC
        X8502zR3f4O/ggcTjtvQpBI3cAqBzbmsURUM3A==
X-Google-Smtp-Source: AGRyM1vEU0TU6446zcFlt8XQ41VpLNIDpvLPJJWLFyAvdYxrrXtwtri0B4ajRFiKvqzZ4o36bIfOakNDOfb3+fL11Q==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:21e:d672:5a6a:420e])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:706:b0:670:a469:6efb with
 SMTP id k6-20020a056902070600b00670a4696efbmr500406ybt.410.1658438423802;
 Thu, 21 Jul 2022 14:20:23 -0700 (PDT)
Date:   Thu, 21 Jul 2022 14:20:12 -0700
Message-Id: <20220721212012.4060328-1-justinstitt@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH] drivers: lkdtm: fix clang -Wformat warning
From:   Justin Stitt <justinstitt@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
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

Cast REC_STACK_SIZE to `unsigned long` to match format specifier `%lu`.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Reported by Nathan here:
https://lore.kernel.org/all/YtmrCJjQrSbv8Aj1@dev-arch.thelio-3990X/

 drivers/misc/lkdtm/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 009239ad1d8a..6381255aaecc 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -29,7 +29,7 @@ struct lkdtm_list {
 #if defined(CONFIG_FRAME_WARN) && (CONFIG_FRAME_WARN > 0)
 #define REC_STACK_SIZE (_AC(CONFIG_FRAME_WARN, UL) / 2)
 #else
-#define REC_STACK_SIZE (THREAD_SIZE / 8)
+#define REC_STACK_SIZE ((unsigned long)(THREAD_SIZE / 8))
 #endif
 #define REC_NUM_DEFAULT ((THREAD_SIZE / REC_STACK_SIZE) * 2)
 
-- 
2.37.1.359.gd136c6c3e2-goog

