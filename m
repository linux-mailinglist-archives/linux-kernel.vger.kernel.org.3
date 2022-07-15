Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7889B575FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiGOLZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGOLZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7D5B87C21
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657884303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MJ4BikKIkteipJN2dHT/nYxK+elJw8+xVCUOzivv06k=;
        b=OrlO8JzHsMGiEuzAA6QgU3o9hl3gezrY1NCS/uhudD20MtwBFpJ104lSMCG/o/kfiijZRk
        rLEf6614fq+982lVAXqIb2wsCK2w9pmcMA83O4i/j0WqgrpX/aSKw/CK/jcP00egyxB3EX
        BflsXMBWrCa2YBYTeydBKwtDAws7Tns=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-z-Syo2cLOA6SB7AfOdBlyg-1; Fri, 15 Jul 2022 07:25:02 -0400
X-MC-Unique: z-Syo2cLOA6SB7AfOdBlyg-1
Received: by mail-ed1-f70.google.com with SMTP id o13-20020a056402438d00b0043aa846b2d2so3276781edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=MJ4BikKIkteipJN2dHT/nYxK+elJw8+xVCUOzivv06k=;
        b=b/3h8iJ80C9pg+N839nGsPgPJGELHujEJck3athAeSixBIKmIgRV+sl3CiFAOEGW6J
         CbUdqIPyMC0JtCJxdD2vAGrWIhn5I9z0X2enfu39wbPOoVeOimu8B+MuIjfAdZlu3Ia9
         aSU8io0jO4kT8QssCo1ZkOoV8S4K8PlU98L70cBu+szHVLogKehcC+2jfJhVy8/WuanJ
         WqRHfX+m8Ugjg4Xdp054r0jnwMuUNfWC17rYlgfph+s9bSxvWJX4kjeJRjQIt++qix0X
         ESmuXzRKHuuD/DQVJYlheMD+wSDwpl58g0S/VSCZ+c0HlpEH1yqjZWSeOkBYqJFRrdzp
         mppg==
X-Gm-Message-State: AJIora/SatfeNyZCdAZ5GfbL4jGemA2H/XUffwppiHZ1J5boY9p80hxw
        d+m8nuFCDTmY5e5hId7TuoLOO01WLkny1x8mUjLx3bJOIm/jsZgnyT2GeBI2Wumbkd11kJ2uhIM
        WybH5ch8ur6Fx+AuhGk/ngKt6
X-Received: by 2002:a17:906:7007:b0:6ff:8028:42e with SMTP id n7-20020a170906700700b006ff8028042emr13371541ejj.278.1657884300923;
        Fri, 15 Jul 2022 04:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sGvTo7xq2GgQL+1fcRQNFizUAl1x04wTAqcfS9ZUiASmEyKutXH6fygjvPj9LNeKUqBKIZDQ==
X-Received: by 2002:a17:906:7007:b0:6ff:8028:42e with SMTP id n7-20020a170906700700b006ff8028042emr13371529ejj.278.1657884300746;
        Fri, 15 Jul 2022 04:25:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906301100b0072f0041cf03sm616004ejz.224.2022.07.15.04.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 04:25:00 -0700 (PDT)
Message-ID: <fc307e0b-2b4d-165d-230d-8c5cddf64dd4@redhat.com>
Date:   Fri, 15 Jul 2022 13:24:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.19-4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a final set of fixes for platform-drivers-x86 for 5.19:

 -  Fix brightness key events getting reported twice on some Dell's
    regression caused by recent Panasonic hotkey fixes
 -  Fix poweroff no longer working on some devices regression caused
    by recent poweroff handler rework
 -  Mark new (in 5.19) Intel IFS driver as broken, because of some issues
    surrounding the userspace (sysfs) API which need to be cleared up
 -  Some hardware-id / quirk additions

This (again) includes a small fix to the acpi_video_handles_brightness_key_presses()
ACPI helper function, this has been acked by Rafael for merging through
the pdx86 tree.

And one of the 2 poweroff fixes sits below drivers/firmware/efi, this
has been acked by Ard for merging through the pdx86 tree.

Regards,

Hans


The following changes since commit 9ab762a84b8094540c18a170e5ddd6488632c456:

  platform/x86: hp-wmi: Ignore Sanitization Mode event (2022-06-28 22:20:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.19-4

for you to fetch changes up to 5ad26161a371e4aa2d2553286f0cac580987a493:

  ACPI: video: Fix acpi_video_handles_brightness_key_presses() (2022-07-14 21:40:20 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.19-4

Highlights:
 -  Fix brightness key events getting reported twice on some Dell's
    regression caused by recent Panasonic hotkey fixes
 -  Fix poweroff no longer working on some devices regression caused
    by recent poweroff handler rework
 -  Mark new (in 5.19) Intel IFS driver as broken, because of some issues
    surrounding the userspace (sysfs) API which need to be cleared up
 -  Some hardware-id / quirk additions

The following is an automated git shortlog grouped by driver:

ACPI:
 -  video: Fix acpi_video_handles_brightness_key_presses()

asus-wmi:
 -  Add key mappings

efi:
 -  Fix efi_power_off() not being run before acpi_power_off() when necessary

gigabyte-wmi:
 -  add support for B660I AORUS PRO DDR4

intel_atomisp2_led:
 -  Also turn off the always-on camera LED on the Asus T100TAF

platform/x86/amd/pmc:
 -  Add new platform support
 -  Add new acpi id for PMC controller

platform/x86/intel/ifs:
 -  Mark as BROKEN

x86-android-tablets:
 -  Fix Lenovo Yoga Tablet 2 830/1050 poweroff again

----------------------------------------------------------------
Hans de Goede (5):
      platform/x86: x86-android-tablets: Fix Lenovo Yoga Tablet 2 830/1050 poweroff again
      efi: Fix efi_power_off() not being run before acpi_power_off() when necessary
      platform/x86/intel/ifs: Mark as BROKEN
      platform/x86: intel_atomisp2_led: Also turn off the always-on camera LED on the Asus T100TAF
      ACPI: video: Fix acpi_video_handles_brightness_key_presses()

Misaka19465 (1):
      platform/x86: asus-wmi: Add key mappings

Pär Eriksson (1):
      platform/x86: gigabyte-wmi: add support for B660I AORUS PRO DDR4

Shyam Sundar S K (2):
      platform/x86/amd/pmc: Add new acpi id for PMC controller
      platform/x86/amd/pmc: Add new platform support

 drivers/acpi/acpi_video.c                  | 11 +++++++----
 drivers/firmware/efi/reboot.c              | 21 +++++++++++----------
 drivers/platform/x86/amd-pmc.c             | 14 ++++++++++++--
 drivers/platform/x86/asus-nb-wmi.c         |  2 ++
 drivers/platform/x86/gigabyte-wmi.c        |  1 +
 drivers/platform/x86/intel/atomisp2/led.c  |  3 ++-
 drivers/platform/x86/intel/ifs/Kconfig     |  3 +++
 drivers/platform/x86/x86-android-tablets.c | 17 +++++++++++++----
 8 files changed, 51 insertions(+), 21 deletions(-)

