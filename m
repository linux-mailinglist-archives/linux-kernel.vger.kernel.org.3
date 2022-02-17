Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9544BAD12
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiBQXKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:10:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiBQXKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:10:20 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9D15577D;
        Thu, 17 Feb 2022 15:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645139401; x=1676675401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=if4d4IuEQryq2xSeSq7kvbYAGlbQsoeOTWd/h53pnDI=;
  b=azGQIZQRRHT0kO7NaPLB0LxL+GQFJXDeLEzTY/K0TInoIdoxEpt37+bA
   F1lIdDz+1BLdO5kHwrLtgwHTa+MH1qX+Jfc/2ycuzTi9Y3UYlC5+LryBd
   dZASmtffh9Dqyq5Ca2og3deKNfnDRMY6kuohshNRZGlTXYnsMqVU0FJa4
   F+qMuvRoiULIPGU9SlAAcxepfXZ++dcGJ/o+cN9hcemdgOTc/wOCOwR2u
   xfV8SkLCOtJv5rkrgb0qCi9QWvOWaMI2phUcLTw+wb95toDKTQ7iYtWB/
   vu26okbq4St3Wa+RK033VmdlrLAgKdWO64V153UV1hK34YE6VKqmEFZUE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="250750772"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="250750772"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 15:10:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="503738929"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 17 Feb 2022 15:09:59 -0800
Received: from debox1-desk4.lan (unknown [10.251.23.8])
        by linux.intel.com (Postfix) with ESMTP id BD2AD580AA7;
        Thu, 17 Feb 2022 15:09:59 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, david.e.box@linux.intel.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH V8 2/2] selftests: sdsi: test sysfs setup
Date:   Thu, 17 Feb 2022 15:09:58 -0800
Message-Id: <20220217230958.259360-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217230958.259360-1-david.e.box@linux.intel.com>
References: <20220217230958.259360-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tests file configuration and error handling of the Intel Software
Defined Silicon sysfs ABI.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
Applied on review-hans branch.

V8
  - Skip if python3 or pytest aren't installed
  - Do not remove driver after test is run
V7
  - No changes.
V6
  - No changes.
V5
  - No changes.
V4
  - No changes.
V3
  - Add tests to check PCI device removal handling and to check for
    driver memory leaks.
V2
  - New patch.

 MAINTAINERS                                   |   1 +
 tools/testing/selftests/drivers/sdsi/sdsi.sh  |  26 ++
 .../selftests/drivers/sdsi/sdsi_test.py       | 226 ++++++++++++++++++
 3 files changed, 253 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/sdsi/sdsi.sh
 create mode 100644 tools/testing/selftests/drivers/sdsi/sdsi_test.py

diff --git a/MAINTAINERS b/MAINTAINERS
index dc3c9f271463..be2c4c63e58f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9872,6 +9872,7 @@ M:	David E. Box <david.e.box@linux.intel.com>
 S:	Supported
 F:	drivers/platform/x86/intel/sdsi.c
 F:	tools/arch/x86/intel_sdsi/
+F:	tools/testing/selftests/drivers/sdsi/
 
 INTEL SKYLAKE INT3472 ACPI DEVICE DRIVER
 M:	Daniel Scally <djrscally@gmail.com>
diff --git a/tools/testing/selftests/drivers/sdsi/sdsi.sh b/tools/testing/selftests/drivers/sdsi/sdsi.sh
new file mode 100755
index 000000000000..b938b1d46b04
--- /dev/null
+++ b/tools/testing/selftests/drivers/sdsi/sdsi.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Runs tests for the intel_sdsi driver
+
+if ! command -v python3 > /dev/null 2>&1; then
+	echo "drivers/sdsi: [SKIP] python3 not installed"
+	exit 77
+fi
+
+if ! python -c "import pytest" > /dev/null 2>&1; then
+	echo "drivers/sdsi: [SKIP] pytest module not installed"
+	exit 77
+fi
+
+if ! /sbin/modprobe -q -r intel_sdsi; then
+	echo "drivers/sdsi: [SKIP]"
+	exit 77
+fi
+
+if /sbin/modprobe -q intel_sdsi; then
+	python3 -m pytest sdsi_test.py
+	echo "drivers/sdsi: [OK]"
+else
+	echo "drivers/sdsi: [FAIL]"
+	exit 1
+fi
diff --git a/tools/testing/selftests/drivers/sdsi/sdsi_test.py b/tools/testing/selftests/drivers/sdsi/sdsi_test.py
new file mode 100644
index 000000000000..4922edfe461f
--- /dev/null
+++ b/tools/testing/selftests/drivers/sdsi/sdsi_test.py
@@ -0,0 +1,226 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from struct import pack
+from time import sleep
+
+import errno
+import glob
+import os
+import subprocess
+
+try:
+    import pytest
+except ImportError:
+    print("Unable to import pytest python module.")
+    print("\nIf not already installed, you may do so with:")
+    print("\t\tpip3 install pytest")
+    exit(1)
+
+SOCKETS = glob.glob('/sys/bus/auxiliary/devices/intel_vsec.sdsi.*')
+NUM_SOCKETS = len(SOCKETS)
+
+MODULE_NAME = 'sdsi'
+DEV_PREFIX = 'intel_vsec.sdsi'
+CLASS_DIR = '/sys/bus/auxiliary/devices'
+GUID = "0x6dd191"
+
+def read_bin_file(file):
+    with open(file, mode='rb') as f:
+        content = f.read()
+    return content
+
+def get_dev_file_path(socket, file):
+    return CLASS_DIR + '/' + DEV_PREFIX + '.' + str(socket) + '/' + file
+
+def kmemleak_enabled():
+    kmemleak = "/sys/kernel/debug/kmemleak"
+    return os.path.isfile(kmemleak)
+
+class TestSDSiDriver:
+    def test_driver_loaded(self):
+        lsmod_p = subprocess.Popen(('lsmod'), stdout=subprocess.PIPE)
+        result = subprocess.check_output(('grep', '-q', MODULE_NAME), stdin=lsmod_p.stdout)
+
+@pytest.mark.parametrize('socket', range(0, NUM_SOCKETS))
+class TestSDSiFilesClass:
+
+    def read_value(self, file):
+        f = open(file, "r")
+        value = f.read().strip("\n")
+        return value
+
+    def get_dev_folder(self, socket):
+        return CLASS_DIR + '/' + DEV_PREFIX + '.' + str(socket) + '/'
+
+    def test_sysfs_files_exist(self, socket):
+        folder = self.get_dev_folder(socket)
+        print (folder)
+        assert os.path.isfile(folder + "guid") == True
+        assert os.path.isfile(folder + "provision_akc") == True
+        assert os.path.isfile(folder + "provision_cap") == True
+        assert os.path.isfile(folder + "state_certificate") == True
+        assert os.path.isfile(folder + "registers") == True
+
+    def test_sysfs_file_permissions(self, socket):
+        folder = self.get_dev_folder(socket)
+        mode = os.stat(folder + "guid").st_mode & 0o777
+        assert mode == 0o444    # Read all
+        mode = os.stat(folder + "registers").st_mode & 0o777
+        assert mode == 0o400    # Read owner
+        mode = os.stat(folder + "provision_akc").st_mode & 0o777
+        assert mode == 0o200    # Read owner
+        mode = os.stat(folder + "provision_cap").st_mode & 0o777
+        assert mode == 0o200    # Read owner
+        mode = os.stat(folder + "state_certificate").st_mode & 0o777
+        assert mode == 0o400    # Read owner
+
+    def test_sysfs_file_ownership(self, socket):
+        folder = self.get_dev_folder(socket)
+
+        st = os.stat(folder + "guid")
+        assert st.st_uid == 0
+        assert st.st_gid == 0
+
+        st = os.stat(folder + "registers")
+        assert st.st_uid == 0
+        assert st.st_gid == 0
+
+        st = os.stat(folder + "provision_akc")
+        assert st.st_uid == 0
+        assert st.st_gid == 0
+
+        st = os.stat(folder + "provision_cap")
+        assert st.st_uid == 0
+        assert st.st_gid == 0
+
+        st = os.stat(folder + "state_certificate")
+        assert st.st_uid == 0
+        assert st.st_gid == 0
+
+    def test_sysfs_file_sizes(self, socket):
+        folder = self.get_dev_folder(socket)
+
+        if self.read_value(folder + "guid") == GUID:
+            st = os.stat(folder + "registers")
+            assert st.st_size == 72
+
+        st = os.stat(folder + "provision_akc")
+        assert st.st_size == 1024
+
+        st = os.stat(folder + "provision_cap")
+        assert st.st_size == 1024
+
+        st = os.stat(folder + "state_certificate")
+        assert st.st_size == 4096
+
+    def test_no_seek_allowed(self, socket):
+        folder = self.get_dev_folder(socket)
+        rand_file = bytes(os.urandom(8))
+
+        f = open(folder + "provision_cap", "wb", 0)
+        f.seek(1)
+        with pytest.raises(OSError) as error:
+            f.write(rand_file)
+        assert error.value.errno == errno.ESPIPE
+        f.close()
+
+        f = open(folder + "provision_akc", "wb", 0)
+        f.seek(1)
+        with pytest.raises(OSError) as error:
+            f.write(rand_file)
+        assert error.value.errno == errno.ESPIPE
+        f.close()
+
+    def test_registers_seek(self, socket):
+        folder = self.get_dev_folder(socket)
+
+        # Check that the value read from an offset of the entire
+        # file is none-zero and the same as the value read
+        # from seeking to the same location
+        f = open(folder + "registers", "rb")
+        data = f.read()
+        f.seek(64)
+        id = f.read()
+        assert id != bytes(0)
+        assert data[64:] == id
+        f.close()
+
+@pytest.mark.parametrize('socket', range(0, NUM_SOCKETS))
+class TestSDSiMailboxCmdsClass:
+    def test_provision_akc_eoverflow_1017_bytes(self, socket):
+
+        # The buffer for writes is 1k, of with 8 bytes must be
+        # reserved for the command, leaving 1016 bytes max.
+        # Check that we get an overflow error for 1017 bytes.
+        node = get_dev_file_path(socket, "provision_akc")
+        rand_file = bytes(os.urandom(1017))
+
+        f = open(node, 'wb', 0)
+        with pytest.raises(OSError) as error:
+            f.write(rand_file)
+        assert error.value.errno == errno.EOVERFLOW
+        f.close()
+
+@pytest.mark.parametrize('socket', range(0, NUM_SOCKETS))
+class TestSdsiDriverLocksClass:
+    def test_enodev_when_pci_device_removed(self, socket):
+        node = get_dev_file_path(socket, "provision_akc")
+        dev_name = DEV_PREFIX + '.' + str(socket)
+        driver_dir = CLASS_DIR + '/' + dev_name + "/driver/"
+        rand_file = bytes(os.urandom(8))
+
+        f = open(node, 'wb', 0)
+        g = open(node, 'wb', 0)
+
+        with open(driver_dir + 'unbind', 'w') as k:
+            print(dev_name, file = k)
+
+        with pytest.raises(OSError) as error:
+            f.write(rand_file)
+        assert error.value.errno == errno.ENODEV
+
+        with pytest.raises(OSError) as error:
+            g.write(rand_file)
+        assert error.value.errno == errno.ENODEV
+
+        f.close()
+        g.close()
+
+        # Short wait needed to allow file to close before pulling driver
+        sleep(1)
+
+        p = subprocess.Popen(('modprobe', '-r', 'intel_sdsi'))
+        p.wait()
+        p = subprocess.Popen(('modprobe', '-r', 'intel_vsec'))
+        p.wait()
+        p = subprocess.Popen(('modprobe', 'intel_vsec'))
+        p.wait()
+
+        # Short wait needed to allow driver time to get inserted
+        # before continuing tests
+        sleep(1)
+
+    def test_memory_leak(self, socket):
+        if not kmemleak_enabled:
+            pytest.skip("kmemleak not enabled in kernel")
+
+        dev_name = DEV_PREFIX + '.' + str(socket)
+        driver_dir = CLASS_DIR + '/' + dev_name + "/driver/"
+
+        with open(driver_dir + 'unbind', 'w') as k:
+            print(dev_name, file = k)
+
+        sleep(1)
+
+        subprocess.check_output(('modprobe', '-r', 'intel_sdsi'))
+        subprocess.check_output(('modprobe', '-r', 'intel_vsec'))
+
+        with open('/sys/kernel/debug/kmemleak', 'w') as f:
+            print('scan', file = f)
+        sleep(5)
+
+        assert os.stat('/sys/kernel/debug/kmemleak').st_size == 0
+
+        subprocess.check_output(('modprobe', 'intel_vsec'))
+        sleep(1)
-- 
2.25.1

