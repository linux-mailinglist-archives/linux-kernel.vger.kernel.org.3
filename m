Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A324BFB52
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiBVO5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiBVO5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:57:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DA1810CF28
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645541823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N7YY5z46d/Qt4RuUWB/43lOJycGj9nuwbhsZsylUFMM=;
        b=CQoxBgN22n2ramAQPNhkTxY01AC3V1e1NgKsJplPdgcl8FxM7XPdf+MNqTxtbdG9dJrE+H
        XFkHGwk5l17pgwjhoNA/KOr8QbWKE2dSMh4UvI+3DhM+sdP0cbcKboPkiu19qS4b3o/H49
        ICq/r72E3Te5UBHdPnRWVjG5pcu0KvI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-xg7OmaesMnCr_8Kq5ycCtA-1; Tue, 22 Feb 2022 09:57:01 -0500
X-MC-Unique: xg7OmaesMnCr_8Kq5ycCtA-1
Received: by mail-ej1-f69.google.com with SMTP id sa22-20020a1709076d1600b006ce78cacb85so5893766ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N7YY5z46d/Qt4RuUWB/43lOJycGj9nuwbhsZsylUFMM=;
        b=XIe5itRI3R/0m554dNIyem8mghyIQp4+939/9PwqZW3ejfvTr2g0yJXI5GIdJww+Hm
         0czUuoT3/qQgYAIafgRRyAgiuNOP9GzjpHq/u1HwFO5pUMwC5zEhRyngikTaTCm0Juuh
         bw+jW8obBMYOJW1LmxxNmo7AplmVKDh0EQR3V0WFrf/dilx3BhOjd6WOgwfqV7hm5Nw+
         G81rVRspTRkeCtqu5cGzA8pQvH5JWh2mrSbFrp+fG64HW2LrUB9qA401Y1/o10/xbF4w
         xec2wGoBcOUQ1kqH80yfgHPRRc/HO4Vrb+tjPGy07ZLOV3u08JCTZ69dhUtS749lgkkI
         Y79g==
X-Gm-Message-State: AOAM532i1jcMHvOvmh8/6mJyFaxuPdl97BCT/IpMESTxKczJaQIH0c2l
        aNtMG3Sx0+torXVqiEl3uqcmm7wzHrGb1ZtBgACzQuR8ao/3TTwL66fa13SIkBpLfvB51VlQVxL
        mF1b8dcxDTkm/xnNqP/lSNF4v
X-Received: by 2002:a17:906:716:b0:6ce:72c6:8e18 with SMTP id y22-20020a170906071600b006ce72c68e18mr19346572ejb.117.1645541819966;
        Tue, 22 Feb 2022 06:56:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLw2m+EmShyJ1bO3r3YAPDpXhJ/gP5Sd4lOUduNeezVUuTIbSRQxIan3Bv3R6Iy61i3SmhsA==
X-Received: by 2002:a17:906:716:b0:6ce:72c6:8e18 with SMTP id y22-20020a170906071600b006ce72c68e18mr19346564ejb.117.1645541819738;
        Tue, 22 Feb 2022 06:56:59 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id 24sm6366589ejb.150.2022.02.22.06.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 06:56:59 -0800 (PST)
Message-ID: <82d99977-6bd9-280a-8165-0f082ebaccce@redhat.com>
Date:   Tue, 22 Feb 2022 15:56:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V8 2/2] selftests: sdsi: test sysfs setup
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20220217230958.259360-1-david.e.box@linux.intel.com>
 <20220217230958.259360-2-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220217230958.259360-2-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2/18/22 00:09, David E. Box wrote:
> Tests file configuration and error handling of the Intel Software
> Defined Silicon sysfs ABI.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> Applied on review-hans branch.
> 
> V8
>   - Skip if python3 or pytest aren't installed
>   - Do not remove driver after test is run
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
>  tools/testing/selftests/drivers/sdsi/sdsi.sh  |  26 ++
>  .../selftests/drivers/sdsi/sdsi_test.py       | 226 ++++++++++++++++++
>  3 files changed, 253 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/sdsi/sdsi.sh
>  create mode 100644 tools/testing/selftests/drivers/sdsi/sdsi_test.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dc3c9f271463..be2c4c63e58f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9872,6 +9872,7 @@ M:	David E. Box <david.e.box@linux.intel.com>
>  S:	Supported
>  F:	drivers/platform/x86/intel/sdsi.c
>  F:	tools/arch/x86/intel_sdsi/
> +F:	tools/testing/selftests/drivers/sdsi/
>  
>  INTEL SKYLAKE INT3472 ACPI DEVICE DRIVER
>  M:	Daniel Scally <djrscally@gmail.com>
> diff --git a/tools/testing/selftests/drivers/sdsi/sdsi.sh b/tools/testing/selftests/drivers/sdsi/sdsi.sh
> new file mode 100755
> index 000000000000..b938b1d46b04
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/sdsi/sdsi.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Runs tests for the intel_sdsi driver
> +
> +if ! command -v python3 > /dev/null 2>&1; then
> +	echo "drivers/sdsi: [SKIP] python3 not installed"
> +	exit 77
> +fi
> +
> +if ! python -c "import pytest" > /dev/null 2>&1; then
> +	echo "drivers/sdsi: [SKIP] pytest module not installed"
> +	exit 77
> +fi
> +
> +if ! /sbin/modprobe -q -r intel_sdsi; then
> +	echo "drivers/sdsi: [SKIP]"
> +	exit 77
> +fi
> +
> +if /sbin/modprobe -q intel_sdsi; then
> +	python3 -m pytest sdsi_test.py
> +	echo "drivers/sdsi: [OK]"

You will now echo "[OK]" and exit with 0 independent of
the results of the pytest invocation, please change this to:

if /sbin/modprobe -q intel_sdsi && python3 -m pytest sdsi_test.py; then
	echo "drivers/sdsi: [OK]"
else
	echo "drivers/sdsi: [FAIL]"
	exit 1
fi

So that errors of the pytest will result in the test failing.

Regards,

Hans



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

