Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B28152ECBD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbiETM5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbiETM51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:57:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EF7169E22
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:57:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gh17so2429506ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8kdNn8l7rt+1wUrOT8wrbdyhKVqofAvGGuPnPxKPDT8=;
        b=Arf0zo5lsJo9vU1dVvjgh8pnWHh9r1oAqTqjMpcTF6p400FrXcjVWEfJ9Wt/n0bZTK
         MTB8cZgPyqzHoQK+bIFuq6W5ck3mnUagQHc0F/0jiahNeZE4CJ65lbTpYcy1X5u+S8Gc
         A6Dv/+nUZNSsQj0pKwMqqBqfZqeQBqS3b1Rc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8kdNn8l7rt+1wUrOT8wrbdyhKVqofAvGGuPnPxKPDT8=;
        b=AGGWoqaAyuQYLb25xE3aGSpJ65kRWKBZr1Ot6G+gxmac+v1d+jP0SXHe6CA7B/5Rr9
         yg1tXMpIrXwBG68p2x9+iD0GiG8KxP2m7+g+2f6InchtNAIspkDjpbp91LSCZD9jJDS+
         SZAGfUXfNWY4301Ympe+Bpp8NXZUWy0EbvSV56bIRYuTUDaqmsb0KjQtnBiSlO6HlVqe
         W84C4m2fTU5E+PhnM9TGoTp1ilV29sEmWRKkEWKV4UZDR7Va5Vj8UPMpaU1JQo0MBiY+
         QCy18Tf9k1eQ6a1FbTCeaQ36lXRXmLTGBC/AZ7KrtGacSjSGOx/lxj+EuL1eix6300jB
         7k0Q==
X-Gm-Message-State: AOAM530Kz66ggVrMzqH80nGiagZDZQkjM4d4P3XWx/1KGv4HCiizbWJe
        kyomMFfnKQz26pP3Ntc3WLsBiz1RkMYA/bZx
X-Google-Smtp-Source: ABdhPJybpGS9nvrMefXv0F5a31C4OTA/OqT8Y05RK6lvmDUtxIJwAtnTqASW5VHHJGuykcCJBmA2sQ==
X-Received: by 2002:a17:907:6eaa:b0:6f4:7e59:feae with SMTP id sh42-20020a1709076eaa00b006f47e59feaemr8592606ejc.99.1653051440929;
        Fri, 20 May 2022 05:57:20 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:c90f])
        by smtp.gmail.com with ESMTPSA id ep20-20020a1709069b5400b006feb5dc81absm334731ejc.125.2022.05.20.05.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:57:20 -0700 (PDT)
Date:   Fri, 20 May 2022 13:57:19 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: [RFC PATCH v2] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoeQLxhDeIk4VSmx@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.5 (a8c7fba1) (2022-05-16)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Once the goals of this patch are generally agreed upon, it can be split
out further with more detailed changelogs if desired.]

Consoles can have vastly different latencies and throughputs. For
example, writing a message to the serial console can take on the order
of tens of milliseconds to get the UART to successfully write a message.
While this might be fine for a single, one-off message, this can cause
significant application-level stalls in situations where the kernel
writes large amounts of information to the console.

This means that while you might want to send at least INFO level
messages to (for example) netconsole, which is relatively fast, you may
only want to send at least WARN level messages to the serial console.
Such an implementation would permit debugging using the serial console
in cases that netconsole doesn't receive messages during particularly
bad system issues, while still keeping the noise low enough to avoid
inducing latency in userspace applications. This patch adds such an
interface, extending the existing console loglevel controls to allow
each console to have its own loglevel.

One can't just disable the serial console, because one may actually need
it in situations where the machine is in a bad enough state that nothing
is received on netconsole. One also can't just bump the loglevel at
runtime after the issue, because usually the machine is already so
wedged by this point that it isn't responsive to such requests.

In terms of technical implementation, this patch embeds a device pointer
in the console struct, and registers each console using it so we can
expose attributes in sysfs.

The lifecycle of this classdev looks like this on registration:

    register_console(con)/printk_late_init()
      console_register_device(con)
        device_initialize(con->classdev) # refcount++
        device_add(con->classdev)        # refcount++

At stable state, the refcount is two.

Console unregistration looks like this:

    [con->classdev refcount drops to 0]
        console_classdev_release(con->classdev)
            kfree(con->classdev)

    unregister_console(con)
        device_unregister(con->classdev)
            device_del(con->classdev) # refcount--
                device_remove_class_symlinks()
                    kernfs_remove_by_name_ns()
                        kernfs_drain()
                            kernfs_drain_open_files() # wait for close()
            put_device(con->classdev) # refcount--

We also deprecate the kernel.printk sysctl as it doesn't know about
per-console loglevels, and is generally pretty confusing.

For information on the precedence and application of the new controls,
see Documentation/ABI/testing/sysfs-class-console and
Documentation/admin-guide/per-console-loglevel.rst.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 Documentation/ABI/testing/sysfs-class-console |  50 +++
 .../admin-guide/kernel-parameters.txt         |  18 +-
 .../admin-guide/per-console-loglevel.rst      | 116 ++++++
 Documentation/admin-guide/serial-console.rst  |  17 +-
 Documentation/core-api/printk-basics.rst      |  34 +-
 Documentation/networking/netconsole.rst       |  17 +
 MAINTAINERS                                   |   3 +
 include/linux/console.h                       |  23 ++
 include/linux/kern_levels.h                   |   2 +
 init/main.c                                   |   2 +-
 kernel/printk/console_cmdline.h               |   2 +
 kernel/printk/printk.c                        | 352 ++++++++++++++++--
 kernel/printk/sysctl.c                        |  95 ++++-
 13 files changed, 680 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-console
 create mode 100644 Documentation/admin-guide/per-console-loglevel.rst

diff --git a/Documentation/ABI/testing/sysfs-class-console b/Documentation/ABI/testing/sysfs-class-console
new file mode 100644
index 000000000000..6753e45e19ce
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-console
@@ -0,0 +1,50 @@
+What:		/sys/class/console/
+Date:		May 2022
+Contact:	Chris Down <chris@chrisdown.name>
+Description:	Interface for viewing and setting per-console attributes, like
+		the per-console loglevel. For a high-level document describing
+		the motivations for this interface and related non-sysfs
+		controls, see
+		Documentation/admin-guide/per-console-loglevel.rst.
+
+What:		/sys/class/console/<C>/effective_loglevel
+Date:		May 2022
+Contact:	Chris Down <chris@chrisdown.name>
+Description:	Read only. The currently effective loglevel for this console.
+		All messages emitted with a loglevel below the effective value
+		will be emitted to the console.
+
+What:		/sys/class/console/<C>/effective_loglevel_source
+Date:		May 2022
+Contact:	Chris Down <chris@chrisdown.name>
+Description:	Read only. The currently effective loglevel source for this
+		console -- for example, whether it was set globally based on
+		the default loglevel, or whether it was set locally. Possible
+		values are:
+
+		local: The loglevel comes from the per-console loglevel.
+		global: The loglevel comes from the global default loglevel.
+		forced: The loglevel comes from the global forced loglevel.
+		minimum: The loglevel comes from the global minimum loglevel.
+		forced_minimum: A forced global loglevel is active, but it is
+				below the global minimum loglevel. The loglevel
+				comes from the global minimum loglevel and is
+				forced regardless of the console's current
+				local loglevel setting.
+		ignore_loglevel: The loglevel is ignored as ignore_loglevel is
+		                 present on the kernel command line.
+
+What:		/sys/class/console/<C>/enabled
+Date:		May 2022
+Contact:	Chris Down <chris@chrisdown.name>
+Description:	Read only. "1" if the console is enabled, "0" otherwise.
+
+What:		/sys/class/console/<C>/loglevel
+Date:		May 2022
+Contact:	Chris Down <chris@chrisdown.name>
+Description:	Read write. The current local loglevel, which will take effect
+		if not overridden by other non-sysfs controls (see
+		Documentation/admin-guide/per-console-loglevel.rst). Bounds are
+		0 (LOGLEVEL_EMERG) to 8 (LOGLEVEL_DEBUG + 1) inclusive. Also
+		takes the special value "unset" to indicate that no local
+		loglevel is set, and we should defer to the global controls.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1a9f89a835b3..77febe32d73b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -696,10 +696,11 @@
 		ttyS<n>[,options]
 		ttyUSB0[,options]
 			Use the specified serial port.  The options are of
-			the form "bbbbpnf", where "bbbb" is the baud rate,
+			the form "bbbbpnf/l", where "bbbb" is the baud rate,
 			"p" is parity ("n", "o", or "e"), "n" is number of
-			bits, and "f" is flow control ("r" for RTS or
-			omit it).  Default is "9600n8".
+			bits, "f" is flow control ("r" for RTS or omit it),
+			and "l" is the minimum loglevel ([0,8], can be
+			omitted). The default is "9600n8".
 
 			See Documentation/admin-guide/serial-console.rst for more
 			information.  See
@@ -2709,10 +2710,13 @@
 	logibm.irq=	[HW,MOUSE] Logitech Bus Mouse Driver
 			Format: <irq>
 
-	loglevel=	All Kernel Messages with a loglevel smaller than the
-			console loglevel will be printed to the console. It can
-			also be changed with klogd or other programs. The
-			loglevels are defined as follows:
+	loglevel=	Sets the default loglevel. All messages with a loglevel
+			smaller than the console loglevel will be printed to
+			the console. Note that this can be overridden
+			per-console, see
+			Documentation/admin-guide/per-console-loglevel.rst.
+
+			The loglevels are defined as follows:
 
 			0 (KERN_EMERG)		system is unusable
 			1 (KERN_ALERT)		action must be taken immediately
diff --git a/Documentation/admin-guide/per-console-loglevel.rst b/Documentation/admin-guide/per-console-loglevel.rst
new file mode 100644
index 000000000000..f1b56a4daec7
--- /dev/null
+++ b/Documentation/admin-guide/per-console-loglevel.rst
@@ -0,0 +1,116 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _per_console_loglevel:
+
+Per-console loglevel support
+============================
+
+Motivation
+----------
+
+Consoles can have vastly different latencies and throughputs. For example,
+writing a message to the serial console can take on the order of tens of
+milliseconds to get the UART to successfully write a message. While this might
+be fine for a single, one-off message, this can cause signiifcant
+application-level stalls in situations where the kernel writes large amounts of
+information to the console.
+
+This means that while you might want to send at least INFO level messages to
+(for example) netconsole, which is relatively fast, you may only want to send
+at least WARN level messages to the serial console. This permits debugging
+using the serial console in cases that netconsole doesn't receive messages
+during particularly bad system issues, while still keeping the noise low enough
+to avoid inducing latency in userspace applications.
+
+Tunables
+--------
+
+In order to allow tuning this, the following controls exist:
+
+Global
+~~~~~~
+
+In order of authority:
+
+* ``ignore_loglevel`` on the kernel command line: Emit all messages. Cannot be
+  disabled without restarting the kernel. All other controls are ignored if
+  this is present.
+* ``loglevel=...`` on the kernel command line: Equivalent to sysctl
+  ``kernel.default_console_loglevel``.
+* ``kernel.minimum_console_loglevel`` sysctl: Clamp all consoles to emit
+  messages beyond this loglevel.
+* ``kernel.force_console_loglevel`` sysctl: Force all consoles to the given
+  loglevel. If this value is lower than ``kernel.minimum_console_loglevel``,
+  ``kernel.minimum_console_loglevel`` is respected. Can also be set to the
+  special value "unset" which removes any existing forced level.
+* ``kernel.default_console_loglevel`` sysctl: The default console loglevel if
+  there is no local loglevel for the console, and
+  ``kernel.force_console_loglevel`` is unset. If this value is lower than
+  ``kernel.minimum_console_loglevel``, ``kernel.minimum_console_loglevel`` is
+  respected.
+* ``kernel.default_console_loglevel`` sysctl: The default console loglevel if
+  there is no local loglevel for the console, and
+  ``kernel.force_console_loglevel`` is unset. If this value is lower than
+  ``kernel.minimum_console_loglevel``, ``kernel.minimum_console_loglevel`` is
+  forced.
+* ``kernel.default_message_loglevel`` sysctl: The default loglevel to send
+  messages at if they are sent with no explicit loglevel.
+
+The default value for ``kernel.default_console_loglevel`` comes from
+``CONFIG_CONSOLE_LOGLEVEL_DEFAULT``, or ``CONFIG_CONSOLE_LOGLEVEL_QUIET`` if
+``quiet`` is passed on the kernel command line.
+
+Console attributes
+~~~~~~~~~~~~~~~~~~
+
+Registered consoles are exposed at ``/sys/class/console``. For example, if you
+are using ``ttyS0``, the console backing it can be viewed at
+``/sys/class/console/ttyS/``. The following files are available:
+
+* ``effective_loglevel`` (r): The effective loglevel after considering all
+  loglevel authorities. For example, if the local loglevel is 3, but the global
+  minimum console loglevel is 5, then the value will be 5.
+* ``effective_loglevel_source`` (r): The loglevel authority which resulted in
+  the effective loglevel being set. The following values can be present:
+
+    * ``local``: The console-specific loglevel is in effect.
+    * ``global``: The global default loglevel
+      (``kernel.default_console_loglevel``) is in effect. Set a console-specific
+      loglevel to override it.
+    * ``forced``: The global forced loglevel (``kernel.force_console_loglevel``)
+      is in effect. Write "unset" to ``kernel.force_console_loglevel`` to disable
+      it.
+    * ``minimum``: The global minimum loglevel
+      (``kernel.minimum_console_loglevel``) is in effect. Set a higher
+      console-specific loglevel to override it.
+    * ``forced_minimum``: The global minimum loglevel
+      (``kernel.minimum_console_loglevel``) is in effect. Even if the local
+      console-specific loglevel is higher, it is in effect because the global
+      forced loglevel (``kernel.force_console_loglevel``) is present, but is
+      below ``kernel.minimum_console_loglevel``. Write "unset" to
+      ``kernel.force_console_loglevel`` to disable the forcing, and make sure
+      ``kernel.minimum_console_loglevel`` is below the local console loglevel
+      if you want the per-console loglevel to take effect.
+      console-specific loglevel to override it.
+    * ``ignore_loglevel``: ``ignore_loglevel`` was specified on the kernel
+      command line. Restart without it to use other controls.
+
+* ``enabled`` (r): Whether the console is enabled.
+* ``loglevel`` (rw): The local loglevel for this console. This will be in
+  effect if no other global control overrides it. Look at
+  ``effective_loglevel`` and ``effective_loglevel_source`` to verify that.
+
+Deprecated
+~~~~~~~~~~
+
+* ``syslog(SYSLOG_ACTION_CONSOLE_*)``: This sets
+  ``kernel.force_console_loglevel``. It is unaware of per-console loglevel
+  semantics and is not recommended. A warning will be emitted if it is used
+  while local loglevels are in effect.
+* ``kernel.printk`` sysctl: this takes four values, setting
+  ``kernel.force_console_loglevel``, ``kernel.default_message_loglevel``,
+  ``kernel.minimum_console_loglevel``, and ``kernel.default_console_loglevel``
+  respectively. The interface is generally considered to quite confusing, and
+  is unaware of per-console loglevel semantics.
+
+Chris Down <chris@chrisdown.name>, 17-May-2020
diff --git a/Documentation/admin-guide/serial-console.rst b/Documentation/admin-guide/serial-console.rst
index 58b32832e50a..7329ef2b5f73 100644
--- a/Documentation/admin-guide/serial-console.rst
+++ b/Documentation/admin-guide/serial-console.rst
@@ -17,7 +17,7 @@ use for console output.
 
 The format of this option is::
 
-	console=device,options
+	console=device,options/loglevel
 
 	device:		tty0 for the foreground virtual console
 			ttyX for any other virtual console
@@ -32,15 +32,23 @@ The format of this option is::
 			and F is flow control ('r' for RTS). Default is
 			9600n8. The maximum baudrate is 115200.
 
+	loglevel:	optional. a number can be provided from 0
+			(LOGLEVEL_EMERG) to 8 (LOGLEVEL_DEBUG + 1), and
+			messages below that will be emitted onto the console as
+			they become available.
+
 You can specify multiple console= options on the kernel command line.
 Output will appear on all of them. The last device will be used when
 you open ``/dev/console``. So, for example::
 
-	console=ttyS1,9600 console=tty0
+	console=ttyS1,9600/5 console=tty0
 
 defines that opening ``/dev/console`` will get you the current foreground
-virtual console, and kernel messages will appear on both the VGA
-console and the 2nd serial port (ttyS1 or COM2) at 9600 baud.
+virtual console, and kernel messages will appear on both the VGA console and
+the 2nd serial port (ttyS1 or COM2) at 9600 baud. The optional loglevel "5"
+indicates that this console will emit messages more serious than
+LOGLEVEL_NOTICE (that is, LOGLEVEL_WARNING and below, since more serious
+messages have lower ordering).
 
 Note that you can only define one console per device type (serial, video).
 
@@ -113,3 +121,4 @@ Replace the sample values as needed.
    the integration of these patches into m68k, ppc and alpha.
 
 Miquel van Smoorenburg <miquels@cistron.nl>, 11-Jun-2000
+Chris Down <chris@chrisdown.name>, 17-May-2020
diff --git a/Documentation/core-api/printk-basics.rst b/Documentation/core-api/printk-basics.rst
index 2dde24ca7d9f..deeabbc8cad6 100644
--- a/Documentation/core-api/printk-basics.rst
+++ b/Documentation/core-api/printk-basics.rst
@@ -54,32 +54,32 @@ string, the log level is not a separate argument). The available log levels are:
 
 The log level specifies the importance of a message. The kernel decides whether
 to show the message immediately (printing it to the current console) depending
-on its log level and the current *console_loglevel* (a kernel variable). If the
-message priority is higher (lower log level value) than the *console_loglevel*
-the message will be printed to the console.
+on its log level and the current global *console_loglevel* or local per-console
+loglevel (kernel variables). If the message priority is higher (lower log level
+value) than the effective loglevel the message will be printed to the console.
 
 If the log level is omitted, the message is printed with ``KERN_DEFAULT``
 level.
 
-You can check the current *console_loglevel* with::
+You can check the current console's loglevel -- for example if you want to
+check the loglevel for serial consoles:
 
-  $ cat /proc/sys/kernel/printk
-  4        4        1        7
+  $ cat /sys/class/console/ttyS/effective_loglevel
+  6
+  $ cat /sys/class/console/ttyS/effective_loglevel_source
+  local
 
-The result shows the *current*, *default*, *minimum* and *boot-time-default* log
-levels.
+To change the current loglevel for all consoles, simply write the desired level
+to ``/proc/sys/kernel/forced_console_loglevel``. For example, to print all
+messages to all consoles::
 
-To change the current console_loglevel simply write the desired level to
-``/proc/sys/kernel/printk``. For example, to print all messages to the console::
+  # echo 5 > /proc/sys/kernel/forced_console_loglevel
 
-  # echo 8 > /proc/sys/kernel/printk
+This sets the console_loglevel to print KERN_WARNING (4) or more severe
+messages to console.
 
-Another way, using ``dmesg``::
-
-  # dmesg -n 5
-
-sets the console_loglevel to print KERN_WARNING (4) or more severe messages to
-console. See ``dmesg(1)`` for more information.
+For more information on per-console loglevels, see
+Documentation/admin-guide/per-console-loglevel.rst.
 
 As an alternative to printk() you can use the ``pr_*()`` aliases for
 logging. This family of macros embed the log level in the macro names. For
diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 1f5c4a04027c..aa56f2420fb9 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -67,6 +67,23 @@ Built-in netconsole starts immediately after the TCP stack is
 initialized and attempts to bring up the supplied dev at the supplied
 address.
 
+You can also set a loglevel at boot time on the kernel command line::
+
+  console=netcon0/2
+
+This can also be changed at runtime::
+
+  $ ls -l /sys/class/console/netcon/
+  total 0
+  lrwxrwxrwx 1 root root    0 May 18 13:28 subsystem -> ../../../../class/console/
+  -r--r--r-- 1 root root 4096 May 18 13:28 effective_loglevel
+  -r--r--r-- 1 root root 4096 May 18 13:28 effective_loglevel_source
+  -r--r--r-- 1 root root 4096 May 18 13:28 enabled
+  -rw-r--r-- 1 root root 4096 May 18 13:28 loglevel
+  -rw-r--r-- 1 root root 4096 May 18 13:28 uevent
+
+See Documentation/admin-guide/per-console-loglevel.rst for more information.
+
 The remote host has several options to receive the kernel messages,
 for example:
 
diff --git a/MAINTAINERS b/MAINTAINERS
index c10fbd13080a..4d0a5d16894a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15579,6 +15579,9 @@ R:	Steven Rostedt <rostedt@goodmis.org>
 R:	John Ogness <john.ogness@linutronix.de>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
+F:	Documentation/ABI/testing/sysfs-class-console
+F:	Documentation/admin-guide/per-console-loglevel.rst
+F:	Documentation/core-api/printk-basics.rst
 F:	include/linux/printk.h
 F:	kernel/printk/
 
diff --git a/include/linux/console.h b/include/linux/console.h
index 7cd758a4f44e..408dd86be8eb 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -15,6 +15,7 @@
 #define _LINUX_CONSOLE_H_ 1
 
 #include <linux/atomic.h>
+#include <linux/device.h>
 #include <linux/types.h>
 
 struct vc_data;
@@ -137,6 +138,24 @@ static inline int con_debug_leave(void)
 #define CON_BRL		(32) /* Used for a braille device */
 #define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
 
+/*
+ * The loglevel for a console can be set in many places:
+ *
+ * 1. It can be forced to a certain value permanently (ignore_loglevel);
+ * 2. It can be forced temporarily to a value (sysctls kernel.printk
+ *    (deprecated), kernel.force_console_loglevel,
+ *    kernel.minimum_console_loglevel, magic sysrq)
+ * 3. It can be locally set (console=.../N on kernel command line,
+ *    /sys/class/console/.../loglevel);
+ * 4. It can be set by a global default
+ *    (CONFIG_CONSOLE_LOGLEVEL_{DEFAULT,QUIET}, loglevel= on kernel command
+ *    line, sysctl kernel.default_console_loglevel).
+ *
+ * If case 3 happens, even if another forced value in effect, CON_LOGLEVEL will
+ * be set.
+ */
+#define CON_LOGLEVEL	(128) /* Level set locally for this console */
+
 struct console {
 	char	name[16];
 	void	(*write)(struct console *, const char *, unsigned);
@@ -153,8 +172,12 @@ struct console {
 	uint	ospeed;
 	void	*data;
 	struct	 console *next;
+	int	level;
+	struct	device *classdev;
 };
 
+#define classdev_to_console(dev) dev_get_drvdata(dev)
+
 /*
  * for_each_console() allows you to iterate on each console
  */
diff --git a/include/linux/kern_levels.h b/include/linux/kern_levels.h
index bf2389c26ae3..38923956841b 100644
--- a/include/linux/kern_levels.h
+++ b/include/linux/kern_levels.h
@@ -24,6 +24,8 @@
 #define KERN_CONT	KERN_SOH "c"
 
 /* integer equivalents of KERN_<LEVEL> */
+#define LOGLEVEL_INVALID	-127	/* Invalid loglevel, used to indicate
+					   this loglevel is not used */
 #define LOGLEVEL_SCHED		-2	/* Deferred messages from sched code
 					 * are set to this special level */
 #define LOGLEVEL_DEFAULT	-1	/* default (or last) loglevel */
diff --git a/init/main.c b/init/main.c
index 560f45c27ffe..7f0216b273df 100644
--- a/init/main.c
+++ b/init/main.c
@@ -255,7 +255,7 @@ static int __init loglevel(char *str)
 	 * are quite hard to debug
 	 */
 	if (get_option(&str, &newlevel)) {
-		console_loglevel = newlevel;
+		default_console_loglevel = newlevel;
 		return 0;
 	}
 
diff --git a/kernel/printk/console_cmdline.h b/kernel/printk/console_cmdline.h
index 3ca74ad391d6..40f1a1ff0965 100644
--- a/kernel/printk/console_cmdline.h
+++ b/kernel/printk/console_cmdline.h
@@ -6,6 +6,8 @@ struct console_cmdline
 {
 	char	name[16];			/* Name of the driver	    */
 	int	index;				/* Minor dev. to use	    */
+	int	level;				/* Log level to use */
+	short	flags;				/* Initial flags */
 	bool	user_specified;			/* Specified by command line vs. platform */
 	char	*options;			/* Options for the driver   */
 #ifdef CONFIG_A11Y_BRAILLE_CONSOLE
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index da03c15ecc89..0cfcff1a4757 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -44,6 +44,7 @@
 #include <linux/irq_work.h>
 #include <linux/ctype.h>
 #include <linux/uio.h>
+#include <linux/device.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
@@ -61,7 +62,7 @@
 #include "internal.h"
 
 int console_printk[4] = {
-	CONSOLE_LOGLEVEL_DEFAULT,	/* console_loglevel */
+	LOGLEVEL_INVALID,		/* console_loglevel (forced) */
 	MESSAGE_LOGLEVEL_DEFAULT,	/* default_message_loglevel */
 	CONSOLE_LOGLEVEL_MIN,		/* minimum_console_loglevel */
 	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
@@ -396,6 +397,32 @@ static struct latched_seq clear_seq = {
 	.val[1]		= 0,
 };
 
+static struct class *console_class;
+
+/*
+ * When setting a console loglevel, we may not ultimately end up with that as
+ * the effective level due to forced_console_loglevel,
+ * minimum_console_loglevel, or ignore_loglevel. Always returning the level and
+ * effective source allows us to keep the logic in one place.
+ */
+enum loglevel_source {
+	LLS_GLOBAL,
+	LLS_LOCAL,
+	LLS_FORCED,
+	LLS_MINIMUM,
+	LLS_FORCED_MINIMUM,
+	LLS_IGNORE_LOGLEVEL,
+};
+
+static const char *const loglevel_source_names[] = {
+	[LLS_GLOBAL] = "global",
+	[LLS_LOCAL] = "local",
+	[LLS_FORCED] = "forced",
+	[LLS_MINIMUM] = "minimum",
+	[LLS_FORCED_MINIMUM] = "forced_minimum",
+	[LLS_IGNORE_LOGLEVEL] = "ignore_loglevel",
+};
+
 #ifdef CONFIG_PRINTK_CALLER
 #define PREFIX_MAX		48
 #else
@@ -1199,9 +1226,68 @@ module_param(ignore_loglevel, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ignore_loglevel,
 		 "ignore loglevel setting (prints all kernel messages to the console)");
 
-static bool suppress_message_printing(int level)
+/*
+ * Hierarchy of loglevel authority:
+ *
+ * 1. ignore_loglevel. Cannot be changed after boot. Overrides absolutely
+ *    everything since it's used to debug.
+ * 2. forced_console_loglevel. Optional, forces all consoles to the specified
+ *    loglevel.
+ * 3. minimum_console_loglevel. Always present, in effect if it's greater than
+ *    the console's local loglevel (or the global level if that isn't set).
+ * 4. con->level. Optional.
+ * 5. default_console_loglevel. Always present.
+ *
+ * Callers typically only need the level _or_ the source, but they're both
+ * emitted from this function so that the effective loglevel logic can be
+ * kept in one place.
+ */
+static int console_effective_loglevel(const struct console *con,
+				      enum loglevel_source *source)
+{
+	enum loglevel_source lsource;
+	int level;
+
+	if (ignore_loglevel) {
+		*source = LLS_IGNORE_LOGLEVEL;
+		return CONSOLE_LOGLEVEL_MOTORMOUTH;
+	}
+
+	/* Everything below here must respect minimum_console_loglevel */
+
+	if (console_loglevel != LOGLEVEL_INVALID) {
+		lsource = LLS_FORCED;
+		level = console_loglevel;
+		goto check_minimum;
+	}
+
+	if (con && (con->flags & CON_LOGLEVEL)) {
+		lsource = LLS_LOCAL;
+		level = con->level;
+		goto check_minimum;
+	}
+
+	lsource = LLS_GLOBAL;
+	level = default_console_loglevel;
+
+check_minimum:
+	if (level < minimum_console_loglevel) {
+		if (lsource == LLS_FORCED)
+			lsource = LLS_FORCED_MINIMUM;
+		else
+			lsource = LLS_MINIMUM;
+		level = minimum_console_loglevel;
+	}
+
+	*source = lsource;
+	return level;
+}
+
+static bool suppress_message_printing(int level, struct console *con)
 {
-	return (level >= console_loglevel && !ignore_loglevel);
+	enum loglevel_source source;
+
+	return level >= console_effective_loglevel(con, &source);
 }
 
 #ifdef CONFIG_BOOT_PRINTK_DELAY
@@ -1233,7 +1319,7 @@ static void boot_delay_msec(int level)
 	unsigned long timeout;
 
 	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
-		|| suppress_message_printing(level)) {
+		|| suppress_message_printing(level, NULL)) {
 		return;
 	}
 
@@ -1642,6 +1728,32 @@ static void syslog_clear(void)
 	mutex_unlock(&syslog_lock);
 }
 
+/*
+ * Using the global klogctl/syslog API is unlikely to do what you want if you
+ * also have console specific loglevels. Warn about it.
+ */
+static void warn_on_local_loglevel(void)
+{
+	struct console *con;
+
+	/*
+	 * If it's already forced, it's not like local console loglevels are
+	 * taking effect anyway.
+	 */
+	if (console_loglevel != LOGLEVEL_INVALID)
+		return;
+
+	console_lock();
+	for_each_console(con) {
+		if (con->flags & CON_LOGLEVEL) {
+			pr_warn_ratelimited("%s (%d) used syslog(SYSLOG_ACTION_CONSOLE_*) with local console loglevels set. This overrides local console loglevels.\n",
+					    current->comm, current->pid);
+			break;
+		}
+	}
+	console_unlock();
+}
+
 int do_syslog(int type, char __user *buf, int len, int source)
 {
 	struct printk_info info;
@@ -1653,6 +1765,18 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	if (error)
 		return error;
 
+	/*
+	 * This is the old, global API -- syslog() has no way to indicate which
+	 * console the changes are supposed to go to. If you want per-console
+	 * loglevel controls, then use the sysfs API.
+	 *
+	 * SYSLOG_ACTION_CONSOLE_{ON,OFF,LEVEL} emulate the old behaviour by
+	 * forcing all consoles to the specified level. Note that this means
+	 * you cannot reasonably mix using per-console loglevels and
+	 * syslog(SYSLOG_ACTION_CONSOLE_*), since this will override your
+	 * per-console loglevel settings.
+	 */
+
 	switch (type) {
 	case SYSLOG_ACTION_CLOSE:	/* Close log */
 		break;
@@ -1687,12 +1811,14 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Disable logging to console */
 	case SYSLOG_ACTION_CONSOLE_OFF:
+		warn_on_local_loglevel();
 		if (saved_console_loglevel == LOGLEVEL_DEFAULT)
 			saved_console_loglevel = console_loglevel;
 		console_loglevel = minimum_console_loglevel;
 		break;
 	/* Enable logging to console */
 	case SYSLOG_ACTION_CONSOLE_ON:
+		warn_on_local_loglevel();
 		if (saved_console_loglevel != LOGLEVEL_DEFAULT) {
 			console_loglevel = saved_console_loglevel;
 			saved_console_loglevel = LOGLEVEL_DEFAULT;
@@ -1700,10 +1826,9 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Set level of messages printed to console */
 	case SYSLOG_ACTION_CONSOLE_LEVEL:
+		warn_on_local_loglevel();
 		if (len < 1 || len > 8)
 			return -EINVAL;
-		if (len < minimum_console_loglevel)
-			len = minimum_console_loglevel;
 		console_loglevel = len;
 		/* Implicitly re-enable logging to console */
 		saved_console_loglevel = LOGLEVEL_DEFAULT;
@@ -1916,7 +2041,7 @@ static int console_trylock_spinning(void)
  * The console_lock must be held.
  */
 static void call_console_drivers(const char *ext_text, size_t ext_len,
-				 const char *text, size_t len)
+				 const char *text, size_t len, int level)
 {
 	static char dropped_text[64];
 	size_t dropped_len = 0;
@@ -1944,6 +2069,8 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 		if (!cpu_online(smp_processor_id()) &&
 		    !(con->flags & CON_ANYTIME))
 			continue;
+		if (suppress_message_printing(level, con))
+			continue;
 		if (con->flags & CON_EXTENDED)
 			con->write(con, ext_text, ext_len);
 		else {
@@ -2326,8 +2453,11 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(void) { return 0; }
 static void call_console_drivers(const char *ext_text, size_t ext_len,
-				 const char *text, size_t len) {}
-static bool suppress_message_printing(int level) { return false; }
+				 const char *text, size_t len, int level) {}
+static bool suppress_message_printing(int level, struct console *con)
+{
+	return false;
+}
 
 #endif /* CONFIG_PRINTK */
 
@@ -2365,7 +2495,8 @@ static void set_user_specified(struct console_cmdline *c, bool user_specified)
 	console_set_on_cmdline = 1;
 }
 
-static int __add_preferred_console(char *name, int idx, char *options,
+static int __add_preferred_console(char *name, int idx, int loglevel,
+				   short initial_flags, char *options,
 				   char *brl_options, bool user_specified)
 {
 	struct console_cmdline *c;
@@ -2394,6 +2525,8 @@ static int __add_preferred_console(char *name, int idx, char *options,
 	set_user_specified(c, user_specified);
 	braille_set_options(c, brl_options);
 
+	c->level = loglevel;
+	c->flags = initial_flags;
 	c->index = idx;
 	return 0;
 }
@@ -2415,7 +2548,9 @@ __setup("console_msg_format=", console_msg_format_setup);
 static int __init console_setup(char *str)
 {
 	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
-	char *s, *options, *brl_options = NULL;
+	char *s, *options, *sloglevel, *brl_options = NULL;
+	int loglevel = default_console_loglevel;
+	short initial_flags = 0;
 	int idx;
 
 	/*
@@ -2424,7 +2559,8 @@ static int __init console_setup(char *str)
 	 * for exactly this purpose.
 	 */
 	if (str[0] == 0 || strcmp(str, "null") == 0) {
-		__add_preferred_console("ttynull", 0, NULL, NULL, true);
+		__add_preferred_console("ttynull", 0, 0, 0, NULL, NULL,
+					true);
 		return 1;
 	}
 
@@ -2444,6 +2580,17 @@ static int __init console_setup(char *str)
 	options = strchr(str, ',');
 	if (options)
 		*(options++) = 0;
+
+	sloglevel = strchr(options ?: str, '/');
+	if (sloglevel) {
+		*(sloglevel++) = 0;
+		if (kstrtoint(sloglevel, 10, &loglevel) == 0) {
+			loglevel = clamp(loglevel, LOGLEVEL_EMERG,
+					 LOGLEVEL_DEBUG + 1);
+			initial_flags |= CON_LOGLEVEL;
+		}
+	}
+
 #ifdef __sparc__
 	if (!strcmp(str, "ttya"))
 		strcpy(buf, "ttyS0");
@@ -2456,7 +2603,8 @@ static int __init console_setup(char *str)
 	idx = simple_strtoul(s, NULL, 10);
 	*s = 0;
 
-	__add_preferred_console(buf, idx, options, brl_options, true);
+	__add_preferred_console(buf, idx, loglevel, initial_flags, options,
+				brl_options, true);
 	return 1;
 }
 __setup("console=", console_setup);
@@ -2476,7 +2624,7 @@ __setup("console=", console_setup);
  */
 int add_preferred_console(char *name, int idx, char *options)
 {
-	return __add_preferred_console(name, idx, options, NULL, false);
+	return __add_preferred_console(name, idx, 0, 0, options, NULL, false);
 }
 
 bool console_suspend_enabled = true;
@@ -2706,8 +2854,10 @@ void console_unlock(void)
 
 	for (;;) {
 		size_t ext_len = 0;
+		bool solicited = false;
 		int handover;
 		size_t len;
+		struct console *con;
 
 skip:
 		if (!prb_read_valid(prb, console_seq, &r))
@@ -2722,12 +2872,18 @@ void console_unlock(void)
 			}
 		}
 
-		if (suppress_message_printing(r.info->level)) {
-			/*
-			 * Skip record we have buffered and already printed
-			 * directly to the console when we received it, and
-			 * record that has level above the console loglevel.
-			 */
+		/*
+		 * Already checked per-console in call_console_drivers(), but
+		 * we should avoid spending time formatting the text at all if
+		 * no console wants the message in the first place.
+		 */
+		for_each_console(con) {
+			if (!suppress_message_printing(r.info->level, con)) {
+				solicited = true;
+				break;
+			}
+		}
+		if (!solicited) {
 			console_seq++;
 			goto skip;
 		}
@@ -2771,7 +2927,8 @@ void console_unlock(void)
 		console_lock_spinning_enable();
 
 		stop_critical_timings();	/* don't trace print latency */
-		call_console_drivers(ext_text, ext_len, text, len);
+		call_console_drivers(ext_text, ext_len, text, len,
+				     r.info->level);
 		start_critical_timings();
 
 		handover = console_lock_spinning_disable_and_check();
@@ -2919,6 +3076,142 @@ static int __init keep_bootcon_setup(char *str)
 
 early_param("keep_bootcon", keep_bootcon_setup);
 
+#ifdef CONFIG_PRINTK
+static ssize_t loglevel_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct console *con = classdev_to_console(dev);
+
+	if (con->flags & CON_LOGLEVEL)
+		return sysfs_emit(buf, "%d\n", con->level);
+	else
+		return sysfs_emit(buf, "unset\n");
+}
+
+static ssize_t loglevel_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t size)
+{
+	struct console *con = classdev_to_console(dev);
+	ssize_t ret;
+	int tmp;
+
+	if (!strcmp(buf, "unset") || !strcmp(buf, "unset\n")) {
+		con->flags &= ~CON_LOGLEVEL;
+		return size;
+	}
+
+	ret = kstrtoint(buf, 10, &tmp);
+	if (ret < 0)
+		return ret;
+
+	if (tmp < LOGLEVEL_EMERG || tmp > LOGLEVEL_DEBUG + 1)
+		return -ERANGE;
+
+	con->level = tmp;
+	con->flags |= CON_LOGLEVEL;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(loglevel);
+
+static ssize_t effective_loglevel_source_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct console *con = classdev_to_console(dev);
+	enum loglevel_source source;
+
+	console_effective_loglevel(con, &source);
+	return sysfs_emit(buf, "%s\n", loglevel_source_names[source]);
+}
+
+static DEVICE_ATTR_RO(effective_loglevel_source);
+
+static ssize_t effective_loglevel_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct console *con = classdev_to_console(dev);
+	enum loglevel_source source;
+
+	return sysfs_emit(buf, "%d\n",
+			  console_effective_loglevel(con, &source));
+}
+
+static DEVICE_ATTR_RO(effective_loglevel);
+
+static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct console *con = classdev_to_console(dev);
+
+	return sysfs_emit(buf, "%d\n", !!(con->flags & CON_ENABLED));
+}
+
+static DEVICE_ATTR_RO(enabled);
+
+static struct attribute *console_sysfs_attrs[] = {
+	&dev_attr_loglevel.attr,
+	&dev_attr_effective_loglevel_source.attr,
+	&dev_attr_effective_loglevel.attr,
+	&dev_attr_enabled.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(console_sysfs);
+
+static void console_classdev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+static void console_register_device(struct console *new)
+{
+	/*
+	 * We might be called from register_console() before the class is
+	 * registered. If that happens, we'll take care of it in
+	 * printk_late_init.
+	 */
+	if (IS_ERR_OR_NULL(console_class))
+		return;
+
+	new->classdev = kzalloc(sizeof(struct device), GFP_KERNEL);
+	if (!new->classdev)
+		return;
+
+	device_initialize(new->classdev);
+	dev_set_name(new->classdev, "%s", new->name);
+	dev_set_drvdata(new->classdev, new);
+	new->classdev->release = console_classdev_release;
+	new->classdev->class = console_class;
+	if (device_add(new->classdev))
+		put_device(new->classdev);
+}
+
+static void console_setup_class(void)
+{
+	struct console *con;
+
+	/*
+	 * printk exists for the lifetime of the kernel, it cannot be unloaded,
+	 * so we should never end up back in here.
+	 */
+	if (WARN_ON(console_class))
+		return;
+
+	console_class = class_create(THIS_MODULE, "console");
+	if (!IS_ERR(console_class))
+		console_class->dev_groups = console_sysfs_groups;
+
+	for_each_console(con)
+		console_register_device(con);
+}
+#else /* CONFIG_PRINTK */
+static void console_register_device(struct console *new) {}
+static void console_setup_class(void) {}
+#endif
+
 /*
  * This is called by register_console() to try to match
  * the newly registered console with any of the ones selected
@@ -2951,6 +3244,11 @@ static int try_enable_preferred_console(struct console *newcon,
 			if (newcon->index < 0)
 				newcon->index = c->index;
 
+			if (c->flags & CON_LOGLEVEL)
+				newcon->level = c->level;
+			newcon->flags |= c->flags;
+			newcon->classdev = NULL;
+
 			if (_braille_register_console(newcon, c))
 				return 0;
 
@@ -3118,6 +3416,7 @@ void register_console(struct console *newcon)
 		console_seq = syslog_seq;
 		mutex_unlock(&syslog_lock);
 	}
+	console_register_device(newcon);
 	console_unlock();
 	console_sysfs_notify();
 
@@ -3188,6 +3487,10 @@ int unregister_console(struct console *console)
 		console_drivers->flags |= CON_CONSDEV;
 
 	console->flags &= ~CON_ENABLED;
+
+	if (console->classdev)
+		device_unregister(console->classdev);
+
 	console_unlock();
 	console_sysfs_notify();
 
@@ -3247,6 +3550,10 @@ void __init console_init(void)
  * To mitigate this problem somewhat, only unregister consoles whose memory
  * intersects with the init section. Note that all other boot consoles will
  * get unregistered when the real preferred console is registered.
+ *
+ * Early consoles will also have been registered before we had the
+ * infrastructure to put them into /sys/class/console, so make sure they get
+ * set up now that we're ready.
  */
 static int __init printk_late_init(void)
 {
@@ -3280,6 +3587,9 @@ static int __init printk_late_init(void)
 					console_cpu_notify, NULL);
 	WARN_ON(ret < 0);
 	printk_sysctl_init();
+
+	console_setup_class();
+
 	return 0;
 }
 late_initcall(printk_late_init);
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index c228343eeb97..6a0c099ce6c3 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -7,9 +7,12 @@
 #include <linux/printk.h>
 #include <linux/capability.h>
 #include <linux/ratelimit.h>
+#include <linux/console.h>
 #include "internal.h"
 
 static const int ten_thousand = 10000;
+static const int min_loglevel = LOGLEVEL_EMERG;
+static const int max_loglevel = LOGLEVEL_DEBUG + 1;
 
 static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
@@ -20,13 +23,71 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
 	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 }
 
+static int printk_sysctl_deprecated(struct ctl_table *table, int write,
+				    void __user *buffer, size_t *lenp,
+				    loff_t *ppos)
+{
+	int res = proc_dointvec(table, write, buffer, lenp, ppos);
+
+	if (write)
+		pr_warn_ratelimited(
+			"printk: The kernel.printk sysctl is deprecated. Use kernel.force_console_loglevel, kernel.default_message_loglevel, kernel.minimum_console_loglevel, or kernel.default_console_loglevel instead.\n"
+		);
+
+	return res;
+}
+
+#define FORCE_CONSOLE_LOGLEVEL_MAX_LEN (sizeof("unset\n") + 1)
+
+static int printk_force_console_loglevel(struct ctl_table *table, int write,
+					 void __user *buffer, size_t *lenp,
+					 loff_t *ppos)
+{
+
+	char level[FORCE_CONSOLE_LOGLEVEL_MAX_LEN] = "unset";
+	struct ctl_table ltable = *table;
+	int ret, value;
+
+	ltable.data = level;
+	ltable.maxlen = sizeof(level) - 1;
+
+	if (!write) {
+		if (console_loglevel != LOGLEVEL_INVALID)
+			snprintf(ltable.data,
+				 FORCE_CONSOLE_LOGLEVEL_MAX_LEN, "%d",
+				 console_loglevel);
+		return proc_dostring(&ltable, write, buffer, lenp, ppos);
+	}
+
+	/* We accept either a loglevel, or "unset". */
+	ret = proc_dostring(&ltable, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
+
+	if (strncmp(ltable.data, "unset", sizeof("unset")) == 0) {
+		console_loglevel = LOGLEVEL_INVALID;
+		return 0;
+	}
+
+	ret = kstrtoint(ltable.data, 10, &value);
+	if (ret)
+		return ret;
+
+	if (value < LOGLEVEL_EMERG || value > LOGLEVEL_DEBUG + 1)
+		return -ERANGE;
+
+	console_loglevel = value;
+
+	return 0;
+}
+
 static struct ctl_table printk_sysctls[] = {
 	{
 		.procname	= "printk",
 		.data		= &console_loglevel,
 		.maxlen		= 4*sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= printk_sysctl_deprecated,
 	},
 	{
 		.procname	= "printk_ratelimit",
@@ -76,6 +137,38 @@ static struct ctl_table printk_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "force_console_loglevel",
+		.mode		= 0644,
+		.proc_handler	= printk_force_console_loglevel,
+	},
+	{
+		.procname	= "default_message_loglevel",
+		.data		= &default_message_loglevel,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= (void *)&min_loglevel,
+		.extra2		= (void *)&max_loglevel,
+	},
+	{
+		.procname	= "default_console_loglevel",
+		.data		= &default_console_loglevel,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= (void *)&min_loglevel,
+		.extra2		= (void *)&max_loglevel,
+	},
+	{
+		.procname	= "minimum_console_loglevel",
+		.data		= &minimum_console_loglevel,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= (void *)&min_loglevel,
+		.extra2		= (void *)&max_loglevel,
+	},
 	{}
 };
 

base-commit: 3ef4ea3d84ca568dcd57816b9521e82e3bd94f08
-- 
2.36.0

