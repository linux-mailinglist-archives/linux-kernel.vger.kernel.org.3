Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C9A56206C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbiF3QhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiF3QhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:37:01 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE4D3BA41;
        Thu, 30 Jun 2022 09:37:00 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id E002760B;
        Thu, 30 Jun 2022 16:36:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E002760B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656607020; bh=NJ/Y9ONMRQjKnuqNr+P82fP9Qj+0laPsAzZtOD+ZrsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nto3tl8ZDBazIuSqbrwftEdcHKIgLAuEaNjBqWKDlgchLQVneCBtJ3/zi0YttVWSz
         OTY7RoLhxENDankyDZogHTU9VccuKR+LukqH/MPEZSNYGny3NVhnYCD3q9pu7jIptr
         c8BHloTXR5Tgu90eusYF02fZ3KXbbJJYIurMJNvC7GkDDgfOU9CMbLk+JdQkIppnNn
         XU5sXA2ZeobEhQJ4ADaxXINw5rf0v1emH+jNJ6/tUQupovXPIkudcyCDFgpOaMfns8
         8cYhZG/HF7OswJmABTr/XPIKjQOKA+VtamTQ1ROKvKr9c+G4QibFMyA4eJZ7tmYPMH
         kYYJm4J0pbw2g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <n@nfraprado.net>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/2] docs: automarkup: do not look up symbols twice
Date:   Thu, 30 Jun 2022 10:36:30 -0600
Message-Id: <20220630163630.714673-3-corbet@lwn.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630163630.714673-1-corbet@lwn.net>
References: <20220630163630.714673-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The automarkup code tries to look up symbols once as a function, and once
as a macro.  The Sphinx C domain code, though, totally ignores that
distinction and will return the same results either way.  So just look
things up once and be done with it; the resulting output does not change,
but htmldocs build time drops by about 5%.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sphinx/automarkup.py | 57 ++++++++++++++----------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
index 5b1f83e6192f..06b34740bf90 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -125,19 +125,16 @@ def markup_refs(docname, app, node):
 # do them again.
 #
 failed_lookups = { }
-def failure_seen(target, reftype):
-    return (target + '::' + reftype) in failed_lookups
-def note_failure(target, reftype):
-    failed_lookups[target + '::' + reftype] = True
+def failure_seen(target):
+    return (target) in failed_lookups
+def note_failure(target):
+    failed_lookups[target] = True
 
 #
 # In sphinx3 we can cross-reference to C macro and function, each one with its
 # own C role, but both match the same regex, so we try both.
 #
 def markup_func_ref_sphinx3(docname, app, match):
-    class_str = ['c-func', 'c-macro']
-    reftype_str = ['function', 'macro']
-
     cdom = app.env.domains['c']
     #
     # Go through the dance of getting an xref out of the C domain
@@ -153,30 +150,28 @@ def markup_func_ref_sphinx3(docname, app, match):
 
     if base_target not in Skipnames:
         for target in possible_targets:
-            if target not in Skipfuncs:
-                for class_s, reftype_s in zip(class_str, reftype_str):
-                    if failure_seen(target, reftype_s):
-                        continue
-                    lit_text = nodes.literal(classes=['xref', 'c', class_s])
-                    lit_text += target_text
-                    pxref = addnodes.pending_xref('', refdomain = 'c',
-                                                  reftype = reftype_s,
-                                                  reftarget = target, modname = None,
-                                                  classname = None)
-                    #
-                    # XXX The Latex builder will throw NoUri exceptions here,
-                    # work around that by ignoring them.
-                    #
-                    try:
-                        xref = cdom.resolve_xref(app.env, docname, app.builder,
-                                                 reftype_s, target, pxref,
-                                                 lit_text)
-                    except NoUri:
-                        xref = None
-
-                    if xref:
-                        return xref
-                    note_failure(target, reftype_s)
+            if (target not in Skipfuncs) and not failure_seen(target):
+                lit_text = nodes.literal(classes=['xref', 'c', 'c-func'])
+                lit_text += target_text
+                pxref = addnodes.pending_xref('', refdomain = 'c',
+                                              reftype = 'function',
+                                              reftarget = target,
+                                              modname = None,
+                                              classname = None)
+                #
+                # XXX The Latex builder will throw NoUri exceptions here,
+                # work around that by ignoring them.
+                #
+                try:
+                    xref = cdom.resolve_xref(app.env, docname, app.builder,
+                                             'function', target, pxref,
+                                             lit_text)
+                except NoUri:
+                    xref = None
+
+                if xref:
+                    return xref
+                note_failure(target)
 
     return target_text
 
-- 
2.36.1

