Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6FD4BA2DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241825AbiBQOWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:22:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241848AbiBQOV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:21:59 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEC3294133;
        Thu, 17 Feb 2022 06:21:43 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a23so7692764eju.3;
        Thu, 17 Feb 2022 06:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pszNuayq3uAwPjpzq/uwyInszVpNCtaI4non2ruEen8=;
        b=EzWUOMPttCGG5Yg3G3nXzK6cU6fkvWMUdfJ1CNKVYIofnQ8MBABhzHGcjpeaFGveKU
         1OJ87QrSEX1uuPUc7BJfeIXXIytBzZXFv4LINWFVY4q0nOBh21i+Dm+TNrqGBcP6ILHL
         RYij2xEsD4K9kfiKIPn1kgvc5FXRqQJe3rsjuiXcLRwTgOEY8S7C5EP47XiYxycZvsQX
         tsBHRGZih1VxQ8SDY14SgZdLKxYb6uPxBy9oA9ytoZh6iBNdvdycVP8Shj7JdvFwV3aL
         UaZfCHoIRd/1OXv2XTyFj0JQvyUlRQ2nvRshbjkDNpVEAMTxb0OOkGByWao2Bj/kbnqT
         ErnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pszNuayq3uAwPjpzq/uwyInszVpNCtaI4non2ruEen8=;
        b=XUiOc69KuUXk3MjYuVhhMfvuWVD60tEvQtHYYfXJE0ofvcHgn0CCBW8t9lxj25pyLh
         qULHLOofS/il9LXwSKi2Yqk03+w4Y7KI/cE+w7kNeY8Msh27ZR8dv3GDZPaq9Eaq9xyU
         GZGFzh9/BNRFes9mdCCM3dlOhOA0AqVoL3Q/r2vhwKiu4rXqTbINM005wX/YHe25Qehd
         6hhXTBChGPa23IQOVKDQVf7Q0G1+2cExGkZCMaMmjIJDQTL1ujP0nI4NXVtK8hrp6LGr
         wTMMFIGWCKJ5gPiVxTTTBsLUZ3kznnQ9mDKagZDYxfTFbLauUMxEB2h9/Dyl7e0nt1Xr
         bVzw==
X-Gm-Message-State: AOAM531BeaiNgW4PiYv9LXW4WQLtxVMOe15lPmSYCc2IOkRi4P5phJ/C
        mgPKU+5P2GNxODcIQBxXG9DXO06ZUL8GkA==
X-Google-Smtp-Source: ABdhPJwa0W7mI8nYQ7LIYGYeZKKRoW7ww/i5hwmuOBPRPmWmW0gWn5Vc8PxZZvea3wi00KlNvupvhQ==
X-Received: by 2002:a17:906:c08a:b0:6ce:36f8:bfe8 with SMTP id f10-20020a170906c08a00b006ce36f8bfe8mr2553503ejz.52.1645107701726;
        Thu, 17 Feb 2022 06:21:41 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-001-066-240.77.1.pool.telefonica.de. [77.1.66.240])
        by smtp.gmail.com with ESMTPSA id a13sm578436edn.25.2022.02.17.06.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 06:21:41 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Austin Kim <austin.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 2/5] selinux: use correct type for context length
Date:   Thu, 17 Feb 2022 15:21:25 +0100
Message-Id: <20220217142133.72205-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

security_sid_to_context() expects a pointer to an u32 as the address
where to store the length of the computed context.

Reported by sparse:

    security/selinux/xfrm.c:359:39: warning: incorrect type in argument 4 (different signedness)
    security/selinux/xfrm.c:359:39:    expected unsigned int [usertype] *scontext_len
    security/selinux/xfrm.c:359:39:    got int *

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/xfrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 90697317895f..c576832febc6 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -347,7 +347,7 @@ int selinux_xfrm_state_alloc_acquire(struct xfrm_state *x,
 	int rc;
 	struct xfrm_sec_ctx *ctx;
 	char *ctx_str = NULL;
-	int str_len;
+	u32 str_len;
 
 	if (!polsec)
 		return 0;
-- 
2.35.1

