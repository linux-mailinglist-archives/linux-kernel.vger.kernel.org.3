Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EDC53B255
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 05:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiFBD5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 23:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiFBD47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:56:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF65C4F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 20:56:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb7d137101so32736767b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 20:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=LuUhsyPypQZGU3jrXJoAWrZRXReGqGn6qLSIaznozAI=;
        b=E4IWPG7NT1UNf7GgQZe5LzAC8VRVYnRLzg5OUu2SgHPIm1/RvPYznhXRfW7f/mLixq
         qv9VNC/sWKPyFMPOfc+CTVdC6tc5MuIdmS5C/UoaNmYLr7K1pNTub+L9xw/QT09YZaC+
         f2XZcEbtFREwvM1WK1LwmNTj/lTfmObEgLlZ1wXIv8ZOJFosqJ6gfsu75H58qx1h+Gzj
         ZTFiVMPMzXH0VjoW3I7ayX7JX6iRP28ZPk/8sUptlfDI8CVh2EQ4Fez6yyH3yT+K3/Gf
         i2gVz5aJ2jpi+RwW6HucKlndxXRGrZUeAWNp14c5b6EA/SWp0ziIm7uO1p0FmZRbrE20
         3PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=LuUhsyPypQZGU3jrXJoAWrZRXReGqGn6qLSIaznozAI=;
        b=RET69JPacPQPSX6n1pFBBANZZs0gLBZis3mCRQca1hIoz0a5WkyFb5ILq5rNLLiXtZ
         1gH0JBPOv126oKWrdB93NYegLQ1JffhkFwwMavzbwxaaV+I9GiheSZsovnDN3MCywhdm
         97Ih6S6UXG12KsrdXhZX321/ED4mH7pfBP4dAm9Mc9irjmoRk7J54ewXSApuzyTbSP7O
         jTJZFtLi19V4HiTulz7tEwm8xsbwVHmkKetbGVkPJTi4hEBcN8TBYy0WZHXrcbLVqBlI
         aQQvuF98JUjrLwdu3obUgkulTI3bD4DXSMbM+AjTBt4ZcxIhtGiTSGv/ThdN0g8sGx0b
         2ESw==
X-Gm-Message-State: AOAM53352FqyTJ1+M+0V1sqtEDdvDWmSE3O3Hs96F3XGM532XmkN2YVU
        EYQHEDB2ZfoFMg2jhPR93N2wioDb/dnBkEw=
X-Google-Smtp-Source: ABdhPJwn00Xm5TeG8g1UhL2QZig3oGqw407L7c6XxVwg/P5zA9iQtgMe4kID06ml4/12GqzzsZIaI5vyC4db/fk=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f3aa:cafe:c20a:e136])
 (user=saravanak job=sendgmr) by 2002:a25:2e46:0:b0:65c:d35b:2441 with SMTP id
 b6-20020a252e46000000b0065cd35b2441mr3211894ybn.249.1654142217260; Wed, 01
 Jun 2022 20:56:57 -0700 (PDT)
Date:   Wed,  1 Jun 2022 20:56:52 -0700
In-Reply-To: <20220322140344.556474-2-atomlin@redhat.com>
Message-Id: <20220602035653.4167316-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v1] module: Fix prefix for module.sig_enforce module param
From:   Saravana Kannan <saravanak@google.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     Saravana Kannan <saravanak@google.com>, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        kernel-team@android.com
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

Commit cfc1d277891e ("module: Move all into module/") changed the prefix
of the module param by moving/renaming files. A later commit also moves
the module_param() into a different file, thereby changing the prefix
yet again.

This would break kernel cmdline compatibility and also userspace
compatibility at /sys/module/module/parameters/sig_enforce.

So, set the prefix back to "module.".

Cc: Aaron Tomlin <atomlin@redhat.com>
Cc: mcgrof@kernel.org
Cc: christophe.leroy@csgroup.eu
Cc: cl@linux.com
Cc: mbenes@suse.cz
Cc: akpm@linux-foundation.org
Cc: jeyu@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-modules@vger.kernel.org
Cc: void@manifault.com
Cc: atomlin@atomlin.com
Cc: allen.lkml@gmail.com
Cc: joe@perches.com
Cc: msuchanek@suse.de
Cc: oleksandr@natalenko.name
Cc: jason.wessel@windriver.com
Cc: pmladek@suse.com
Cc: daniel.thompson@linaro.org
Cc: hch@infradead.org
Fixes: cfc1d277891e ("module: Move all into module/")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
Sending this patch in case my analysis in [1] was right.

[1] - https://lore.kernel.org/lkml/20220602034111.4163292-1-saravanak@google.com/

-Saravana

 kernel/module/signing.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index 85c8999dfecf..6b0672e4417b 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -16,6 +16,11 @@
 #include <uapi/linux/module.h>
 #include "internal.h"
 
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "module."
+
 static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
 module_param(sig_enforce, bool_enable_only, 0644);
 
-- 
2.36.1.255.ge46751e96f-goog

