Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABAC5AC707
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbiIDVnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbiIDVmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:32 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03882F025
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:27 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d68so5628957iof.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ka8KRcp96RIs3WOVwaYMps+w4bs0E4mB3tU6nT4x+Cw=;
        b=GxYiBhtnCCLvIcjhtx8t6SNtIL7IN9FTRLpFWPEgQwmEChr7Li1YPuQJ9uzL52Yj6A
         cgqwOnKPTkhyNLE0ZRZ71TysRmVMnqOnOuIZy+W7qyW1e5LLWRS5QYdy3aifvqzwysH4
         6lBOaERL6zccFDJfBmPhlj41W7qOzgatR/sLszHd+5qrcHenG/kiPqGelWghMXTumLSf
         wFRbcjMRbogjvc9bqHIzD2/qSvsiQjcw0SYznzSLJ7jTTu+kn1HauuURN6n5y/Y3xzEP
         XBYr4ufLmOy1cM38/VKtTZMrK2mJrrVShrlX+MdWlctqxmtxNnUASO0irSsXn081Wpp/
         hmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ka8KRcp96RIs3WOVwaYMps+w4bs0E4mB3tU6nT4x+Cw=;
        b=UeA7n6oMrXjKpLpfDTWkCIakbpC353awoupEMh4bkcSFhyeJDz/65PAUoo458mkyCq
         hBsH1iJr6jXMMNV/ppFsCNurIG0nhKpRsLNTyqJkcZHmkoNd3UHu+kVlEpAhp9GsRLQm
         XulrDm+ERVMSxIO7bEV89vdNDxeRNzaDa7v6Eo5YgBfWSTOWNmzr5xmMQbQO9DBoOi6N
         9DSYqMeYOsO6RdJjKdrUJ4fcpSpXtzqYhwvqWdzQD24aGxg6Y/kAuPxKxNkBK7IallZJ
         /+XO1J7h39n78XknKq3a7lQCg2w7GXACEcepNhjAHDAqK9X56q7IlxtaEd+7GMmEyqo8
         IZPA==
X-Gm-Message-State: ACgBeo11jSOKQN3yqQZtoGSJTSZinMiMWuGKHu87kiYvS6cuOMu1jI9t
        +8OKk9wyv921nomI7g6qnXPKcyBuLrU=
X-Google-Smtp-Source: AA6agR5AUEVpUfSPOxmk4wGZ/zK2tirYmhJ7zb9Jqld8zfrr8gDhVIB8ywXi+kyB8PgF4y+5mK88yQ==
X-Received: by 2002:a6b:5f19:0:b0:688:2173:1ae3 with SMTP id t25-20020a6b5f19000000b0068821731ae3mr21256805iob.12.1662327747322;
        Sun, 04 Sep 2022 14:42:27 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:27 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 18/57] doc-dyndbg: describe "class CLASS_NAME" query support
Date:   Sun,  4 Sep 2022 15:40:55 -0600
Message-Id: <20220904214134.408619-19-jim.cromie@gmail.com>
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

Add an explanation of the new "class CLASS_NAME" syntax and meaning,
noting that the module determines if CLASS_NAME applies to it.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index a89cfa083155..d8954ab05c7b 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -35,6 +35,7 @@ Dynamic debug has even more useful features:
    - line number (including ranges of line numbers)
    - module name
    - format string
+   - class name (as known/declared by each module)
 
  * Provides a debugfs control file: ``<debugfs>/dynamic_debug/control``
    which can be read to display the complete list of known debug
@@ -142,6 +143,7 @@ against.  Possible keywords are:::
 		 'file' string |
 		 'module' string |
 		 'format' string |
+		 'class' string |
 		 'line' line-range
 
   line-range ::= lineno |
@@ -203,6 +205,15 @@ format
 	format "nfsd: SETATTR"  // a neater way to match a format with whitespace
 	format 'nfsd: SETATTR'  // yet another way to match a format with whitespace
 
+class
+    The given class_name is validated against each module, which may
+    have declared a list of known class_names.  If the class_name is
+    found for a module, callsite & class matching and adjustment
+    proceeds.  Examples::
+
+	class DRM_UT_KMS	# a DRM.debug category
+	class JUNK		# silent non-match
+
 line
     The given line number or range of line numbers is compared
     against the line number of each ``pr_debug()`` callsite.  A single
-- 
2.37.2

