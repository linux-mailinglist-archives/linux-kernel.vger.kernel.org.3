Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56855905EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiHKRgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiHKRf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:35:56 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAB76A48D
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:35:56 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 68so8534775iou.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dW/qowRKwpSX+eB9zQgpcFjLzbW7/9zpGPg2Go1FHeI=;
        b=NJ9PcskJy7nr2SjTCl4gvdy0wSBjPffJjU2h/Z2dYq1Phl9+gYPeVXo4DIqTOSSG4S
         4G9wuzt2TjUxrQXI5TYSOQ28Qtwy09xK7BYDDxBP4IPub7lczOuQ97P7VVf4YLQDJh0m
         JS3ukgNVw2+2O3nIREoCKYXbnmaB+aPZ4Qf7DM2OECxKEVWQBFg0rIJPZVw8SU8M7hw7
         UjgsMOma2HU+IucUoSZSCI4SAb/xEzQtsPXXW57rJFgn82KpTLxXw6e0uOjZqRZg5G2u
         mwxB5lItFR2s3zTXHlSthyXpbP1BmdOzsQm64PgkmV7qVDrIU+8gQLf8utHmDsRRhnuZ
         QHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dW/qowRKwpSX+eB9zQgpcFjLzbW7/9zpGPg2Go1FHeI=;
        b=rXfjzhCE+opvhtLXponBEmvQtymJ0fCI20wA0ny5NhzYCKWk/WQ9EYMHwkvMrVvgig
         2L8/efuJX4ySn2Q47YUuJkyfBVd+dAF5a9z3w8iOkWGK2llJwxhyYUG61rSwH5JsGsH/
         A0EgK+lv6yu3WuIHXrRCTsMBUueiX7Ho+u6ZfPSlO9s+eORXeba9PjuDXNT6TLYdnT74
         fdwSta1hBiJblcDt0PojdGP2VzVC6tyC/EknQ3zTD2tKcsFpy5lNWHYQtIgjnEZP5oKH
         DVU7EAJHLLTrsGr0eCaVp1I+VnG7sA4aO5qgaHVJINWQC9VIg4c5ZNObAQPbVAspPO4S
         mJFQ==
X-Gm-Message-State: ACgBeo2HylGwhervXrMTAAtvjXLD7xELtw+BR/y9ensDlbSZJAiUvQUN
        uy1OhaOFZfgDMpMuy7VVxw4FStwkhv8=
X-Google-Smtp-Source: AA6agR6k0UFYv17BoW0YB3vq8lKhQKXYQ/mv+AHacBINfJyqF4kt5lsxoWDQYzq/gziVWoeDm2amQw==
X-Received: by 2002:a05:6638:25cb:b0:341:6546:1534 with SMTP id u11-20020a05663825cb00b0034165461534mr182370jat.308.1660239355483;
        Thu, 11 Aug 2022 10:35:55 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n9-20020a056638110900b003435e8635bbsm27928jal.77.2022.08.11.10.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:35:55 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 02/11] dyndbg: fix module.dyndbg handling
Date:   Thu, 11 Aug 2022 11:35:32 -0600
Message-Id: <20220811173541.2901122-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811173541.2901122-1-jim.cromie@gmail.com>
References: <20220811173541.2901122-1-jim.cromie@gmail.com>
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
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Jason Baron <jbaron@akamai.com>
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
2.37.1

