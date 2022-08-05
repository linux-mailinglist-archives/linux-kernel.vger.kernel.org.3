Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A6E58B1CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbiHEV4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241719AbiHEVzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:55:05 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC787C1A6;
        Fri,  5 Aug 2022 14:54:41 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id z8so680546ile.0;
        Fri, 05 Aug 2022 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZSrYcW0n+hMGbP13qtU8Pp8sbnMOwvc1NQla3G+MVBY=;
        b=pPw4i+VqbQa25X7qFM0wRNJ8nxyDnFuNDaCsDun2ttngNr71qRrGr4k8NyN7xsD80B
         7OEIqPTiLY9pjqLlMqCA6IqcQ4HOo+XNP1ix9evPlP7vO7Y4Inyr2r4bjjSX+Y7R5zKj
         HBqzGMZzxBa4+4ptNMHk1htpzfhYtw+mflA0z/piZ8WMUwb2U1ZqHiU3Imd97+NRj9ky
         9s+6OnPcOXDsdoVQnqcU89Epq/rxnhZWvYbGfrNLUGI18PpSQORnjRdXOq31ZhCtjElZ
         5vcklUbLM0pu+LW/VNKLMAEWqRA+MegMEmVcJXzQkN1+nedaHwzujL6llty5ACx/1Dp4
         s4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZSrYcW0n+hMGbP13qtU8Pp8sbnMOwvc1NQla3G+MVBY=;
        b=fQaXsN3TPkpsB7tc6G+3pKI8XsTgJKjiJp4oOafB86mDUpbvlSyJWJiIyCK1s3cxlg
         ph/TeXP5mSbNIvFWNacFPqHr68BSVUA8seL1Ywa++zOC2ncVUs1r5WkXKhm0RNTSuef7
         ptMvsuuj+zo4MUHWwfGomxnrsdQ0xo9/9rk8ruV2RcXeZNNn+Qe2diPRRGi3Nffw3uOa
         d5wQp2lBJtfL2TJ3UEVKPdk73CaaQgq72iiizagmENkaNcYaxWNT09Ml7SNmXZJRjBgF
         SxsuZLEl4V7IFyTKQisBlgU8Xh6tNuWyc3ueb/dKgogBCeVgIDcCCLOqnBn2LlHJT3QZ
         Wl/w==
X-Gm-Message-State: ACgBeo0PDBwZBxW23vMtAH33+3FOcWs6B+cxJS1PRK3Bm3RwNE9FSB0E
        dbonT3k4TC05WslStgGunXm01aivZPvMVw==
X-Google-Smtp-Source: AA6agR6G2mXKbweLP8JJH09ZIwf4toE4HNTDaPGGZAufMuf4+BUTj0JP+37VK2t41KmICClDFLB/DQ==
X-Received: by 2002:a05:6e02:2164:b0:2de:e996:b8f with SMTP id s4-20020a056e02216400b002dee9960b8fmr4037903ilv.0.1659736480406;
        Fri, 05 Aug 2022 14:54:40 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:40 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 18/33] doc-dyndbg: describe "class CLASS_NAME" query support
Date:   Fri,  5 Aug 2022 15:53:40 -0600
Message-Id: <20220805215355.3509287-19-jim.cromie@gmail.com>
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
2.37.1

