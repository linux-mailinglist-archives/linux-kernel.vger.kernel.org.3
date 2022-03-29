Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5141B4EB0D4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbiC2Pjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbiC2Pja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:39:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA78324F2A1;
        Tue, 29 Mar 2022 08:37:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 89F04732;
        Tue, 29 Mar 2022 15:37:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 89F04732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1648568265; bh=LgqYNts+7wvT/aAKZ340NN7yfd+hMq7kPJubjS/JS6E=;
        h=From:To:Cc:Subject:Date:From;
        b=Y305iODNnNT5eTqKcaYOJebWLpfgVS/GlQsI4TxgjwQxgmjm64XMIlthMkV0ZhsXm
         +ODVEARtBBXxsSxteGHpyjdZAirBHKdf5sK3Ds0dFNRgdydmnYtj4qwWTVuiWYF8CX
         MIwPgQGYSRs28aw8aRdv6H+BmxWLuaPOe+CViWAyvZZXXxxnZh5+XG1HVVOggzZXjm
         VZiMjlkw7vPLgEAVVnmML3eje617Hdc13hAD4nmAS0XXP3wj2ErKmImnysbp+OQbr1
         qMTMdZWGWRQ89n/97+nApaYDmNavPOFDSpGNZLFloFA30XoCI6SD7f/N2o3kbogRWf
         u+on9alYZDw/g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v2] docs: Add a document on how to fix a messy diffstat
Date:   Tue, 29 Mar 2022 09:37:45 -0600
Message-ID: <87wngc6a7q.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
v2: Various tweaks suggested by Borislav, Bagas, and Akira

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
index 000000000000..c015f66d7621
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
+diffstat that shows which files will be touched and how much of each will
+be changed.  Occasionally, though, a repository with a relatively
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
+this will do the job::
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
+situation is to indeed to do a merge with the branch you intend your work
+to be pulled into, but to do it privately, as if it were the source of
+shame.  Create a new, throwaway branch and do the merge there::
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

