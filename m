Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE25562068
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbiF3QhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbiF3QhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:37:00 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5953B55F;
        Thu, 30 Jun 2022 09:36:59 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 82ADE2BD;
        Thu, 30 Jun 2022 16:36:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 82ADE2BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656607019; bh=iUgBxaMFogHblUjqh3+L/kIHthcIN9dVA3xUYz0iqas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=psgMGBO74DasMyPGIUlPkemb+ZFWEqiUsKUtazCQZy+BbRa0iJb/3+Hy1Qjo0zoAM
         jQf3ga0moFUJOILhDt2K2KZKnd8tpjAs5a8jMum5IRqHS0KIluCgQSyViGjvo06Vb6
         3qwexoMVJrKBjGi182S3u4tV792NmPOno127BzPXq4IO5abhj7qFbywuFyanbvPK0A
         oQyJzsTRAS1sS2/fgSzC9RtI+wrdtsyU624JDrMMt6WG3EwGXaNQ7ayNU7PiEOHCAQ
         igiDahmQRmFfYRNK20wZ18UqOiP1JLLgKvHmhQqAdwDn7XL4gXV3ys2WkCg1BrKHB7
         cZjwIwj9dJZTQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <n@nfraprado.net>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/2] docs: automarkup: track failed cross-reference attempts
Date:   Thu, 30 Jun 2022 10:36:29 -0600
Message-Id: <20220630163630.714673-2-corbet@lwn.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630163630.714673-1-corbet@lwn.net>
References: <20220630163630.714673-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The automarkup code tries to create a lot of cross-references that don't
exist.  Cross-reference lookups are expensive, especially in later versions
of Sphinx, so there is value in avoiding unnecessary ones.  Remember
attempts that failed and do not retry them.

This improves the htmldocs build time by 5-10% depending on the phase of
the moon and other factors.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sphinx/automarkup.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
index cc348b219fca..5b1f83e6192f 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -120,6 +120,16 @@ def markup_refs(docname, app, node):
         repl.append(nodes.Text(t[done:]))
     return repl
 
+#
+# Keep track of cross-reference lookups that failed so we don't have to
+# do them again.
+#
+failed_lookups = { }
+def failure_seen(target, reftype):
+    return (target + '::' + reftype) in failed_lookups
+def note_failure(target, reftype):
+    failed_lookups[target + '::' + reftype] = True
+
 #
 # In sphinx3 we can cross-reference to C macro and function, each one with its
 # own C role, but both match the same regex, so we try both.
@@ -145,6 +155,8 @@ def markup_func_ref_sphinx3(docname, app, match):
         for target in possible_targets:
             if target not in Skipfuncs:
                 for class_s, reftype_s in zip(class_str, reftype_str):
+                    if failure_seen(target, reftype_s):
+                        continue
                     lit_text = nodes.literal(classes=['xref', 'c', class_s])
                     lit_text += target_text
                     pxref = addnodes.pending_xref('', refdomain = 'c',
@@ -164,6 +176,7 @@ def markup_func_ref_sphinx3(docname, app, match):
 
                     if xref:
                         return xref
+                    note_failure(target, reftype_s)
 
     return target_text
 
-- 
2.36.1

