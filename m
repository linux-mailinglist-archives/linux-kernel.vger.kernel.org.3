Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83C84B81D8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiBPHgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:36:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiBPHgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:36:11 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DEA205D3;
        Tue, 15 Feb 2022 23:35:58 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1nKEA5-00083j-G7; Wed, 16 Feb 2022 07:51:37 +0100
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        regressions@lists.linux.dev,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v5 2/3] docs: *-regressions.rst: explain how quickly issues should be handled
Date:   Wed, 16 Feb 2022 07:51:34 +0100
Message-Id: <a7b717b52c0d54cdec9b6daf56ed6669feddee2c.1644994117.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644994117.git.linux@leemhuis.info>
References: <cover.1644994117.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1644996958;9ea4acf0;
X-HE-SMSGID: 1nKEA5-00083j-G7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a section with a few rules of thumb about how
quickly developers should address regressions to
Documentation/process/handling-regressions.rst; additionally,
add a short paragraph about this to the companion document
Documentation/admin-guide/reporting-regressions.rst as well.

The rules of thumb were written after studying the quotes from Linus
found in handling-regressions.rst and especially influenced by
statements like "Users are literally the _only_ thing that matters" and
"without users, your program is not a program, it's a pointless piece of
code that you might as well throw away". The author interpreted those in
perspective to how the various Linux kernel series are maintained
currently and what those practices might mean for users running into a
regression on a small or big kernel update.

That for example lead to the paragraph starting with "Aim to get fixes
for regressions mainlined within one week after identifying the culprit,
if the regression was introduced in a stable/longterm release or the
devel cycle for the latest mainline release". Some might see this as
pretty high bar, but on the other hand something like that is needed to
not leave users out in the cold for too long -- which can quickly happen
when updating to the latest stable series, as the previous one is
normally stamped "End of Life" about three or four weeks after a new
mainline release. This makes a lot of users switch during this
timeframe. Any of them thus risk running into regressions not promptly
fixed; even worse, once the previous stable series is EOLed for real,
users that face a regression might be left with only three options:

 (1) continue running an outdated and thus potentially insecure kernel
     version from an abandoned stable series

 (2) run the kernel with the regression

 (3) downgrade to an earlier longterm series still supported

This is better avoided, as (1) puts users and their data in danger, (2)
will only be possible if it's a minor regression that doesn't interfere
with booting or serious usage, and (3) might be regression itself or
impossible on the particular machine, as the users might require drivers
or features only introduced after the latest longterm series branched
of.

In the end this lead to the aforementioned "Aim to fix regression within
one week" part. It's also the reason for the "Try to resolve any
regressions introduced in the current development cycle before its
end.".

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
CC: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Hi! A lot of developers are doing a good job in fixing regressions in a
reasonable time span, but I noticed it sometimes takes many weeks to get
even simple fixes for regressions merged. Most of the time this is due
to one of these factors:

 * it takes a long time to get the fix ready, as some developers
   apparently don't prioritize work on fixing regressions

 * fully developed fixes linger in git trees of maintainers for weeks,
   sometimes even without the fix being in linux-next

This afaics is especially a problem for regressions introduced in
mainline, but only found after a new versions was released and a new
stable kernel series derived from it. Sometimes fixes for these
regressions are even left lying around for weeks until the next merge
window, which contributes to a huge pile of fixes getting backported to
stable and longterm releases after a merge window ended.  Asking
developers to speed things up rarely helped, as people have different
opinions on how fast regression fixes need to be developed and merged
upstream.

That's why it would be a great help to my work as regression tracker if
we had some rough written down guidelines for handling regressions, as
proposed by the patch below. I'm well aware that the text sets a pretty
high bar. That's because I approached the problem primarily from the
point of a user, as can be seen by the patch description.

The text added by this patch likely will lead to some discussions,
that's why I submit it separately from the rest of the new documents on
regressions, which are found in patch 1/3; I also CCed Linus on this
patch and hope he states his opinion or even ACKs is. In the end I can
easily tone this down or write something totally different: that's
totally fine for me, I'm mainly interested in having some expectations
roughly documented to get everyone on the same page.

Ciao, Thorsten
---
 .../admin-guide/reporting-regressions.rst     | 12 +++
 .../process/handling-regressions.rst          | 87 +++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/Documentation/admin-guide/reporting-regressions.rst b/Documentation/admin-guide/reporting-regressions.rst
index 6fbd24ceb3bf..d8adccdae23f 100644
--- a/Documentation/admin-guide/reporting-regressions.rst
+++ b/Documentation/admin-guide/reporting-regressions.rst
@@ -214,6 +214,18 @@ your report on the radar of these people by CCing or forwarding each report to
 the regressions mailing list, ideally with a "regzbot command" in your mail to
 get it tracked immediately.
 
+How quickly are regressions normally fixed?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Developers should fix any reported regression as quickly as possible, to provide
+affected users with a solution in a timely manner and prevent more users from
+running into the issue; nevertheless developers need to take enough time and
+care to ensure regression fixes do not cause additional damage.
+
+The answer thus depends on various factors like the impact of a regression, its
+age, or the Linux series in which it occurs. In the end though, most regressions
+should be fixed within two weeks.
+
 Is it a regression, if the issue can be avoided by updating some software?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
index e1102a3207e3..abb741b1aeee 100644
--- a/Documentation/process/handling-regressions.rst
+++ b/Documentation/process/handling-regressions.rst
@@ -45,6 +45,10 @@ The important bits (aka "The TL;DR")
    mandated by Documentation/process/submitting-patches.rst and
    :ref:`Documentation/process/5.Posting.rst <development_posting>`.
 
+#. Try to fix regressions quickly once the culprit has been identified; fixes
+   for most regressions should be merged within two weeks, but some need to be
+   resolved within two or three days.
+
 
 All the details on Linux kernel regressions relevant for developers
 ===================================================================
@@ -125,6 +129,89 @@ tools and scripts used by other kernel developers or Linux distributions; one of
 these tools is regzbot, which heavily relies on the "Link:" tags to associate
 reports for regression with changes resolving them.
 
+Prioritize work on fixing regressions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You should fix any reported regression as quickly as possible, to provide
+affected users with a solution in a timely manner and prevent more users from
+running into the issue; nevertheless developers need to take enough time and
+care to ensure regression fixes do not cause additional damage.
+
+In the end though, developers should give their best to prevent users from
+running into situations where a regression leaves them only three options: "run
+a kernel with a regression that seriously impacts usage", "continue running an
+outdated and thus potentially insecure kernel version for more than two weeks
+after a regression's culprit was identified", and "downgrade to a still
+supported kernel series that lack required features".
+
+How to realize this depends a lot on the situation. Here are a few rules of
+thumb for you, in order or importance:
+
+ * Prioritize work on handling regression reports and fixing regression over all
+   other Linux kernel work, unless the latter concerns acute security issues or
+   bugs causing data loss or damage.
+
+ * Always consider reverting the culprit commits and reapplying them later
+   together with necessary fixes, as this might be the least dangerous and
+   quickest way to fix a regression.
+
+ * Developers should handle regressions in all supported kernel series, but are
+   free to delegate the work to the stable team, if the issue probably at no
+   point in time occurred with mainline.
+
+ * Try to resolve any regressions introduced in the current development before
+   its end. If you fear a fix might be too risky to apply only days before a new
+   mainline release, let Linus decide: submit the fix separately to him as soon
+   as possible with the explanation of the situation. He then can make a call
+   and postpone the release if necessary, for example if multiple such changes
+   show up in his inbox.
+
+ * Address regressions in stable, longterm, or proper mainline releases with
+   more urgency than regressions in mainline pre-releases. That changes after
+   the release of the fifth pre-release, aka "-rc5": mainline then becomes as
+   important, to ensure all the improvements and fixes are ideally tested
+   together for at least one week before Linus releases a new mainline version.
+
+ * Fix regressions within two or three days, if they are critical for some
+   reason -- for example, if the issue is likely to affect many users of the
+   kernel series in question on all or certain architectures. Note, this
+   includes mainline, as issues like compile errors otherwise might prevent many
+   testers or continuous integration systems from testing the series.
+
+ * Aim to fix regressions within one week after the culprit was identified, if
+   the issue was introduced in either:
+
+    * a recent stable/longterm release
+
+    * the development cycle of the latest proper mainline release
+
+   In the latter case (say Linux v5.14), try to address regressions even
+   quicker, if the stable series for the predecessor (v5.13) will be abandoned
+   soon or already was stamped "End-of-Life" (EOL) -- this usually happens about
+   three to four weeks after a new mainline release.
+
+ * Try to fix all other regressions within two weeks after the culprit was
+   found. Two or three additional weeks are acceptable for performance
+   regressions and other issues which are annoying, but don't prevent anyone
+   from running Linux (unless it's an issue in the current development cycle,
+   as those should ideally be addressed before the release). A few weeks in
+   total are acceptable if a regression can only be fixed with a risky change
+   and at the same time is affecting only a few users; as much time is
+   also okay if the regression is already present in the second newest longterm
+   kernel series.
+
+Note: The aforementioned time frames for resolving regressions are meant to
+include getting the fix tested, reviewed, and merged into mainline, ideally with
+the fix being in linux-next at least briefly. This leads to delays you need to
+account for.
+
+Subsystem maintainers are expected to assist in reaching those periods by doing
+timely reviews and quick handling of accepted patches. They thus might have to
+send git-pull requests earlier or more often than usual; depending on the fix,
+it might even be acceptable to skip testing in linux-next. Especially fixes for
+regressions in stable and longterm kernels need to be handled quickly, as fixes
+need to be merged in mainline before they can be backported to older series.
+
 
 More aspects regarding regressions developers should be aware of
 ----------------------------------------------------------------
-- 
2.35.1

