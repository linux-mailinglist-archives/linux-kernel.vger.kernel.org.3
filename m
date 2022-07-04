Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB144565532
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiGDM06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiGDM0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:26:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C622DF7B;
        Mon,  4 Jul 2022 05:26:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n8so11567999eda.0;
        Mon, 04 Jul 2022 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6OtORRyOM1wDPu65v8Us4BfcsokvyRp/mcgiSXtNDto=;
        b=VK/ocAyL42EdpqZeVEj3eUx0J8Lply9fhbCFHpLMXrBwC7/ZvhPcp46eAuAilvvyMj
         ebSLNgxwU6eXc+7DcLa9+654hwdsk62VvzvXMQxyFyu6LcB7BfeOo6vuSPtn1IZBBrtY
         gPv280h2X/6fcGCpBcZdm4VpK0vgv3dgI0oUWvlhLigIcVVBQnbjDyW8zNgIK1I99bik
         0QNDy7EEbFme+X2O+RyHbRwBo/PIjiztzw8cRLfjMAFzQEu9fTY/9JI2YNw44D6bgwBd
         nLEqZvufPJTLLpEcGXy++VmqfqEzZ2MAJmg5u54Y5lbHAASUqA4Ii7wqTWk2i9/qU1dZ
         7wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6OtORRyOM1wDPu65v8Us4BfcsokvyRp/mcgiSXtNDto=;
        b=BhCklwvUgL/S+jjEOZF7i0zRSVB7JGcxnK57OLbJQdd1O6x4u0Gq7veh2UNvUPXdSU
         Sa3css3MsBtcdv6Zvys8N7pzT5aznmvkq36d7ZD+PiikAQM47LMp1Sy3hkveShXRY72W
         2ZOUx5MqM99jgtvI0T3GrGHaQYYkhWE8vn8gzGDVy4GwFnwLatPEn4iOttkdVBBjLfCI
         FjsJAYU2+bfYvzCPoKlc+jqbKuvbLCb5sg9hgjXBya9pBuCAp8kuV+qiILHfe3M0e4im
         YOMb8oZ1cPlLF8k1HWGpJVonD/4uM/peU9CUEL/AdKfDSqDvpNTZXx1g/Zt7zTVBQqlC
         BDRQ==
X-Gm-Message-State: AJIora9gRL2eEK7UI9nLB8EvdbE4tiOA2tWNnDhkReUpz7wcijLxmd0W
        V6CFlt9k7grpTAliwEy/6N0=
X-Google-Smtp-Source: AGRyM1tXnfqqTxvjz1s1pU/jCuO4LNSTwIpWd7Lvm2z+ev4LCOm+akfHBODIF60s4AHgYaAe/1wlDQ==
X-Received: by 2002:aa7:de88:0:b0:435:9a54:168a with SMTP id j8-20020aa7de88000000b004359a54168amr37644993edv.73.1656937586725;
        Mon, 04 Jul 2022 05:26:26 -0700 (PDT)
Received: from felia.fritz.box (200116b826716b008998943ac77556e4.dip.versatel-1u1.de. [2001:16b8:2671:6b00:8998:943a:c775:56e4])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm13974467ejj.112.2022.07.04.05.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:26:26 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 06/11] docs: process: remove outdated submitting-drivers.rst
Date:   Mon,  4 Jul 2022 14:25:32 +0200
Message-Id: <20220704122537.3407-7-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
References: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 31b24bee3357 ("docs: add a warning to submitting-drivers.rst")
in October 2016 already warns "This (...) should maybe just be deleted,
but I'm not quite ready to do that yet".

Maybe, six years ago, we were not ready but let us remove old content
for the better now and structure and maintain less content in the kernel
documentation with a better result.

Drop this already outdated document and adjust all textual references.

Here is an argument why deleting the content will not remove any useful
information to the existing kernel documentation, individually broken down
for each section.

Section "Allocating Device Numbers" refers to https://www.lanana.org/, and
then refers to Documentation/admin-guide/devices.rst.

However, the devices.rst clearly states:

  "The version of this document at lanana.org is no longer maintained."

Everything needed for submitting drivers is already stated in devices.rst
and the reference to https://www.lanana.org/ is outdated, and should be
just deleted.

Section "Who To Submit Drivers To" is all about Linux 2.0 - 2.6, before
the new release version scheme; the mentioned developers are still around,
but actually not the first developers to contact anymore.

Section "What Criteria Determine Acceptance" has a few bullet points:

Licensing and Copyright is well-covered in process/kernel-license.rst.

Interfaces, Code, Portability, Clarity state some obvious things about
ensuring kernel code quality.

Control suggests to add a MAINTAINERS entry, which is already mentioned in
6.Followthrough.rst: "... added yourself to the MAINTAINERS file..."

PM support states a bit about implementing and testing power management of
a driver, it remains an open question where to place that in the process
documents. Driver developers interested in power management will find the
corresponding part on power management in the kernel documentation anyway.

In section "What Criteria Do Not Determine Acceptance", the points Vendor
and Author states something basic consequence of the kernel being an
open-source community software development. Probably no need to mention it
nowadays.

Section "Resources" lists resources that are also mentioned elsewhere more
central.

  - Linux kernel tree and mailing list is mentioned in many places.
  - https://lwn.net/Kernel/LDD3/ is mentioned in
    Documentation/process/kernel-docs.rst.

  - https://lwn.net/ is mentioned in:
    - Documentation/process/8.Conclusion.rst
    - Documentation/process/kernel-docs.rst

  - https://kernelnewbies.org/ is mentioned in:
      - Documentation/process/8.Conclusion.rst
      - Documentation/process/kernel-docs.rst

  - http://www.linux-usb.org/ is mentioned in
    Documentation/driver-api/usb/usb.rst

  - https://landley.net/kdocs/ols/2002/ols2002-pages-545-555.pdf
    is mentioned in Documentation/process/kernel-docs.rst

  - https://kernelnewbies.org/KernelJanitors is mentioned in
    Documentation/process/howto.rst

  - https://git-scm.com/ is mentioned in
    - Documentation/process/2.Process.rst
    - Documentation/process/7.AdvancedTopics.rst
    - Documentation/process/howto.rst

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/hwmon/submitting-patches.rst   |   1 -
 Documentation/kernel-hacking/hacking.rst     |   3 +-
 Documentation/process/5.Posting.rst          |   3 +-
 Documentation/process/8.Conclusion.rst       |  16 +-
 Documentation/process/howto.rst              |   4 +-
 Documentation/process/index.rst              |   1 -
 Documentation/process/submitting-drivers.rst | 194 -------------------
 Documentation/process/submitting-patches.rst |   5 +-
 8 files changed, 13 insertions(+), 214 deletions(-)
 delete mode 100644 Documentation/process/submitting-drivers.rst

diff --git a/Documentation/hwmon/submitting-patches.rst b/Documentation/hwmon/submitting-patches.rst
index 9a218ea996d8..d953ee763c96 100644
--- a/Documentation/hwmon/submitting-patches.rst
+++ b/Documentation/hwmon/submitting-patches.rst
@@ -12,7 +12,6 @@ increase the chances of your change being accepted.
 * It should be unnecessary to mention, but please read and follow:
 
     - Documentation/process/submit-checklist.rst
-    - Documentation/process/submitting-drivers.rst
     - Documentation/process/submitting-patches.rst
     - Documentation/process/coding-style.rst
 
diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
index ebd9d90882ea..9a1f020c8449 100644
--- a/Documentation/kernel-hacking/hacking.rst
+++ b/Documentation/kernel-hacking/hacking.rst
@@ -755,8 +755,7 @@ make a neat patch, there's administrative work to be done:
    it implies a more-than-passing commitment to some part of the code.
 
 -  Finally, don't forget to read
-   ``Documentation/process/submitting-patches.rst`` and possibly
-   ``Documentation/process/submitting-drivers.rst``.
+   ``Documentation/process/submitting-patches.rst``
 
 Kernel Cantrips
 ===============
diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index bd36ecb29409..906235c11c24 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -10,8 +10,7 @@ of conventions and procedures which are used in the posting of patches;
 following them will make life much easier for everybody involved.  This
 document will attempt to cover these expectations in reasonable detail;
 more information can also be found in the files
-:ref:`Documentation/process/submitting-patches.rst <submittingpatches>`,
-:ref:`Documentation/process/submitting-drivers.rst  <submittingdrivers>`
+:ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
 and :ref:`Documentation/process/submit-checklist.rst <submitchecklist>`.
 
 
diff --git a/Documentation/process/8.Conclusion.rst b/Documentation/process/8.Conclusion.rst
index b32a40215858..8c847dffe76b 100644
--- a/Documentation/process/8.Conclusion.rst
+++ b/Documentation/process/8.Conclusion.rst
@@ -5,15 +5,13 @@ For more information
 
 There are numerous sources of information on Linux kernel development and
 related topics.  First among those will always be the Documentation
-directory found in the kernel source distribution.  The top-level :ref:`process/howto.rst <process_howto>`
-file is an important starting point; :ref:`process/submitting-patches.rst <submittingpatches>`
-and :ref:`process/submitting-drivers.rst  <submittingdrivers>`
-are also something which all kernel developers should
-read.  Many internal kernel APIs are documented using the kerneldoc
-mechanism; "make htmldocs" or "make pdfdocs" can be used to generate those
-documents in HTML or PDF format (though the version of TeX shipped by some
-distributions runs into internal limits and fails to process the documents
-properly).
+directory found in the kernel source distribution.  Start with the
+top-level :ref:`process/howto.rst <process_howto>`; also read
+:ref:`process/submitting-patches.rst <submittingpatches>`. Many internal
+kernel APIs are documented using the kerneldoc mechanism; "make htmldocs"
+or "make pdfdocs" can be used to generate those documents in HTML or PDF
+format (though the version of TeX shipped by some distributions runs into
+internal limits and fails to process the documents properly).
 
 Various web sites discuss kernel development at all levels of detail.  Your
 author would like to humbly suggest https://lwn.net/ as a source;
diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index e4beeca57e5f..cd6997a9d203 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -105,8 +105,8 @@ required reading:
     patches if these rules are followed, and many people will only
     review code if it is in the proper style.
 
-  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>` and :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
-    These files describe in explicit detail how to successfully create
+  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
+    This file describes in explicit detail how to successfully create
     and send a patch, including (but not limited to):
 
        - Email contents
diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 3587dae4d0ef..2ba2a1582bbe 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -40,7 +40,6 @@ Other guides to the community that are of interest to most developers are:
    :maxdepth: 1
 
    changes
-   submitting-drivers
    stable-api-nonsense
    management-style
    stable-kernel-rules
diff --git a/Documentation/process/submitting-drivers.rst b/Documentation/process/submitting-drivers.rst
deleted file mode 100644
index 8413b693d10d..000000000000
--- a/Documentation/process/submitting-drivers.rst
+++ /dev/null
@@ -1,194 +0,0 @@
-.. _submittingdrivers:
-
-Submitting Drivers For The Linux Kernel
-=======================================
-
-This document is intended to explain how to submit device drivers to the
-various kernel trees. Note that if you are interested in video card drivers
-you should probably talk to XFree86 (https://www.xfree86.org/) and/or X.Org
-(https://x.org/) instead.
-
-.. note::
-
-   This document is old and has seen little maintenance in recent years; it
-   should probably be updated or, perhaps better, just deleted.  Most of
-   what is here can be found in the other development documents anyway.
-
-   Oh, and we don't really recommend submitting changes to XFree86 :)
-
-Also read the :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
-document.
-
-
-Allocating Device Numbers
--------------------------
-
-Major and minor numbers for block and character devices are allocated
-by the Linux assigned name and number authority (currently this is
-Torben Mathiasen). The site is https://www.lanana.org/. This
-also deals with allocating numbers for devices that are not going to
-be submitted to the mainstream kernel.
-See :ref:`Documentation/admin-guide/devices.rst <admin_devices>`
-for more information on this.
-
-If you don't use assigned numbers then when your device is submitted it will
-be given an assigned number even if that is different from values you may
-have shipped to customers before.
-
-Who To Submit Drivers To
-------------------------
-
-Linux 2.0:
-	No new drivers are accepted for this kernel tree.
-
-Linux 2.2:
-	No new drivers are accepted for this kernel tree.
-
-Linux 2.4:
-	If the code area has a general maintainer then please submit it to
-	the maintainer listed in MAINTAINERS in the kernel file. If the
-	maintainer does not respond or you cannot find the appropriate
-	maintainer then please contact Willy Tarreau <w@1wt.eu>.
-
-Linux 2.6 and upper:
-	The same rules apply as 2.4 except that you should follow linux-kernel
-	to track changes in API's. The final contact point for Linux 2.6+
-	submissions is Andrew Morton.
-
-What Criteria Determine Acceptance
-----------------------------------
-
-Licensing:
-		The code must be released to us under the
-		GNU General Public License. If you wish the driver to be
-		useful to other communities such as BSD you may release
-		under multiple licenses. If you choose to release under
-		licenses other than the GPL, you should include your
-		rationale for your license choices in your cover letter.
-		See accepted licenses at include/linux/module.h
-
-Copyright:
-		The copyright owner must agree to use of GPL.
-		It's best if the submitter and copyright owner
-		are the same person/entity. If not, the name of
-		the person/entity authorizing use of GPL should be
-		listed in case it's necessary to verify the will of
-		the copyright owner.
-
-Interfaces:
-		If your driver uses existing interfaces and behaves like
-		other drivers in the same class it will be much more likely
-		to be accepted than if it invents gratuitous new ones.
-		If you need to implement a common API over Linux and NT
-		drivers do it in userspace.
-
-Code:
-		Please use the Linux style of code formatting as documented
-		in :ref:`Documentation/process/coding-style.rst <codingStyle>`.
-		If you have sections of code
-		that need to be in other formats, for example because they
-		are shared with a windows driver kit and you want to
-		maintain them just once separate them out nicely and note
-		this fact.
-
-Portability:
-		Pointers are not always 32bits, not all computers are little
-		endian, people do not all have floating point and you
-		shouldn't use inline x86 assembler in your driver without
-		careful thought. Pure x86 drivers generally are not popular.
-		If you only have x86 hardware it is hard to test portability
-		but it is easy to make sure the code can easily be made
-		portable.
-
-Clarity:
-		It helps if anyone can see how to fix the driver. It helps
-		you because you get patches not bug reports. If you submit a
-		driver that intentionally obfuscates how the hardware works
-		it will go in the bitbucket.
-
-PM support:
-		Since Linux is used on many portable and desktop systems, your
-		driver is likely to be used on such a system and therefore it
-		should support basic power management by implementing, if
-		necessary, the .suspend and .resume methods used during the
-		system-wide suspend and resume transitions.  You should verify
-		that your driver correctly handles the suspend and resume, but
-		if you are unable to ensure that, please at least define the
-		.suspend method returning the -ENOSYS ("Function not
-		implemented") error.  You should also try to make sure that your
-		driver uses as little power as possible when it's not doing
-		anything.  For the driver testing instructions see
-		Documentation/power/drivers-testing.rst and for a relatively
-		complete overview of the power management issues related to
-		drivers see :ref:`Documentation/driver-api/pm/devices.rst <driverapi_pm_devices>`.
-
-Control:
-		In general if there is active maintenance of a driver by
-		the author then patches will be redirected to them unless
-		they are totally obvious and without need of checking.
-		If you want to be the contact and update point for the
-		driver it is a good idea to state this in the comments,
-		and include an entry in MAINTAINERS for your driver.
-
-What Criteria Do Not Determine Acceptance
------------------------------------------
-
-Vendor:
-		Being the hardware vendor and maintaining the driver is
-		often a good thing. If there is a stable working driver from
-		other people already in the tree don't expect 'we are the
-		vendor' to get your driver chosen. Ideally work with the
-		existing driver author to build a single perfect driver.
-
-Author:
-		It doesn't matter if a large Linux company wrote the driver,
-		or you did. Nobody has any special access to the kernel
-		tree. Anyone who tells you otherwise isn't telling the
-		whole story.
-
-
-Resources
----------
-
-Linux kernel master tree:
-	ftp.\ *country_code*\ .kernel.org:/pub/linux/kernel/...
-
-	where *country_code* == your country code, such as
-	**us**, **uk**, **fr**, etc.
-
-	https://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git
-
-Linux kernel mailing list:
-	linux-kernel@vger.kernel.org
-	[mail majordomo@vger.kernel.org to subscribe]
-
-Linux Device Drivers, Third Edition (covers 2.6.10):
-	https://lwn.net/Kernel/LDD3/  (free version)
-
-LWN.net:
-	Weekly summary of kernel development activity - https://lwn.net/
-
-	2.6 API changes:
-
-		https://lwn.net/Articles/2.6-kernel-api/
-
-	Porting drivers from prior kernels to 2.6:
-
-		https://lwn.net/Articles/driver-porting/
-
-KernelNewbies:
-	Documentation and assistance for new kernel programmers
-
-		https://kernelnewbies.org/
-
-Linux USB project:
-	http://www.linux-usb.org/
-
-How to NOT write kernel driver by Arjan van de Ven:
-	https://landley.net/kdocs/ols/2002/ols2002-pages-545-555.pdf
-
-Kernel Janitor:
-	https://kernelnewbies.org/KernelJanitors
-
-GIT, Fast Version Control System:
-	https://git-scm.com/
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index a1cb6280fbcf..be49d8f2601b 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -12,9 +12,8 @@ This document contains a large number of suggestions in a relatively terse
 format.  For detailed information on how the kernel development process
 works, see Documentation/process/development-process.rst. Also, read
 Documentation/process/submit-checklist.rst
-for a list of items to check before submitting code.  If you are submitting
-a driver, also read Documentation/process/submitting-drivers.rst; for device
-tree binding patches, read
+for a list of items to check before submitting code.
+For device tree binding patches, read
 Documentation/devicetree/bindings/submitting-patches.rst.
 
 This documentation assumes that you're using ``git`` to prepare your patches.
-- 
2.17.1

