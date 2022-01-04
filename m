Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89521484A4B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiADV7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:59:05 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:35465 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiADV7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:59:04 -0500
Received: (Authenticated sender: n@nfraprado.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 6664E200004;
        Tue,  4 Jan 2022 21:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nfraprado.net;
        s=gm1; t=1641333543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Hq0+LAaU1dQY+2RururmJebF95dLwWOeR4UYWnU6VU=;
        b=KQbwXY124F5BfISwQ4EIjHRth6Vc2fR4N7RS6TOEC0Qp+XwwTHtAnEVbLgK/DGrK4diz8U
        thlinCWwCpbaAOV3JnnRJBmvOPPPyCN/JJCoOgiCZRy/lCKgBJ8b+/2FaKx4aKvTOTQ1tO
        lmXEXoG76ejY7XYoLV9KZptkQLXukp5cgNOpr3Arvrq1HLjd/OKl3CkpFrM69ozzpyOdKd
        xtn6tcGVegsJ6L8zWrT+VUtCCWZzkUsTPTYNVM4ac2ed35hBMTarzRbU3UEGb9IxNSvFc+
        U7r/im5229410xOtpI4TZn2NwSDP6ilW573L3yOBKoVWkMe7hAmk8am3I9+n0g==
Date:   Tue, 4 Jan 2022 16:58:58 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <n@nfraprado.net>
To:     James Clark <james.clark@arm.com>
Cc:     mchehab+huawei@kernel.org, nfraprado@protonmail.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] docs: automarkup.py: Fix invalid HTML link output
 and broken URI fragments
Message-ID: <20220104215858.dugh3er4hn6cwh43@notapiano>
References: <20211216192704.413216-1-james.clark@arm.com>
 <20211216192704.413216-2-james.clark@arm.com>
 <9f490126-ef08-e3f3-3f5b-1a55874d8d7c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f490126-ef08-e3f3-3f5b-1a55874d8d7c@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello James,

On Tue, Jan 04, 2022 at 02:17:43PM +0000, James Clark wrote:
> 
> 
> On 16/12/2021 19:27, James Clark wrote:
> > Since commit d18b01789ae5 ("docs: Add automatic cross-reference for
> > documentation pages"), references that were already explicitly defined
> > with "ref:" and reffered to other pages with a path have been doubled.
> > This is reported as the following error by Firefox:
> > 
> >   Start tag "a" seen but an element of the same type was already open.
> >   End tag "a" violates nesting rules.
> > 
> > As well as the invalid HTML, this also obscures the URI fragment links
> > to subsections because the second link overrides the first. For example
> > on the page admin-guide/hw-vuln/mds.html the last link should be to the
> > "Default Mitigations" subsection using a # URI fragment:
> > 
> >   admin-guide/hw-vuln/l1tf.html#default-mitigations
> > 
> > But it is obsured by a second link to the whole page:
> > 
> >   admin-guide/hw-vuln/l1tf.html
> > 
> 
> Bump. Is there a way this can be merged if there are no objections? It's
> preventing me from adding links in the docs.

Sorry for the delay, I changed emails and wasn't monitoring that old one.

First of all, thank you for noticing and fixing this issue!

To be honest, it bothered me that you walked upwards on the node tree to figure
out if the current node is a child of a reference node instead of figuring that
out as the tree is traversed down, so I took a stab at implementing that. The
aim was to only consider nodes that are:

  1. below a paragraph node, to avoid changing text outside the paragraphs like
     titles and so on
  2. not below a literal or reference, to avoid this issue you noticed

However I was not very happy with the end result either. The code got a bit
messy, and while I thought it would be a lot faster than the upward walk, in the
end it doesn't really make a difference: From my test-run this approach took
10m15s, while yours took 10m49s.

I'll include my patch at the end of this email for reference (to myself and
others) if/when we revisit this in the future.

So this is to say that, while I think the best long-term solution would be to
only walk the nodes we're interested in from the get go, your solution is way
simpler and not noticibly slower, so let's go with it for now. I just have a
little nit on the patch, see below.

> 
> Thanks
> James
> 
> > The full HTML with the double <a> tags looks like this:
> > 
> >   <a class="reference internal" href="l1tf.html#default-mitigations">
> >     <span class="std std-ref">
> >       <a class="reference internal" href="l1tf.html">
> >         <span class="doc">L1TF - L1 Terminal Fault</span>
> >       </a>
> >     </span>
> >   </a>
> > 
> > After this commit, there is only a single link:
> > 
> >   <a class="reference internal" href="l1tf.html#default-mitigations">
> >     <span class="std std-ref">Documentation/admin-guide/hw-vuln//l1tf.rst</span>
> >   </a>
> > 
> > Now that the second link is removed, the browser correctly jumps to the
> > default-mitigations subsection when clicking the link.
> > 
> > The fix is to check that nodes in the document to be modified are not
> > already references. A reference is counted as any text that is a
> > descendant of a reference type node. Only plain text should be converted
> > to new references, otherwise the doubling occurs.
> > 
> > Testing
> > =======
> > 
> >  * Test that the build stdout is the same (ignoring ordering), and that
> >    no new warnings are printed.
> > 
> >  * Diff all .html files and check that the only modifications occur
> >    to the bad double links.
> > 
> >  * The auto linking of bare references to pages without "ref:" is still
> >    working.
> > 
> > Fixes: d18b01789ae5 ("docs: Add automatic cross-reference for
> >        documentation pages")
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  Documentation/sphinx/automarkup.py | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
> > index acf5473002f3..3fee247b55b3 100644
> > --- a/Documentation/sphinx/automarkup.py
> > +++ b/Documentation/sphinx/automarkup.py
> > @@ -280,10 +280,22 @@ def auto_markup(app, doctree, name):
> >      # avoid adding cross-references to functions that have been explicitly
> >      # marked with cc:func:.
> >      #

Could you add your function above this comment so it doesn't get separated from
the code it's commenting on?

Actually, the comment about the literal could be moved inside your function...

> > +    def text_but_not_a_reference(node):

...here:
    #
    # The nodes.literal test catches ``literal text``, its purpose is to
    # avoid adding cross-references to functions that have been explicitly
    # marked with cc:func:.
    #

> > +        if not isinstance(node, nodes.Text) or isinstance(node.parent, nodes.literal):
> > +            return False
> > +
> > +        child_of_reference = False
> > +        parent = node.parent
> > +        while parent:
> > +            if isinstance(parent, nodes.Referential):
> > +                child_of_reference = True
> > +                break
> > +            parent = parent.parent
> > +        return not child_of_reference
> > +

and the comment about refactoring the loop should be left here:

    #
    # This loop could eventually be improved on.  Someday maybe we
    # want a proper tree traversal with a lot of awareness of which
    # kinds of nodes to prune.  But this works well for now.
    #

With this,

Reviewed-by: Nícolas F. R. A. Prado <n@nfraprado.net>

Thanks,
Nícolas

> >      for para in doctree.traverse(nodes.paragraph):
> > -        for node in para.traverse(nodes.Text):
> > -            if not isinstance(node.parent, nodes.literal):
> > -                node.parent.replace(node, markup_refs(name, app, node))
> > +        for node in para.traverse(condition=text_but_not_a_reference):
> > +            node.parent.replace(node, markup_refs(name, app, node))
> >  
> >  def setup(app):
> >      app.connect('doctree-resolved', auto_markup)
> > 
> 

Uncleaned/unoptimized patch for walking down the tree:

diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/automarkup.py
index acf5473002f3..4738c99bbbfb 100644
--- a/Documentation/sphinx/automarkup.py
+++ b/Documentation/sphinx/automarkup.py
@@ -271,19 +271,48 @@ def get_c_namespace(app, docname):
 def auto_markup(app, doctree, name):
     global c_namespace
     c_namespace = get_c_namespace(app, name)
-    #
-    # This loop could eventually be improved on.  Someday maybe we
-    # want a proper tree traversal with a lot of awareness of which
-    # kinds of nodes to prune.  But this works well for now.
-    #
-    # The nodes.literal test catches ``literal text``, its purpose is to
-    # avoid adding cross-references to functions that have been explicitly
-    # marked with cc:func:.
-    #
-    for para in doctree.traverse(nodes.paragraph):
-        for node in para.traverse(nodes.Text):
-            if not isinstance(node.parent, nodes.literal):
-                node.parent.replace(node, markup_refs(name, app, node))
+
+    def find_suitable_nodes(root):
+        pending_nodes = [root]
+        top_nodes = []
+        final_nodes = []
+        index = 0
+
+        def is_top_node(node):
+            return isinstance(node, nodes.paragraph)
+
+        def is_bottom_node(node):
+            return isinstance(node, nodes.Referential) or isinstance(node, nodes.literal)
+
+        while index < len(pending_nodes):
+            current_node = pending_nodes[index]
+            if is_top_node(current_node):
+                top_nodes.append(current_node)
+            else:
+                pending_nodes.extend(current_node.children)
+            index += 1
+
+        index = 0
+        while index < len(top_nodes):
+            current_node = top_nodes[index]
+            for child in current_node.children:
+                if not is_bottom_node(child):
+                    final_nodes.append(child)
+            index += 1
+
+        index = 0
+        while index < len(final_nodes):
+            current_node = final_nodes[index]
+            for child in current_node.children:
+                if not is_bottom_node(child):
+                    final_nodes.append(child)
+            index += 1
+
+        return final_nodes
+
+    for node in find_suitable_nodes(doctree):
+        if isinstance(node, nodes.Text):
+            node.parent.replace(node, markup_refs(name, app, node))

 def setup(app):
     app.connect('doctree-resolved', auto_markup)
--
