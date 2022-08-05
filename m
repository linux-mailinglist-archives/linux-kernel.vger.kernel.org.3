Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED0658B1D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbiHEV5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241772AbiHEVzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:55:31 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9B011811;
        Fri,  5 Aug 2022 14:54:50 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id v185so2831944ioe.11;
        Fri, 05 Aug 2022 14:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=38b4ptDDIvz2ddGSj5VKmEi/zh+RmsO1/UedvwI7WxU=;
        b=DtJrrTM0KeU+8b/viLC94jltyJcFE60mrEuVXYQV1o++JUn4Ob+xUZE0y5y7tVW3cB
         CbDi305LuxsU/K6tMe6B4AeLFT8aZhIvbuOGpEQYwmHa/VPMdPh+0b1Mmb7tbhnslq2l
         NxbSbsWCdcYZG9PT7jg9bgZ8gupfdCfvM49RioZ+yd/sGMGxWUK+ug9RkciRZFCt2An8
         nOBJMTq5Phw0oEkmUR/XOzwHkyWv89v62jV+rD7vQ7c/UgmiJofYtxToWqYxXFTyquF/
         59XiNq51Cf8UJiRb8IVQTDeiThvAFqbOJIrBr/oIN+HTOE6f39AVY64wFDRW8WffWdoh
         uEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=38b4ptDDIvz2ddGSj5VKmEi/zh+RmsO1/UedvwI7WxU=;
        b=S2ULAqfHGagxqI5inzhMTZLmR6o8rXNodl1k4GVKZLBsAYBSVGisHBmeObqiDupP2f
         jDwHjHU2kF2rA9axpnnVGKs1gSBwvqQ7bkBpX/7nPC1xhBTa02dc3BDY22IGDaJSdD8G
         SO7CKsIkmAYFdfmmQuXKT2Jm2t8+I00g+WAPOhgwBUTKVt+p5e7T9GnhExPb3wc48Ylq
         P+Cjn6S/UnfW6AuN54h0wReC47x4+T5KWbffOQU9mp1T4LdQFjEI0cJKgG749MBSjY0b
         yinMzHMjDAPJ63JSAsdivAK/10RaLJ/zBN/+jAm2Tv7bmUNMoPW80wIzLgsMmfiKOldG
         /nIA==
X-Gm-Message-State: ACgBeo1vSl6HHZb65gMaGMHn200pKwtU3rFO1FV1hr4XGX6TBqfM/uaM
        u/NY84gSQRvmg/7npTqLFdbFhIfIfqR45A==
X-Google-Smtp-Source: AA6agR621XKXrLQiWUu1/0axmxkoh81epfEoghE2k1YD0aYPKC9SfRWprmpI0qGAoNtVO0ewMEUPPQ==
X-Received: by 2002:a6b:c3c3:0:b0:67f:f487:987e with SMTP id t186-20020a6bc3c3000000b0067ff487987emr3625137iof.0.1659736489639;
        Fri, 05 Aug 2022 14:54:49 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:49 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 26/33] drm-print.h: include dyndbg header
Date:   Fri,  5 Aug 2022 15:53:48 -0600
Message-Id: <20220805215355.3509287-27-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805215355.3509287-1-jim.cromie@gmail.com>
References: <20220805215355.3509287-1-jim.cromie@gmail.com>
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

lkp robot told me:

  >> drivers/gpu/drm/drm_ioc32.c:989:2:
  error: call to undeclared function '_dynamic_func_call_cls';
  ISO C99 and later do not support implicit function declarations
  [-Wimplicit-function-declaration]

           DRM_DEBUG("comm=\"%s\", pid=%d, dev=0x%lx, auth=%d, %s\n",

Since that macro is defined in drm_print.h, and under DRM_USE_DYN*=y
configs, invokes dyndbg-factory macros, include dynamic_debug.h from
there too, so that those configs have the definitions of all the
macros in the callchain.

This is done as a separate patch mostly to see how lkp sorts it.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_print.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 2d2cef76b5c1..f8bb3e7158c6 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -31,6 +31,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/debugfs.h>
+#include <linux/dynamic_debug.h>
 
 #include <drm/drm.h>
 
-- 
2.37.1

