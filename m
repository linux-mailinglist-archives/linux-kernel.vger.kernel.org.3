Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F3552941B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350017AbiEPW53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349862AbiEPW5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:06 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A893142A3B;
        Mon, 16 May 2022 15:57:04 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id b11so7613047ilr.4;
        Mon, 16 May 2022 15:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PoO/FHr0Tzfzf5P1B6XW1SDDzBeQTtD4lR71J35fVB4=;
        b=hc4BLkqpCT9R4W4i7l0zefNNlEKY2zz43aOLOytEmIYryaqtFTXD70GWmf0k7ytBSm
         PJqH1duNIjfaYz/dZu9lsTxRmq5rdkLB7Z5H4aiGjvlDvnq1O/sJxzCKbR9TGOBycAyj
         YdFdyAGyiRyLaUCLyQnuZUzm7eymIHnN13wrUv+Ew5wXPQxZhXnhhBOfw7exNw7pSQSz
         XNO3vMkVaXZUdfkfQSkLejRUdXE3fHM5Z8+efXpPJh3fM+yEvN81wzneSgdN2aB6Y8Iy
         3gppEV7yEv86QkoDdeYF3eQZNX5wy+pbp41VoYuA9IxX4Md64KSW12G9/JddFlYNgSEn
         8HFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PoO/FHr0Tzfzf5P1B6XW1SDDzBeQTtD4lR71J35fVB4=;
        b=q5fk0kRqTm4Gzg+s6s5x3eT9dcPY/hACAj07FUVhXZJ6Shv1YUaElh08KYVGdm649O
         J95A427sm8g1Cf39KfVnJkpFLz7vbl++ZfOm15n0dc1v1FXlE5tZTYYdwDgSt/Gs9nCR
         mhdGCemXfjttJ84QymLRBqFHJzz0q+DW6mGViEv60dkYiTDl3IKz33av50ElmJFm7Q7T
         RZwp9jg0rCPchaQWnJ24BAoa0YxPE7XHZmLAxMy404ZU8uW3twA4Hr5J4OjcnUDzyqxA
         MpDgue0KKO/92w0/BvssgR71iH2YvIwuRc3w3yiZuAAJARWgraFrITWAV+JeiM1ftPPQ
         6HHQ==
X-Gm-Message-State: AOAM531TH216gs9YtskHfxL6HOQhovYUF6ELKTcwdHcn8dx/e34SHV3C
        wfHrSOwhqhMgtwh7rKRSbJQbk2J1590=
X-Google-Smtp-Source: ABdhPJwuNA8eYlVKbPRsQ7MSW422HjHltNMa6MYgzwzBN3oyRsIKn3be980+iuLjBzfHqKn+YxCiwQ==
X-Received: by 2002:a05:6e02:216c:b0:2cf:3b9f:72c5 with SMTP id s12-20020a056e02216c00b002cf3b9f72c5mr10013301ilv.225.1652741824045;
        Mon, 16 May 2022 15:57:04 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:03 -0700 (PDT)
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
        jim.cromie@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 03/27] dyndbg: fix module.dyndbg handling
Date:   Mon, 16 May 2022 16:56:16 -0600
Message-Id: <20220516225640.3102269-4-jim.cromie@gmail.com>
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

For CONFIG_DYNAMIC_DEBUG=N, the ddebug_dyndbg_module_param_cb()
stub-fn is too permissive:

bash-5.1# modprobe drm JUNKdyndbg
bash-5.1# modprobe drm dyndbgJUNK
[   42.933220] dyndbg param is supported only in CONFIG_DYNAMIC_DEBUG builds
[   42.937484] ACPI: bus type drm_connector registered

This caused no ill effects, because unknown parameters are either
ignored by default (with an "unknown parameter" warning, see below),
or ignored because dyndbg allows its no-effect use on non-dyndbg builds.

That said, the code has an explicit feedback message, which should be
issued accurately.  Fix with strcmp, for exact param-name match.

Here is fixed behavior:

bash-5.1# modprobe drm dyndbgJUNK
[   20.127473] drm: unknown parameter 'dyndbgJUNK' ignored
[   20.128835] ACPI: bus type drm_connector registered
bash-5.1# rmmod drm
[   37.961656] ACPI: bus type drm_connector unregistered
bash-5.1# modprobe drm dyndbg
[   42.933220] dyndbg param is supported only in CONFIG_DYNAMIC_DEBUG builds
[   42.937484] ACPI: bus type drm_connector registered

Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
2.35.3

