Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF1E4E85D0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 06:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiC0EuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 00:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbiC0Et7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 00:49:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4D013E27
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:48:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i11so780654plg.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Z+uQoE5tv5cHr6wpjP6l67koucowLD5yeqOkHmKHU0=;
        b=VUr2uA+jde3zFTsNVMf0cKMFbJG5xQLBIkR74dJ7hilDvGFth7p7zOCOBWu1GOAJCg
         lAE1nrOEMz3NtbjnwywDRoWJmsWhn8PUX1Xm0EVWOyXf5Usp7F+OxMTwfO9qJAu1NDiY
         aUyM5cb/W1UEt/w64JqAj9cfMhKhO8E5868oLUDsUKBJS5zEn44JfsrJn6G3O7FksZm9
         xfyDiV251zMzbmI/Ifuc6qXf7xeS6rc/AYU22glLWKxAg608cq4ezPWBWKgGGcRUq5ai
         vt4CCtg2uGP/xdxfktFPGi4laUVKwoZyrLH4st+YROOD8QKzbQYWTE8iP9175RQgd+jy
         wIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Z+uQoE5tv5cHr6wpjP6l67koucowLD5yeqOkHmKHU0=;
        b=AOghofKuTUwkoQZYKd6CdmNdHwQa+nVwEClsYZsOsz8oTrdYTFA4Q1Jqojm+juS4Rr
         cfJLCObIZwp/T5io1xtrfaL/uHfT51+8sV5EV/RQy3jTjR8I9aIgW8iWGmvJTVZDvMbp
         y0DpDyc7iRVwrfbUxep4gMglIMS9k2Mt5pk2u0vNbdIYYyJxyvsYHMSs9dFd713YLHZG
         OrLdADOGHdGMkOSlaGj3AxoZVy3pLAt0f0eT43FccKstErRO3ER14hXIKorb8qskCslJ
         ro/YuMuZQcurhws5pn/P7j7WkumA5OWVanpE1zZlGlH+oWkPKHUCnlPzDfJ4LoVn/9q/
         Vorg==
X-Gm-Message-State: AOAM532XAStw4PV8yZKB6b7E0FMynA+FJZgKKto4vxw6milu+OX2jqor
        SL9CLA7buXqioLfHIW7gXjgcj43z0VKuWg==
X-Google-Smtp-Source: ABdhPJxsP7I5Y0HntymzUhPvTU59l0VlCeQNCsu3U8urmT2DxnVGqEUDTdggWFN7oCi6nJxzEuqemA==
X-Received: by 2002:a17:90b:4c52:b0:1c9:96c3:a91e with SMTP id np18-20020a17090b4c5200b001c996c3a91emr1295706pjb.131.1648356500055;
        Sat, 26 Mar 2022 21:48:20 -0700 (PDT)
Received: from yusufkhan-MS-7B17.lan ([24.17.200.29])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b004e17e11cb17sm12063138pfc.111.2022.03.26.21.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 21:48:19 -0700 (PDT)
From:   Yusuf Khan <yusisamerican@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jasowang@redhat.com, mikelley@microsoft.com, mst@redhat.com,
        gregkh@linuxfoundation.org, javier@javigon.com, arnd@arndb.de,
        will@kernel.org, axboe@kernel.dk,
        Yusuf Khan <yusisamerican@gmail.com>,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v9] drivers: ddcci: upstream DDCCI driver
Date:   Sat, 26 Mar 2022 21:46:57 -0700
Message-Id: <20220327044656.142958-4-yusisamerican@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220327044656.142958-1-yusisamerican@gmail.com>
References: <20220327044656.142958-1-yusisamerican@gmail.com>
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

