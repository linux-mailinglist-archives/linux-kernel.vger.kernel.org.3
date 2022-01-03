Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A11482FAB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiACJu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiACJuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:50:55 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7D3C061784;
        Mon,  3 Jan 2022 01:50:55 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1n4JzQ-0003R8-G6; Mon, 03 Jan 2022 10:50:52 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH v1 2/2] docs: regressions.rst: rules of thumb for handling regressions
Date:   Mon,  3 Jan 2022 10:50:51 +0100
Message-Id: <9a68f2fcb5fe599b76e278a61928e23eb950cd83.1641203216.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641203216.git.linux@leemhuis.info>
References: <cover.1641203216.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641203455;535f8a11;
X-HE-SMSGID: 1n4JzQ-0003R8-G6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a section with a few rules of thumb about how quickly regressions
should be fixed. They are written after studying the quotes from Linus
found in the modified document and especially influenced by statements
like "Users are literally the _only_ thing that matters" and "without
users, your program is not a program, it's a pointless piece of code
that you might as well throw away". The author interpreted those in
perspective to how the various Linux kernel series are maintained and
what those practices might mean for users running into a regression when
updating.

That for example lead to the paragraph starting with "Aim to get fixes
for regressions mainlined within one week after identifying the culprit,
if the regression was introduced in a stable/longterm release or the
devel cycle for the latest mainline release". This is a pretty high bar,
but on the other hand needed to not leave users out in the cold for to
long. This can quickly happen, as the previous stable series is normally
stamped "End of Life" about three or four weeks after a new mainline
release, which makes a lot of users switch during this timeframe. Any of
them risk running into regressions not promptly fixed; even worse, once
the previous stable series is EOLed for real, users that face a
regression might be left with only three options:

 (1) continue running an outdated and thus potentially insecure kernel
     version from an abandoned stable series

 (2) run the kernel with the regression

 (3) downgrade to an earlier longterm series still supported

This is better avoided, as (1) puts users and their data in danger, (2)
will only be possible if it's a minor regression that doesn't interfere
with booting or serious usage, and (3) might be regression itself or
even impossible, as some users will require drivers or features only
introduced after the latest longterm series took of. In the end this
lead to the "Aim to fix regression within one week" part.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
Hi! A lot of developers are doing a good job in fixing regressions, but
I noticed it sometimes it takes many weeks to get even simple fixes for
regressions merged. Most of the time this is due to these factors:

 * it takes a long time to get the fix ready, as some developers
   apparently don't prioritize work on fixing regressions

 * fully developed fixes linger in git trees of maintainers for weeks,
   sometimes even without the fix being in linux-next

This is especially a problem for regressions introduced in mainline, but
only found after the release in the release or a stable kernel series
derived from it. Sometimes fixes for these regressions are even left
lying around for weeks until the next merge window, which contributes to
a huge pile of fixes getting backported to stable and longterm releases
during or shortly after merge windows. Asking developers to speed things
up rarely helped, as people have different options on how fast regression
fixes need to be developed and merged upstream.

That's why it would be a great help to my work as regression tracker if
we had some rough written down guideliones for handling regressions, as
proposed by the patch below. I'm well aware that the texts sets a pretty
high bar. That's because I approached primarily from the point of a
user, as can be seen by the patch description.

The proposed text likely will lead to some discussions, that's why I
submit this part separately from the rest of the new document on
regressions, which is added in patch 1/2; I also CCed Linus and Greg on
this patch and hope they state their opinion or ACK is. In the end I can
easily tone this down or write something totally different: that's
totally fine for me, I'm mainly interested to have some expectations
roughly documented to get everyone on the same page.
---
 Documentation/admin-guide/regressions.rst | 78 +++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/Documentation/admin-guide/regressions.rst b/Documentation/admin-guide/regressions.rst
index 1ff6a0802fc9..5f02a001e53c 100644
--- a/Documentation/admin-guide/regressions.rst
+++ b/Documentation/admin-guide/regressions.rst
@@ -63,6 +63,10 @@ list; add the aforementioned paragraph, just omit the caret (the ^) before the
 ``introduced``, which make regzbot treat your mail (and not the one you reply
 to) as the report.
 
+Try to fix regressions quickly once the culprit got identified. Fixes for most
+regressions should be mainlined within two weeks, but some should be addressed
+within two or three days.
+
 When submitting fixes for regressions, always include 'Link:' tags in the commit
 message that point to all places where the issue was reported, as explained in
 `Documentation/process/submitting-patches.rst` and
@@ -229,6 +233,80 @@ Alternatively to all the above you can just forward or bounce the report to the
 Linux kernel's regression tracker, but consider the downsides already outlined
 in the previous section.
 
+How quickly should regressions get fixed?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Developers should fix any reported regression as quickly as possible, to provide
+affected users with a solution in timely manner and prevent more users from
+running into the issue; nevertheless developers need to take enough time and
+care to ensure regression fixes do not cause additional damage.
+
+In the end though, developers should give their best to prevent users from
+running into situations where a regression leaves them only three options: "run
+a kernel with a regression that seriously impacts usage", "continue running an
+outdated and thus potentially insecure kernel version for more than two weeks
+after a regression's culprit got identified", and "downgrade to a still
+supported kernel series that's missing required features".
+
+How to realize this depends a lot on the situation. Here are a few rules of
+thumb for developers, in order or importance:
+
+ * Prioritize work on handling reports about regression and fixing them over all
+   other Linux kernel work, unless the latter concerns acute security issues or
+   bugs causing data loss or damage.
+
+ * Always consider reverting the culprit commits and reapplying them later
+   together with necessary fixes, as this might be the least dangerous and
+   quickest way to fix a regression.
+
+ * Try to get any regressions introduced in the current development cycle
+   resolved before its end. If you fear a fix might be too risky to apply only
+   days before a new mainline release, let Linus decide: submit the fix
+   separately to him as soon as possible with the explanation of the
+   situation. He then can make a call and postpone the release if necessary,
+   for example if multiple such changes show up in his inbox.
+
+ * Address regressions in stable, longterm, or proper mainline releases with
+   more urgency than regressions in mainline pre-releases. That changes after
+   the release of the fifth pre-release, aka '-rc5': mainline then becomes as
+   important, to ensure all the improvements and fixes ideally get at least one
+   week of testing together before Linus releases a new mainline version.
+
+ * Fix regressions within two or three days, if they are critical for some
+   reason -- for example, if the issue is likely to affect many users of the
+   kernel series in question on all or certain architectures. This thus
+   includes fixes for compile errors in mainline, as they might prevent testers
+   and continuous integration systems from doing their work.
+
+ * Aim to get fixes for regressions mainlined within one week after the culprit
+   was identified, if the regression was introduced in a stable/longterm
+   release or the development cycle for the latest mainline release (say
+   v5.14). If possible, try to address the issue even quicker, if the previous
+   stable series (v5.13.y) will be abandoned soon or already got stamped
+   'End-of-Life' (EOL) -- this usually happens about three to four weeks after
+   a new mainline release.
+
+ * Try to fix all other regression within two weeks after the culprit was found.
+   Two or three additional weeks are acceptable for performance regressions and
+   other issues which are annoying, but don't prevent anyone from running Linux
+   -- unless it's an issue in the current development cycle, which should be
+   addressed before the release. A few weeks in total are also acceptable if a
+   regression can only be fixed with a risky change and at the same time is
+   affecting only a few users; as much time is also acceptable if the regression
+   is already present in the second newest longterm kernel series.
+
+Note: The aforementioned timeframes for getting a regression resolved are meant
+to include getting the fix tested, reviewed, and merged into mainline, ideally
+with the fix being in Linux next for two days. Developers need to keep in mind
+that each of these steps takes some time.
+
+Subsystem maintainer are expected to assist in reaching those periods by doing
+timely reviews and quick handling of accepted patches. They thus might have to
+send git-pull requests earlier or more often than usually; depending on the fix,
+it might even be acceptable to skip testing in Linux-next. Especially fixes for
+regressions in stable and longterm kernels need to be handled quickly, as the
+fix needs to reach mainline before it can be backported there.
+
 Do really all regressions get fixed?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.31.1

