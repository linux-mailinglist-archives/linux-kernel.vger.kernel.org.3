Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34A4477C85
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbhLPT1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:27:17 -0500
Received: from foss.arm.com ([217.140.110.172]:47734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241034AbhLPT1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:27:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 820921474;
        Thu, 16 Dec 2021 11:27:13 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.6.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 643C03F774;
        Thu, 16 Dec 2021 11:27:12 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mchehab+huawei@kernel.org, nfraprado@protonmail.com,
        corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] docs: automarkup.py: Fix invalid HTML link output and broken URI fragments
Date:   Thu, 16 Dec 2021 19:27:04 +0000
Message-Id: <20211216192704.413216-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211216192704.413216-1-james.clark@arm.com>
References: <20211216192704.413216-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d18b01789ae5 ("docs: Add automatic cross-reference for
documentation pages"), references that were already explicitly defined
with "ref:" and reffered to other pages with a path have been doubled.
This is reported as the following error by Firefox:

  Start tag "a" seen but an element of the same type was already open.
  End tag "a" violates nesting rules.

As well as the invalid HTML, this also obscures the URI fragment links
to subsections because the second link overrides the first. For example
on the page admin-guide/hw-vuln/mds.html the last link should be to the
"Default Mitigations" subsection using a # URI fragment:

  admin-guide/hw-vuln/l1tf.html#default-mitigations

But it is obsured by a second link to the whole page:

  admin-guide/hw-vuln/l1tf.html

The full HTML with the double <a> tags looks like this:

  <a class="reference internal" href="l1tf.html#default-mitigations">
    <span class="std std-ref">
      <a class="reference internal" href="l1tf.html">
        <span class="doc">L1TF - L1 Terminal Fault</span>
      </a>
    </span>
  </a>

After this commit, there is only a single link:

  <a class="reference internal" href="l1tf.html#default-mitigations">
    <span class="std std-ref">Documentation/admin-guide/hw-vuln//l1tf.rst</span>
  </a>

Now that the second link is removed, the browser correctly jumps to the
default-mitigations subsection when clicking the link.

The fix is to check that nodes in the document to be modified are not
already references. A reference is counted as any text that is a
descendant of a reference type node. Only plain text should be converted
to new references, otherwise the doubling occurs.

Testing
=======

 * Test that the build stdout is the same (ignoring ordering), and that
   no new warnings are printed.

 * Diff all .html files and check that the only modifications occur
   to the bad double links.

 * The auto linking of bare references to pages without "ref:" is still
   working.

Fixes: d18b01789ae5 ("docs: Add automatic cross-reference for
       documentation pages")
Signed-off-by: James Clark <james.clark@arm.com>
---
 Documentation/sphinx/automarkup.py | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
index acf5473002f3..3fee247b55b3 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -280,10 +280,22 @@ def auto_markup(app, doctree, name):
     # avoid adding cross-references to functions that have been explicitly
     # marked with cc:func:.
     #
+    def text_but_not_a_reference(node):
+        if not isinstance(node, nodes.Text) or isinstance(node.parent, nodes.literal):
+            return False
+
+        child_of_reference = False
+        parent = node.parent
+        while parent:
+            if isinstance(parent, nodes.Referential):
+                child_of_reference = True
+                break
+            parent = parent.parent
+        return not child_of_reference
+
     for para in doctree.traverse(nodes.paragraph):
-        for node in para.traverse(nodes.Text):
-            if not isinstance(node.parent, nodes.literal):
-                node.parent.replace(node, markup_refs(name, app, node))
+        for node in para.traverse(condition=text_but_not_a_reference):
+            node.parent.replace(node, markup_refs(name, app, node))
 
 def setup(app):
     app.connect('doctree-resolved', auto_markup)
-- 
2.28.0

