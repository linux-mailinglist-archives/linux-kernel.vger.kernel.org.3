Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DFB4E7DC1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiCYWAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 18:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbiCYWAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 18:00:18 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9404C118F5A;
        Fri, 25 Mar 2022 14:58:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 454BB2C3;
        Fri, 25 Mar 2022 21:58:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 454BB2C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1648245523; bh=hsYCabDYG9BsnSr6aIERiuj385zksjChMI7/4113Z3I=;
        h=From:To:Cc:Subject:Date:From;
        b=VrC4nDK2COPGZVaDKnzQ0RIroS8+LdFo30Izn8Ow21Zvvjs6AqQjlDJVidAdf4GsO
         SVp8q2DV2vdvwXDMXrYcOnCR+7JQcqksOye/BVL/VSsQ4ExGakHB5wDu7TI59QEntr
         8Y0SN1IqWmveU5eCyRyg6JuBCyt0Ky9DQigJT0p1yfgjemOTeEdkMshz5qptfIODsq
         Ba6yF7SNSH6EF5vft5y7yrnb5nDZDxAZ0keNFYmMyCfbsdVdSLRTKjfPxC+88NwKyG
         Ljfm/tbMjb6OVuKq82e3Vm8m0gqjM95BaDh6rH+nDwdd5/4Ys1Ecka/FtELk6jcKQ8
         jnqG8bh59RWMQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs: Add a document on how to fix a messy diffstat
Date:   Fri, 25 Mar 2022 15:58:42 -0600
Message-ID: <87wnghd78t.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A branch with merges in will sometimes create a diffstat containing a lot
of unrelated work at "git request-pull" time.  Create a document based on
Linus's advice (found in the links below) and add it to the maintainer
manual in the hope of saving some wear on Linus's keyboard going forward.

Link: https://lore.kernel.org/lkml/CAHk-=wg3wXH2JNxkQi+eLZkpuxqV+wPiHhw_Jf7ViH33Sw7PHA@mail.gmail.com/
Link: https://lore.kernel.org/lkml/CAHk-=wgXbSa8yq8Dht8at+gxb_idnJ7X5qWZQWRBN4_CUPr=eQ@mail.gmail.com/
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
[If this passes muster I'll likely toss a version onto LWN as well]

 Documentation/maintainer/index.rst          |  1 +
 Documentation/maintainer/messy-diffstat.rst | 96 +++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/maintainer/messy-diffstat.rst

diff --git a/Documentation/maintainer/index.rst b/Documentation/maintainer/index.rst
index f0a60435b124..3e03283c144e 100644
--- a/Documentation/maintainer/index.rst
+++ b/Documentation/maintainer/index.rst
@@ -12,6 +12,7 @@ additions to this manual.
    configure-git
    rebasing-and-merging
    pull-requests
+   messy-diffstat
    maintainer-entry-profile
    modifying-patches
 
diff --git a/Documentation/maintainer/messy-diffstat.rst b/Documentation/maintainer/messy-diffstat.rst
new file mode 100644
index 000000000000..970eac087f67
--- /dev/null
+++ b/Documentation/maintainer/messy-diffstat.rst
@@ -0,0 +1,96 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+Handling messy pull-request diffstats
+=====================================
+
+Subsystem maintainers routinely use ``git request-pull`` as part of the
+process of sending work upstream.  Normally, the result includes a nice
+diffstat listing showing which files will be touched and how much of each
+will be changed.  Occasionally, though, a repository with a relatively
+complicated development history will yield a massive diffstat containing a
+great deal of unrelated work.  The result looks ugly and obscures what the
+pull request is actually doing.  This document describes what is happening
+and how to fix things up; it is derived from The Wisdom of Linus Torvalds,
+found in Linus1_ and Linus2_.
+
+.. _Linus1: https://lore.kernel.org/lkml/CAHk-=wg3wXH2JNxkQi+eLZkpuxqV+wPiHhw_Jf7ViH33Sw7PHA@mail.gmail.com/
+.. _Linus2: https://lore.kernel.org/lkml/CAHk-=wgXbSa8yq8Dht8at+gxb_idnJ7X5qWZQWRBN4_CUPr=eQ@mail.gmail.com/
+
+A Git development history proceeds as a series of commits.  In a simplified
+manner, mainline kernel development looks like this::
+
+  ... vM --- vN-rc1 --- vN-rc2 --- vN-rc3 --- ... --- vN-rc7 --- vN
+
+If one wants to see what has changed between two points, a command like
+will do the job::
+
+  $ git diff --stat --summary vN-rc2..vN-rc3
+
+Here, there are two clear points in the history; Git will essentially
+"subtract" the beginning point from the end point and display the resulting
+differences.  The requested operation is unambiguous and easy enough to
+understand.
+
+When a subsystem maintainer creates a branch and commits changes to it, the
+result in the simplest case is a history that looks like::
+
+  ... vM --- vN-rc1 --- vN-rc2 --- vN-rc3 --- ... --- vN-rc7 --- vN
+                          |
+                          +-- c1 --- c2 --- ... --- cN
+
+If that maintainer now uses ``git diff`` to see what has changed between
+the mainline branch (let's call it "linus") and cN, there are still two
+clear endpoints, and the result is as expected.  So a pull request
+generated with ``git request-pull`` will also be as expected.  But now
+consider a slightly more complex development history::
+
+  ... vM --- vN-rc1 --- vN-rc2 --- vN-rc3 --- ... --- vN-rc7 --- vN
+                |         |
+                |         +-- c1 --- c2 --- ... --- cN
+                |                   /
+                +-- x1 --- x2 --- x3
+
+Our maintainer has created one branch at vN-rc1 and another at vN-rc2; the
+two were then subsequently merged into c2.  Now a pull request generated
+for cN may end up being messy indeed, and developers often end up wondering
+why.
+
+What is happening here is that there are no longer two clear end points for
+the ``git diff`` operation to use.  The development culminating in cN
+started in two different places; to generate the diffstat, ``git diff``
+ends up having pick one of them and hoping for the best.  If the diffstat
+starts at vN-rc1, it may end up including all of the changes between there
+and the second origin end point (vN-rc2), which is certainly not what our
+maintainer had in mind.  With all of that extra junk in the diffstat, it
+may be impossible to tell what actually happened in the changes leading up
+to cN.
+
+Maintainers often try to resolve this problem by, for example, rebasing the
+branch or performing another merge with the linus branch, then recreating
+the pull request.  This approach tends not to lead to joy at the receiving
+end of that pull request; rebasing and/or merging just before pushing
+upstream is a well-known way to get a grumpy response.
+
+So what is to be done?  The best response when confronted with this
+situation is to indeed to a merge, but to do it privately, as if it were
+the source of shame.  Create a new, throwaway branch and do the merge
+there::
+
+  ... vM --- vN-rc1 --- vN-rc2 --- vN-rc3 --- ... --- vN-rc7 --- vN
+                |         |                                      |
+                |         +-- c1 --- c2 --- ... --- cN           |
+                |                   /               |            |
+                +-- x1 --- x2 --- x3                +------------+-- TEMP
+
+The merge operation resolves all of the complications resulting from the
+multiple beginning points, yielding a coherent result that contains only
+the differences from the mainline branch.  Now it will be possible to
+generate a diffstat with the desired information::
+
+  $ git diff -C --stat --summary linus..TEMP
+
+Save the output from this command, then simply delete the TEMP branch;
+definitely do not expose it to the outside world.  Take the saved diffstat
+output and edit it into the messy pull request, yielding a result that
+shows what is really going on.  That request can then be sent upstream.
-- 
2.35.1

