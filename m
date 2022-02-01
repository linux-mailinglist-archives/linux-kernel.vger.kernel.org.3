Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C414A6067
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbiBAPqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240503AbiBAPqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643730360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=V16Rg9PyE4F77OrMl7neP6fNLg9hugyZlwvmW/En9MU=;
        b=SEy6f2qMvTpUm0MMj/mTfQSmGtWdIK1j29FXLv1DDruxE0khRwY7+vIA8ic0y2KxP5qIYc
        N+6DobstPXEb0tWBI3tXUWa61Xy+8SPC+gdCSOx40PxxeW2i2AGAFm+aw94Ykhge4/g79V
        UDO3Hw5ujUfpqhXdDufN00cB/ogIFHk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-ZDokbAX5MMOkaOqkFbXBhw-1; Tue, 01 Feb 2022 10:45:59 -0500
X-MC-Unique: ZDokbAX5MMOkaOqkFbXBhw-1
Received: by mail-ed1-f71.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso8864766edt.20
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 07:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=V16Rg9PyE4F77OrMl7neP6fNLg9hugyZlwvmW/En9MU=;
        b=5uR3GVNQKK8Sonse/5okIov5quvqrwGf6Lt4MI+7xIbR+noZeAfUHFOhbY3oka7/Zg
         6DQQzwolWKaEkYgg+jfmKBjJrQRgc3xvx3lx797XcJvBvVSscPWphDDeUNN5rj0mUqjy
         WG6Jws6xIaBj3M7w8LwQbHPcTHs/KVx8HrTiXxz3k9UTQfjYkTHPtohpy1AYX4VnXHQc
         P5j/K2SsDYIoaxCvbslaZnpeBMWp4Nh+ZBboBRqHRY8wuAdDpXIPq7pt5Gz5D+Ov3mZ+
         3agpz8e7tD/93d+6G8mQ2qcFZa9ICNxvc4RYMYFIAYqcw+xK5SkyqOXsSdWs0ApcFJfx
         x8lg==
X-Gm-Message-State: AOAM530+pgq99uqp4DRbDDRqDQbON82KnzUWQoOFTJ1G0H87N+4l0mJF
        GA0jj5ax7qhKj0VpiwiUDAQSCWHInu1fJFTjG/SDFwQmKFSOKgmgQLxR1VewO46tUzSvDWrM/XJ
        PEBjwYhRKqBuIhj0wzNDtXxlQ
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr21612100ejc.112.1643730358353;
        Tue, 01 Feb 2022 07:45:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdrUpN1gbDzc4IVQYH3CqIaSxdXvuszg5XkrEKt+aKypjCMSeE6cI9mdNsh9ljvHFvoHp8Aw==
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr21612091ejc.112.1643730358083;
        Tue, 01 Feb 2022 07:45:58 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id a25sm4329945ejs.149.2022.02.01.07.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 07:45:57 -0800 (PST)
Message-ID: <37770642-bdab-bf37-c5c5-5c3edf9ad4a4@redhat.com>
Date:   Tue, 1 Feb 2022 16:45:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.17-2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the first round of bug-fixes for platform-drivers-x86
for 5.17.

This consists of various build- and bug-fixes as well as
a few hardware-id additions.

Regards,

Hans


The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.17-2

for you to fetch changes up to 836f35f79153ce09d813c83f341dba4481996966:

  platform/x86: thinkpad_acpi: Fix incorrect use of platform profile on AMD platforms (2022-02-01 15:37:00 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v5.17-2

Highlights:
 - Bunch of fixes for the new x86-android-tablets module
 - Misc. other fixes
 - A couple of hw-id additions

The following is an automated git shortlog grouped by driver:

ISST:
 -  Fix possible circular locking dependency detected

amd-pmc:
 -  Correct usage of SMU version
 -  Make amd_pmc_stb_debugfs_fops static

asus-tf103c-dock:
 -  Make 2 global structs static

intel_crystal_cove_charger:
 -  Fix IRQ masking / unmasking

platform/surface:
 -  Reinstate platform dependency

thinkpad_acpi:
 -  Fix incorrect use of platform profile on AMD platforms
 -  Add quirk for ThinkPads without a fan

touchscreen_dmi:
 -  Add info for the RWC NANOTE P8 AY07J 2-in-1

x86-android-tablets:
 -  Trivial typo fix for MODULE_AUTHOR
 -  Fix the buttons on CZC P10T tablet
 -  Constify the gpiod_lookup_tables arrays
 -  Add an init() callback to struct x86_dev_info
 -  Add support for disabling ACPI _AEI handlers
 -  Correct crystal_cove_charger module name

----------------------------------------------------------------
Alexander Kobel (1):
      platform/x86: thinkpad_acpi: Add quirk for ThinkPads without a fan

Geert Uytterhoeven (1):
      platform/surface: Reinstate platform dependency

Hans de Goede (7):
      platform/x86: x86-android-tablets: Correct crystal_cove_charger module name
      platform/x86: x86-android-tablets: Add support for disabling ACPI _AEI handlers
      platform/x86: x86-android-tablets: Add an init() callback to struct x86_dev_info
      platform/x86: x86-android-tablets: Constify the gpiod_lookup_tables arrays
      platform/x86: intel_crystal_cove_charger: Fix IRQ masking / unmasking
      platform/x86: amd-pmc: Make amd_pmc_stb_debugfs_fops static
      platform/x86: asus-tf103c-dock: Make 2 global structs static

Lubomir Rintel (2):
      platform/x86: x86-android-tablets: Fix the buttons on CZC P10T tablet
      platform/x86: x86-android-tablets: Trivial typo fix for MODULE_AUTHOR

Mario Limonciello (1):
      platform/x86: amd-pmc: Correct usage of SMU version

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Fix incorrect use of platform profile on AMD platforms

Srinivas Pandruvada (1):
      platform/x86: ISST: Fix possible circular locking dependency detected

Yuka Kawajiri (1):
      platform/x86: touchscreen_dmi: Add info for the RWC NANOTE P8 AY07J 2-in-1

 drivers/platform/surface/Kconfig                   |   1 +
 drivers/platform/x86/amd-pmc.c                     |  15 +--
 drivers/platform/x86/asus-tf103c-dock.c            |   4 +-
 drivers/platform/x86/intel/crystal_cove_charger.c  |  26 ++---
 .../x86/intel/speed_select_if/isst_if_common.c     |  97 ++++++++++++-------
 drivers/platform/x86/thinkpad_acpi.c               |  25 ++++-
 drivers/platform/x86/touchscreen_dmi.c             |  24 +++++
 drivers/platform/x86/x86-android-tablets.c         | 105 +++++++++++++++++++--
 8 files changed, 229 insertions(+), 68 deletions(-)

