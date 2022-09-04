Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09EF5AC70F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiIDVpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiIDVoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:44:08 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8863C303DB
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:48 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id p187so5653041iod.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F+IqvxQINaymRL+MafidUTbGzpHBkq2RsFapBWAQydg=;
        b=N0zhsOBdmXSpqdVIM7Dax53vYiJTKsqF6x9qw6PLO/aFCYoOS0opwP1W/5aTypbefh
         thcPTdmgHjCwAVeFNHFjBjHzjInzGS+YiXXOrz8p9PMclYRxe1LfcB0y1XUcNo/5BytA
         YEnLhw/gfAr8rG8KozwOaV+lYe7NXyUjy4JmDGJ94WvqWQr15EnP0FR45EtCb9sixA2H
         5PVujoc2/62tw2Rf6QVixL1umMf0g4g0KWpbNPggi2SaHbsUt9ALitBx9exeU1qkh3CT
         vHElW8wRlXwjNWiUeoUytlqPPgsAovjsIKN3Z9gCGdsWoXgjj0apzjKHP7jxrbSbW8d4
         SIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F+IqvxQINaymRL+MafidUTbGzpHBkq2RsFapBWAQydg=;
        b=3Q6QutCUPnMjb7WitR2N3iF/z5Hi7OmUclNAb9YkJHCeoHHVzb2bY8UsHpjXLBLIHq
         DCj11QemdHDE1GXq1CzAtxdvxyv3gFDslZ3j/BZ8MhX2suk3WkOXysTpe9DpyBhCYIk3
         U0Okca/uVSuxCD1HXXWcVIkU1Ymbyvwz0+eq82SzzONwHhdkZlhbN2qXk0ODLXkn74ep
         XfAD5ok5M4Hq7toZV3XBm2EB54aYEyvTFn9L4dTXizUl3XDb43IV86Evis6roVe7mm0T
         o3JwneoTLchtMMO98ChOikR52Rwaf5AlKb+0tBIQj69uqlenyUNqIvUG3EhBydzbmP2e
         yJDA==
X-Gm-Message-State: ACgBeo3foEF8DcbYwS3sp3BxFm2SsW4zt1DsyTApyIJsb8xEcSJzermB
        Nv78UxA2Mtx2GSDbdJ4kzk8=
X-Google-Smtp-Source: AA6agR6wneRG7yCu0WnhzdrmY46L82HWUk9b8e+ZYvtbU/eRsNK3PLQqrk215dPJggzpSd7jRHChZQ==
X-Received: by 2002:a5e:c319:0:b0:68b:2683:8e26 with SMTP id a25-20020a5ec319000000b0068b26838e26mr17614839iok.129.1662327767546;
        Sun, 04 Sep 2022 14:42:47 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:47 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 39/57] dyndbg/drm: POC add tracebits sysfs-knob
Date:   Sun,  4 Sep 2022 15:41:16 -0600
Message-Id: <20220904214134.408619-40-jim.cromie@gmail.com>
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

clone DRM.debug interface to DRM.tracebits: ie map bits to
drm-debug-categories, except this interface enables messages to
tracefs, not to syslog.

1- we reuse the class-map added previously.
   this reflects the single source of both syslog/trace events

2- add a 2nd struct ddebug_classes_bitmap_param
   refs 1, reusing it.
   flags = "T", to enable trace-events on this callsite.

3- module_param_cb([2]) - does the sysfs part

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index c50edbf443d3..75d0cecd7e86 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -45,6 +45,9 @@
 unsigned long __drm_debug;
 EXPORT_SYMBOL(__drm_debug);
 
+unsigned long __drm_trace;
+EXPORT_SYMBOL(__drm_trace);
+
 MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
 "\t\tBit 0 (0x01)  will enable CORE messages (drm core code)\n"
 "\t\tBit 1 (0x02)  will enable DRIVER messages (drm controller code)\n"
@@ -77,6 +80,13 @@ static struct ddebug_class_param drm_debug_bitmap = {
 	.map = &drm_debug_classes,
 };
 module_param_cb(debug, &param_ops_dyndbg_classes, &drm_debug_bitmap, 0600);
+
+static struct ddebug_class_param drm_trace_bitmap = {
+	.bits = &__drm_trace,
+	.flags = "T",
+	.map = &drm_debug_classes,
+};
+module_param_cb(tracecats, &param_ops_dyndbg_classes, &drm_trace_bitmap, 0600);
 #endif
 
 void __drm_puts_coredump(struct drm_printer *p, const char *str)
-- 
2.37.2

