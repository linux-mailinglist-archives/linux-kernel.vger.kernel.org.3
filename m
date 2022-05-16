Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB7652947C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350032AbiEPW7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350034AbiEPW5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:30 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A55146650;
        Mon, 16 May 2022 15:57:28 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y12so9273223ior.7;
        Mon, 16 May 2022 15:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=275OPBiQ2XPDTBRqKvoZzw/+Pf2YOYW8BZL5aogRIAM=;
        b=erXw/YodA3OXO6nPINUovqh61wUerUIUtr0unKej/ygKy09BntPa7b2Ga/snFnWqRN
         mtoKDgBhHIuI18S7owrD22QKbctFTy/M6o9shAJ6+0ouzudUyjANzXNDMc0Q3hIV+f5q
         XnYixuoQFoJZCiCQDsXoPHqPdfWbeEA0c/7106IbTnzOiTQOCS35fre1X9yfUACWftd8
         LgQfxHSO1ccHM7ZFABS+oM9u+ZYIQfZXUVXowulqyibhSPLwsJiSFjdYhvpsOOygWG+u
         n6kLxDSr0CYelPk7OPO3/RynfWIFOXZ/aAUWpWWu1hoV6RWlrK08yikqaaHJMadlmP8H
         L6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=275OPBiQ2XPDTBRqKvoZzw/+Pf2YOYW8BZL5aogRIAM=;
        b=MvvIecrdZ5eUAABg4mBqYwXsyVwSYYrdacpF7qMBRkdBXb74yl6xST+C3eKocZwlu1
         GAVS2V6p1iOKKaRCCU/TertSdHx6AxZ8A310KGWCca5DRIgivTx/tx/7NHfo9HwFy/gs
         mVSYQmOBOktblc2Wb/vbhv/PhLiObapYb4R0e2FEX+Bou4v5fP6DLbrmOMIEIPp/iYIR
         bZPranxq1cMkIEXzYVeN9YAXITY2kMoLoV+EuS4Wvqs7N90InxKbyJsor2mBLXImW6sa
         I/rVzPVIQHQhwB5tAlOHjPlxlYYfpmagGDDVb9zI3Q5nI9AVuxT0dxu3kC+o6YaPY9UC
         2IQA==
X-Gm-Message-State: AOAM531hd90Yw8KhBd+a1SEMmChGZehI07geHa99qGLxdooosqezczyK
        5XOIKzVfsTCtQxJ63Azp2f8=
X-Google-Smtp-Source: ABdhPJz8ja5KMGhfVRvrrgjeLgWG6Cp8mO/6M9ENzbru9N3/0pmPE3IQ+As/ImX5TSoW3EuTo0LvtA==
X-Received: by 2002:a05:6638:b:b0:32e:3b8d:3e5d with SMTP id z11-20020a056638000b00b0032e3b8d3e5dmr2979106jao.91.1652741847355;
        Mon, 16 May 2022 15:57:27 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:26 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, quic_saipraka@quicinc.com,
        will@kernel.org, catalin.marinas@arm.com,
        quic_psodagud@quicinc.com, maz@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v2 21/27] drm_print: prefer bare printk KERN_DEBUG on generic fn
Date:   Mon, 16 May 2022 16:56:34 -0600
Message-Id: <20220516225640.3102269-22-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220516225640.3102269-1-jim.cromie@gmail.com>
References: <20220516225640.3102269-1-jim.cromie@gmail.com>
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
   its hardwired on currently
   could accidentally: #> echo -p > /proc/dynamic_debug/control

2- optional "decorations" by dyndbg are unhelpful/misleading
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
index 22b7ab1c5c40..1b11a15366b7 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -23,8 +23,6 @@
  * Rob Clark <robdclark@gmail.com>
  */
 
-#define DEBUG /* for pr_debug() */
-
 #include <linux/stdarg.h>
 
 #include <linux/io.h>
@@ -172,7 +170,8 @@ EXPORT_SYMBOL(__drm_printfn_info);
 
 void __drm_printfn_debug(struct drm_printer *p, struct va_format *vaf)
 {
-	pr_debug("%s %pV", p->prefix, vaf);
+	/* pr_debug callsite decorations are unhelpful here */
+	printk(KERN_DEBUG "%s %pV", p->prefix, vaf);
 }
 EXPORT_SYMBOL(__drm_printfn_debug);
 
-- 
2.35.3

