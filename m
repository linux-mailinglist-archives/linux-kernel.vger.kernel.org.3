Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DC85A9D62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiIAQnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiIAQng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFD489902
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662050614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PrJ4ySHIrP8ROBjoDBorg1jCunJZhbH8/S5JcvsTtFM=;
        b=O4UYm8rq9j8Xi1EWpEjr+/y7UMd928G0VvVCuwKAYUk/0FSJDhHwzcGGT5n3qpB989y20J
        wNOvNxuXufItRKucfUO9gSxikBVt5Z5L3mPOJDENUNqyeMXMya1nF/LXnmR/JOBS38Ldm2
        Hj03cHPYR12r4w/TLRoIOLzT0DwgA3I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-6WkrmYpjO8uHupbQEGsV5Q-1; Thu, 01 Sep 2022 12:43:33 -0400
X-MC-Unique: 6WkrmYpjO8uHupbQEGsV5Q-1
Received: by mail-ed1-f71.google.com with SMTP id t13-20020a056402524d00b0043db1fbefdeso12042788edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=PrJ4ySHIrP8ROBjoDBorg1jCunJZhbH8/S5JcvsTtFM=;
        b=K/B0rgio+uIdwO4ExXyAZdC92oH2emO0kgW5KMzlZ/YOFUkMYzB0y+eU4twmG5iIA6
         +AMS1tfsH0QgvaDo2ulO4obe0QEz1x/CuHy6nH9LZOxkuf9YvAkzQiktc4mnnOEnkaQA
         kdGyBOPbFI9juJx1v/T6Hs30Dbk34k/3Pg7LY6VwTDgtHendeE9n4AcQSmeaqzm8cFIR
         P34KowaJdLZNOrCA1Fvm84yG6PXwI+Nnfqkvu/2B98gCFLYF64dRyBElauLrkpH2IrPD
         xnrFqt1pd6BIqYGOzECL5OEjqgvZgMgoaHYyhh+ZSgGM/D8hu7cwdTZcea8f4uGMqaeH
         ppiA==
X-Gm-Message-State: ACgBeo0ol34jpbTUuPX/TwMUeoyRE21t7h6yVZTQIBvKHQ2nAZQItGiR
        DlGiaA8Y9ds5v6duOKSPydq4v8J7RMhxUWmdQ5ahKIOg4bewW5NZLI69x8Njz3qIfnmkDr3fI2s
        EnAyvbbWLM6HezkSA1qW32HF5
X-Received: by 2002:a17:907:7678:b0:730:e1ad:b128 with SMTP id kk24-20020a170907767800b00730e1adb128mr25179595ejc.67.1662050612026;
        Thu, 01 Sep 2022 09:43:32 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5NrGqkbyyZ0fwizjhE35YmoDlfDgv524Gsk/uveADS0YNnu8WYkhS9FzPvX7l7wwMqul5mtQ==
X-Received: by 2002:a17:907:7678:b0:730:e1ad:b128 with SMTP id kk24-20020a170907767800b00730e1adb128mr25179578ejc.67.1662050611763;
        Thu, 01 Sep 2022 09:43:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id h10-20020a0564020e8a00b004478be33bddsm1583098eda.15.2022.09.01.09.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:43:31 -0700 (PDT)
Message-ID: <3766fb4c-d7fa-564c-abeb-c746cdf12526@redhat.com>
Date:   Thu, 1 Sep 2022 18:43:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.0-2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the first round of fixes for platform-drivers-x86 for 6.0,
nothing special to report just various small fixes and hardware-id
additions.

Regards,

Hans


The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.0-2

for you to fetch changes up to 647e82dbf85124697be59a4b4cf00c0d38177dcb:

  platform/x86: p2sb: Fix UAF when caller uses resource name (2022-09-01 17:51:34 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.0-2

Various small fixes and hardware-id additions.

The following is an automated git shortlog grouped by driver:

acer-wmi:
 -  Acer Aspire One AOD270/Packard Bell Dot keymap fixes

asus-wmi:
 -  Increase FAN_CURVE_BUF_LEN to 32
 -  Fix the name of the mic-mute LED classdev

p2sb:
 -  Fix UAF when caller uses resource name

platform/mellanox:
 -  Remove redundant 'NULL' check
 -  Remove unnecessary code
 -  mlxreg-lc: Fix locking issue
 -  mlxreg-lc: Fix coverity warning

platform/surface:
 -  aggregator_registry: Add HID devices for sensors and UCSI client to SP8
 -  aggregator_registry: Rename HID device nodes based on new findings
 -  aggregator_registry: Rename HID device nodes based on their function
 -  aggregator_registry: Add support for Surface Laptop Go 2

pmc_atom:
 -  Fix SLP_TYPx bitfield mask

thinkpad_acpi:
 -  Explicitly set to balanced mode on startup

x86-android-tablets:
 -  Fix broken touchscreen on Chuwi Hi8 with Windows BIOS

----------------------------------------------------------------
Andy Shevchenko (2):
      platform/x86: pmc_atom: Fix SLP_TYPx bitfield mask
      platform/x86: p2sb: Fix UAF when caller uses resource name

Hans de Goede (2):
      platform/x86: x86-android-tablets: Fix broken touchscreen on Chuwi Hi8 with Windows BIOS
      platform/x86: acer-wmi: Acer Aspire One AOD270/Packard Bell Dot keymap fixes

Luke D. Jones (1):
      platform/x86: asus-wmi: Increase FAN_CURVE_BUF_LEN to 32

Mario Limonciello (1):
      platform/x86: thinkpad_acpi: Explicitly set to balanced mode on startup

Maximilian Luz (4):
      platform/surface: aggregator_registry: Add support for Surface Laptop Go 2
      platform/surface: aggregator_registry: Rename HID device nodes based on their function
      platform/surface: aggregator_registry: Rename HID device nodes based on new findings
      platform/surface: aggregator_registry: Add HID devices for sensors and UCSI client to SP8

PaddyKP_Yao (1):
      platform/x86: asus-wmi: Fix the name of the mic-mute LED classdev

Vadim Pasternak (4):
      platform/mellanox: mlxreg-lc: Fix coverity warning
      platform/mellanox: mlxreg-lc: Fix locking issue
      platform/mellanox: Remove unnecessary code
      platform/mellanox: Remove redundant 'NULL' check

 drivers/platform/mellanox/mlxreg-lc.c              | 53 +++++++++++++---------
 .../platform/surface/surface_aggregator_registry.c | 47 ++++++++++---------
 drivers/platform/x86/acer-wmi.c                    |  9 +++-
 drivers/platform/x86/asus-wmi.c                    | 11 ++---
 drivers/platform/x86/p2sb.c                        | 18 +++++++-
 drivers/platform/x86/pmc_atom.c                    |  2 +-
 drivers/platform/x86/thinkpad_acpi.c               |  7 ++-
 drivers/platform/x86/x86-android-tablets.c         | 14 ++++++
 include/linux/platform_data/x86/pmc_atom.h         |  6 ++-
 9 files changed, 108 insertions(+), 59 deletions(-)

