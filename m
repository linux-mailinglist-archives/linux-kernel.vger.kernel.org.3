Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7161E4B4E63
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244697AbiBNLaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:30:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351444AbiBNLaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:30:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A96825C53
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644837010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Rizj8YnqZQJVyJKo81V8QYZR39z9NkMLTYR4Tc1pW0=;
        b=epO+Bnecu2VULVf6eBqlx2PE+9w2AguUrC6ErHjk3D0baM4P651JDA7BAuKJUaz1Ydvhqd
        D4XK0uUwNzaQxISc1QS2GqrDwecXbOjaWRFEEBti/VuFJhnXC0M30YdsFAhCExMuh54Em2
        3kAm2iy4qLDdyo3vWCnMC7NGDKqAQQQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-KbX6fzHqNsC4fq5j3rTreQ-1; Mon, 14 Feb 2022 06:10:07 -0500
X-MC-Unique: KbX6fzHqNsC4fq5j3rTreQ-1
Received: by mail-ed1-f69.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so10037687edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/Rizj8YnqZQJVyJKo81V8QYZR39z9NkMLTYR4Tc1pW0=;
        b=jF9Ly6MZgZ8fup6BMfwygi+8xirKj6I7HVpqDC2NM9OVMpoHogK9UNRG15M8K4Gbi8
         /NkOwCSbgj1n1AnIrUi7g/ucR7aUucIVfCYk5xyl3hDhj0UVhZq2ge6pTgxmF2MfFBNT
         0VV4CzSwvu1ZLy9Q1qlBUG3O35BjjEhLLbZ7p7+3hr4e3grd8V5Yx3sciDPggKd1fmcL
         inge+IWO7LNmOQxSOjTGBkm8MfrtUtYTtKkgx6o+9nsOScehdsKnqgOee9DUWbbEEkp/
         /vM0c0ov4pb3SCuoccG7Am2jNMvKiIK7tjEUWMLqkhUAJCwWzfWbtxurUQm/C2eka91w
         Jp4g==
X-Gm-Message-State: AOAM533hdm1pjZ82cI73iCNgFNpTWG80J0a9iZ4v/8Q1ydTR19vALTv7
        2oMIylDs3QTqQMoowZMhSCGdmq6MdRrvvypzjX7D3d6VFMzpKDD/hazOj3fHBUXXF/1zZMy7+4N
        q9PNs6eQtSTT40D/wYJmMzn8u
X-Received: by 2002:a17:907:6283:: with SMTP id nd3mr11000849ejc.2.1644837006266;
        Mon, 14 Feb 2022 03:10:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzn/b9jDxWKh+XTffTqJoZwvUs+V+VKPf4cH3b5eQDEDymHFXJl7LquA525Qwqk+v1shhC7eQ==
X-Received: by 2002:a17:907:6283:: with SMTP id nd3mr11000831ejc.2.1644837005994;
        Mon, 14 Feb 2022 03:10:05 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id b7sm1636601ejl.145.2022.02.14.03.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 03:10:05 -0800 (PST)
Message-ID: <b431a81f-a2c0-cdc5-208b-7e8adb03cf23@redhat.com>
Date:   Mon, 14 Feb 2022 12:10:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V7 3/3] selftests: sdsi: test sysfs setup
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20220212013252.1293396-1-david.e.box@linux.intel.com>
 <20220212013252.1293396-4-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220212013252.1293396-4-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/12/22 02:32, David E. Box wrote:
> Tests file configuration and error handling of the Intel Software
> Defined Silicon sysfs ABI.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V7
>   - No changes.
> V6
>   - No changes.
> V5
>   - No changes.
> V4
>   - No changes.
> V3
>   - Add tests to check PCI device removal handling and to check for
>     driver memory leaks.
> V2
>   - New patch.
> 
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/drivers/sdsi/sdsi.sh  |  18 ++
>  .../selftests/drivers/sdsi/sdsi_test.py       | 226 ++++++++++++++++++
>  3 files changed, 245 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/sdsi/sdsi.sh
>  create mode 100644 tools/testing/selftests/drivers/sdsi/sdsi_test.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 80325cbde3bd..a05c6b40601a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9874,6 +9874,7 @@ M:	David E. Box <david.e.box@linux.intel.com>
>  S:	Supported
>  F:	drivers/platform/x86/intel/sdsi.c
>  F:	tools/arch/x86/intel_sdsi/
> +F:	tools/testing/selftests/drivers/sdsi/
>  
>  INTEL SKYLAKE INT3472 ACPI DEVICE DRIVER
>  M:	Daniel Scally <djrscally@gmail.com>
> diff --git a/tools/testing/selftests/drivers/sdsi/sdsi.sh b/tools/testing/selftests/drivers/sdsi/sdsi.sh
> new file mode 100755
> index 000000000000..8db71961d164
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/sdsi/sdsi.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Runs tests for the intel_sdsi driver
> +
> +if ! /sbin/modprobe -q -r intel_sdsi; then
> +	echo "drivers/sdsi: [SKIP]"
> +	exit 77
> +fi

You should also test that python3 and pytest are available and if not then
also skip this test.

> +
> +if /sbin/modprobe -q intel_sdsi; then
> +	python3 -m pytest sdsi_test.py

You are ignoring the return value of the python script here, you probably want something like
this instead:

if /sbin/modprobe -q intel_sdsi && python3 -m pytest sdsi_test.py; then




> +	/sbin/modprobe -q -r intel_sdsi

Why? now you are leaving the system behind in a different state then it was before?

Regards,

Hans


> +
> +	echo "drivers/sdsi: ok"
> +else
> +	echo "drivers/sdsi: [FAIL]"
> +	exit 1
> +fi
> diff --git a/tools/testing/selftests/drivers/sdsi/sdsi_test.py b/tools/testing/selftests/drivers/sdsi/sdsi_test.py
> new file mode 100644
> index 000000000000..4922edfe461f
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/sdsi/sdsi_test.py
> @@ -0,0 +1,226 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from struct import pack
> +from time import sleep
> +
> +import errno
> +import glob
> +import os
> +import subprocess
> +
> +try:
> +    import pytest
> +except ImportError:
> +    print("Unable to import pytest python module.")
> +    print("\nIf not already installed, you may do so with:")
> +    print("\t\tpip3 install pytest")
> +    exit(1)
> +
> +SOCKETS = glob.glob('/sys/bus/auxiliary/devices/intel_vsec.sdsi.*')
> +NUM_SOCKETS = len(SOCKETS)
> +
> +MODULE_NAME = 'sdsi'
> +DEV_PREFIX = 'intel_vsec.sdsi'
> +CLASS_DIR = '/sys/bus/auxiliary/devices'
> +GUID = "0x6dd191"
> +
> +def read_bin_file(file):
> +    with open(file, mode='rb') as f:
> +        content = f.read()
> +    return content
> +
> +def get_dev_file_path(socket, file):
> +    return CLASS_DIR + '/' + DEV_PREFIX + '.' + str(socket) + '/' + file
> +
> +def kmemleak_enabled():
> +    kmemleak = "/sys/kernel/debug/kmemleak"
> +    return os.path.isfile(kmemleak)
> +
> +class TestSDSiDriver:
> +    def test_driver_loaded(self):
> +        lsmod_p = subprocess.Popen(('lsmod'), stdout=subprocess.PIPE)
> +        result = subprocess.check_output(('grep', '-q', MODULE_NAME), stdin=lsmod_p.stdout)
> +
> +@pytest.mark.parametrize('socket', range(0, NUM_SOCKETS))
> +class TestSDSiFilesClass:
> +
> +    def read_value(self, file):
> +        f = open(file, "r")
> +        value = f.read().strip("\n")
> +        return value
> +
> +    def get_dev_folder(self, socket):
> +        return CLASS_DIR + '/' + DEV_PREFIX + '.' + str(socket) + '/'
> +
> +    def test_sysfs_files_exist(self, socket):
> +        folder = self.get_dev_folder(socket)
> +        print (folder)
> +        assert os.path.isfile(folder + "guid") == True
> +        assert os.path.isfile(folder + "provision_akc") == True
> +        assert os.path.isfile(folder + "provision_cap") == True
> +        assert os.path.isfile(folder + "state_certificate") == True
> +        assert os.path.isfile(folder + "registers") == True
> +
> +    def test_sysfs_file_permissions(self, socket):
> +        folder = self.get_dev_folder(socket)
> +        mode = os.stat(folder + "guid").st_mode & 0o777
> +        assert mode == 0o444    # Read all
> +        mode = os.stat(folder + "registers").st_mode & 0o777
> +        assert mode == 0o400    # Read owner
> +        mode = os.stat(folder + "provision_akc").st_mode & 0o777
> +        assert mode == 0o200    # Read owner
> +        mode = os.stat(folder + "provision_cap").st_mode & 0o777
> +        assert mode == 0o200    # Read owner
> +        mode = os.stat(folder + "state_certificate").st_mode & 0o777
> +        assert mode == 0o400    # Read owner
> +
> +    def test_sysfs_file_ownership(self, socket):
> +        folder = self.get_dev_folder(socket)
> +
> +        st = os.stat(folder + "guid")
> +        assert st.st_uid == 0
> +        assert st.st_gid == 0
> +
> +        st = os.stat(folder + "registers")
> +        assert st.st_uid == 0
> +        assert st.st_gid == 0
> +
> +        st = os.stat(folder + "provision_akc")
> +        assert st.st_uid == 0
> +        assert st.st_gid == 0
> +
> +        st = os.stat(folder + "provision_cap")
> +        assert st.st_uid == 0
> +        assert st.st_gid == 0
> +
> +        st = os.stat(folder + "state_certificate")
> +        assert st.st_uid == 0
> +        assert st.st_gid == 0
> +
> +    def test_sysfs_file_sizes(self, socket):
> +        folder = self.get_dev_folder(socket)
> +
> +        if self.read_value(folder + "guid") == GUID:
> +            st = os.stat(folder + "registers")
> +            assert st.st_size == 72
> +
> +        st = os.stat(folder + "provision_akc")
> +        assert st.st_size == 1024
> +
> +        st = os.stat(folder + "provision_cap")
> +        assert st.st_size == 1024
> +
> +        st = os.stat(folder + "state_certificate")
> +        assert st.st_size == 4096
> +
> +    def test_no_seek_allowed(self, socket):
> +        folder = self.get_dev_folder(socket)
> +        rand_file = bytes(os.urandom(8))
> +
> +        f = open(folder + "provision_cap", "wb", 0)
> +        f.seek(1)
> +        with pytest.raises(OSError) as error:
> +            f.write(rand_file)
> +        assert error.value.errno == errno.ESPIPE
> +        f.close()
> +
> +        f = open(folder + "provision_akc", "wb", 0)
> +        f.seek(1)
> +        with pytest.raises(OSError) as error:
> +            f.write(rand_file)
> +        assert error.value.errno == errno.ESPIPE
> +        f.close()
> +
> +    def test_registers_seek(self, socket):
> +        folder = self.get_dev_folder(socket)
> +
> +        # Check that the value read from an offset of the entire
> +        # file is none-zero and the same as the value read
> +        # from seeking to the same location
> +        f = open(folder + "registers", "rb")
> +        data = f.read()
> +        f.seek(64)
> +        id = f.read()
> +        assert id != bytes(0)
> +        assert data[64:] == id
> +        f.close()
> +
> +@pytest.mark.parametrize('socket', range(0, NUM_SOCKETS))
> +class TestSDSiMailboxCmdsClass:
> +    def test_provision_akc_eoverflow_1017_bytes(self, socket):
> +
> +        # The buffer for writes is 1k, of with 8 bytes must be
> +        # reserved for the command, leaving 1016 bytes max.
> +        # Check that we get an overflow error for 1017 bytes.
> +        node = get_dev_file_path(socket, "provision_akc")
> +        rand_file = bytes(os.urandom(1017))
> +
> +        f = open(node, 'wb', 0)
> +        with pytest.raises(OSError) as error:
> +            f.write(rand_file)
> +        assert error.value.errno == errno.EOVERFLOW
> +        f.close()
> +
> +@pytest.mark.parametrize('socket', range(0, NUM_SOCKETS))
> +class TestSdsiDriverLocksClass:
> +    def test_enodev_when_pci_device_removed(self, socket):
> +        node = get_dev_file_path(socket, "provision_akc")
> +        dev_name = DEV_PREFIX + '.' + str(socket)
> +        driver_dir = CLASS_DIR + '/' + dev_name + "/driver/"
> +        rand_file = bytes(os.urandom(8))
> +
> +        f = open(node, 'wb', 0)
> +        g = open(node, 'wb', 0)
> +
> +        with open(driver_dir + 'unbind', 'w') as k:
> +            print(dev_name, file = k)
> +
> +        with pytest.raises(OSError) as error:
> +            f.write(rand_file)
> +        assert error.value.errno == errno.ENODEV
> +
> +        with pytest.raises(OSError) as error:
> +            g.write(rand_file)
> +        assert error.value.errno == errno.ENODEV
> +
> +        f.close()
> +        g.close()
> +
> +        # Short wait needed to allow file to close before pulling driver
> +        sleep(1)
> +
> +        p = subprocess.Popen(('modprobe', '-r', 'intel_sdsi'))
> +        p.wait()
> +        p = subprocess.Popen(('modprobe', '-r', 'intel_vsec'))
> +        p.wait()
> +        p = subprocess.Popen(('modprobe', 'intel_vsec'))
> +        p.wait()
> +
> +        # Short wait needed to allow driver time to get inserted
> +        # before continuing tests
> +        sleep(1)
> +
> +    def test_memory_leak(self, socket):
> +        if not kmemleak_enabled:
> +            pytest.skip("kmemleak not enabled in kernel")
> +
> +        dev_name = DEV_PREFIX + '.' + str(socket)
> +        driver_dir = CLASS_DIR + '/' + dev_name + "/driver/"
> +
> +        with open(driver_dir + 'unbind', 'w') as k:
> +            print(dev_name, file = k)
> +
> +        sleep(1)
> +
> +        subprocess.check_output(('modprobe', '-r', 'intel_sdsi'))
> +        subprocess.check_output(('modprobe', '-r', 'intel_vsec'))
> +
> +        with open('/sys/kernel/debug/kmemleak', 'w') as f:
> +            print('scan', file = f)
> +        sleep(5)
> +
> +        assert os.stat('/sys/kernel/debug/kmemleak').st_size == 0
> +
> +        subprocess.check_output(('modprobe', 'intel_vsec'))
> +        sleep(1)

