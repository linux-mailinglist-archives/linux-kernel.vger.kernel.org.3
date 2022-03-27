Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC094E858A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 06:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiC0E0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 00:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiC0E0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 00:26:45 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39E116594
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:25:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w8so12037512pll.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Z+uQoE5tv5cHr6wpjP6l67koucowLD5yeqOkHmKHU0=;
        b=GgKBrELMer7jQYvb7TUiWXcVN7p+KnCWSVyn+wNoT8NErRdKummTXbUN2qwO/eyb+Z
         gJNSVK0gv/TEKHlxnhd9fAn5nFHfKvI64RT5pHtEWYpvymJhU3mrgtWpeLn71WLd6vps
         4GIzY5LkYPPIh0W4Ffq04NVCuBFwa6H8tkfshOPXsWfx/bhSmfmFq5hPOgu/3bpEOCLD
         lbD8MsaKBYcnfNpzHjTTKBoWr0n+k+UcHRMwWNj7SLkZouFpUgR1U+UeOugNy22zRrdY
         Xx33DY/x6r0q8bLrMavKSZU/AvIZmyAiv3XEfgywhuMsw9/cUoVNyE5PWv7XLrxoy0dR
         LXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Z+uQoE5tv5cHr6wpjP6l67koucowLD5yeqOkHmKHU0=;
        b=KcMck1OPbRjup8hdO2MeHMIBTIzxsiwWhKkZQbwbfHG0HdM3FArHdrIDRm8IJNs1Si
         tgS0Oo6RvdHBoHF6LbSdCiJAVm8e8kBwcMrWoZxJIuxKIEJuVeshfI54Na3eZwAknh3L
         EnS7Ssobun64FbY+o9ZTLbHHJo2xUcvxfUz/tLGmcafWGUP5bG+dJxeZVq08j08f52D5
         XYyP4AKKto9P+yoivaH7FempiCTTyUGv52rdjUx4Zc22kc/XYitHdih/uVyRpLlE5/U2
         47QH42bblE2rd4FYh2zHsonZ6/1+yMorqMSCcPcZVgzO4ZvNpDUURPNKXjbetA9+pxvY
         O+tw==
X-Gm-Message-State: AOAM530+mhn0DnYGOgbUu7XSUvofXXDLgjPF1iH8QxgLstLXmTMPObNR
        I7k9V6XSymSFyBrASq/X6lZNUow8du52mA==
X-Google-Smtp-Source: ABdhPJxkVzMjUHNVZq+0y8QnWBYRBADM9WR6TBdNqEdK1HGniL0gntdbtptT4AA3FfBd7wpywhrUdA==
X-Received: by 2002:a17:902:9046:b0:14d:5c9d:e7df with SMTP id w6-20020a170902904600b0014d5c9de7dfmr19871011plz.65.1648355105833;
        Sat, 26 Mar 2022 21:25:05 -0700 (PDT)
Received: from yusufkhan-MS-7B17.lan ([24.17.200.29])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b0038085c0a9d7sm9121038pgo.49.2022.03.26.21.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 21:25:05 -0700 (PDT)
From:   Yusuf Khan <yusisamerican@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jasowang@redhat.com, mikelley@microsoft.com, mst@redhat.com,
        gregkh@linuxfoundation.org, javier@javigon.com, arnd@arndb.de,
        will@kernel.org, axboe@kernel.dk,
        Yusuf Khan <yusisamerican@gmail.com>,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>
Subject: [PATCH v9] drivers: ddcci: upstream DDCCI driver
Date:   Sat, 26 Mar 2022 21:24:59 -0700
Message-Id: <20220327042459.141515-4-yusisamerican@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220327042459.141515-1-yusisamerican@gmail.com>
References: <20220327042459.141515-1-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Documentation for the DDCCI driver.

Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
Signed-off-by: Christoph Grenz <christophg+lkml@grenz-bonn.de>
---
 Documentation/ABI/testing/sysfs-driver-ddcci |  57 +++++++++
 Documentation/driver-api/ddcci.rst           | 122 +++++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ddcci
 create mode 100644 Documentation/driver-api/ddcci.rst

diff --git a/Documentation/ABI/testing/sysfs-driver-ddcci b/Documentation/ABI/testing/sysfs-driver-ddcci
new file mode 100644
index 000000000000..19f77ccf3ed0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-ddcci
@@ -0,0 +1,57 @@
+What:		/sys/bus/ddcci/ddcci<I²C bus number>i<hex address>
+Date:		March 2022
+KernelVersion:	5.18
+Contact:	Christoph Grenz <christophg+lkml@grenz-bonn.de>
+Description:	This file is a user interface for an internal
+		dependent device on the I2C bus, it exports the same
+		information as the master device(/sys/bus/ddcci/
+		ddcci<I²C bus number>) that is referenced in this
+		document.
+
+What:		/sys/bus/ddcci/ddcci<I²C bus number>e<hex address>
+Date:		March 2022
+KernelVersion:	5.18
+Contact:	Christoph Grenz <christophg+lkml@grenz-bonn.de>
+Description:	This file is a user interface for an external
+		dependent device on the I2C bus, it exports the same
+		information as the master device(/sys/bus/ddcci/
+		ddcci<I²C bus number>) that is referenced in this
+		document.
+
+What:		/sys/bus/ddcci/ddcci<I²C bus number>
+Date:		March 2022
+KernelVersion:	5.18
+Contact:	Christoph Grenz <christophg+lkml@grenz-bonn.de>
+Description:	This file provides the user interface for the
+		master device on the I2C bus. It exports the following
+		peices of information:
+		- idProt
+		ACCESS.bus protocol supported by the device. Usually
+		"monitor".
+
+		- idType
+		ACCESS.bus device subtype. Usually "LCD" or "CRT".
+
+		- idModel
+		ACCESS.bus device model identifier. Usually a
+		shortened form of the device model name.
+
+		- idVendor
+		ACCESS.bus device vendor identifier. Empty if the
+		Identification command is not supported.
+
+		- idModule
+		ACCESS.bus device module identifier. Empty if the
+		Identification command is not supported.
+
+		- idSerial
+		32 bit device number. A fixed serial number if it's
+		positive, a temporary serial number if negative and zero
+		if the Identification command is not supported.
+
+		- modalias
+		A combined identifier for driver selection. It has the form:
+		ddcci:<idProt>-<idType>-<idModel>-<idVendor>-<idModule>.
+		All non-alphanumeric characters (including whitespace)
+		in the model, vendor or module parts are replaced by
+		underscores to prevent issues with software like systemd-udevd.
diff --git a/Documentation/driver-api/ddcci.rst b/Documentation/driver-api/ddcci.rst
new file mode 100644
index 000000000000..2b7de1ac2656
--- /dev/null
+++ b/Documentation/driver-api/ddcci.rst
@@ -0,0 +1,122 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==============
+DDC/CI
+==============
+
+1. Introduction
+===============
+DDC/CI is a control protocol for monitor settings supported by most
+monitors since about 2005. It is based on ACCESS.bus (an early USB predecessor).
+This could be used to create drivers that communicate with the DDCCI component,
+see ddcci-backlight for an example.
+
+2. sysfs interface
+==================
+Each detected DDC/CI device gets a directory in /sys/bus/ddcci/devices.
+The main device on a bus is named ddcci[I²C bus number].
+Internal dependent devices are named ddcci[I²C bus number]i[hex address]
+External dependent devices are named ddcci[I²C bus number]e[hex address]
+There the following files export information about the device:
+
+capabilities
+The full ACCESS.bus capabilities string. It contains the protocol,
+type and model of the device, a list of all supported command
+codes, etc. See the ACCESS.bus spec for more information.
+
+- idProt
+ACCESS.bus protocol supported by the device. Usually "monitor".
+
+- idType
+ACCESS.bus device subtype. Usually "LCD" or "CRT".
+
+- idModel
+ACCESS.bus device model identifier. Usually a shortened form of the
+device model name.
+
+- idVendor
+ACCESS.bus device vendor identifier. Empty if the Identification command
+is not supported.
+
+- idModule
+ACCESS.bus device module identifier. Empty if the Identification command
+is not supported.
+
+- idSerial
+32 bit device number. A fixed serial number if it's positive, a temporary
+serial number if negative and zero if the
+Identification command is not supported.
+
+- modalias
+A combined identifier for driver selection. It has the form:
+ddcci:<idProt>-<idType>-<idModel>-<idVendor>-<idModule>.
+All non-alphanumeric characters (including whitespace) in the model,
+vendor or module parts are replaced by underscores to prevent issues
+with software like systemd-udevd.
+
+3. Character device interface
+=============================
+For each DDC/CI device a character device in
+/dev/bus/ddcci/[I²C bus number]/ is created,
+127 devices are assigned in total.
+
+The main device on the bus is named display.
+
+Internal dependent devices are named i[hex address]
+
+External dependent devices are named e[hex address]
+
+These character devices can be used to issue commands to a DDC/CI device
+more easily than over i2c-dev devices. They should be opened unbuffered.
+To send a command just write the command byte and the arguments with a
+single write() operation. The length byte and checksum are automatically
+calculated.
+
+To read a response use read() with a buffer big enough for the expected answer.
+
+NOTE: The maximum length of a DDC/CI message is 32 bytes.
+
+4. ddcci-backlight (monitor backlight driver)
+=============================================
+[This is not specific to the DDC/CI backlight driver, if you already dealt with
+backlight drivers, skip over this.]
+
+For each monitor that supports accessing the Backlight Level White
+or the Luminance property, a backlight device of type "raw" named like the
+corresponding ddcci device is created. You can find them in /sys/class/backlight/.
+For convenience a symlink "ddcci_backlight" on the device associated with the
+display connector in /sys/class/drm/ to the backlight device is created, as
+long as the graphics driver allows to make this association.
+
+5. Limitations
+==============
+
+-Dependent devices (sub devices using DDC/CI directly wired to the monitor,
+like  Calibration devices, IR remotes, etc.) aren't automatically detected.
+You can force detection of external dependent devices by writing
+"ddcci-dependent [address]" into /sys/bus/i2c/i2c-?/new_device.
+
+There is no direct synchronization if you manually change the luminance
+with the buttons on your monitor, as this can only be realized through polling
+and some monitors close their OSD every time a DDC/CI command is received.
+
+Monitor hotplugging is not detected. You need to detach/reattach the I²C driver
+or reload the module.
+
+6. Debugging
+============
+Both drivers use the dynamic debugging feature of the Linux kernel.
+To get detailed debugging messages, set the dyndbg module parameter.
+If you want to enable debugging permanently across reboots, create a file
+/etc/modprobe.d/ddcci.conf containing lines like the following before loading the modules:
+
+options ddcci dyndbg
+options ddcci-backlight dyndbg
+
+7. Origin
+============
+This driver originally came from Christoph Grenz in DKMS form here:
+https://gitlab.com/ddcci-driver-linux/ddcci-driver-linux
+with multiple backups available on the wayback machine. It also
+inlcudes a example program for the usage of this driver in
+userland.
-- 
2.25.1

