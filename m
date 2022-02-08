Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513C34ACDE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345597AbiBHBLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344274AbiBHAys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:54:48 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9084DC0612A4;
        Mon,  7 Feb 2022 16:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281687; x=1675817687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Poa9fhXkN9WmqKneGUj4w2DXt5zrSfRnkqADPaoYJqw=;
  b=SPsXn7AOEdoK+CB4ZMDWrCmDgaX//Yos/9MY4oVPQhrLS/qBB49PoVs9
   g86hYmrnx6H2COxHlYNTsd0Hvdxrxpy8Ul44WJed8yPzId7i3wYAvZ3EM
   XLFzKzQ6jTgaxhr2y1yNul7SzCFibUmNJ+1zmJ2jhgt9iIneyRIQTJY3q
   2JZ5YsSYiuTtm12C+QoGcpo/P58ESImmFnbyuBv42Ribzkz2PLCHsuRTB
   1yxHgfXz2VcAUOOv34fIN7EIMtNATigpmCs8cftVwOFivpYqObUsHYpEC
   JNsCLsg+mrhMzpCLLTLtjRMTopHTCoiFdu2oJ43lSp1M/26BzWAmPDZre
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248791229"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="248791229"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:54:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="567673641"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2022 16:54:47 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.183.65])
        by linux.intel.com (Postfix) with ESMTP id 16B5A580C35;
        Mon,  7 Feb 2022 16:54:47 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, david.e.box@linux.intel.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH V6 3/3] selftests: sdsi: test sysfs setup
Date:   Mon,  7 Feb 2022 16:54:44 -0800
Message-Id: <20220208005444.487209-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208005444.487209-1-david.e.box@linux.intel.com>
References: <20220208005444.487209-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tests file configuration and error handling of the Intel Software
Defined Silicon sysfs ABI.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
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
 tools/testing/selftests/drivers/sdsi/sdsi.sh  |  18 ++
 .../selftests/drivers/sdsi/sdsi_test.py       | 226 ++++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/sdsi/sdsi.sh
 create mode 100644 tools/testing/selftests/drivers/sdsi/sdsi_test.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 80325cbde3bd..a05c6b40601a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9874,6 +9874,7 @@ M:	David E. Box <david.e.box@linux.intel.com>
 S:	Supported
 F:	drivers/platform/x86/intel/sdsi.c
 F:	tools/arch/x86/intel_sdsi/
+F:	tools/testing/selftests/drivers/sdsi/
 
 INTEL SKYLAKE INT3472 ACPI DEVICE DRIVER
 M:	Daniel Scally <djrscally@gmail.com>
diff --git a/tools/testing/selftests/drivers/sdsi/sdsi.sh b/tools/testing/selftests/drivers/sdsi/sdsi.sh
new file mode 100755
index 000000000000..8db71961d164
--- /dev/null
+++ b/tools/testing/selftests/drivers/sdsi/sdsi.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Runs tests for the intel_sdsi driver
+
+if ! /sbin/modprobe -q -r intel_sdsi; then
+	echo "drivers/sdsi: [SKIP]"
+	exit 77
+fi
+
+if /sbin/modprobe -q intel_sdsi; then
+	python3 -m pytest sdsi_test.py
+	/sbin/modprobe -q -r intel_sdsi
+
+	echo "drivers/sdsi: ok"
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

