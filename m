Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CBA4B81B4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiBPHgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:36:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiBPHgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:36:17 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D685DD5DDC;
        Tue, 15 Feb 2022 23:36:01 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1nKEA4-00083j-Vi; Wed, 16 Feb 2022 07:51:37 +0100
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
Subject: [PATCH v5 1/3] docs: add two documents about regression handling
Date:   Wed, 16 Feb 2022 07:51:33 +0100
Message-Id: <34e56d3588f22d7e0b4d635ef9c9c3b33ca4ac04.1644994117.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644994117.git.linux@leemhuis.info>
References: <cover.1644994117.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1644996961;b07ce526;
X-HE-SMSGID: 1nKEA4-00083j-Vi
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create two documents explaining various aspects around regression
handling and tracking; one is aimed at users, the other targets
developers.

The texts among others describes the first rule of Linux kernel
development and what it means in practice. They also explain what a
regression actually is and how to report one properly.

Both texts additionally provide a brief introduction to the bot the
kernel's regression tracker uses to facilitate the work, but mention the
use is optional.

To sum things up, provide a few quotes from Linus in the document for
developers to show how serious we take regressions.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/index.rst           |   1 +
 .../admin-guide/reporting-regressions.rst     | 439 ++++++++++++
 .../process/handling-regressions.rst          | 659 ++++++++++++++++++
 Documentation/process/index.rst               |   1 +
 MAINTAINERS                                   |   2 +
 5 files changed, 1102 insertions(+)
 create mode 100644 Documentation/admin-guide/reporting-regressions.rst
 create mode 100644 Documentation/process/handling-regressions.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 1bedab498104..5bfafcbb9562 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -35,6 +35,7 @@ problems and bugs in particular.
    :maxdepth: 1
 
    reporting-issues
+   reporting-regressions
    security-bugs
    bug-hunting
    bug-bisect
diff --git a/Documentation/admin-guide/reporting-regressions.rst b/Documentation/admin-guide/reporting-regressions.rst
new file mode 100644
index 000000000000..6fbd24ceb3bf
--- /dev/null
+++ b/Documentation/admin-guide/reporting-regressions.rst
@@ -0,0 +1,439 @@
+.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
+.. [see the bottom of this file for redistribution information]
+
+Reporting regressions
++++++++++++++++++++++
+
+"*We don't cause regressions*" is the first rule of Linux kernel development;
+Linux founder and lead developer Linus Torvalds established it himself and
+ensures it's obeyed.
+
+This document describes what the rule means for users and how the Linux kernel's
+development model ensures to address all reported regressions; aspects relevant
+for kernel developers are left to Documentation/process/handling-regressions.rst.
+
+
+The important bits (aka "TL;DR")
+================================
+
+#. It's a regression if something running fine with one Linux kernel works worse
+   or not at all with a newer version. Note, the newer kernel has to be compiled
+   using a similar configuration; the detailed explanations below describes this
+   and other fine print in more detail.
+
+#. Report your issue as outlined in Documentation/admin-guide/reporting-issues.rst,
+   it already covers all aspects important for regressions and repeated
+   below for convenience. Two of them are important: start your report's subject
+   with "[REGRESSION]" and CC or forward it to `the regression mailing list
+   <https://lore.kernel.org/regressions/>`_ (regressions@lists.linux.dev).
+
+#. Optional, but recommended: when sending or forwarding your report, make the
+   Linux kernel regression tracking bot "regzbot" track the issue by specifying
+   when the regression started like this::
+
+       #regzbot introduced v5.13..v5.14-rc1
+
+
+All the details on Linux kernel regressions relevant for users
+==============================================================
+
+
+The important basics
+--------------------
+
+
+What is a "regression" and what is the "no regressions rule"?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+It's a regression if some application or practical use case running fine with
+one Linux kernel works worse or not at all with a newer version compiled using a
+similar configuration. The "no regressions rule" forbids this to take place; if
+it happens by accident, developers that caused it are expected to quickly fix
+the issue.
+
+It thus is a regression when a WiFi driver from Linux 5.13 works fine, but with
+5.14 doesn't work at all, works significantly slower, or misbehaves somehow.
+It's also a regression if a perfectly working application suddenly shows erratic
+behavior with a newer kernel version; such issues can be caused by changes in
+procfs, sysfs, or one of the many other interfaces Linux provides to userland
+software. But keep in mind, as mentioned earlier: 5.14 in this example needs to
+be built from a configuration similar to the one from 5.13. This can be achieved
+using ``make olddefconfig``, as explained in more detail below.
+
+Note the "practical use case" in the first sentence of this section: developers
+despite the "no regressions" rule are free to change any aspect of the kernel
+and even APIs or ABIs to userland, as long as no existing application or use
+case breaks.
+
+Also be aware the "no regressions" rule covers only interfaces the kernel
+provides to the userland. It thus does not apply to kernel-internal interfaces
+like the module API, which some externally developed drivers use to hook into
+the kernel.
+
+How do I report a regression?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Just report the issue as outlined in
+Documentation/admin-guide/reporting-issues.rst, it already describes the
+important points. The following aspects outlined there are especially relevant
+for regressions:
+
+ * When checking for existing reports to join, also search the `archives of the
+   Linux regressions mailing list <https://lore.kernel.org/regressions/>`_ and
+   `regzbot's web-interface <https://linux-regtracking.leemhuis.info/regzbot/>`_.
+
+ * Start your report's subject with "[REGRESSION]".
+
+ * In your report, clearly mention the last kernel version that worked fine and
+   the first broken one. Ideally try to find the exact change causing the
+   regression using a bisection, as explained below in more detail.
+
+ * Remember to let the Linux regressions mailing list
+   (regressions@lists.linux.dev) know about your report:
+
+   * If you report the regression by mail, CC the regressions list.
+
+   * If you report your regression to some bug tracker, forward the submitted
+     report by mail to the regressions list while CCing the maintainer and the
+     mailing list for the subsystem in question.
+
+   If it's a regression within a stable or longterm series (e.g.
+   v5.15.3..v5.15.5), remember to CC the `Linux stable mailing list
+   <https://lore.kernel.org/stable/>`_ (stable@vger.kernel.org).
+
+  In case you performed a successful bisection, add everyone to the CC the
+  culprit's commit message mentions in lines starting with "Signed-off-by:".
+
+When CCing for forwarding your report to the list, consider directly telling the
+aforementioned Linux kernel regression tracking bot about your report. To do
+that, include a paragraph like this in your mail::
+
+       #regzbot introduced: v5.13..v5.14-rc1
+
+Regzbot will then consider your mail a report for a regression introduced in the
+specified version range. In above case Linux v5.13 still worked fine and Linux
+v5.14-rc1 was the first version where you encountered the issue. If you
+performed a bisection to find the commit that caused the regression, specify the
+culprit's commit-id instead::
+
+       #regzbot introduced: 1f2e3d4c5d
+
+Placing such a "regzbot command" is in your interest, as it will ensure the
+report won't fall through the cracks unnoticed. If you omit this, the Linux
+kernel's regressions tracker will take care of telling regzbot about your
+regression, as long as you send a copy to the regressions mailing lists. But the
+regression tracker is just one human which sometimes has to rest or occasionally
+might even enjoy some time away from computers (as crazy as that might sound).
+Relying on this person thus will result in an unnecessary delay before the
+regressions becomes mentioned `on the list of tracked and unresolved Linux
+kernel regressions <https://linux-regtracking.leemhuis.info/regzbot/>`_ and the
+weekly regression reports sent by regzbot. Such delays can result in Linus
+Torvalds being unaware of important regressions when deciding between "continue
+development or call this finished and release the final?".
+
+Are really all regressions fixed?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Nearly all of them are, as long as the change causing the regression (the
+"culprit commit") is reliably identified. Some regressions can be fixed without
+this, but often it's required.
+
+Who needs to find the root cause of a regression?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Developers of the affected code area should try to locate the culprit on their
+own. But for them that's often impossible to do with reasonable effort, as quite
+a lot of issues only occur in a particular environment outside the developer's
+reach -- for example, a specific hardware platform, firmware, Linux distro,
+system's configuration, or application. That's why in the end it's often up to
+the reporter to locate the culprit commit; sometimes users might even need to
+run additional tests afterwards to pinpoint the exact root cause. Developers
+should offer advice and reasonably help where they can, to make this process
+relatively easy and achievable for typical users.
+
+How can I find the culprit?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Perform a bisection, as roughly outlined in
+Documentation/admin-guide/reporting-issues.rst and described in more detail by
+Documentation/admin-guide/bug-bisect.rst. It might sound like a lot of work, but
+in many cases finds the culprit relatively quickly. If it's hard or
+time-consuming to reliably reproduce the issue, consider teaming up with other
+affected users to narrow down the search range together.
+
+Who can I ask for advice when it comes to regressions?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Send a mail to the regressions mailing list (regressions@lists.linux.dev) while
+CCing the Linux kernel's regression tracker (regressions@leemhuis.info); if the
+issue might better be dealt with in private, feel free to omit the list.
+
+
+Additional details about regressions
+------------------------------------
+
+
+What is the goal of the "no regressions rule"?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Users should feel safe when updating kernel versions and not have to worry
+something might break. This is in the interest of the kernel developers to make
+updating attractive: they don't want users to stay on stable or longterm Linux
+series that are either abandoned or more than one and a half years old. That's
+in everybody's interest, as `those series might have known bugs, security
+issues, or other problematic aspects already fixed in later versions
+<http://www.kroah.com/log/blog/2018/08/24/what-stable-kernel-should-i-use/>`_.
+Additionally, the kernel developers want to make it simple and appealing for
+users to test the latest pre-release or regular release. That's also in
+everybody's interest, as it's a lot easier to track down and fix problems, if
+they are reported shortly after being introduced.
+
+Is the "no regressions" rule really adhered in practice?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+It's taken really seriously, as can be seen by many mailing list posts from
+Linux creator and lead developer Linus Torvalds, some of which are quoted in
+Documentation/process/handling-regressions.rst.
+
+Exceptions to this rule are extremely rare; in the past developers almost always
+turned out to be wrong when they assumed a particular situation was warranting
+an exception.
+
+Who ensures the "no regressions" is actually followed?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The subsystem maintainers should take care of that, which are watched and
+supported by the tree maintainers -- e.g. Linus Torvalds for mainline and
+Greg Kroah-Hartman et al. for various stable/longterm series.
+
+All of them are helped by people trying to ensure no regression report falls
+through the cracks. One of them is Thorsten Leemhuis, who's currently acting as
+the Linux kernel's "regressions tracker"; to facilitate this work he relies on
+regzbot, the Linux kernel regression tracking bot. That's why you want to bring
+your report on the radar of these people by CCing or forwarding each report to
+the regressions mailing list, ideally with a "regzbot command" in your mail to
+get it tracked immediately.
+
+Is it a regression, if the issue can be avoided by updating some software?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Almost always: yes. If a developer tells you otherwise, ask the regression
+tracker for advice as outlined above.
+
+Is it a regression, if a newer kernel works slower or consumes more energy?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Yes, but the difference has to be significant. A five percent slow-down in a
+micro-benchmark thus is unlikely to qualify as regression, unless it also
+influences the results of a broad benchmark by more than one percent. If in
+doubt, ask for advice.
+
+Is it a regression, if an external kernel module breaks when updating Linux?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+No, as the "no regression" rule is about interfaces and services the Linux
+kernel provides to the userland. It thus does not cover building or running
+externally developed kernel modules, as they run in kernel-space and hook into
+the kernel using internal interfaces occasionally changed.
+
+How are regressions handled that are caused by security fixes?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+In extremely rare situations security issues can't be fixed without causing
+regressions; those fixes are given way, as they are the lesser evil in the end.
+Luckily this middling almost always can be avoided, as key developers for the
+affected area and often Linus Torvalds himself try very hard to fix security
+issues without causing regressions.
+
+If you nevertheless face such a case, check the mailing list archives if people
+tried their best to avoid the regression. If not, report it; if in doubt, ask
+for advice as outlined above.
+
+What happens if fixing a regression is impossible without causing another?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Sadly these things happen, but luckily not very often; if they occur, expert
+developers of the affected code area should look into the issue to find a fix
+that avoids regressions or at least their impact. If you run into such a
+situation, do what was outlined already for regressions caused by security
+fixes: check earlier discussions if people already tried their best and ask for
+advice if in doubt.
+
+A quick note while at it: these situations could be avoided, if people would
+regularly give mainline pre-releases (say v5.15-rc1 or -rc3) from each
+development cycle a test run. This is best explained by imagining a change
+integrated between Linux v5.14 and v5.15-rc1 which causes a regression, but at
+the same time is a hard requirement for some other improvement applied for
+5.15-rc1. All these changes often can simply be reverted and the regression thus
+solved, if someone finds and reports it before 5.15 is released. A few days or
+weeks later this solution can become impossible, as some software might have
+started to rely on aspects introduced by one of the follow-up changes: reverting
+all changes would then cause a regression for users of said software and thus is
+out of the question.
+
+Is it a regression, if some feature I relied on was removed months ago?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+It is, but often it's hard to fix such regressions due to the aspects outlined
+in the previous section. It hence needs to be dealt with on a case-by-case
+basis. This is another reason why it's in everybody's interest to regularly test
+mainline pre-releases.
+
+Does the "no regression" rule apply if I seem to be the only affected person?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+It does, but only for practical usage: the Linux developers want to be free to
+remove support for hardware only to be found in attics and museums anymore.
+
+Note, sometimes regressions can't be avoided to make progress -- and the latter
+is needed to prevent Linux from stagnation. Hence, if only very few users seem
+to be affected by a regression, it for the greater good might be in their and
+everyone else's interest to lettings things pass. Especially if there is an
+easy way to circumvent the regression somehow, for example by updating some
+software or using a kernel parameter created just for this purpose.
+
+Does the regression rule apply for code in the staging tree as well?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Not according to the `help text for the configuration option covering all
+staging code <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/Kconfig>`_,
+which since its early days states::
+
+       Please note that these drivers are under heavy development, may or
+       may not work, and may contain userspace interfaces that most likely
+       will be changed in the near future.
+
+The staging developers nevertheless often adhere to the "no regressions" rule,
+but sometimes bend it to make progress. That's for example why some users had to
+deal with (often negligible) regressions when a WiFi driver from the staging
+tree was replaced by a totally different one written from scratch.
+
+Why do later versions have to be "compiled with a similar configuration"?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Because the Linux kernel developers sometimes integrate changes known to cause
+regressions, but make them optional and disable them in the kernel's default
+configuration. This trick allows progress, as the "no regressions" rule
+otherwise would lead to stagnation.
+
+Consider for example a new security feature blocking access to some kernel
+interfaces often abused by malware, which at the same time are required to run a
+few rarely used applications. The outlined approach makes both camps happy:
+people using these applications can leave the new security feature off, while
+everyone else can enable it without running into trouble.
+
+How to create a configuration similar to the one of an older kernel?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Start your machine with a known-good kernel and configure the newer Linux
+version with ``make olddefconfig``. This makes the kernel's build scripts pick
+up the configuration file (the ".config" file) from the running kernel as base
+for the new one you are about to compile; afterwards they set all new
+configuration options to their default value, which should disable new features
+that might cause regressions.
+
+Can I report a regression I found with pre-compiled vanilla kernels?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You need to ensure the newer kernel was compiled with a similar configuration
+file as the older one (see above), as those that built them might have enabled
+some known-to-be incompatible feature for the newer kernel. If in doubt, report
+the matter to the kernel's provider and ask for advice.
+
+
+More about regression tracking with "regzbot"
+---------------------------------------------
+
+What is regression tracking and why should I care about it?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Rules like "no regressions" need someone to ensure they are followed, otherwise
+they are broken either accidentally or on purpose. History has shown this to be
+true for Linux kernel development as well. That's why Thorsten Leemhuis, the
+Linux Kernel's regression tracker, and some people try to ensure all regression
+are fixed by keeping an eye on them until they are resolved. Neither of them are
+paid for this, that's why the work is done on a best effort basis.
+
+Why and how are Linux kernel regressions tracked using a bot?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Tracking regressions completely manually has proven to be quite hard due to the
+distributed and loosely structured nature of Linux kernel development process.
+That's why the Linux kernel's regression tracker developed regzbot to facilitate
+the work, with the long term goal to automate regression tracking as much as
+possible for everyone involved.
+
+Regzbot works by watching for replies to reports of tracked regressions.
+Additionally, it's looking out for posted or committed patches referencing such
+reports with "Link:" tags; replies to such patch postings are tracked as well.
+Combined this data provides good insights into the current state of the fixing
+process.
+
+How to see which regressions regzbot tracks currently?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Check out `regzbot's web-interface <https://linux-regtracking.leemhuis.info/regzbot/>`_.
+
+What kind of issues are supposed to be tracked by regzbot?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The bot is meant to track regressions, hence please don't involve regzbot for
+regular issues. But it's okay for the Linux kernel's regression tracker if you
+involve regzbot to track severe issues, like reports about hangs, corrupted
+data, or internal errors (Panic, Oops, BUG(), warning, ...).
+
+How to change aspects of a tracked regression?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+By using a 'regzbot command' in a direct or indirect reply to the mail with the
+report. The easiest way to do that: find the report in your "Sent" folder or the
+mailing list archive and reply to it using your mailer's "Reply-all" function.
+In that mail, use one of the following commands in a stand-alone paragraph (IOW:
+use blank lines to separate one or multiple of these commands from the rest of
+the mail's text).
+
+ * Update when the regression started to happen, for example after performing a
+   bisection::
+
+       #regzbot introduced: 1f2e3d4c5d
+
+ * Set or update the title::
+
+       #regzbot title: foo
+
+ * Monitor a discussion or bugzilla.kernel.org ticket where additions aspects of
+   the issue or a fix are discussed:::
+
+       #regzbot monitor: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
+       #regzbot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=123456789
+
+ * Point to a place with further details of interest, like a mailing list post
+   or a ticket in a bug tracker that are slightly related, but about a different
+   topic::
+
+       #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=123456789
+
+ * Mark a regression as invalid::
+
+       #regzbot invalid: wasn't a regression, problem has always existed
+
+Regzbot supports a few other commands primarily used by developers or people
+tracking regressions. They and more details about the aforementioned regzbot
+commands can be found in the `getting started guide
+<https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md>`_ and
+the `reference documentation <https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md>`_
+for regzbot.
+
+..
+   end-of-content
+..
+   This text is available under GPL-2.0+ or CC-BY-4.0, as stated at the top
+   of the file. If you want to distribute this text under CC-BY-4.0 only,
+   please use "The Linux kernel developers" for author attribution and link
+   this as source:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/reporting-regressions.rst
+..
+   Note: Only the content of this RST file as found in the Linux kernel sources
+   is available under CC-BY-4.0, as versions of this text that were processed
+   (for example by the kernel's build system) might contain content taken from
+   files which use a more restrictive license.
diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
new file mode 100644
index 000000000000..e1102a3207e3
--- /dev/null
+++ b/Documentation/process/handling-regressions.rst
@@ -0,0 +1,659 @@
+.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
+.. See the bottom of this file for additional redistribution information.
+
+Handling regressions
+++++++++++++++++++++
+
+*We don't cause regressions* -- this document describes what this "first rule of
+Linux kernel development" means in practice for developers. It complements
+Documentation/admin-guide/reporting-regressions.rst, which covers the topic from a
+user's point of view; if you never read that text, go and at least skim over it
+before continuing here.
+
+The important bits (aka "The TL;DR")
+====================================
+
+#. Ensure subscribers of the `regression mailing list <https://lore.kernel.org/regressions/>`_
+   (regressions@lists.linux.dev) quickly become aware of any new regression
+   report:
+
+    * When receiving a mailed report that did not CC the list, bring it into the
+      loop by immediately sending at least a brief "Reply-all" with the list
+      CCed.
+
+    * Forward or bounce any reports submitted in bug trackers to the list.
+
+#. Make the Linux kernel regression tracking bot "regzbot" track the issue (this
+   is optional, but recommended):
+
+    * For mailed reports, check if the reporter included a line like ``#regzbot
+      introduced v5.13..v5.14-rc1``. If not, send a reply (with the regressions
+      list in CC) containing a paragraph like the following, which tells regzbot
+      when the issue started to happen::
+
+       #regzbot ^introduced 1f2e3d4c5b6a
+
+    * When forwarding reports from a bug tracker to the regressions list (see
+      above), include a paragraph like the following::
+
+       #regzbot introduced: v5.13..v5.14-rc1
+       #regzbot from: Some N. Ice Human <some.human@example.com>
+       #regzbot monitor: http://some.bugtracker.example.com/ticket?id=123456789
+
+#. When submitting fixes for regressions, add "Link:" tags to the patch
+   description pointing to all places where the issue was reported, as
+   mandated by Documentation/process/submitting-patches.rst and
+   :ref:`Documentation/process/5.Posting.rst <development_posting>`.
+
+
+All the details on Linux kernel regressions relevant for developers
+===================================================================
+
+
+The important basics in more detail
+-----------------------------------
+
+
+What to do when receiving regression reports
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Ensure the Linux kernel's regression tracker and others subscribers of the
+`regression mailing list <https://lore.kernel.org/regressions/>`_
+(regressions@lists.linux.dev) become aware of any newly reported regression:
+
+ * When you receive a report by mail that did not CC the list, immediately bring
+   it into the loop by sending at least a brief "Reply-all" with the list CCed;
+   try to ensure it gets CCed again in case you reply to a reply that omitted
+   the list.
+
+ * If a report submitted in a bug tracker hits your Inbox, forward or bounce it
+   to the list. Consider checking the list archives beforehand, if the reporter
+   already forwarded the report as instructed by
+   Documentation/admin-guide/reporting-issues.rst.
+
+When doing either, consider making the Linux kernel regression tracking bot
+"regzbot" immediately start tracking the issue:
+
+ * For mailed reports, check if the reporter included a "regzbot command" like
+   ``#regzbot introduced 1f2e3d4c5b6a``. If not, send a reply (with the
+   regressions list in CC) with a paragraph like the following:::
+
+       #regzbot ^introduced: v5.13..v5.14-rc1
+
+   This tells regzbot the version range in which the issue started to happen;
+   you can specify a range using commit-ids as well or state a single commit-id
+   in case the reporter bisected the culprit.
+
+   Note the caret (^) before the "introduced": it tells regzbot to treat the
+   parent mail (the one you reply to) as the initial report for the regression
+   you want to see tracked; that's important, as regzbot will later look out
+   for patches with "Link:" tags pointing to the report in the archives on
+   lore.kernel.org.
+
+ * When forwarding a regressions reported to a bug tracker, include a paragraph
+   with these regzbot commands::
+
+       #regzbot introduced: 1f2e3d4c5b6a
+       #regzbot from: Some N. Ice Human <some.human@example.com>
+       #regzbot monitor: http://some.bugtracker.example.com/ticket?id=123456789
+
+   Regzbot will then automatically associate patches with the report that
+   contain "Link:" tags pointing to your mail or the mentioned ticket.
+
+What's important when fixing regressions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You don't need to do anything special when submitting fixes for regression, just
+remember to do what Documentation/process/submitting-patches.rst,
+:ref:`Documentation/process/5.Posting.rst <development_posting>`, and
+Documentation/process/stable-kernel-rules.rst already explain in more detail:
+
+ * Point to all places where the issue was reported using "Link:" tags::
+
+       Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
+       Link: https://bugzilla.kernel.org/show_bug.cgi?id=1234567890
+
+ * Add a "Fixes:" tag to specify the commit causing the regression.
+
+ * If the culprit was merged in an earlier development cycle, explicitly mark
+   the fix for backporting using the ``Cc: stable@vger.kernel.org`` tag.
+
+All this is expected from you and important when it comes to regression, as
+these tags are of great value for everyone (you included) that might be looking
+into the issue weeks, months, or years later. These tags are also crucial for
+tools and scripts used by other kernel developers or Linux distributions; one of
+these tools is regzbot, which heavily relies on the "Link:" tags to associate
+reports for regression with changes resolving them.
+
+
+More aspects regarding regressions developers should be aware of
+----------------------------------------------------------------
+
+
+How to deal with changes where a risk of regression is known
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Evaluate how big the risk of regressions is, for example by performing a code
+search in Linux distributions and Git forges. Also consider asking other
+developers or projects likely to be affected to evaluate or even test the
+proposed change; if problems surface, maybe some solution acceptable for all
+can be found.
+
+If the risk of regressions in the end seems to be relatively small, go ahead
+with the change, but let all involved parties know about the risk. Hence, make
+sure your patch description makes this aspect obvious. Once the change is
+merged, tell the Linux kernel's regression tracker and the regressions mailing
+list about the risk, so everyone has the change on the radar in case reports
+trickle in. Depending on the risk, you also might want to ask the subsystem
+maintainer to mention the issue in his mainline pull request.
+
+What else is there to known about regressions?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Check out Documentation/admin-guide/reporting-regressions.rst, it covers a lot
+of other aspects you want might want to be aware of:
+
+ * the purpose of the "no regressions rule"
+
+ * what issues actually qualify as regression
+
+ * who's in charge for finding the root cause of a regression
+
+ * how to handle tricky situations, e.g. when a regression is caused by a
+   security fix or when fixing a regression might cause another one
+
+Whom to ask for advice when it comes to regressions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Send a mail to the regressions mailing list (regressions@lists.linux.dev) while
+CCing the Linux kernel's regression tracker (regressions@leemhuis.info); if the
+issue might better be dealt with in private, feel free to omit the list.
+
+
+More about regression tracking and regzbot
+------------------------------------------
+
+
+Why the Linux kernel has a regression tracker, and why is regzbot used?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Rules like "no regressions" need someone to ensure they are followed, otherwise
+they are broken either accidentally or on purpose. History has shown this to be
+true for the Linux kernel as well. That's why Thorsten Leemhuis volunteered to
+keep an eye on things as the Linux kernel's regression tracker, who's
+occasionally helped by other people. Neither of them are paid to do this,
+that's why regression tracking is done on a best effort basis.
+
+Earlier attempts to manually track regressions have shown it's an exhausting and
+frustrating work, which is why they were abandoned after a while. To prevent
+this from happening again, Thorsten developed regzbot to facilitate the work,
+with the long term goal to automate regression tracking as much as possible for
+everyone involved.
+
+How does regression tracking work with regzbot?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The bot watches for replies to reports of tracked regressions. Additionally,
+it's looking out for posted or committed patches referencing such reports
+with "Link:" tags; replies to such patch postings are tracked as well.
+Combined this data provides good insights into the current state of the fixing
+process.
+
+Regzbot tries to do its job with as little overhead as possible for both
+reporters and developers. In fact, only reporters are burdened with an extra
+duty: they need to tell regzbot about the regression report using the ``#regzbot
+introduced`` command outlined above; if they don't do that, someone else can
+take care of that using ``#regzbot ^introduced``.
+
+For developers there normally is no extra work involved, they just need to make
+sure to do something that was expected long before regzbot came to light: add
+"Link:" tags to the patch description pointing to all reports about the issue
+fixed.
+
+Do I have to use regzbot?
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+It's in the interest of everyone if you do, as kernel maintainers like Linus
+Torvalds partly rely on regzbot's tracking in their work -- for example when
+deciding to release a new version or extend the development phase. For this they
+need to be aware of all unfixed regression; to do that, Linus is known to look
+into the weekly reports sent by regzbot.
+
+Do I have to tell regzbot about every regression I stumble upon?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Ideally yes: we are all humans and easily forget problems when something more
+important unexpectedly comes up -- for example a bigger problem in the Linux
+kernel or something in real life that's keeping us away from keyboards for a
+while. Hence, it's best to tell regzbot about every regression, except when you
+immediately write a fix and commit it to a tree regularly merged to the affected
+kernel series.
+
+How to see which regressions regzbot tracks currently?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Check `regzbot's web-interface <https://linux-regtracking.leemhuis.info/regzbot/>`_
+for the latest info; alternatively, `search for the latest regression report
+<https://lore.kernel.org/lkml/?q=%22Linux+regressions+report%22+f%3Aregzbot>`_,
+which regzbot normally sends out once a week on Sunday evening (UTC), which is a
+few hours before Linus usually publishes new (pre-)releases.
+
+What places is regzbot monitoring?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Regzbot is watching the most important Linux mailing lists as well as the git
+repositories of linux-next, mainline, and stable/longterm.
+
+What kind of issues are supposed to be tracked by regzbot?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The bot is meant to track regressions, hence please don't involve regzbot for
+regular issues. But it's okay for the Linux kernel's regression tracker if you
+use regzbot to track severe issues, like reports about hangs, corrupted data,
+or internal errors (Panic, Oops, BUG(), warning, ...).
+
+Can I add regressions found by CI systems to regzbot's tracking?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Feel free to do so, if the particular regression likely has impact on practical
+use cases and thus might be noticed by users; hence, please don't involve
+regzbot for theoretical regressions unlikely to show themselves in real world
+usage.
+
+How to interact with regzbot?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+By using a 'regzbot command' in a direct or indirect reply to the mail with the
+regression report. These commands need to be in their own paragraph (IOW: they
+need to be separated from the rest of the mail using blank lines).
+
+One such command is ``#regzbot introduced <version or commit>``, which makes
+regzbot consider your mail as a regressions report added to the tracking, as
+already described above; ``#regzbot ^introduced <version or commit>`` is another
+such command, which makes regzbot consider the parent mail as a report for a
+regression which it starts to track.
+
+Once one of those two commands has been utilized, other regzbot commands can be
+used in direct or indirect replies to the report. You can write them below one
+of the `introduced` commands or in replies to the mail that used one of them
+or itself is a reply to that mail:
+
+ * Set or update the title::
+
+       #regzbot title: foo
+
+ * Monitor a discussion or bugzilla.kernel.org ticket where additions aspects of
+   the issue or a fix are discussed -- for example the posting of a patch fixing
+   the regression::
+
+       #regzbot monitor: https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/
+
+   Monitoring only works for lore.kernel.org and bugzilla.kernel.org; regzbot
+   will consider all messages in that thread or ticket as related to the fixing
+   process.
+
+ * Point to a place with further details of interest, like a mailing list post
+   or a ticket in a bug tracker that are slightly related, but about a different
+   topic::
+
+       #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=123456789
+
+ * Mark a regression as fixed by a commit that is heading upstream or already
+   landed::
+
+       #regzbot fixed-by: 1f2e3d4c5d
+
+ * Mark a regression as a duplicate of another one already tracked by regzbot::
+
+       #regzbot dup-of: https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/
+
+ * Mark a regression as invalid::
+
+       #regzbot invalid: wasn't a regression, problem has always existed
+
+Is there more to tell about regzbot and its commands?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+More detailed and up-to-date information about the Linux
+kernel's regression tracking bot can be found on its
+`project page <https://gitlab.com/knurd42/regzbot>`_, which among others
+contains a `getting started guide <https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md>`_
+and `reference documentation <https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md>`_
+which both cover more details than the above section.
+
+Quotes from Linus about regression
+----------------------------------
+
+Find below a few real life examples of how Linus Torvalds expects regressions to
+be handled:
+
+ * From `2017-10-26 (1/2)
+   <https://lore.kernel.org/lkml/CA+55aFwiiQYJ+YoLKCXjN_beDVfu38mg=Ggg5LFOcqHE8Qi7Zw@mail.gmail.com/>`_::
+
+       If you break existing user space setups THAT IS A REGRESSION.
+
+       It's not ok to say "but we'll fix the user space setup".
+
+       Really. NOT OK.
+
+       [...]
+
+       The first rule is:
+
+        - we don't cause regressions
+
+       and the corollary is that when regressions *do* occur, we admit to
+       them and fix them, instead of blaming user space.
+
+       The fact that you have apparently been denying the regression now for
+       three weeks means that I will revert, and I will stop pulling apparmor
+       requests until the people involved understand how kernel development
+       is done.
+
+ * From `2017-10-26 (2/2)
+   <https://lore.kernel.org/lkml/CA+55aFxW7NMAMvYhkvz1UPbUTUJewRt6Yb51QAx5RtrWOwjebg@mail.gmail.com/>`_::
+
+       People should basically always feel like they can update their kernel
+       and simply not have to worry about it.
+
+       I refuse to introduce "you can only update the kernel if you also
+       update that other program" kind of limitations. If the kernel used to
+       work for you, the rule is that it continues to work for you.
+
+       There have been exceptions, but they are few and far between, and they
+       generally have some major and fundamental reasons for having happened,
+       that were basically entirely unavoidable, and people _tried_hard_ to
+       avoid them. Maybe we can't practically support the hardware any more
+       after it is decades old and nobody uses it with modern kernels any
+       more. Maybe there's a serious security issue with how we did things,
+       and people actually depended on that fundamentally broken model. Maybe
+       there was some fundamental other breakage that just _had_ to have a
+       flag day for very core and fundamental reasons.
+
+       And notice that this is very much about *breaking* peoples environments.
+
+       Behavioral changes happen, and maybe we don't even support some
+       feature any more. There's a number of fields in /proc/<pid>/stat that
+       are printed out as zeroes, simply because they don't even *exist* in
+       the kernel any more, or because showing them was a mistake (typically
+       an information leak). But the numbers got replaced by zeroes, so that
+       the code that used to parse the fields still works. The user might not
+       see everything they used to see, and so behavior is clearly different,
+       but things still _work_, even if they might no longer show sensitive
+       (or no longer relevant) information.
+
+       But if something actually breaks, then the change must get fixed or
+       reverted. And it gets fixed in the *kernel*. Not by saying "well, fix
+       your user space then". It was a kernel change that exposed the
+       problem, it needs to be the kernel that corrects for it, because we
+       have a "upgrade in place" model. We don't have a "upgrade with new
+       user space".
+
+       And I seriously will refuse to take code from people who do not
+       understand and honor this very simple rule.
+
+       This rule is also not going to change.
+
+       And yes, I realize that the kernel is "special" in this respect. I'm
+       proud of it.
+
+       I have seen, and can point to, lots of projects that go "We need to
+       break that use case in order to make progress" or "you relied on
+       undocumented behavior, it sucks to be you" or "there's a better way to
+       do what you want to do, and you have to change to that new better
+       way", and I simply don't think that's acceptable outside of very early
+       alpha releases that have experimental users that know what they signed
+       up for. The kernel hasn't been in that situation for the last two
+       decades.
+
+       We do API breakage _inside_ the kernel all the time. We will fix
+       internal problems by saying "you now need to do XYZ", but then it's
+       about internal kernel API's, and the people who do that then also
+       obviously have to fix up all the in-kernel users of that API. Nobody
+       can say "I now broke the API you used, and now _you_ need to fix it
+       up". Whoever broke something gets to fix it too.
+
+       And we simply do not break user space.
+
+ * From `2020-05-21
+   <https://lore.kernel.org/all/CAHk-=wiVi7mSrsMP=fLXQrXK_UimybW=ziLOwSzFTtoXUacWVQ@mail.gmail.com/>`_::
+
+       The rules about regressions have never been about any kind of
+       documented behavior, or where the code lives.
+
+       The rules about regressions are always about "breaks user workflow".
+
+       Users are literally the _only_ thing that matters.
+
+       No amount of "you shouldn't have used this" or "that behavior was
+       undefined, it's your own fault your app broke" or "that used to work
+       simply because of a kernel bug" is at all relevant.
+
+       Now, reality is never entirely black-and-white. So we've had things
+       like "serious security issue" etc that just forces us to make changes
+       that may break user space. But even then the rule is that we don't
+       really have other options that would allow things to continue.
+
+       And obviously, if users take years to even notice that something
+       broke, or if we have sane ways to work around the breakage that
+       doesn't make for too much trouble for users (ie "ok, there are a
+       handful of users, and they can use a kernel command line to work
+       around it" kind of things) we've also been a bit less strict.
+
+       But no, "that was documented to be broken" (whether it's because the
+       code was in staging or because the man-page said something else) is
+       irrelevant. If staging code is so useful that people end up using it,
+       that means that it's basically regular kernel code with a flag saying
+       "please clean this up".
+
+       The other side of the coin is that people who talk about "API
+       stability" are entirely wrong. API's don't matter either. You can make
+       any changes to an API you like - as long as nobody notices.
+
+       Again, the regression rule is not about documentation, not about
+       API's, and not about the phase of the moon.
+
+       It's entirely about "we caused problems for user space that used to work".
+
+ * From `2017-11-05
+   <https://lore.kernel.org/all/CA+55aFzUvbGjD8nQ-+3oiMBx14c_6zOj2n7KLN3UsJ-qsd4Dcw@mail.gmail.com/>`_::
+
+       And our regression rule has never been "behavior doesn't change".
+       That would mean that we could never make any changes at all.
+
+       For example, we do things like add new error handling etc all the
+       time, which we then sometimes even add tests for in our kselftest
+       directory.
+
+       So clearly behavior changes all the time and we don't consider that a
+       regression per se.
+
+       The rule for a regression for the kernel is that some real user
+       workflow breaks. Not some test. Not a "look, I used to be able to do
+       X, now I can't".
+
+ * From `2018-08-03
+   <https://lore.kernel.org/all/CA+55aFwWZX=CXmWDTkDGb36kf12XmTehmQjbiMPCqCRG2hi9kw@mail.gmail.com/>`_::
+
+       YOU ARE MISSING THE #1 KERNEL RULE.
+
+       We do not regress, and we do not regress exactly because your are 100% wrong.
+
+       And the reason you state for your opinion is in fact exactly *WHY* you
+       are wrong.
+
+       Your "good reasons" are pure and utter garbage.
+
+       The whole point of "we do not regress" is so that people can upgrade
+       the kernel and never have to worry about it.
+
+       > Kernel had a bug which has been fixed
+
+       That is *ENTIRELY* immaterial.
+
+       Guys, whether something was buggy or not DOES NOT MATTER.
+
+       Why?
+
+       Bugs happen. That's a fact of life. Arguing that "we had to break
+       something because we were fixing a bug" is completely insane. We fix
+       tens of bugs every single day, thinking that "fixing a bug" means that
+       we can break something is simply NOT TRUE.
+
+       So bugs simply aren't even relevant to the discussion. They happen,
+       they get found, they get fixed, and it has nothing to do with "we
+       break users".
+
+       Because the only thing that matters IS THE USER.
+
+       How hard is that to understand?
+
+       Anybody who uses "but it was buggy" as an argument is entirely missing
+       the point. As far as the USER was concerned, it wasn't buggy - it
+       worked for him/her.
+
+       Maybe it worked *because* the user had taken the bug into account,
+       maybe it worked because the user didn't notice - again, it doesn't
+       matter. It worked for the user.
+
+       Breaking a user workflow for a "bug" is absolutely the WORST reason
+       for breakage you can imagine.
+
+       It's basically saying "I took something that worked, and I broke it,
+       but now it's better". Do you not see how f*cking insane that statement
+       is?
+
+       And without users, your program is not a program, it's a pointless
+       piece of code that you might as well throw away.
+
+       Seriously. This is *why* the #1 rule for kernel development is "we
+       don't break users". Because "I fixed a bug" is absolutely NOT AN
+       ARGUMENT if that bug fix broke a user setup. You actually introduced a
+       MUCH BIGGER bug by "fixing" something that the user clearly didn't
+       even care about.
+
+       And dammit, we upgrade the kernel ALL THE TIME without upgrading any
+       other programs at all. It is absolutely required, because flag-days
+       and dependencies are horribly bad.
+
+       And it is also required simply because I as a kernel developer do not
+       upgrade random other tools that I don't even care about as I develop
+       the kernel, and I want any of my users to feel safe doing the same
+       time.
+
+       So no. Your rule is COMPLETELY wrong. If you cannot upgrade a kernel
+       without upgrading some other random binary, then we have a problem.
+
+ * From `2021-06-05
+   <https://lore.kernel.org/all/CAHk-=wiUVqHN76YUwhkjZzwTdjMMJf_zN4+u7vEJjmEGh3recw@mail.gmail.com/>`_::
+
+       THERE ARE NO VALID ARGUMENTS FOR REGRESSIONS.
+
+       Honestly, security people need to understand that "not working" is not
+       a success case of security. It's a failure case.
+
+       Yes, "not working" may be secure. But security in that case is *pointless*.
+
+ * From `2011-05-06 (1/3)
+   <https://lore.kernel.org/all/BANLkTim9YvResB+PwRp7QTK-a5VNg2PvmQ@mail.gmail.com/>`_::
+
+       Binary compatibility is more important.
+
+       And if binaries don't use the interface to parse the format (or just
+       parse it wrongly - see the fairly recent example of adding uuid's to
+       /proc/self/mountinfo), then it's a regression.
+
+       And regressions get reverted, unless there are security issues or
+       similar that makes us go "Oh Gods, we really have to break things".
+
+       I don't understand why this simple logic is so hard for some kernel
+       developers to understand. Reality matters. Your personal wishes matter
+       NOT AT ALL.
+
+       If you made an interface that can be used without parsing the
+       interface description, then we're stuck with the interface. Theory
+       simply doesn't matter.
+
+       You could help fix the tools, and try to avoid the compatibility
+       issues that way. There aren't that many of them.
+
+   From `2011-05-06 (2/3)
+   <https://lore.kernel.org/all/BANLkTi=KVXjKR82sqsz4gwjr+E0vtqCmvA@mail.gmail.com/>`_::
+
+       it's clearly NOT an internal tracepoint. By definition. It's being
+       used by powertop.
+
+   From `2011-05-06 (3/3)
+   <https://lore.kernel.org/all/BANLkTinazaXRdGovYL7rRVp+j6HbJ7pzhg@mail.gmail.com/>`_::
+
+       We have programs that use that ABI and thus it's a regression if they break.
+
+ * From `2012-07-06 <https://lore.kernel.org/all/CA+55aFwnLJ+0sjx92EGREGTWOx84wwKaraSzpTNJwPVV8edw8g@mail.gmail.com/>`_::
+
+       > Now this got me wondering if Debian _unstable_ actually qualifies as a
+       > standard distro userspace.
+
+       Oh, if the kernel breaks some standard user space, that counts. Tons
+       of people run Debian unstable
+
+ * From `2019-09-15
+   <https://lore.kernel.org/lkml/CAHk-=wiP4K8DRJWsCo=20hn_6054xBamGKF2kPgUzpB5aMaofA@mail.gmail.com/>`_::
+
+       One _particularly_ last-minute revert is the top-most commit (ignoring
+       the version change itself) done just before the release, and while
+       it's very annoying, it's perhaps also instructive.
+
+       What's instructive about it is that I reverted a commit that wasn't
+       actually buggy. In fact, it was doing exactly what it set out to do,
+       and did it very well. In fact it did it _so_ well that the much
+       improved IO patterns it caused then ended up revealing a user-visible
+       regression due to a real bug in a completely unrelated area.
+
+       The actual details of that regression are not the reason I point that
+       revert out as instructive, though. It's more that it's an instructive
+       example of what counts as a regression, and what the whole "no
+       regressions" kernel rule means. The reverted commit didn't change any
+       API's, and it didn't introduce any new bugs. But it ended up exposing
+       another problem, and as such caused a kernel upgrade to fail for a
+       user. So it got reverted.
+
+       The point here being that we revert based on user-reported _behavior_,
+       not based on some "it changes the ABI" or "it caused a bug" concept.
+       The problem was really pre-existing, and it just didn't happen to
+       trigger before. The better IO patterns introduced by the change just
+       happened to expose an old bug, and people had grown to depend on the
+       previously benign behavior of that old issue.
+
+       And never fear, we'll re-introduce the fix that improved on the IO
+       patterns once we've decided just how to handle the fact that we had a
+       bad interaction with an interface that people had then just happened
+       to rely on incidental behavior for before. It's just that we'll have
+       to hash through how to do that (there are no less than three different
+       patches by three different developers being discussed, and there might
+       be more coming...). In the meantime, I reverted the thing that exposed
+       the problem to users for this release, even if I hope it will be
+       re-introduced (perhaps even backported as a stable patch) once we have
+       consensus about the issue it exposed.
+
+       Take-away from the whole thing: it's not about whether you change the
+       kernel-userspace ABI, or fix a bug, or about whether the old code
+       "should never have worked in the first place". It's about whether
+       something breaks existing users' workflow.
+
+       Anyway, that was my little aside on the whole regression thing.  Since
+       it's that "first rule of kernel programming", I felt it is perhaps
+       worth just bringing it up every once in a while
+
+..
+   end-of-content
+..
+   This text is available under GPL-2.0+ or CC-BY-4.0, as stated at the top
+   of the file. If you want to distribute this text under CC-BY-4.0 only,
+   please use "The Linux kernel developers" for author attribution and link
+   this as source:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/process/handling-regressions.rst
+..
+   Note: Only the content of this RST file as found in the Linux kernel sources
+   is available under CC-BY-4.0, as versions of this text that were processed
+   (for example by the kernel's build system) might contain content taken from
+   files which use a more restrictive license.
diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 9f1b88492bb3..428e39074f61 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -25,6 +25,7 @@ Below are the essential guides that every developer should read.
    code-of-conduct-interpretation
    development-process
    submitting-patches
+   handling-regressions
    programming-language
    coding-style
    maintainer-handbooks
diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..6c62f7e0dc9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10438,6 +10438,8 @@ KERNEL REGRESSIONS
 M:	Thorsten Leemhuis <linux@leemhuis.info>
 L:	regressions@lists.linux.dev
 S:	Supported
+F:	Documentation/admin-guide/reporting-regressions.rst
+F:	Documentation/process/handling-regressions.rst
 
 KERNEL SELFTEST FRAMEWORK
 M:	Shuah Khan <shuah@kernel.org>
-- 
2.35.1

