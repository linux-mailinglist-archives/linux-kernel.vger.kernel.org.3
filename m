Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579665AC72B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbiIDVoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiIDVmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:53 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8842F390
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:35 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 62so5674077iov.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6ZAp0SLSNepdkM6caeO4skWDicbHMA8OFY8bo87a1Nc=;
        b=DfX4/ghpRrLMvEAxpwWwPbtD5a1dkzxKOUPp2TD6F2q29vGGj/18IHkmJJpqNGED84
         ReA0JJE5AA9AlXq8pGzPQjVUBQcsMR8EpnSbOuKD6tojGRRoX3dI2Ud0v22DsMUX8opI
         d3JQlwkymuNoAqrccLE9gDUMCmRsZkunqKR2XFWr2KptUsf2TiLlIieQnWztzPo6ZUgh
         MiQCOt2dHNm9l4z5HrlM5ImqTPv0SubrVLnrEYTh/r1aKOa0fhVY5VE/iog4DwbkB60l
         BBQjI90yzoxv+hYSTdUZRg31WO5JZtO0Ko4fDN3r4WVdZF42swnnS3An562cNwwtMv5i
         lx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6ZAp0SLSNepdkM6caeO4skWDicbHMA8OFY8bo87a1Nc=;
        b=yHLlq2bJlJRT4/6dCCrLLNJxJmasdwZqMO8j4KeawthUcZx2TMQLZ6yA2p/KAuDyQq
         +L3UpR+sIjgMbaVRqIkCj0b6Q7ze70qsuaO8FdUYGiwx+gDUr6qw3LGVuiBFAR9aSgyJ
         suEH+D4Vg5XzKjYNok+EBKhp77R6Bd91RvFvdZeY7WJ91K5AaBXLMFErhR/05+yGpv2P
         9qKy+iKG80dN81T3/IAsGybVz5I8oY7JPvYz1LYXmBjeKchwiZ+0Nx+rZa9guCrHYK9+
         G/5c2wBwi6hO5lUKSXSGpmIkMRr3sHriIjX5QvSnW2DbQVwEdHaE6IYm5n6oakgH0Myl
         gWOA==
X-Gm-Message-State: ACgBeo2PJQuN1kNCWoAiMfKOlwTrcd9C3aExbVOBuKizDEMNElbFhuIJ
        ac1xDPRU1x1+FFjOtJEJBSA=
X-Google-Smtp-Source: AA6agR7xT5UcbaaPMupHq74aD54OF9ftmAPlIhpkXGE6kw4lTSCQlvdL0+PZQyRTjzyip0WI8xfCIg==
X-Received: by 2002:a02:3f20:0:b0:342:c96d:2f8 with SMTP id d32-20020a023f20000000b00342c96d02f8mr25501456jaa.74.1662327754895;
        Sun, 04 Sep 2022 14:42:34 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:34 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 26/57] drm-print.h: include dyndbg header
Date:   Sun,  4 Sep 2022 15:41:03 -0600
Message-Id: <20220904214134.408619-27-jim.cromie@gmail.com>
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
2.37.2

