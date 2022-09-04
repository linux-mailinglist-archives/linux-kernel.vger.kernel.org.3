Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE835AC6B7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiIDVmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiIDVmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:15 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D152EF2B
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:12 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q81so5653536iod.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uH+4PavI6tAvpP/bjllSxBrsqqx6lF8VrU02FESH7jw=;
        b=KSguwditGP/8FfWJ8QbYlUiwq8c5izqFVOSRXyhmdm05P40z31yyLERnx/4KMPZ18U
         yGQR/CcjnDmULO16vw9EZu863miip8Q4Ywm4OktFjjZNUdUqH0muQK6Hts5AQIQFY6EB
         Gnd8tvXDTP4gJcju+NDHoa6XhCzxcDglfVGpQH0OUqyXe+AwXj6MR3J0j7QIftZAI5mj
         aaAjnkm2GGxbLWKdhe9FWSpkC220hHqlwQNKss4GdfYbEiEqODGTAqXksS6qf8YV6XOx
         K+5l+OjHWI7q3CG8hiEA7+JF714yQmdURuxM/WmEm8lMmPJufYDfmHmioTV5V0ZMKzak
         OMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uH+4PavI6tAvpP/bjllSxBrsqqx6lF8VrU02FESH7jw=;
        b=qd9qyxCNiglQ5IFMvi8xYPTJNx/3RHtz3TqoVttf979PuDX/uyNF5YxGEripLH1Q5Y
         mTHtjKF4PPMJuh+xmjnDl/1YgyR6ls7yAbz3huqa6pyPFAhAg4JLdpJenH0gjp8vDrZB
         6x5wwB7bhJrb4D5QE+u4ohV+mwMoTpBVK7/MrQ1JsuVYRVEWlO47DxX7qSnJWViabXAm
         ijWK4bmBRFNoT9WQXW4Cya9HgTsyq3EL5gGEmjaFtcKMTGURUFoNMjJU8qFNHdJ1Bdra
         YIj6HcF2fGnbbDOX8+txTQ+rGdYlL5n41m2AkzlED12hts4I40qxXQjuV509mvJv2K5c
         kPkA==
X-Gm-Message-State: ACgBeo0QuTbE4dJAlDCIN8FdyqMihrc2L1puY5T7WoJyldTFn0CiMUjh
        c0Dsw9pu+MSC6JZXyLW5WMboWHVqYdY=
X-Google-Smtp-Source: AA6agR47srkJpi3DXb58PnE0nCQCRP4+fmezLwneAZEvxkrMVJGtdvwOuDoiXOHxF1d7qDgzdSj+Lg==
X-Received: by 2002:a05:6602:140d:b0:68b:1bd1:1c54 with SMTP id t13-20020a056602140d00b0068b1bd11c54mr18562369iov.9.1662327731887;
        Sun, 04 Sep 2022 14:42:11 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:11 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 02/57] dyndbg: fix module.dyndbg handling
Date:   Sun,  4 Sep 2022 15:40:39 -0600
Message-Id: <20220904214134.408619-3-jim.cromie@gmail.com>
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

For CONFIG_DYNAMIC_DEBUG=N, the ddebug_dyndbg_module_param_cb()
stub-fn is too permissive:

bash-5.1# modprobe drm JUNKdyndbg
bash-5.1# modprobe drm dyndbgJUNK
[   42.933220] dyndbg param is supported only in CONFIG_DYNAMIC_DEBUG builds
[   42.937484] ACPI: bus type drm_connector registered

This caused no ill effects, because unknown parameters are either
ignored by default with an "unknown parameter" warning, or ignored
because dyndbg allows its no-effect use on non-dyndbg builds.

But since the code has an explicit feedback message, it should be
issued accurately.  Fix with strcmp for exact param-name match.

Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Fixes: b48420c1d301 dynamic_debug: make dynamic-debug work for module initialization
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index dce631e678dd..f30b01aa9fa4 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -201,7 +201,7 @@ static inline int ddebug_remove_module(const char *mod)
 static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
 						const char *modname)
 {
-	if (strstr(param, "dyndbg")) {
+	if (!strcmp(param, "dyndbg")) {
 		/* avoid pr_warn(), which wants pr_fmt() fully defined */
 		printk(KERN_WARNING "dyndbg param is supported only in "
 			"CONFIG_DYNAMIC_DEBUG builds\n");
-- 
2.37.2

