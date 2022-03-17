Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDF64DBCCC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348001AbiCQCES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiCQCEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:04:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA7F642F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647482579; x=1679018579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ygj5CHEtZP4OZbDg8L2b07ms+ZfgJHLplt5OQT4RsaY=;
  b=ZmJzyusO90B2omTWg43kq8St75VVvHgCrseL8Af5uCmVk/6SI4Y5TIn0
   yeEkIU0moqtgCbio0p7/TW6lNKd8OyItVI+DgSYRrn5V8bkltDvWVmlLD
   83sbrsu+YohW8J39xC5VwrcupdFz75/kjSvw8YfiPXq/tf9Ro2C6sIMCZ
   mY21ZmE6zosxg2iOcFuj5kuQmZLMc5xyDCUC9/wU4oMSczp3NsjT257UU
   anCi6GDw/1K5YdUBU022Dv7ot2Nj/kClv6ojVgQaQO9pDVXetMiltOLrv
   QpFk1956a2KH6ktAGLTmJ2tzWVuprISLIaw1Rop1c9OYFscrMhwM90Rk8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256488734"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="256488734"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 19:02:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516582832"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2022 19:02:56 -0700
Date:   Thu, 17 Mar 2022 09:55:56 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [PATCH v1 0/8] Extend FW framework for user FW uploads
Message-ID: <20220317015556.GA133444@yilunxu-OptiPlex-7050>
References: <20220308214932.24477-1-russell.h.weight@intel.com>
 <20220316033206.GA123354@yilunxu-OptiPlex-7050>
 <3840315e-9f78-91a4-cdcd-9bd103c1d144@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3840315e-9f78-91a4-cdcd-9bd103c1d144@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 10:39:39AM -0700, Russ Weight wrote:
> 
> 
> On 3/15/22 20:32, Xu Yilun wrote:
> > On Tue, Mar 08, 2022 at 01:49:24PM -0800, Russ Weight wrote:
> >> Extend the firmware loader subsystem to support a persistent sysfs
> >> interface that userspace may use to initiate a firmware update. For
> >> example, FPGA based PCIe cards automatically load firmware and FPGA images
> >> from local FLASH when the card boots. The images in FLASH may be updated
> >> with new images that are uploaded by the user.
> >>
> >> A device driver may call firmware_upload_register() to expose persistent
> >> "loading" and "data" sysfs files at /sys/class/firmare/<NAME>/*. These
> >> files are used in the same way as the fallback sysfs "loading" and "data"
> >> files. However, when 0 is written to "loading" to complete the write of
> >> firmware data, the data is also transferred to the lower-level driver
> >> using pre-registered call-back functions. The data transfer is done in
> >> the context of a kernel worker thread.
> >>
> >> Additional sysfs nodes are added in the same location as "loading" and
> >> "data" to monitor the transfer of the image data to the device using
> >> callback functions provided by the lower-level device driver and to allow
> >> the data transfer to be cancelled.
> >>
> >> Example usage:
> >>
> >> $ pwd
> >> /sys/class/firmware/n3000bmc-sec-update.8
> > I'm good with the firmware update API, but have concern about the
> > example.
> >
> > The n3000 bmc secure update engine is the sub device on N3000 PCIe based
> > FPGA card, it could be a data xfer engine which helps to update the
> > firmware of the N3000. The N3000 PCI driver knows how the firmware
> > uploading affects the card.
> >
> > So maybe the N3000 PCI driver should register the firmware upload. But
> > of course it could interact with the n3000bmc-sec-update driver for
> > specific firmware upload ops.
> Until now, these interfaces (for the firmware-loader) have been created
> (i.e. registered) at a granularity of one interface per firmware file (e.g.
> /sys/class/firmware/my-firmware-file.bin/). For secure updates, the files
> are self describing, so a single interface is sufficient for various
> payloads. It sounds like you are suggesting a coarser granularity that
> would allow other firmware files (separate from the secure update driver)
> to share a single interface for a PCI card?

The granularity is specific to the HW. If we could independently update
firmware for one sub device and not impact the other component on the card,
an interface could be registered by the sub device driver. If there is a
firmware updating that impacts the whole card, an interface could be
registered by the parent card driver. Alternatively, we could have a single
interface for parent card which serves all different types of updates
inside the card, the parent card driver handles each update request
internally.

My main concern is we should be clear about the scope of the update,
then find the right device driver to create the interface. To avoid that
the device is impacted by an update but its driver is unaware of it.

I think registering the firmware update interface in a data transfer engine
driver is general not a good idea. The update is not to change the data
transfer engine itself.

Thanks,
Yilun

> 
> - Russ
> >
> > Thanks,
> > Yilun
> >
> >> $ ls
> >> cancel  device  loading  remaining_size  subsystem
> >> data    error   power    status          uevent
> >> $ echo 1 > loading
> >> $ cat /tmp/firmware.bin > data
> >> $ echo 0 > loading
> >> $ while :; do cat status; cat remaining_size ; sleep 3; done
> >> preparing
> >> 44590080
> >> <--snip-->
> >> transferring
> >> 44459008
> >> transferring
> >> 44311552
> >> <--snip-->
> >> transferring
> >> 173056
> >> <--snip-->
> >> programming
> >> 0
> >> <--snip-->
> >> idle
> >> 0
> >> ^C
> >> $ cat error
> >>
> >> The first two patches in this set make minor changes to enable the
> >> fw_priv data structure and the sysfs interfaces to be used multiple times
> >> during the existence of the device driver instance. The third patch is
> >> mostly a reorganization of existing code in preparation for sharing common
> >> code with the firmware-upload support. The fourth and fifth patches provide
> >> the code for user-initiated firmware uploads. The final 3 patches extend
> >> selftest support to test firmware-upload functionality.
> >>
> >>
> >> Changelog RFC -> v1:
> >>   - Renamed files fw_sysfs.c and fw_sysfs.h to sysfs.c and sysfs.h
> >>   - Moved "MODULE_IMPORT_NS(FIRMWARE_LOADER_PRIVATE);" from sysfs.c to
> >>     sysfs.h to address an error identified by the kernel test robot
> >>     <lkp@intel.com>
> >>   - renamed fw_upload_register() and fw_upload_unregister() to
> >>     firmware_upload_register() and fw_upload_unregister().
> >>   - Moved ifdef'd section of code out of firmware_loading_store() in sysfs.c
> >>     into a new function, fw_upload_start(), in sysfs_upload.c.
> >>   - Changed #defines to enums for error codes and progress states
> >>   - Added additional kernel-doc supported symbols into the documentation.
> >>     Some rewording in documentation as well.
> >>   - Added module reference counting for the parent module in the
> >>     firmware_upload_register() and firmware_upload_unregister() functions
> >>     to fix problems found when testing with test_firmware module.
> >>   - Removed unnecessary module reference counting for THIS_MODULE.
> >>   - Added a new patch to modify the test_firmware module to support
> >>     testing of the firmware upload mechanism.
> >>   - Added a new patch to modify the test_firmware module to support
> >>     error injection for firmware upload.
> >>   - Added a new patch to extend the existing firmware selftests to cover
> >>     firmware upload.
> >>
> >> Russ Weight (8):
> >>   firmware_loader: Clear data and size in fw_free_paged_buf
> >>   firmware_loader: Check fw_state_is_done in loading_store
> >>   firmware_loader: Split sysfs support from fallback
> >>   firmware_loader: Add firmware-upload support
> >>   firmware_loader: Add sysfs nodes to monitor fw_upload
> >>   test_firmware: Add test support for firmware upload
> >>   test_firmware: Error injection for firmware upload
> >>   selftests: firmware: Add firmware upload selftests
> >>
> >>  .../ABI/testing/sysfs-class-firmware          |  77 ++++
> >>  .../driver-api/firmware/fw_upload.rst         | 117 +++++
> >>  Documentation/driver-api/firmware/index.rst   |   1 +
> >>  drivers/base/firmware_loader/Kconfig          |  18 +
> >>  drivers/base/firmware_loader/Makefile         |   2 +
> >>  drivers/base/firmware_loader/fallback.c       | 430 -----------------
> >>  drivers/base/firmware_loader/fallback.h       |  46 +-
> >>  drivers/base/firmware_loader/firmware.h       |  11 +
> >>  drivers/base/firmware_loader/main.c           |  18 +-
> >>  drivers/base/firmware_loader/sysfs.c          | 435 ++++++++++++++++++
> >>  drivers/base/firmware_loader/sysfs.h          | 100 ++++
> >>  drivers/base/firmware_loader/sysfs_upload.c   | 396 ++++++++++++++++
> >>  drivers/base/firmware_loader/sysfs_upload.h   |  47 ++
> >>  include/linux/firmware.h                      |  82 ++++
> >>  lib/test_firmware.c                           | 378 +++++++++++++++
> >>  tools/testing/selftests/firmware/Makefile     |   2 +-
> >>  tools/testing/selftests/firmware/config       |   1 +
> >>  tools/testing/selftests/firmware/fw_lib.sh    |   7 +
> >>  .../selftests/firmware/fw_run_tests.sh        |   4 +
> >>  tools/testing/selftests/firmware/fw_upload.sh | 214 +++++++++
> >>  20 files changed, 1900 insertions(+), 486 deletions(-)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-class-firmware
> >>  create mode 100644 Documentation/driver-api/firmware/fw_upload.rst
> >>  create mode 100644 drivers/base/firmware_loader/sysfs.c
> >>  create mode 100644 drivers/base/firmware_loader/sysfs.h
> >>  create mode 100644 drivers/base/firmware_loader/sysfs_upload.c
> >>  create mode 100644 drivers/base/firmware_loader/sysfs_upload.h
> >>  create mode 100755 tools/testing/selftests/firmware/fw_upload.sh
> >>
> >> -- 
> >> 2.25.1
