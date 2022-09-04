Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557B75AC70A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiIDVnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbiIDVmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:31 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0048E2F007
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:22 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d68so5628878iof.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9SzKct1HE2F9SFFHU0qV3d4yTS+Vy3tZKPhpRiWkMoE=;
        b=keVbDAqmRl0RyYCgYBZ9vpqCQmkMyk7el0JhW316fk9lzXS1Qp8s1NvY5dl+0KhmSp
         ibqXTnOnHqVsgbVNxEqbtv43vgYRsJvWCMIHnYD2MdOnweaxtJ/6lJmRUKioxtauNnK3
         MAOa5YY5NhAaVnZUHf9WjVTMmFZFR8zfXvqsn6ug0qyuxgGFFgrtJhQLojNKtMyGeGVu
         +yc9Lpue47auQ2O1yq9JKZ+AL+lsysQCM4CP52NRtG4YNpaMNSOR2BmwDKNu/vEgwcNy
         CzChZLaOzOawknlDJ4jxM+ihj0KwR+efhIg2T10h1eobX6skVdqLap7sQsWzIfHZi9ST
         UvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9SzKct1HE2F9SFFHU0qV3d4yTS+Vy3tZKPhpRiWkMoE=;
        b=mLoPzAT0tPQupExuRDKWzYWQzNaZ4pujoLH6pVtLffbC4w3/0hLg7Uv40LS56WeKVC
         GjEe0Ai5MWzbHj+WQPriEXpoIcH/1e7b7lsXMWepMUAtRyJAcq1bwj9xH0kwCOv0r9t0
         UVOD7+60wOdxexNHti9XjKBj1TEj4yYvnrrWgwhneXB4H2pMLYtksIhChmgmqzYZrMLR
         ciJzF8ISAO1zpX/14fnOhuWhshz2ufqGQjeQ/ftxki5HfLR4Aon2DDeTAE4E1oW5txpn
         3vHgvevcObRrw0O0tA63WfNJhBl9jGzU5bU/cehBQGaj7YVQf3Pil6A1llQMMyyjv2+a
         uulQ==
X-Gm-Message-State: ACgBeo1tFrLkaHbmR7MTjoeBK1zbtA28knuLirFM8azroP9Dh8K6NrNo
        gltpuuc0XbEYSA5wBxywFgM=
X-Google-Smtp-Source: AA6agR6jMolGXndfzGgA0ZvJd/LMfHAfLgpxQDVqtziCymaTm3c0Mj4mJvOTk/aEeCbTagH4y5NkEA==
X-Received: by 2002:a5e:8407:0:b0:689:ff32:84d3 with SMTP id h7-20020a5e8407000000b00689ff3284d3mr21836771ioj.180.1662327742655;
        Sun, 04 Sep 2022 14:42:22 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:22 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 13/57] dyndbg: add __pr_debug_cls for testing
Date:   Sun,  4 Sep 2022 15:40:50 -0600
Message-Id: <20220904214134.408619-14-jim.cromie@gmail.com>
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

For selftest purposes, add __pr_debug_cls(class, fmt, ...)

I didn't think we'd need to define this, since DRM effectively has it
already in drm_dbg, drm_devdbg.  But test_dynamic_debug needs it in
order to demonstrate all the moving parts.

Note the __ prefix; its not intended for general use, at least until a
need emerges.  ISTM the drm.debug model (macro wrappers inserting enum
const 1st arg) is the baseline approach.

That said, nouveau might want it for easy use in its debug macros. TBD.

NB: it does require a builtin-constant class, __pr_debug_cls(i++, ...)
is disallowed by compiler.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 633f4e463766..3c9690da44d9 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -221,6 +221,13 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 				   KERN_DEBUG, prefix_str, prefix_type,	\
 				   rowsize, groupsize, buf, len, ascii)
 
+/* for test only, generally expect drm.debug style macro wrappers */
+#define __pr_debug_cls(cls, fmt, ...) do {			\
+	BUILD_BUG_ON_MSG(!__builtin_constant_p(cls),		\
+			 "expecting constant class int/enum");	\
+	dynamic_pr_debug_cls(cls, fmt, ##__VA_ARGS__);		\
+	} while (0)
+
 #else /* !CONFIG_DYNAMIC_DEBUG_CORE */
 
 #include <linux/string.h>
-- 
2.37.2

