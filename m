Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E757451FD45
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiEIMuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiEIMue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461DC14A255;
        Mon,  9 May 2022 05:46:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BADAC61456;
        Mon,  9 May 2022 12:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEB8C385A8;
        Mon,  9 May 2022 12:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652100398;
        bh=ihjeT2JhaTx+dp2Ux5u1rCCufDClsce+lqR/zaKnHfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZ9PVltV8W69NgJ0Hgxi8gm4UlIpmVz4e7GsBm/FLbwHaIFxJOSCHH7KM5/YaxN1A
         3fE/Syj6unUkbqOXz8D39PDCezX+8J3QAIUsx5SCJEpdvkM7wElw8tNkRiT6JFx7P7
         rTslm3faZhs+DRWNG85H2mt1paIZQqeixzlH0648=
Date:   Mon, 9 May 2022 14:46:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v10] platform/chrome: Add ChromeOS ACPI device driver
Message-ID: <YnkNKqu1GT6BlbRp@kroah.com>
References: <Ynj8lA+bpTR1x2hJ@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynj8lA+bpTR1x2hJ@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 04:35:48PM +0500, Muhammad Usama Anjum wrote:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> The x86 Chromebooks have the ChromeOS ACPI device. This driver attaches
> to the ChromeOS ACPI device and exports the values reported by ACPI in a
> sysfs directory. This data isn't present in ACPI tables when read
> through ACPI tools, hence a driver is needed to do it. The driver gets
> data from firmware using the ACPI component of the kernel. The ACPI values
> are presented in string form (numbers as decimal values) or binary
> blobs, and can be accessed as the contents of the appropriate read only
> files in the standard ACPI device's sysfs directory tree. This data is
> consumed by the ChromeOS user space.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Co-developed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> The driver's implementation has been changed completely after Greg's
> comment. I've updated the authorship of the module to myself. Enric,
> Please let me know if yuo are comfortable with this.
> 
> Changes in v10:
> - Remove COMPILE_TEST as driver depends on ACPI component which isn't
>   enabled by COMPILE_TEST itself.
> - Fix build warnings
> 
> Changes in v9:
> - Changed the implementation completely
> - Move the driver to drivers/platform/chrome
> - Remove Acked-by Rafael as driver has changed
> - Corrected some typos
> - Changed the author of the module
> 
> Changes in v8:
> - Change struct platform_driver name from chromeos_acpi_driver to
>   chromeos_acpi_device_driver
> 
> Changes in v7:
> - Rename acpi_chromeos Kconfig option to chromeos_acpi
> - Change this acpi driver to platform driver
> - Minor cosmetic changes
> 
> There were the following concerns on v4 which have been delt with in
> v5/v6:
> - Remove BINF.{0,1,4} from sysfs as they are reserved and not used
>   anymore
> - Reword the description of MECK
> - Change function name from chromeos_acpi_alloc_name() to
>   chromeos_acpi_gen_file_name()
> - Remove local variable obj in chromeos_acpi_add_method()
> - Replace usage of dev_info() to dev_dbg()
> - Improve the description of the patch
> - Add the firmware interface document which serves as primary
>   documentation and garantees that this interface will not change
> - GGL0001 is valid PNP ID of the Google. PNP ID can be used with the
>   ACPI devices. Consensus was developed on it in discussion of v4.
> 
> Changes in v6:
> - Correct authorship and path email's From
> - Add changelog between v4 and v5 in detail
> - Add copywrite year 2022
> - Improve the description and add concerns from V4 which have been fixed
> 
> Changes in v5:
> - Improve the description of the patch
> - Document firmware interface
> - Update sysfs interface documentation
> - Remove binf{0,1,4} as they have been deprecated
> - Update some cleanup logic in case of error
>   - Remove freeing of chromeos_acpi.root explicitely in
>     chromeos_acpi_device_remove() as it'll be automatically freed by
>     chromeos_acpi_remove_groups()
>   - If sysfs_create_groups() fails in chromeos_acpi_process_mlst(),
>     cleanup all groups
> - Cosmetic changes
> 
> Changes in v4:
> https://lore.kernel.org/lkml/20200413134611.478441-1-enric.balletbo@collabora.com/t/
> - Add COMPILE_TEST to increase build coverage.
> - Add sysfs ABI documentation.
> - Rebased on top of 5.7-rc1 and solve conflicts.
> - Cc ACPI maintainers.
> 
> Changes in v3:
> - Use attribute groups instead of adding files "by hand".
> - Do not use "raw" kobject to create directories.
> - Do not abuse of the platform_device interface. Remove it.
> 
> Changes in v2:
> - Note that this version is a total rework, with those major changes:
> - Use lists to track dinamically allocated attributes and groups.
> - Use sysfs binary attributes to store the ACPI contents.
> - Remove all the functionalities except the one that creates the sysfs files.
> ---
>  .../ABI/testing/sysfs-driver-chromeos-acpi    | 126 ++++++
>  .../acpi/chromeos-acpi-device.rst             | 363 ++++++++++++++++++
>  Documentation/firmware-guide/acpi/index.rst   |   1 +
>  drivers/platform/chrome/Kconfig               |  11 +
>  drivers/platform/chrome/Makefile              |   1 +
>  drivers/platform/chrome/chromeos_acpi.c       | 278 ++++++++++++++
>  6 files changed, 780 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-chromeos-acpi
>  create mode 100644 Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
>  create mode 100644 drivers/platform/chrome/chromeos_acpi.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> new file mode 100644
> index 0000000000000..5b59ef9d7b371
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> @@ -0,0 +1,126 @@
> +What:		/sys/bus/platform/devices/GGL0001:*/BINF.2
> +Date:		May 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows information about the current boot of
> +		the active EC firmware.
> +		  * 0 - Read only (recovery) firmware.
> +		  * 1 - Rewritable firmware.
> +
> +What:		/sys/bus/platform/devices/GGL0001:*/BINF.3
> +Date:		May 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows information about the current boot of
> +		the active main	firmware type.
> +		  * 0 - Recovery.
> +		  * 1 - Normal.
> +		  * 2 - Developer.
> +		  * 3 - Netboot (factory installation only).
> +
> +What:		/sys/bus/platform/devices/GGL0001:*/CHSW
> +Date:		May 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the switch position for the Chrome OS specific
> +		hardware switches.
> +		  * 0   - No changes.
> +		  * 2   - Recovery button was pressed when firmware booted.
> +		  * 4   - Recovery button was pressed when EC firmware booted.
> +		  * 32  - Developer switch was enabled when firmware booted.
> +		  * 512 - Firmware write protection was disabled when firmware
> +			  booted.
> +
> +What:		/sys/bus/platform/devices/GGL0001:*/FMAP
> +Date:		May 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the physical memory address of the start of
> +		the main processor firmware flashmap.
> +
> +What:		/sys/bus/platform/devices/GGL0001:*/FRID
> +Date:		May 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the firmware version for the read-only portion
> +		of the main processor firmware.
> +
> +What:		/sys/bus/platform/devices/GGL0001:*/FWID
> +Date:		May 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the firmware version for the rewritable portion
> +		of the main processor firmware.
> +
> +What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.0
> +Date:		May 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the type of the GPIO signal for the Chrome OS
> +		specific GPIO assignments.
> +		  * 1   - Recovery button.
> +		  * 2   - Developer mode switch.
> +		  * 3   - Firmware write protection switch.
> +		  * 256 to 511 - Debug header GPIO 0 to GPIO 255.
> +
> +What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.1
> +Date:		May 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the signal attributes of the GPIO signal.
> +		  * 0 - Signal is active low.
> +		  * 1 - Signal is active high.
> +
> +What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.2
> +Date:		May 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the GPIO number on the specified GPIO
> +		controller.
> +
> +What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.3
> +Date:		May 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the name of the GPIO controller.
> +
> +What:		/sys/bus/platform/devices/GGL0001:*/HWID
> +Date:		May 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the hardware ID for the Chromebook.
> +
> +What:		/sys/bus/platform/devices/GGL0001:*/MECK
> +Date:		May 2022
> +KernelVersion:	5.19
> +Description:
> +		This binary file returns the SHA-1 or SHA-256 hash that is
> +		read out of the Management Engine extended registers during
> +		boot. The hash is exported vi ACPI so the OS can verify that
> +		the Management Engine firmware has not changed. If Management
> +		Engine is not present, or if the firmware was unable to read the
> +		extended registers, this buffer size can be zero.
> +
> +What:		/sys/bus/platform/devices/GGL0001:*/VBNV.0
> +Date:		May 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the offset in CMOS bank 0 of the verified boot
> +		non-volatile storage block, counting from the first writable
> +		CMOS byte (that is, 'offset = 0' is the byte following the 14
> +		bytes of clock data).
> +
> +What:		/sys/bus/platform/devices/GGL0001:*/VBNV.1
> +Date:		May 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the size in bytes of the verified boot
> +		non-volatile storage block.
> +
> +What:		/sys/bus/platform/devices/GGL0001:*/VDAT
> +Date:		May 2022
> +KernelVersion:	5.19
> +Description:
> +		This binary file returns the verified boot data block shared
> +		between the firmware verification step and the kernel
> +		verification step.
> diff --git a/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst b/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
> new file mode 100644
> index 0000000000000..f37fc90ce340e
> --- /dev/null
> +++ b/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
> @@ -0,0 +1,363 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Chrome OS ACPI Device
> +=====================
> +
> +Hardware functionality specific to Chrome OS is exposed through a Chrome OS ACPI device.
> +The plug and play ID of a Chrome OS ACPI device is GGL0001. GGL is a valid PNP ID of Google.
> +PNP ID can be used with the ACPI devices according to the guidelines. The following ACPI
> +objects are supported:
> +
> +.. flat-table:: Supported ACPI Objects
> +   :widths: 1 2
> +   :header-rows: 1
> +
> +   * - Object
> +     - Description
> +
> +   * - CHSW
> +     - Chrome OS switch positions
> +
> +   * - HWID
> +     - Chrome OS hardware ID
> +
> +   * - FWID
> +     - Chrome OS firmware version
> +
> +   * - FRID
> +     - Chrome OS read-only firmware version
> +
> +   * - BINF
> +     - Chrome OS boot information
> +
> +   * - GPIO
> +     - Chrome OS GPIO assignments
> +
> +   * - VBNV
> +     - Chrome OS NVRAM locations
> +
> +   * - VDTA
> +     - Chrome OS verified boot data
> +
> +   * - FMAP
> +     - Chrome OS flashmap base address
> +
> +   * - MLST
> +     - Chrome OS method list
> +
> +CHSW (Chrome OS switch positions)
> +=================================
> +This control method returns the switch positions for Chrome OS specific hardware switches.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +An integer containing the switch positions as bitfields:
> +
> +.. flat-table::
> +   :widths: 1 2
> +
> +   * - 0x00000002
> +     - Recovery button was pressed when x86 firmware booted.
> +
> +   * - 0x00000004
> +     - Recovery button was pressed when EC firmware booted. (required if EC EEPROM is
> +       rewritable; otherwise optional)
> +
> +   * - 0x00000020
> +     - Developer switch was enabled when x86 firmware booted.
> +
> +   * - 0x00000200
> +     - Firmware write protection was disabled when x86 firmware booted. (required if
> +       firmware write protection is controlled through x86 BIOS; otherwise optional)
> +
> +All other bits are reserved and should be set to 0.
> +
> +HWID (Chrome OS hardware ID)
> +============================
> +This control method returns the hardware ID for the Chromebook.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +A null-terminated ASCII string containing the hardware ID from the Model-Specific Data area of
> +EEPROM.
> +
> +Note that the hardware ID can be up to 256 characters long, including the terminating null.
> +
> +FWID (Chrome OS firmware version)
> +=================================
> +This control method returns the firmware version for the rewritable portion of the main
> +processor firmware.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +A null-terminated ASCII string containing the complete firmware version for the rewritable
> +portion of the main processor firmware.
> +
> +FRID (Chrome OS read-only firmware version)
> +===========================================
> +This control method returns the firmware version for the read-only portion of the main
> +processor firmware.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +A null-terminated ASCII string containing the complete firmware version for the read-only
> +(bootstrap + recovery ) portion of the main processor firmware.
> +
> +BINF (Chrome OS boot information)
> +=================================
> +This control method returns information about the current boot.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +
> +.. code-block::
> +
> +   Package {
> +           Reserved1
> +           Reserved2
> +           Active EC Firmware
> +           Active Main Firmware Type
> +           Reserved5
> +   }
> +
> +.. flat-table::
> +   :widths: 1 1 2
> +   :header-rows: 1
> +
> +   * - Field
> +     - Format
> +     - Description
> +
> +   * - Reserved1
> +     - DWORD
> +     - Set to 256 (0x100). This indicates this field is no longer used.
> +
> +   * - Reserved2
> +     - DWORD
> +     - Set to 256 (0x100). This indicates this field is no longer used.
> +
> +   * - Active EC firmware
> +     - DWORD
> +     - The EC firmware which was used during boot.
> +
> +       - 0 - Read-only (recovery) firmware
> +       - 1 - Rewritable firmware.
> +
> +       Set to 0 if EC firmware is always read-only.
> +
> +   * - Active Main Firmware Type
> +     - DWORD
> +     - The main firmware type which was used during boot.
> +
> +       - 0 - Recovery
> +       - 1 - Normal
> +       - 2 - Developer
> +       - 3 - netboot (factory installation only)
> +
> +       Other values are reserved.
> +
> +   * - Reserved5
> +     - DWORD
> +     - Set to 256 (0x100). This indicates this field is no longer used.
> +
> +GPIO (Chrome OS GPIO assignments)
> +=================================
> +This control method returns information about Chrome OS specific GPIO assignments for
> +Chrome OS hardware, so the kernel can directly control that hardware.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +.. code-block::
> +
> +        Package {
> +                Package {
> +                        // First GPIO assignment
> +                        Signal Type        //DWORD
> +                        Attributes         //DWORD
> +                        Controller Offset  //DWORD
> +                        Controller Name    //ASCIIZ
> +                },
> +                ...
> +                Package {
> +                        // Last GPIO assignment
> +                        Signal Type        //DWORD
> +                        Attributes         //DWORD
> +                        Controller Offset  //DWORD
> +                        Controller Name    //ASCIIZ
> +                }
> +        }
> +
> +Where ASCIIZ means a null-terminated ASCII string.
> +
> +.. flat-table::
> +   :widths: 1 1 2
> +   :header-rows: 1
> +
> +   * - Field
> +     - Format
> +     - Description
> +
> +   * - Signal Type
> +     - DWORD
> +     - Type of GPIO signal
> +
> +       - 0x00000001 - Recovery button
> +       - 0x00000002 - Developer mode switch
> +       - 0x00000003 - Firmware write protection switch
> +       - 0x00000100 - Debug header GPIO 0
> +       - ...
> +       - 0x000001FF - Debug header GPIO 255
> +
> +       Other values are reserved.
> +
> +   * - Attributes
> +     - DWORD
> +     - Signal attributes as bitfields:
> +
> +       - 0x00000001 - Signal is active-high (for button, a GPIO value
> +         of 1 means the button is pressed; for switches, a GPIO value
> +         of 1 means the switch is enabled). If this bit is 0, the signal
> +         is active low. Set to 0 for debug header GPIOs.
> +
> +   * - Controller Offset
> +     - DWORD
> +     - GPIO number on the specified controller.
> +
> +   * - Controller Name
> +     - ASCIIZ
> +     - Name of the controller for the GPIO.
> +       Currently supported names:
> +       "NM10" - Intel NM10 chip
> +
> +VBNV (Chrome OS NVRAM locations)
> +================================
> +This control method returns information about the NVRAM (CMOS) locations used to
> +communicate with the BIOS.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +.. code-block::
> +
> +        Package {
> +                NV Storage Block Offset  //DWORD
> +                NV Storage Block Size    //DWORD
> +        }
> +
> +.. flat-table::
> +   :widths: 1 1 2
> +   :header-rows: 1
> +
> +   * - Field
> +     - Format
> +     - Description
> +
> +   * - NV Storage Block Offset
> +     - DWORD
> +     - Offset in CMOS bank 0 of the verified boot non-volatile storage block, counting from
> +       the first writable CMOS byte (that is, offset=0 is the byte following the 14 bytes of
> +       clock data).
> +
> +   * - NV Storage Block Size
> +     - DWORD
> +     - Size in bytes of the verified boot non-volatile storage block.
> +
> +FMAP (Chrome OS flashmap address)
> +=================================
> +This control method returns the physical memory address of the start of the main processor
> +firmware flashmap.
> +
> +Arguments:
> +----------
> +None
> +
> +NoneResult code:
> +----------------
> +A DWORD containing the physical memory address of the start of the main processor firmware
> +flashmap.
> +
> +VDTA (Chrome OS verified boot data)
> +===================================
> +This control method returns the verified boot data block shared between the firmware
> +verification step and the kernel verification step.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +A buffer containing the verified boot data block.
> +
> +MECK (Management Engine Checksum)
> +=================================
> +This control method returns the SHA-1 or SHA-256 hash that is read out of the Management
> +Engine extended registers during boot. The hash is exported via ACPI so the OS can verify that
> +the ME firmware has not changed. If Management Engine is not present, or if the firmware was
> +unable to read the extended registers, this buffer can be zero.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +A buffer containing the ME hash.
> +
> +MLST (Chrome OS method list)
> +============================
> +This control method returns a list of the other control methods supported by the Chrome OS
> +hardware device.
> +
> +Arguments:
> +----------
> +None
> +
> +Result code:
> +------------
> +A package containing a list of null-terminated ASCII strings, one for each control method
> +supported by the Chrome OS hardware device, not including the MLST method itself.
> +For this version of the specification, the result is:
> +
> +.. code-block::
> +
> +        Package {
> +                "CHSW",
> +                "FWID",
> +                "HWID",
> +                "FRID",
> +                "BINF",
> +                "GPIO",
> +                "VBNV",
> +                "FMAP",
> +                "VDTA",
> +                "MECK"
> +        }
> diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> index b053b0c3d6969..b6a42f4ffe032 100644
> --- a/Documentation/firmware-guide/acpi/index.rst
> +++ b/Documentation/firmware-guide/acpi/index.rst
> @@ -29,3 +29,4 @@ ACPI Support
>     non-d0-probe
>     extcon-intel-int3496
>     intel-pmc-mux
> +   chromeos-acpi-device
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 75e93efd669f0..717299cbccac6 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -15,6 +15,17 @@ menuconfig CHROME_PLATFORMS
>  
>  if CHROME_PLATFORMS
>  
> +config CHROMEOS_ACPI
> +	tristate "ChromeOS specific ACPI extensions"
> +	depends on ACPI
> +	help
> +	  This driver provides the firmware interface for the services
> +	  exported through the ChromeOS interfaces when using ChromeOS
> +	  ACPI firmware.
> +
> +	  If you have an ACPI-compatible Chromebook, say Y or M here.
> +	  The module will be called chromeos_acpi.
> +
>  config CHROMEOS_LAPTOP
>  	tristate "Chrome OS Laptop"
>  	depends on I2C && DMI && X86
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 6420ca129548e..52f5a2dde8b81 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -4,6 +4,7 @@
>  CFLAGS_cros_ec_trace.o:=		-I$(src)
>  CFLAGS_cros_ec_sensorhub_ring.o:=	-I$(src)
>  
> +obj-$(CONFIG_CHROMEOS_ACPI)		+= chromeos_acpi.o
>  obj-$(CONFIG_CHROMEOS_LAPTOP)		+= chromeos_laptop.o
>  obj-$(CONFIG_CHROMEOS_PRIVACY_SCREEN)	+= chromeos_privacy_screen.o
>  obj-$(CONFIG_CHROMEOS_PSTORE)		+= chromeos_pstore.o
> diff --git a/drivers/platform/chrome/chromeos_acpi.c b/drivers/platform/chrome/chromeos_acpi.c
> new file mode 100644
> index 0000000000000..cb7b6d326803d
> --- /dev/null
> +++ b/drivers/platform/chrome/chromeos_acpi.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ChromeOS specific ACPI extensions
> + *
> + * Copyright 2022 Google LLC
> + *
> + * This driver attaches to the ChromeOS ACPI device and then exports the
> + * values reported by the ACPI in a sysfs directory. All values are
> + * presented in the string form (numbers as decimal values) and can be
> + * accessed as the contents of the appropriate read only files in the
> + * sysfs directory tree.
> + */
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +
> +#define ACPI_ATTR_NAME_LEN 4
> +
> +#define DEV_ATTR(_var, _name)					\
> +	static struct device_attribute dev_attr_##_var = {	\
> +		.attr	= { .name = _name, .mode = 0444 },	\
> +		.show	= chromeos_first_level_attr_show	\
> +	};

Why do you really need to define your own macro here?

What's wrong with DEVICE_ATTR_RO()?

At the very least, use __ATTR() please, to ensure you get the
read-only mode correct, but really, just use the macros we have already
today.  I see you want only one show function, so please use
__ATTR().

> +
> +#define GPIO_ATTR_GROUP(_group, _name, _num)						\
> +	static umode_t attr_is_visible_gpio_##_num(struct kobject *kobj,		\
> +						   struct attribute *attr, int n)	\
> +	{										\
> +		if (_num < chromeos_acpi_gpio_groups)					\
> +			return attr->mode;						\
> +		else									\
> +			return 0;							\
> +	}										\
> +	static ssize_t chromeos_attr_show_gpio_##_num(struct device *dev,		\
> +						      struct device_attribute *attr,	\
> +						      char *buf)			\
> +	{										\
> +		char name[ACPI_ATTR_NAME_LEN + 1];					\
> +		int ret, num;								\
> +											\
> +		ret = parse_attr_name(attr->attr.name, name, &num);			\
> +		if (ret)								\
> +			return ret;							\
> +		ret = chromeos_acpi_evaluate_method(dev, _num, num, name, buf);		\
> +		if (ret < 0)								\
> +			ret = 0;							\
> +		return ret;								\
> +	}										\
> +	static struct device_attribute dev_attr_0_##_group = {				\
> +		.attr	= { .name = "GPIO.0", .mode = 0444 },				\
> +		.show	= chromeos_attr_show_gpio_##_num				\
> +	};										\
> +	static struct device_attribute dev_attr_1_##_group = {				\
> +		.attr	= { .name = "GPIO.1", .mode = 0444 },				\
> +		.show	= chromeos_attr_show_gpio_##_num				\
> +	};										\
> +	static struct device_attribute dev_attr_2_##_group = {				\
> +		.attr	= { .name = "GPIO.2", .mode = 0444 },				\
> +		.show	= chromeos_attr_show_gpio_##_num				\
> +	};										\
> +	static struct device_attribute dev_attr_3_##_group = {				\
> +		.attr	= { .name = "GPIO.3", .mode = 0444 },				\
> +		.show	= chromeos_attr_show_gpio_##_num				\
> +	};										\

Same for the above, __ATTR() please.

> +	static struct attribute *attrs_##_group[] = {					\
> +		&dev_attr_0_##_group.attr,						\
> +		&dev_attr_1_##_group.attr,						\
> +		&dev_attr_2_##_group.attr,						\
> +		&dev_attr_3_##_group.attr,						\
> +		NULL									\
> +	};										\
> +	static const struct attribute_group attr_group_##_group = {			\
> +		.name = _name,								\
> +		.is_visible = attr_is_visible_gpio_##_num,				\
> +		.attrs = attrs_##_group							\
> +	};
> +
> +static unsigned int chromeos_acpi_gpio_groups;
> +
> +/* Parse the ACPI package and return the data related to that attribute */
> +static int chromeos_acpi_handle_package(struct device *dev, union acpi_object *obj,
> +					int pkg_num, int sub_pkg_num, char *name, char *buf)
> +{
> +	union acpi_object *element = obj->package.elements;
> +	int length = -EINVAL;
> +
> +	if (pkg_num >= obj->package.count)
> +		return -EINVAL;
> +	element += pkg_num;
> +
> +	if (element->type == ACPI_TYPE_PACKAGE) {
> +		if (sub_pkg_num >= element->package.count)
> +			return -EINVAL;
> +		// select sub element inside this package
> +		element = element->package.elements;
> +		element += sub_pkg_num;
> +	}
> +
> +	switch (element->type) {
> +	case ACPI_TYPE_INTEGER:
> +		length = sysfs_emit(buf, "%d", (int)element->integer.value);

Why not just:
	return sysfs_emit(....)
here and below?

That allows you to drop the length variable entirely.

> +		break;
> +	case ACPI_TYPE_STRING:
> +		length = sysfs_emit(buf, "%s", element->string.pointer);
> +		break;
> +	case ACPI_TYPE_BUFFER:
> +		length = sysfs_emit(buf, "%s", element->buffer.pointer);
> +		break;
> +	default:
> +		dev_err(dev, "element type %d not supported\n", element->type);
> +		break;
> +	}
> +
> +	return length;
> +}


But that all is just minor tweaks, your call if you want to do that or
not.  Otherwise looks much better than originally, nice work:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

