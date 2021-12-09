Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D6746E5F5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhLIJzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhLIJzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:55:53 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3299C0617A1;
        Thu,  9 Dec 2021 01:52:20 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mvG66-0008GF-FE; Thu, 09 Dec 2021 10:52:18 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     workflows@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ksummit@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH v2 2/2] docs: introduce the commit message tags 'Reported:' and 'Posted:'
Date:   Thu,  9 Dec 2021 10:52:17 +0100
Message-Id: <c6724c7fb534a46e095e6aef13d996ed9589e578.1639042966.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1639042966.git.linux@leemhuis.info>
References: <cover.1639042966.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1639043540;279c6118;
X-HE-SMSGID: 1mvG66-0008GF-FE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the tags 'Posted:' and 'Reported:'. They supplement 'Link:', which
historically is used to point to different things without indicating at
all what the provided URL is about. Users and scripts analyzing commits
thus have to guess from the URLs or follow each one to find out, which
might be hard for a script.

Documenting these tag also provides clarity for developers, as some
didn't link to bug reports at all. Some developers did, but used
'References:' for this. Nevertheless 'Reported:' was chosen for this
purpose, as it better matches up with the 'Reported-by:' tag commonly
used and already needed in this situation anyway.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
To: workflows@vger.kernel.org
---
Note: during review of v1 it was pointed out the perl regex modified in
'configure-git.rst' need to be case-insensitive; I will propose this
with a patch submitted separately once the best approach for that
problem was finally agreed on.

---
 Documentation/maintainer/configure-git.rst   |  8 +++----
 Documentation/process/5.Posting.rst          | 24 +++++++++++++-------
 Documentation/process/submitting-patches.rst | 22 ++++++++++--------
 3 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/Documentation/maintainer/configure-git.rst b/Documentation/maintainer/configure-git.rst
index 80ae5030a590..e33e4121cf21 100644
--- a/Documentation/maintainer/configure-git.rst
+++ b/Documentation/maintainer/configure-git.rst
@@ -40,12 +40,12 @@ Creating commit links to lore.kernel.org
 The web site http://lore.kernel.org is meant as a grand archive of all mail
 list traffic concerning or influencing the kernel development. Storing archives
 of patches here is a recommended practice, and when a maintainer applies a
-patch to a subsystem tree, it is a good idea to provide a Link: tag with a
+patch to a subsystem tree, it is a good idea to provide a Posted: tag with a
 reference back to the lore archive so that people that browse the commit
 history can find related discussions and rationale behind a certain change.
-The link tag will look like this:
+The tag will look like this:
 
-    Link: https://lore.kernel.org/r/<message-id>
+    Posted: https://lore.kernel.org/r/<message-id>
 
 This can be configured to happen automatically any time you issue ``git am``
 by adding the following hook into your git:
@@ -56,7 +56,7 @@ by adding the following hook into your git:
 	$ cat >.git/hooks/applypatch-msg <<'EOF'
 	#!/bin/sh
 	. git-sh-setup
-	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
+	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Posted: https://lore.kernel.org/r/$1|g;' "$1"
 	test -x "$GIT_DIR/hooks/commit-msg" &&
 		exec "$GIT_DIR/hooks/commit-msg" ${1+"$@"}
 	:
diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index 46635310c7c5..1aa4167d54ea 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -207,16 +207,24 @@ the patch::
 
 	Fixes: 1f2e3d4c5b6a ("The first line of the commit specified by the first 12 characters of its SHA-1 ID")
 
-Another tag is used for linking web pages with additional backgrounds or
-details, for example a report about a bug fixed by the patch or a document
-with a specification implemented by the patch::
+A second kind of tags is used for linking web pages with additional details.
+There are three different tags of this sort which all use the following
+format::
 
-	Link: https://example.com/somewhere.html  optional-other-stuff
+	tag: <url>  optional-other-stuff
 
-Many maintainers when applying a patch also add this tag to link to the
-latest public review posting of the patch; often this is automatically done
-by tools like b4 or a git hook like the one described in
-'Documentation/maintainer/configure-git.rst'.
+The tags in common use are:
+
+ - ``Reported:`` points to a report of a problem fixed by this patch. The
+   provided URL thus might point to a entry in a bug tracker or a mail in a
+   mailing list archive. Typically this tag is followed by a "Reported-by:"
+   tag (see below).
+
+ - ``Link:`` points to websites providing additional backgrounds or details,
+   for example an earlier discussion that let to the development of the patch.
+
+ - ``Posted:`` this is a tag many maintainers add when applying a patch, to
+   make the commit point to the latest public review posting of the patch.
 
 A third kind of tags are used to document which developers were involved in
 the development of the patch. Each of these uses this format::
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 6b3aaed66fba..658581be5fa0 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -113,20 +113,22 @@ collisions with shorter IDs a real possibility.  Bear in mind that, even if
 there is no collision with your six-character ID now, that condition may
 change five years from now.
 
-If related discussions or any other background information behind the change
-can be found on the web, add 'Link:' tags pointing to it. In case your patch
-fixes a bug, for example, add a tag with a URL referencing the report in the
-mailing list archives or a bug tracker; if the patch is a result of some
-earlier mailing list discussion or something documented on the web, point to
-it.
+Add tags linking to any related discussions or background information behind
+the change on the web. For example, if your patch fixes a bug, add a
+`Reported:` tag pointing to the report in the mailing list archives or a bug
+tracker::
 
-When linking to mailing list archives, preferably use the lore.kernel.org
-message archiver service. To create the link URL, use the contents of the
-``Message-Id`` header of the message without the surrounding angle brackets.
-For example::
+    Reported: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
+
+If the patch is a related to some earlier mailing list discussion or something
+documented on the web, point to it using a `Link:` tag::
 
     Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
 
+When linking to mailing list archives, preferably use the lore.kernel.org
+message archiver service. To create the link URL, use the contents of the
+``Message-Id`` header of the message without the surrounding angle brackets,
+e.g. "30th.anniversary.repost@klaava.Helsinki.FI" in the two examples above.
 Please check the link to make sure that it is actually working and points
 to the relevant message.
 
-- 
2.31.1

