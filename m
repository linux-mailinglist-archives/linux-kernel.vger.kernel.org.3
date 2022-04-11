Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036684FBD08
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346464AbiDKN2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiDKN2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D206A18F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649683574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6zxZeUHRiO9rxBDHGi62XCZvHnLiqex86OFAcKnXF0A=;
        b=IdAU6Fau0h+CRnWhNpiO+dSKxlemCB9SwfpUWby6oLrS1Fsz/dovROMpOd9RH3sOLEJsIr
        n3Ag3GxXV9i7RxJEqOM6XfHzVpvRsnO8dlOi98S1/bZyQ1U5Pr8raFJ6+HlUm/dCfEA8tp
        2d+qXlF40roQ9tojsyT81WLGHMPttsQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-3op0CxV2PnqROxvrTbRYMg-1; Mon, 11 Apr 2022 09:26:13 -0400
X-MC-Unique: 3op0CxV2PnqROxvrTbRYMg-1
Received: by mail-ed1-f70.google.com with SMTP id cz22-20020a0564021cb600b0041d7e11fbfeso1642616edb.18
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6zxZeUHRiO9rxBDHGi62XCZvHnLiqex86OFAcKnXF0A=;
        b=4ozIe5pw4ecePM/HJ9kU4yTBhL3ZDEhaU5//nHW8CjWOxhpNga+eE31bo/PzBhKjjk
         DPaqxts74Ug4u3z1X1RXqsIcEMWtqF+ZJOw1ihs68b4b2yo8NvTZtLZk44VDerRsI1tX
         zoXifBgsSgup7If4/+vQB/VMJg0CjeowxWD5rUkpFcCtCUxaiqVzhgc7EkPaJ09j830X
         kn2lHG/h6Pa8Qkdn6oI5swiGii2q2FeVFNvtJrmvvQobH7yJuhspuB+JDAem/B4HPwDv
         V29M3Mx2CIn+kJRzp2qm0O8DdCtQ9KrzVqWBELqZ9KmUwFvjRrKcw1na8TbdQbxenSQy
         a8fQ==
X-Gm-Message-State: AOAM532EfQ27jKsP1OQd9pyRlHq1Yjal3BEuqz4/2alxmJU+BL1DAC93
        mdh0hk2kojBQtS8IsCjjH7FswwEJ1bs5PMvUsITneV+JahF8guQqpdziBtIbDJKjf6IA5zoLZ6W
        SzwbSsbfU+oiJpiBH7fHXudk1
X-Received: by 2002:a05:6402:516e:b0:41d:79f1:ff43 with SMTP id d14-20020a056402516e00b0041d79f1ff43mr6000837ede.141.1649683571682;
        Mon, 11 Apr 2022 06:26:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyowDT+/+GWz9GFedgWBQ3aSz2qQzT0WYudYAhNT3Ba/BvIEQmZk19wN2LfoNMUKm5l83980Q==
X-Received: by 2002:a05:6402:516e:b0:41d:79f1:ff43 with SMTP id d14-20020a056402516e00b0041d79f1ff43mr6000790ede.141.1649683571082;
        Mon, 11 Apr 2022 06:26:11 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id lw11-20020a170906bccb00b006e894177b35sm1180193ejb.82.2022.04.11.06.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 06:26:10 -0700 (PDT)
Message-ID: <708fb1ec-4e57-7a1d-b0a0-a3a10b3cacf3@redhat.com>
Date:   Mon, 11 Apr 2022 15:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RESEND v6] platform: x86: Add ChromeOS ACPI device driver
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        vbendeb@chromium.org, andy@infradead.org,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>
References: <Yk7aeAcKIBrTupcq@debian-BULLSEYE-live-builder-AMD64>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Yk7aeAcKIBrTupcq@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/7/22 14:35, Muhammad Usama Anjum wrote:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> The x86 Chromebooks have ChromeOS ACPI device. This driver attaches to
> the ChromeOS ACPI device and exports the values reported by ACPI in a
> sysfs directory. This data isn't present in ACPI tables when read
> through ACPI tools, hence a driver is needed to do it. The driver gets
> data from firmware using ACPI component of the kernel. The ACPI values
> are presented in string form (numbers as decimal values) or binary
> blobs, and can be accessed as the contents of the appropriate read only
> files in the standard ACPI device's sysfs directory tree. This data is
> consumed by the ChromeOS user space.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>


Thanks overall this looks pretty good to me.  The only remark which
I have is that I would like to see the Kconfig symbol changed
from CONFIG_ACPI_CHROMEOS to CONFIG_CHROMEOS_ACPI to match the
filename.

CONFIG_ACPI_CHROMEOS to me suggests that this is an ACPI subsystem
Kconfig option which, with the driver living under
drivers/platform/x86 it is not.

There is no need to send a new version for this, if you agree
with the change let me know and I can change this while merging
the driver.

Rafael, before I merge this do you have any (more) remarks
about this driver?

Regards,

Hans



> ---
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
>   - If sysfs_create_groups() fails in chromeos_acpi_prnocess_mlst(),
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
>  .../ABI/testing/sysfs-driver-chromeos-acpi    | 126 +++++
>  .../acpi/chromeos-acpi-device.rst             | 363 ++++++++++++
>  Documentation/firmware-guide/acpi/index.rst   |   1 +
>  drivers/platform/x86/Kconfig                  |  11 +
>  drivers/platform/x86/Makefile                 |   3 +
>  drivers/platform/x86/chromeos_acpi.c          | 515 ++++++++++++++++++
>  6 files changed, 1019 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-chromeos-acpi
>  create mode 100644 Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
>  create mode 100644 drivers/platform/x86/chromeos_acpi.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> new file mode 100644
> index 0000000000000..2aabac1046417
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
> @@ -0,0 +1,126 @@
> +What:		/sys/bus/acpi/devices/GGL0001:00/BINF.2
> +Date:		April 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows information about the current boot of
> +		the active EC firmware.
> +		  * 0 - Read only (recovery) firmware.
> +		  * 1 - Rewritable firmware.
> +
> +What:		/sys/bus/acpi/devices/GGL0001:00/BINF.3
> +Date:		April 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows information about the current boot of
> +		the active main	firmware type.
> +		  * 0 - Recovery.
> +		  * 1 - Normal.
> +		  * 2 - Developer.
> +		  * 3 - Netboot (factory installation only).
> +
> +What:		/sys/bus/acpi/devices/GGL0001:00/CHSW
> +Date:		April 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the switch position for the Chrome OS specific
> +		hardware switches.
> +		  * 0   - No changes.
> +		  * 2   - Recovery button was pressed when firmware booted.
> +		  * 4   - Recovery button was pressed when EC firmware booted.
> +		  * 32  - Developer switch was enabled when firmware booted.
> +		  * 512 - Firmware write protect was disabled when firmware
> +			  booted.
> +
> +What:		/sys/bus/acpi/devices/GGL0001:00/FMAP
> +Date:		April 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the physical memory address of the start of
> +		the main processor firmware flashmap.
> +
> +What:		/sys/bus/acpi/devices/GGL0001:00/FRID
> +Date:		April 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the firmware version for the read-only portion
> +		of the main processor firmware.
> +
> +What:		/sys/bus/acpi/devices/GGL0001:00/FWID
> +Date:		April 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the firmware version for the rewritable portion
> +		of the main processor firmware.
> +
> +What:		/sys/bus/acpi/devices/GGL0001:00/GPIO.X/GPIO.0
> +Date:		April 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the type of the GPIO signal for the Chrome OS
> +		specific GPIO assignments.
> +		  * 1   - Recovery button.
> +		  * 2   - Developer mode switch.
> +		  * 3   - Firmware write protect switch.
> +		  * 256 to 511 - Debug header GPIO 0 to GPIO 255.
> +
> +What:		/sys/bus/acpi/devices/GGL0001:00/GPIO.X/GPIO.1
> +Date:		April 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the signal attributes of the GPIO signal.
> +		  * 0 - Signal is active low.
> +		  * 1 - Signal is active high.
> +
> +What:		/sys/bus/acpi/devices/GGL0001:00/GPIO.X/GPIO.2
> +Date:		April 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the GPIO number on the specified GPIO
> +		controller.
> +
> +What:		/sys/bus/acpi/devices/GGL0001:00/GPIO.X/GPIO.3
> +Date:		April 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the name of the GPIO controller.
> +
> +What:		/sys/bus/acpi/devices/GGL0001:00/HWID
> +Date:		April 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the hardware ID for the Chromebook.
> +
> +What:		/sys/bus/acpi/devices/GGL0001:00/MECK
> +Date:		April 2022
> +KernelVersion:	5.19
> +Description:
> +		This binary file returns the SHA-1 or SHA-256 hash that is
> +		read out of the Management Engine extend registers during
> +		boot. The hash is exported vi ACPI so the OS can verify that
> +		the Management Engine firmware has not changed. If Management
> +		Engine is not present, or if the firmware was unable to read the
> +		extend registers, this buffer size can be zero.
> +
> +What:		/sys/bus/acpi/devices/GGL0001:00/VBNV.0
> +Date:		April 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the offset in CMOS bank 0 of the verified boot
> +		non-volatile storage block, counting from the first writable
> +		CMOS byte (that is, 'offset = 0' is the byte following the 14
> +		bytes of clock data).
> +
> +What:		/sys/bus/acpi/devices/GGL0001:00/VBNV.1
> +Date:		April 2022
> +KernelVersion:	5.19
> +Description:
> +		This file shows the size in bytes of the verified boot
> +		non-volatile storage block.
> +
> +What:		/sys/bus/acpi/devices/GGL0001:00/VDAT
> +Date:		April 2022
> +KernelVersion:	5.19
> +Description:
> +		This binary file returns the verified boot data block shared
> +		between the firmware verification step and the kernel
> +		verification step.
> diff --git a/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst b/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
> new file mode 100644
> index 0000000000000..ef3cc980bad54
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
> +The plug and play ID of a Chrome OS ACPI device is GGL0001. GGL is valid PNP ID of Google.
> +PNP ID can be used with the ACPI devices accourding to the guidelines. The following ACPI
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
> +     - Firmware write protect was disabled when x86 firmware booted. (required if
> +       firmware write protect is controlled through x86 BIOS; otherwise optional)
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
> +       - 0x00000003 - Firmware write protect switch
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
> +Engine extend registers during boot. The hash is exported via ACPI so the OS can verify that
> +the ME firmware has not changed. If Management Engine is not present, or if the firmware was
> +unable to read the extend registers, this buffer can be zero.
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
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 5d9dd70e4e0f5..41f1f0fd23d79 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -322,6 +322,17 @@ config ASUS_NB_WMI
>  	  If you have an ACPI-WMI compatible Asus Notebook, say Y or M
>  	  here.
>  
> +config ACPI_CHROMEOS
> +	tristate "ChromeOS specific ACPI extensions"
> +	depends on ACPI || COMPILE_TEST
> +	help
> +	  This driver provides the firmware interface for the services
> +	  exported through the ChromeOS interfaces when using ChromeOS
> +	  ACPI firmware.
> +
> +	  If you have an ACPI-compatible Chromebook, say Y or M
> +	  here.
> +
>  config ASUS_TF103C_DOCK
>  	tristate "Asus TF103C 2-in-1 keyboard dock"
>  	depends on ACPI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index fe4d4c8970efa..82196b934a0be 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -44,6 +44,9 @@ obj-$(CONFIG_EEEPC_WMI)		+= eeepc-wmi.o
>  # Cisco/Meraki
>  obj-$(CONFIG_MERAKI_MX100)	+= meraki-mx100.o
>  
> +# Chrome
> +obj-$(CONFIG_ACPI_CHROMEOS)	+= chromeos_acpi.o
> +
>  # Dell
>  obj-$(CONFIG_X86_PLATFORM_DRIVERS_DELL)		+= dell/
>  
> diff --git a/drivers/platform/x86/chromeos_acpi.c b/drivers/platform/x86/chromeos_acpi.c
> new file mode 100644
> index 0000000000000..f8b8a3d0ef01c
> --- /dev/null
> +++ b/drivers/platform/x86/chromeos_acpi.c
> @@ -0,0 +1,515 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ChromeOS specific ACPI extensions
> + *
> + * Copyright 2011 Google, Inc.
> + * Copyright 2020-2022 Google LLC
> + *
> + * This file is a rework and part of the code is ported from chromeos-3.18
> + * kernel and was originally written by Vadim Bendebury <vbendeb@chromium.org>.
> + *
> + * This driver attaches to the ChromeOS ACPI device and then exports the
> + * values reported by the ACPI in a sysfs directory. All values are
> + * presented in the string form (numbers as decimal values) and can be
> + * accessed as the contents of the appropriate read only files in the
> + * sysfs directory tree.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +
> +/*
> + * ACPI method name for MLST; the response for this method is a package of
> + * strings listing the methods which should be reflected in sysfs.
> + */
> +#define MLST "MLST"
> +
> +/*
> + * The default list of methods the ChromeOS ACPI device is supposed to export,
> + * if the MLST method is not present or is poorly formed.  The MLST method
> + * itself is included, to aid in debugging.
> + */
> +static char *chromeos_acpi_default_methods[] = {
> +	"CHSW", "HWID", "BINF", "GPIO", "CHNV", "FWID", "FRID", MLST
> +};
> +
> +/*
> + * Representation of a single sysfs attribute. In addition to the standard
> + * bin_attribute structure has a list of these structures (to keep track for
> + * de-allocation when removing the driver) and a pointer to the actual
> + * attribute name and value, reported when accessing the appropriate sysfs
> + * file.
> + */
> +struct chromeos_acpi_attribute {
> +	struct bin_attribute bin_attr;
> +	struct list_head list;
> +	char *name;
> +	char *data;
> +};
> +
> +/*
> + * Representation of a sysfs attribute group (a sub directory in the device's
> + * sysfs directory). In addition to the standard structure has lists to allow
> + * to keep track of the allocated structures.
> + */
> +struct chromeos_acpi_attribute_group {
> +	struct attribute_group group;
> +	struct list_head attribs;
> +	struct list_head list;
> +	char *name;
> +};
> +
> +/*
> + * This is the main structure, we use it to store data and adds links pointing
> + * at lists of allocated attributes and attribute groups.
> + */
> +struct chromeos_acpi_dev {
> +	struct chromeos_acpi_attribute_group *root;
> +	const struct attribute_group **dev_groups;
> +	struct list_head groups;
> +	unsigned int num_groups;
> +	unsigned int num_attrs;
> +};
> +
> +static struct chromeos_acpi_dev chromeos_acpi;
> +
> +static ssize_t chromeos_acpi_read_bin_attribute(struct file *filp,
> +						struct kobject *kobj,
> +						struct bin_attribute *bin_attr,
> +						char *buffer, loff_t pos,
> +						size_t count)
> +{
> +	struct chromeos_acpi_attribute *info = bin_attr->private;
> +
> +	return memory_read_from_buffer(buffer, count, &pos, info->data,
> +				       info->bin_attr.size);
> +}
> +
> +static char *chromeos_acpi_gen_file_name(char *name, int count, int index)
> +{
> +	char *str;
> +
> +	if (count == 1)
> +		str = kstrdup(name, GFP_KERNEL);
> +	else
> +		str = kasprintf(GFP_KERNEL, "%s.%d", name, index);
> +
> +	return str;
> +}
> +
> +static int
> +chromeos_acpi_add_attr(struct chromeos_acpi_attribute_group *aag,
> +		       union acpi_object *element, char *name,
> +		       int count, int index)
> +{
> +	struct chromeos_acpi_attribute *info;
> +	char buffer[24]; /* enough to store a u64 and null character */
> +	int length;
> +	int ret;
> +
> +	/* Files BINF.{0,1,4} are historical and no longer used. */
> +	if (!strcmp(name, "BINF") && (index == 0 || index == 1 || index == 4))
> +		return 0;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->name = chromeos_acpi_gen_file_name(name, count, index);
> +	if (!info->name) {
> +		ret = -ENOMEM;
> +		goto free_attribute;
> +	}
> +	sysfs_bin_attr_init(&info->bin_attr);
> +	info->bin_attr.attr.name = info->name;
> +	info->bin_attr.attr.mode = 0444;
> +
> +	switch (element->type) {
> +	case ACPI_TYPE_BUFFER:
> +		length = element->buffer.length;
> +		info->data = kmemdup(element->buffer.pointer,
> +				     length, GFP_KERNEL);
> +		break;
> +	case ACPI_TYPE_INTEGER:
> +		length = snprintf(buffer, sizeof(buffer), "%d",
> +				  (int)element->integer.value);
> +		info->data = kmemdup(buffer, length, GFP_KERNEL);
> +		break;
> +	case ACPI_TYPE_STRING:
> +		length = element->string.length + 1;
> +		info->data = kstrdup(element->string.pointer, GFP_KERNEL);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto free_attr_name;
> +	}
> +
> +	if (!info->data) {
> +		ret = -ENOMEM;
> +		goto free_attr_name;
> +	}
> +
> +	info->bin_attr.size = length;
> +	info->bin_attr.read = chromeos_acpi_read_bin_attribute;
> +	info->bin_attr.private = info;
> +
> +	INIT_LIST_HEAD(&info->list);
> +
> +	list_add(&info->list, &aag->attribs);
> +	return 0;
> +
> +free_attr_name:
> +	kfree(info->name);
> +free_attribute:
> +	kfree(info);
> +	return ret;
> +}
> +
> +static void
> +chromeos_acpi_remove_attribs(struct chromeos_acpi_attribute_group *aag)
> +{
> +	struct chromeos_acpi_attribute *attr, *tmp_attr;
> +
> +	list_for_each_entry_safe(attr, tmp_attr, &aag->attribs, list) {
> +		kfree(attr->name);
> +		kfree(attr->data);
> +		kfree(attr);
> +	}
> +}
> +
> +static int
> +chromeos_acpi_add_attribs_to_group(struct chromeos_acpi_attribute_group *aag,
> +				   unsigned int num_attrs)
> +{
> +	struct chromeos_acpi_attribute *attr;
> +	int count = 0;
> +
> +	aag->group.bin_attrs = kcalloc(num_attrs + 1,
> +				       sizeof(*aag->group.bin_attrs),
> +				       GFP_KERNEL);
> +	if (!aag->group.bin_attrs)
> +		return -ENOMEM;
> +
> +	list_for_each_entry(attr, &aag->attribs, list) {
> +		aag->group.bin_attrs[count] = &attr->bin_attr;
> +		count++;
> +	}
> +
> +	chromeos_acpi.num_groups++;
> +	list_add(&aag->list, &chromeos_acpi.groups);
> +
> +	return 0;
> +}
> +
> +/**
> + * chromeos_acpi_add_group() - Create a sysfs group including attributes
> + *			       representing a nested ACPI package.
> + *
> + * @adev: ACPI device.
> + * @obj: Package contents as returned by ACPI.
> + * @name: Name of the group.
> + * @num_attrs: Number of attributes of this package.
> + * @index: Index number of this particular group.
> + *
> + * The created group is called @name in case there is a single instance, or
> + * @name.@index otherwise.
> + *
> + * All group and attribute storage allocations are included in the lists for
> + * tracking of allocated memory.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +static int chromeos_acpi_add_group(struct acpi_device *adev,
> +				   union acpi_object *obj, char *name,
> +				   int num_attrs, int index)
> +{
> +	struct chromeos_acpi_attribute_group *aag;
> +	union acpi_object *element;
> +	int i, count, ret;
> +
> +	aag = kzalloc(sizeof(*aag), GFP_KERNEL);
> +	if (!aag)
> +		return -ENOMEM;
> +	aag->name = chromeos_acpi_gen_file_name(name, num_attrs, index);
> +	if (!aag->name) {
> +		ret = -ENOMEM;
> +		goto free_group;
> +	}
> +
> +	INIT_LIST_HEAD(&aag->attribs);
> +	INIT_LIST_HEAD(&aag->list);
> +
> +	count = obj->package.count;
> +	element = obj->package.elements;
> +	for (i = 0; i < count; i++, element++) {
> +		ret = chromeos_acpi_add_attr(aag, element, name, count, i);
> +		if (ret)
> +			goto free_group_attr;
> +	}
> +
> +	aag->group.name = aag->name;
> +
> +	ret = chromeos_acpi_add_attribs_to_group(aag, count);
> +	if (ret)
> +		goto free_group_attr;
> +
> +	return 0;
> +
> +free_group_attr:
> +	chromeos_acpi_remove_attribs(aag);
> +	kfree(aag->name);
> +free_group:
> +	kfree(aag);
> +	return ret;
> +}
> +
> +static void chromeos_acpi_remove_groups(void)
> +{
> +	struct chromeos_acpi_attribute_group *aag, *tmp_aag;
> +
> +	list_for_each_entry_safe(aag, tmp_aag, &chromeos_acpi.groups, list) {
> +		chromeos_acpi_remove_attribs(aag);
> +		kfree(aag->group.bin_attrs);
> +		kfree(aag->name);
> +		kfree(aag);
> +	}
> +}
> +
> +/**
> + * chromeos_acpi_handle_package() - Create sysfs group including attributes
> + *				    representing an ACPI package.
> + *
> + * @adev: ACPI device.
> + * @obj: Package contents as returned by ACPI.
> + * @name: Name of the group.
> + *
> + * Scalar objects included in the package get sysfs attributes created for
> + * them. Nested packages are passed to a function creating a sysfs group per
> + * package.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +static int chromeos_acpi_handle_package(struct acpi_device *adev,
> +					union acpi_object *obj, char *name)
> +{
> +	struct device *dev = &adev->dev;
> +	int count = obj->package.count;
> +	union acpi_object *element;
> +	int i, ret;
> +
> +	element = obj->package.elements;
> +	for (i = 0; i < count; i++, element++) {
> +		if (element->type == ACPI_TYPE_BUFFER ||
> +		    element->type == ACPI_TYPE_STRING ||
> +		    element->type == ACPI_TYPE_INTEGER) {
> +			/* Create a single attribute in the root directory */
> +			ret = chromeos_acpi_add_attr(chromeos_acpi.root,
> +						     element, name,
> +						     count, i);
> +			if (ret) {
> +				dev_err(dev, "error adding attributes (%d)\n",
> +					ret);
> +				return ret;
> +			}
> +			chromeos_acpi.num_attrs++;
> +		} else if (element->type == ACPI_TYPE_PACKAGE) {
> +			/* Create a group of attributes */
> +			ret = chromeos_acpi_add_group(adev, element, name,
> +						      count, i);
> +			if (ret) {
> +				dev_err(dev, "error adding a group (%d)\n",
> +					ret);
> +				return ret;
> +			}
> +		} else {
> +			if (ret) {
> +				dev_err(dev, "error on element type (%d)\n",
> +					ret);
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * chromeos_acpi_add_method() - Evaluate an ACPI method and create sysfs
> + *				attributes.
> + *
> + * @adev: ACPI device
> + * @name: Name of the method to evaluate
> + *
> + * Return: 0 on success, non-zero on failure
> + */
> +static int chromeos_acpi_add_method(struct acpi_device *adev, char *name)
> +{
> +	struct device *dev = &adev->dev;
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status status;
> +	int ret = 0;
> +
> +	status = acpi_evaluate_object(adev->handle, name, NULL, &output);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(dev, "failed to retrieve %s (%d)\n", name, status);
> +		return status;
> +	}
> +
> +	if (((union acpi_object *)output.pointer)->type == ACPI_TYPE_PACKAGE)
> +		ret = chromeos_acpi_handle_package(adev, output.pointer, name);
> +
> +	kfree(output.pointer);
> +	return ret;
> +}
> +
> +/**
> + * chromeos_acpi_process_mlst() - Evaluate the MLST method and add methods
> + *				  listed in the response.
> + *
> + * @adev: ACPI device
> + *
> + * Returns: 0 if successful, non-zero if error.
> + */
> +static int chromeos_acpi_process_mlst(struct acpi_device *adev)
> +{
> +	struct chromeos_acpi_attribute_group *aag;
> +	char name[ACPI_NAMESEG_SIZE + 1];
> +	union acpi_object *element, *obj;
> +	struct device *dev = &adev->dev;
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status status;
> +	int ret = 0;
> +	int size;
> +	int i;
> +
> +	status = acpi_evaluate_object(adev->handle, MLST, NULL,
> +				      &output);
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
> +	obj = output.pointer;
> +	if (obj->type != ACPI_TYPE_PACKAGE) {
> +		ret = -EINVAL;
> +		goto free_acpi_buffer;
> +	}
> +
> +	element = obj->package.elements;
> +	for (i = 0; i < obj->package.count; i++, element++) {
> +		if (element->type == ACPI_TYPE_STRING) {
> +			size = min(element->string.length + 1,
> +				   (u32)ACPI_NAMESEG_SIZE + 1);
> +			strscpy(name, element->string.pointer, size);
> +			ret = chromeos_acpi_add_method(adev, name);
> +			if (ret) {
> +				chromeos_acpi_remove_groups();
> +				break;
> +			}
> +		}
> +	}
> +
> +	/* Add root attributes to the main group */
> +	ret = chromeos_acpi_add_attribs_to_group(chromeos_acpi.root,
> +						 chromeos_acpi.num_attrs);
> +	if (ret)
> +		goto free_acpi_buffer;
> +
> +	chromeos_acpi.dev_groups = kcalloc(chromeos_acpi.num_groups + 1,
> +					   sizeof(struct attribute_group),
> +					   GFP_KERNEL);
> +
> +	i = 0;
> +	list_for_each_entry(aag, &chromeos_acpi.groups, list) {
> +		chromeos_acpi.dev_groups[i] = &aag->group;
> +		i++;
> +	}
> +
> +	ret = sysfs_create_groups(&dev->kobj, chromeos_acpi.dev_groups);
> +	if (ret) {
> +		kfree(chromeos_acpi.dev_groups);
> +
> +		/* Remove allocated chromeos acpi groups and attributes */
> +		chromeos_acpi_remove_groups();
> +	}
> +
> +free_acpi_buffer:
> +	kfree(output.pointer);
> +	return ret;
> +}
> +
> +static int chromeos_acpi_device_add(struct acpi_device *adev)
> +{
> +	struct chromeos_acpi_attribute_group *aag;
> +	struct device *dev = &adev->dev;
> +	int i, ret;
> +
> +	aag = kzalloc(sizeof(*aag), GFP_KERNEL);
> +	if (!aag)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&aag->attribs);
> +	INIT_LIST_HEAD(&aag->list);
> +	INIT_LIST_HEAD(&chromeos_acpi.groups);
> +
> +	chromeos_acpi.root = aag;
> +
> +	/*
> +	 * Attempt to add methods by querying the device's MLST method
> +	 * for the list of methods.
> +	 */
> +	if (!chromeos_acpi_process_mlst(adev))
> +		return 0;
> +
> +	dev_dbg(dev, "falling back to default list of methods\n");
> +
> +	for (i = 0; i < ARRAY_SIZE(chromeos_acpi_default_methods); i++) {
> +		ret = chromeos_acpi_add_method(adev,
> +					       chromeos_acpi_default_methods[i]);
> +		if (ret) {
> +			dev_err(dev, "failed to add default methods (%d)\n",
> +				ret);
> +			goto free_group_root;
> +		}
> +	}
> +
> +	return 0;
> +
> +free_group_root:
> +	kfree(chromeos_acpi.root);
> +	return ret;
> +}
> +
> +static int chromeos_acpi_device_remove(struct acpi_device *adev)
> +{
> +	/* Remove sysfs groups */
> +	sysfs_remove_groups(&adev->dev.kobj, chromeos_acpi.dev_groups);
> +	kfree(chromeos_acpi.dev_groups);
> +
> +	/* Remove allocated chromeos acpi groups and attributes */
> +	chromeos_acpi_remove_groups();
> +
> +	return 0;
> +}
> +
> +/* GGL is valid PNP ID of Google. PNP ID can be used with the ACPI devices. */
> +static const struct acpi_device_id chromeos_device_ids[] = {
> +	{ "GGL0001", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, chromeos_device_ids);
> +
> +static struct acpi_driver chromeos_acpi_driver = {
> +	.name = "chromeos-acpi",
> +	.class = "chromeos-acpi",
> +	.ids = chromeos_device_ids,
> +	.ops = {
> +		.add = chromeos_acpi_device_add,
> +		.remove = chromeos_acpi_device_remove,
> +	},
> +};
> +module_acpi_driver(chromeos_acpi_driver);
> +
> +MODULE_AUTHOR("Enric Balletbo i Serra <enric.balletbo@collabora.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ChromeOS specific ACPI extensions");

