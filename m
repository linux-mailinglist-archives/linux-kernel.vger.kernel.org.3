Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622AD58B1E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241949AbiHEV5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241794AbiHEVzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:55:40 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0D07D1E6;
        Fri,  5 Aug 2022 14:54:54 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q124so2870318iod.3;
        Fri, 05 Aug 2022 14:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MvvZaZyejoehIrFC0H4qDj9uQr4p5E/545dNTtoQgHQ=;
        b=fmm7BuKL86WTiFUqrM80q8fnvmCCxKQ+yfVo5u5GrNWEh1gPjy0ghMeQvxYOj0gvgN
         aIsy09O3Dx1evrp6fFuBHhveY8/HgH5P5ppwEDDOTdYgSMFgsvz1dPk7zwDSTd2oyY0J
         3l1uXxEurXP9ikBeRlwZKtIzIhdTLmNbK/m9ymG9s44a/U7GLLoNaI0KFPcjTNcV9D1O
         xVUzqXQ+Mekqzt7vMUSAYC6lgHZkyOrAKirTTJDjeOTGA6dD7l/9LEgQjLDfwVMm+elK
         3+uWixDadropzxSApgGocs25a+0Tqzx0o+X+uD12xDBCFI1EeDsPO3XEsF50kl+ysQfp
         7Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MvvZaZyejoehIrFC0H4qDj9uQr4p5E/545dNTtoQgHQ=;
        b=JIE6JG/qXY4vmS2iTM2mXW3jEn1nFn3egTeh8wD9IFiS2BJKP7Snt77PCupC/u+uab
         p5Byf9ndOYEdd4E1Lm23S8oKVrPyIbRG2YbQdlTXJpeWkearBYJuVh8E2mg8Mzi5fT7T
         zB/FsCDmB+tggboLp1GcSfrKvNtsZJsnxB6AkGkWc4CcS17u0BlhVq84sFZRwqkCFzx/
         3I/bk8F1YUysqzUTYwBwrnTzVqroneIo4U1nl+b1Lj3caEax8BTr7Fqlq+uFIcZx9bkx
         h7sGYfh7fdqmKuA3GHRJH0b8EXz2nvEXALq4LAdO5VJcoj22eHRfGWtc8ARObCFLhAb9
         THJw==
X-Gm-Message-State: ACgBeo0FvbGXI1f3jKzQxOWDfmo3EDNrd7oSwpQHZuHHUk6TErnd4GQG
        9eEpbQD02otCILwfqCqCHp5pSE5nFPmfxA==
X-Google-Smtp-Source: AA6agR4LQNNuWcd+Ya1Hiu/OdFHDikxjmg4O2JeCbTNPgEZO0+Mkpasd1ZrjCNDwbo7G5ke9Mk8F+A==
X-Received: by 2002:a05:6638:441a:b0:342:91c9:ccf9 with SMTP id bp26-20020a056638441a00b0034291c9ccf9mr3855766jab.123.1659736493050;
        Fri, 05 Aug 2022 14:54:53 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:52 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 29/33] drm_print: prefer bare printk KERN_DEBUG on generic fn
Date:   Fri,  5 Aug 2022 15:53:51 -0600
Message-Id: <20220805215355.3509287-30-jim.cromie@gmail.com>
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
2.37.1

