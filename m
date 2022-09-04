Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885225AC70E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbiIDVoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiIDVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:54 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73712F39F
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:36 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 10so5685341iou.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JJmkd9QkaZyaFdemWU+lkrR5661ckSN9S5LOBM0abWI=;
        b=Ekp5LSqCs4NIcDItFljM2WjOwt/efnWVaMW3yCqrqsUihOs5E0jY1gRnas7XeEnwXQ
         mJczoHE301+UhR2sdrk2Z8XMrus7OmPoIHzPLx9pOfthkP14wtWEMeSmcVDFGWB/CtdJ
         QoGwdbXBIatuJbFnjhsoLD7HBBwTwthzbbd/ephKZj4F869SAIYstaCw9X5XldSmfsj5
         425BY3FM/yceTIl0QRHpBbqSrZ3pLSgxz0QvSfOSxR2x3onovMe0LjQXpUS5rZwJQTDD
         f0EEtc2lmFOrlMPRrbL5XtYdvoUv6FfCFWPMR8AZBn6i4YQ82dbzn0YVDauHfrda6dbp
         qmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JJmkd9QkaZyaFdemWU+lkrR5661ckSN9S5LOBM0abWI=;
        b=J2/J1OOgY9+exRKjbn14/m23WCAjYtMr6FhYtcoIEcjdeSXrHSM6lW5qENVDHruufp
         9MrriCCiNrRJYBKiUjeN5maRavpHRN5MIGgLO6XYOgMHYmEXOgd1qpxSEhyqn1iKXpcK
         r7JOwj6Y5A8+hNFjfeiTOWkAkv5pUSVbjt781g5eQLfPPAFnXBhy+LGf6vsHhg5227ul
         9RAGpmyFokn7fD6Sv+cdamdMuf8xSEkuyqdpCHD0zeu+fgtLzv3vN++os18eOp6B0ocd
         Ia4E5i4TP7j6l9lGF/efr4RAIQNJtjlZx44ssGipmywvwKF5/fuNjAfV2fYJj2rUF+Sy
         qDxw==
X-Gm-Message-State: ACgBeo1bvhg5bR27zoirYiJETgL7G8juFd2F9y975knMJgR4Xeppn11T
        +A6by7TQEG02U+x20wjUd54=
X-Google-Smtp-Source: AA6agR6Y58eeN88K8D4OKhkCxT/e0VQuWiJ6m00+40bBTPAFdN9SV1gHrr39O9uhC7t16UdJ5cZYpQ==
X-Received: by 2002:a05:6638:224:b0:350:6e7b:8e59 with SMTP id f4-20020a056638022400b003506e7b8e59mr4269174jaq.237.1662327755824;
        Sun, 04 Sep 2022 14:42:35 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:35 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 27/57] drm-print: add drm_dbg_driver to improve namespace symmetry
Date:   Sun,  4 Sep 2022 15:41:04 -0600
Message-Id: <20220904214134.408619-28-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
MIME-Version: 1.0
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

drm_print defines all of these:
    drm_dbg_{core,kms,prime,atomic,vbl,lease,_dp,_drmres}

but not drm_dbg_driver itself, since it was the original drm_dbg.

To improve namespace symmetry, change the drm_dbg defn to
drm_dbg_driver, and redef grandfathered name to symmetric one.

This will help with nouveau, which uses its own stack of macros to
construct calls to dev_info, dev_dbg, etc, for which adaptation means
drm_dbg_##driver constructs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_print.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index f8bb3e7158c6..dfdd81c3287c 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -468,7 +468,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 
 #define drm_dbg_core(drm, fmt, ...)					\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_CORE, fmt, ##__VA_ARGS__)
-#define drm_dbg(drm, fmt, ...)						\
+#define drm_dbg_driver(drm, fmt, ...)						\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
 #define drm_dbg_kms(drm, fmt, ...)					\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_KMS, fmt, ##__VA_ARGS__)
@@ -487,6 +487,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 #define drm_dbg_drmres(drm, fmt, ...)					\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRMRES, fmt, ##__VA_ARGS__)
 
+#define drm_dbg(drm, fmt, ...)	drm_dbg_driver(drm, fmt, ##__VA_ARGS__)
 
 /*
  * printk based logging
-- 
2.37.2

