Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451B44DC1E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiCQIvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiCQIvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:51:46 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1129F6E7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=/psyaRdsVlBoPSQar3nutqmlxiw
        1nqEeNHN3sJwG3XQ=; b=IlJ3sFfjgXrCV/iFL1WPeYu3Qgy+L75APYhe7y+lKfl
        QP0UNXhvDEyRQADam9sEYoZDOqrqtITCKE2jJqHeyWuwT9L8oaDxdraMtBG8R8cU
        ZVAdrkDKy/yFyFtH64I0wiq7p+CD54XaixmF0K9tTB0xDuaoaenYJpiegHDpqk60
        =
Received: (qmail 3379127 invoked from network); 17 Mar 2022 09:50:25 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Mar 2022 09:50:25 +0100
X-UD-Smtp-Session: l3s3148p1@1XTUHmbaIM0gAQnoAEd5ADwsgXkBgqk7
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v7 0/1] gpio: add simple logic analyzer using polling
Date:   Thu, 17 Mar 2022 09:50:18 +0100
Message-Id: <20220317085019.3987-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the next version of the sloppy GPIO logic analyzer. Changes
since last version:

* improved the script to handle already mounted (legacy) cpusets or
  cgroups. Works also with cgroups2 as long as the cpuset controller
  is not used.

* needed Kconfig options and cpuset hints added to docs

* driver depends now on DEBUG_FS and CPUSETS

The changes are rather small. To ease reviewing, I'll add the diff to
the previous version to the end of this cover-letter. Note that I tried
to convert the analyzer to cgroups2 but I wasn't able to create a new
process on the isolated CPU. Maybe we fix this incrementally or we just
leave it as is, it works well enough and cgroups are still around.

For those new to this sloppy GPIO logic analyzer, here is a small
excerpt from a previous cover-letter with the links updated:

===

Here is the next update of the in-kernel logic analyzer based on GPIO
polling with local irqs disabled. It has been tested locally and
remotely. It provided satisfactory results. Besides the driver, there is
also a script which isolates a CPU to achieve the best possible result.
I am aware of the latency limitations. However, the intention is for
debugging only, not mass production. Especially for remote debugging and
to get a first impression, this has already been useful. Documentation
is within the patch, to get a better idea what this is all about.

A branch is here:
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/gpio-logic-analyzer-v7

And an eLinux-wiki page with a picture of a result is here:
https://elinux.org/Kernel_GPIO_Logic_analyzer

I've used the analyzer in a few more scenarios and on multiple SoCs
(Renesas R-Car H3 and M3-W) and was happy with the outcome. Looking
forward to other tests and comments. From my side this is good to go.

===

Here is the diff:

--- 8< ---

 .../dev-tools/gpio-sloppy-logic-analyzer.rst  |  5 ++++
 drivers/gpio/Kconfig                          |  2 +-
 tools/gpio/gpio-sloppy-logic-analyzer         | 27 ++++++++++++-------
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/Documentation/dev-tools/gpio-sloppy-logic-analyzer.rst b/Documentation/dev-tools/gpio-sloppy-logic-analyzer.rst
index 330d45046f0f..a9b1cd6c2fea 100644
--- a/Documentation/dev-tools/gpio-sloppy-logic-analyzer.rst
+++ b/Documentation/dev-tools/gpio-sloppy-logic-analyzer.rst
@@ -33,6 +33,11 @@ first view and aid further debugging.
 Setup
 =====
 
+Your kernel must have CONFIG_DEBUG_FS and CONFIG_CPUSETS enabled. Ideally, your
+runtime environment does not utilize cpusets otherwise, then isolation of a CPU
+core is easiest. If you do need cpusets, check that helper script for the
+sloppy logic analyzer does not interfere with your other settings.
+
 Tell the kernel which GPIOs are used as probes. For a Device Tree based system,
 you need to use the following bindings. Because these bindings are only for
 debugging, there is no official schema::
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 299205f7628c..2a75a3ffb0ef 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1695,7 +1695,7 @@ menu "GPIO hardware hacking tools"
 
 config GPIO_SLOPPY_LOGIC_ANALYZER
 	tristate "Sloppy GPIO logic analyzer"
-	depends on (GPIOLIB || COMPILE_TEST) && EXPERT
+	depends on (GPIOLIB || COMPILE_TEST) && CPUSETS && DEBUG_FS && EXPERT
 	help
 	  This option enables support for a sloppy logic analyzer using polled
 	  GPIOs. Use the 'tools/gpio/gpio-sloppy-logic-analyzer' script with
diff --git a/tools/gpio/gpio-sloppy-logic-analyzer b/tools/gpio/gpio-sloppy-logic-analyzer
index eb2065fe6733..09065535e874 100755
--- a/tools/gpio/gpio-sloppy-logic-analyzer
+++ b/tools/gpio/gpio-sloppy-logic-analyzer
@@ -8,7 +8,8 @@
 
 samplefreq=1000000
 numsamples=250000
-cpusetdir='/dev/cpuset'
+cpusetdefaultdir='/sys/fs/cgroup'
+cpusetprefix='cpuset.'
 debugdir='/sys/kernel/debug'
 ladirname='gpio-sloppy-logic-analyzer'
 outputdir="$PWD"
@@ -76,17 +77,16 @@ set_newmask()
 init_cpu()
 {
 	isol_cpu="$1"
-	[ -d $cpusetdir ] || mkdir $cpusetdir
-	mount | grep -q $cpusetdir || mount -t cpuset cpuset $cpusetdir
+
 	[ -d "$lacpusetdir" ] || mkdir "$lacpusetdir"
 
-	cur_cpu="$(cat "$lacpusetdir"/cpus)"
+	cur_cpu=$(cat "${lacpusetfile}cpus")
 	[ "$cur_cpu" = "$isol_cpu" ] && return
 	[ -z "$cur_cpu" ] || fail "CPU$isol_cpu requested but CPU$cur_cpu already isolated"
 
-	echo "$isol_cpu" > "$lacpusetdir"/cpus || fail "Could not isolate CPU$isol_cpu. Does it exist?"
-	echo 1 > "$lacpusetdir"/cpu_exclusive
-	echo 0 > "$lacpusetdir"/mems
+	echo "$isol_cpu" > "${lacpusetfile}cpus" || fail "Could not isolate CPU$isol_cpu. Does it exist?"
+	echo 1 > "${lacpusetfile}cpu_exclusive"
+	echo 0 > "${lacpusetfile}mems"
 
 	oldmask=$(cat /proc/irq/default_smp_affinity)
 	newmask=$(printf "%x" $((0x$oldmask & ~(1 << isol_cpu))))
@@ -183,7 +183,16 @@ for f in $neededcmds; do
 	command -v "$f" >/dev/null || fail "Command '$f' not found"
 done
 
+# print cpuset mountpoint if any, errorcode > 0 if noprefix option was found
+cpusetdir=$(awk '$3 == "cgroup" && $4 ~ /cpuset/ { print $2; exit (match($4, /noprefix/) > 0) }' /proc/self/mounts) || cpusetprefix=''
+if [ -z "$cpusetdir" ]; then
+	cpusetdir="$cpusetdefaultdir"
+	[ -d $cpusetdir ] || mkdir $cpusetdir
+	mount -t cgroup -o cpuset none $cpusetdir || fail "Couldn't mount cpusets. Not in kernel or already in use?"
+fi
+
 lacpusetdir="$cpusetdir/$ladirname"
+lacpusetfile="$lacpusetdir/$cpusetprefix"
 sysfsdir="$debugdir/$ladirname"
 
 [ "$samplefreq" -ne 0 ] || fail "Invalid sample frequency"
@@ -194,7 +203,7 @@ sysfsdir="$debugdir/$ladirname"
 if [ -n "$lainstance" ]; then
 	lasysfsdir="$sysfsdir/$lainstance"
 else
-	lasysfsdir="$(find "$sysfsdir" -mindepth 1 -type d -print -quit)"
+	lasysfsdir=$(find "$sysfsdir" -mindepth 1 -type d -print -quit)
 fi
 [ -d "$lasysfsdir" ] || fail "Logic analyzer directory '$lasysfsdir' not found!"
 [ -d "$outputdir" ] || fail "Output directory '$outputdir' not found!"
@@ -213,7 +222,7 @@ if [ -n "$triggerdat" ]; then
 	printf "$trigger_bindat" > "$lasysfsdir"/trigger 2>/dev/null || fail "Trigger data '$triggerdat' rejected"
 fi
 
-workcpu=$(cat "$lacpusetdir"/effective_cpus)
+workcpu=$(cat "${lacpusetfile}effective_cpus")
 [ -n "$workcpu" ] || fail "No isolated CPU found"
 cpumask=$(printf '%x' $((1 << workcpu)))
 instance=${lasysfsdir##*/}

--- 8< ---


Happy hacking,

   Wolfram

Wolfram Sang (1):
  gpio: add sloppy logic analyzer using polling

 .../dev-tools/gpio-sloppy-logic-analyzer.rst  |  91 +++++
 Documentation/dev-tools/index.rst             |   1 +
 drivers/gpio/Kconfig                          |  17 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-sloppy-logic-analyzer.c     | 340 ++++++++++++++++++
 tools/gpio/gpio-sloppy-logic-analyzer         | 230 ++++++++++++
 6 files changed, 680 insertions(+)
 create mode 100644 Documentation/dev-tools/gpio-sloppy-logic-analyzer.rst
 create mode 100644 drivers/gpio/gpio-sloppy-logic-analyzer.c
 create mode 100755 tools/gpio/gpio-sloppy-logic-analyzer

-- 
2.30.2

