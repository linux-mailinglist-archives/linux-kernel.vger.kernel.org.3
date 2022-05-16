Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE31E529481
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbiEPW6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349952AbiEPW50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:26 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A3B44776;
        Mon, 16 May 2022 15:57:17 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id f9so1821265ils.7;
        Mon, 16 May 2022 15:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kFgHG2tewJsN9CYAlq+NJbyhVM4qxnXd9vUi/EQochg=;
        b=APwWUbR7WCm/vV2bYkZXreJGyjTXBdujWBM/SmErqdwxgUV0hDj0LLMU6s9poeH5iT
         FXKjac2KPaRmv5i79zC0mhsAUsVXiwZqRh6viD88comH/LsImmGjEPd5EKvJJjjGwetm
         dtdMPDlrGdED1Igfq+1ncnqB3mLuF8AnEA9mwLdvjf74BU6/WlsaIU1uqRVA/gkYJFFJ
         xzX5VE9gHbP7E5WIC99KeZ8T7SwN6qhNeEUFjOZvi3imC2ZnFxskOMGw/wC7PKgEVeW4
         mB7B32fpSnKhf5ymmcNfiMKYx2Mfx1TPQo9gLZcNV3R/rJU9tIZ4TCYpnFCG1zTWOu3n
         UjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kFgHG2tewJsN9CYAlq+NJbyhVM4qxnXd9vUi/EQochg=;
        b=LWEvw8Qch0Qqm6ghKz5Kew0aLPNUDm+Ed8CDF7Gosq9WhglpCnOYZEpKTro9gw4tck
         YyqIuKnV41K1SKbw0naLTjnHMR/naMR4uq6szki/9whV+pQfoLR/f5DO3pVU/eLZg1fv
         WQl7PX5zEZwCZKwz46k4SMuxCnUm6FZtTDejVYqgE6MJqVYWw0A17ffOQB5YF02adtuL
         31L4xvaep3CuwamqJaTw3DWdqedpl0b56GwFedBmSm/orN/iG/l6KRQsFKXX8Km+t2N8
         gfmLi1sLFhsFyfcUOSpxSCK203S+67+6at8l8c6kQyfGDhrotf86VFn17vSfxgwz8f7I
         dRkA==
X-Gm-Message-State: AOAM531oZiQr2RH2rSpys+skBzvnNxOgoTGWsR41l1G0ND7GTRzvlSmZ
        NraUE/2Qdcb82VEACjS5mPU=
X-Google-Smtp-Source: ABdhPJwTljlWB+rSMPzyqgN07gjHdFBLaJfrHnMONzCrRckPACxxE9mLZ+oS1CTCjNd2OY7YFa1OSw==
X-Received: by 2002:a05:6e02:1587:b0:2c2:5c48:a695 with SMTP id m7-20020a056e02158700b002c25c48a695mr10131603ilu.169.1652741836722;
        Mon, 16 May 2022 15:57:16 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:16 -0700 (PDT)
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
Subject: [PATCH v2 13/27] dyndbg: add __pr_debug_cls(class, fmt, ...)
Date:   Mon, 16 May 2022 16:56:26 -0600
Message-Id: <20220516225640.3102269-14-jim.cromie@gmail.com>
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

For selftest purposes, add __pr_debug_cls(class, fmt, ...)

I didn't think we'd need to define this, since DRM effectively has it
already.  But test_dynamic_debug needs it in order to demonstrate all
the moving parts.

Note the __ prefix; its not intended for general use, and doesn't
include any builtin-constant checks that could pertain.  I'd prefer to
see a use-case where copying the drm.debug model isn't better.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index e9e6d0f503f3..abf43e28d8d3 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -216,6 +216,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 					_DPRINTK_CLASS_DFLT,	\
 					fmt, func, ##__VA_ARGS__)
 
+#define dynamic_pr_debug_cls(cls, fmt, ...)				\
+	_dynamic_func_call_cls(cls, fmt, __dynamic_pr_debug,		\
+			   pr_fmt(fmt), ##__VA_ARGS__)
+
 #define dynamic_pr_debug(fmt, ...)				\
 	_dynamic_func_call(fmt,	__dynamic_pr_debug,		\
 			   pr_fmt(fmt), ##__VA_ARGS__)
@@ -246,6 +250,9 @@ struct kernel_param;
 int param_set_dyndbg_classes(const char *instr, const struct kernel_param *kp);
 int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp);
 
+#define __pr_debug_cls(cls, fmt, ...)		\
+	dynamic_pr_debug_cls(cls, fmt, ##__VA_ARGS__)
+
 #else /* !CONFIG_DYNAMIC_DEBUG_CORE */
 
 #include <linux/string.h>
-- 
2.35.3

