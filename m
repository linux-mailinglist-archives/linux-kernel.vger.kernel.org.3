Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67445AC706
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbiIDVod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiIDVnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:43:24 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340032F001
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:39 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b142so5642337iof.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0Id8r2vYLmajWhF+0Lsomg5sSzhIk/Fv798x/2NCQJ8=;
        b=nMgcsqv10t0jNSou/ChM9aj4Oe2Z78Qyt3lMIFBuZ+lquITOKuL5RF792lnxd7UxJ8
         qpp+DhMKR6rD8Oc8zSCbZeoe0h9QjbpOO0YVftf9vHqXoRe8XPNetD5weW3YMiDh/hpz
         X9RMWx9bzPZKcOgMLConc2T+c/6pPJAtaa/JQl2Ee4JRD9rij46vnjQIlGRlSmKUKYKq
         Bepfrnuvr4KbA0CMM4R2ttIK4x2CvNrggANC7Rg2YtNXHsSx94pjtZ8bFBhm7X0MlxoT
         SxodpVFGmtdB1b6dU/Q2eNKDiZA6RGYLKeiZvHON/fhARPCby/xRuXS2G7hj7UBtB+21
         GNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0Id8r2vYLmajWhF+0Lsomg5sSzhIk/Fv798x/2NCQJ8=;
        b=kfRBwJz69bXA752Qnbe+2pygErWyZPTC43NfnHWyRVf/X0xLVeftWnNBftg0MTsM24
         HD3pZc/kOlyHkUGPwt/IMFnUN/HrnTvJyLnM3grruMlqP6BwjAx5MEf1UYNpR/hEKsCv
         EtcnWeFKwBXYfA1MTwHP+hgrbtdBXuFyrqwFRDEvnhftOtKNW5+hnUbbewnlNDUAZTel
         e/goO//sTFz1z3Ix28ddsEYXabj10hQg3DkPcpD97Zum1cyckg3n+6lrZgpVcqgqPx6d
         AlmLnJYn0SZ9uMJp8YlF9sR1OMdK6Yu/Qd1TQPnnfvmKbnyf1Q5RZYN/dbreKZ0ZSa+7
         v0fw==
X-Gm-Message-State: ACgBeo1TkrEZhjnHo1HoGmTsSZsA90PHNsBoVSxI5IEbVF/vGBeXQkF3
        RNess6sds3k3AzQoJAP3+0o=
X-Google-Smtp-Source: AA6agR6b4AaEEfOSIKL24Lu0tIv0q3qOCsBl00MyhLWPv9u8tITL7jjngdAbr9/9HEHOPy1kJLcPuw==
X-Received: by 2002:a02:cc76:0:b0:34c:13cf:efc9 with SMTP id j22-20020a02cc76000000b0034c13cfefc9mr10073340jaq.152.1662327757907;
        Sun, 04 Sep 2022 14:42:37 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:37 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 29/57] drm_print: prefer bare printk KERN_DEBUG on generic fn
Date:   Sun,  4 Sep 2022 15:41:06 -0600
Message-Id: <20220904214134.408619-30-jim.cromie@gmail.com>
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

drm_print.c calls pr_debug() just once, from __drm_printfn_debug(),
which is a generic/service fn.  The callsite is compile-time enabled
by DEBUG in both DYNAMIC_DEBUG=y/n builds.

For dyndbg builds, reverting this callsite back to bare printk is
correcting a few anti-features:

1- callsite is generic, serves multiple drm users.
   it is soft-wired on currently by #define DEBUG
   could accidentally: #> echo -p > /proc/dynamic_debug/control

2- optional "decorations" by dyndbg are unhelpful/misleading here,
   they describe only the generic site, not end users

IOW, 1,2 are unhelpful at best, and possibly confusing.

reverting yields a nominal data and text shrink:

   text    data     bss     dec     hex filename
 462583   36604   54592 553779   87333 /kernel/drivers/gpu/drm/drm.ko
 462515   36532   54592 553639   872a7 -dirty/kernel/drivers/gpu/drm/drm.ko

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index cb203d63b286..ec477c44a784 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -23,8 +23,6 @@
  * Rob Clark <robdclark@gmail.com>
  */
 
-#define DEBUG /* for pr_debug() */
-
 #include <linux/stdarg.h>
 
 #include <linux/io.h>
@@ -185,7 +183,8 @@ EXPORT_SYMBOL(__drm_printfn_info);
 
 void __drm_printfn_debug(struct drm_printer *p, struct va_format *vaf)
 {
-	pr_debug("%s %pV", p->prefix, vaf);
+	/* pr_debug callsite decorations are unhelpful here */
+	printk(KERN_DEBUG "%s %pV", p->prefix, vaf);
 }
 EXPORT_SYMBOL(__drm_printfn_debug);
 
-- 
2.37.2

