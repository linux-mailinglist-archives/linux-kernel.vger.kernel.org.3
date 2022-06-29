Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2919155FE07
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiF2LBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiF2LBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AEFA3E5D7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656500506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JncY8iU7qudh/q/NGqxm2tsN+EiGstzfMOsDe7WvCvo=;
        b=dV/PuEQDGMqDNseSQuRy8UUIISBJu013yQm28Ot62JfjvkSIaonHBadCfHqMOiaeAxQSWI
        QggWKwyW7F/WzwmophR6x/UcogxlGhit8w9HMtuj2fqMrGvH2e6Cyiuok0LGUIGBw1DgqV
        TkgN9+mEFhmuNa1Wr0mDLUToaqxWVns=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-PXZdQeVMOauoS43BpLswGA-1; Wed, 29 Jun 2022 07:01:45 -0400
X-MC-Unique: PXZdQeVMOauoS43BpLswGA-1
Received: by mail-ed1-f69.google.com with SMTP id w22-20020a05640234d600b00435ba41dbaaso11696730edc.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=JncY8iU7qudh/q/NGqxm2tsN+EiGstzfMOsDe7WvCvo=;
        b=WVWWUYu8WN8dBCyjVL2f8iGD2NYP6s45WFwgJISmDNftxPN7LKecyOW/rWYQOw5flR
         YoDVyqNGenyCH51uyjZfPo0Rr8slowLUEQLa1AfL/KjEBhEf/axqf+y9cuznlqEDZTF+
         /Q0SLEMogI+p0b4fZXU7yZYNMtTYBJCr9aHz5NIVQGMzp0CGof5/C7PWNSw4M+IN5PAR
         OVpqmFCVZF3IcfHk3n+mJnHSi1gBQa1N7ICqetRcV3yGWxNc7bFGSwLvARzTkCwsfFP9
         PNF6V4ZAgG1JD48thQnU5DFXjKH4vHRGFGg6IFJstt+p4NfGQCEN5wpVSsDqinMHhMFG
         OONw==
X-Gm-Message-State: AJIora8eSSXqyc8GTt/HpFxWbn0Xx1T5jdfxdxrCgqX1SO7yDZCokN+A
        eYr5/cPjerex6odAyaysN1i4B+o2XfxlDlH69fvQ7Xnfp7leDR/biXIsXf6mm/mUrXBCczm2LPe
        STNaE8mHsVDZxGFRlPKV+6JjT
X-Received: by 2002:a17:906:c14f:b0:726:a609:a369 with SMTP id dp15-20020a170906c14f00b00726a609a369mr2760532ejc.326.1656500503961;
        Wed, 29 Jun 2022 04:01:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s8eOy+oPXUz1mVczyDKrGkwCyqsPLS5yJ4CQZghPK7i176EkxCQZyOelDL60BAfwGWPhi1yw==
X-Received: by 2002:a17:906:c14f:b0:726:a609:a369 with SMTP id dp15-20020a170906c14f00b00726a609a369mr2760512ejc.326.1656500503782;
        Wed, 29 Jun 2022 04:01:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id m9-20020a509989000000b004355d27799fsm11331281edb.96.2022.06.29.04.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 04:01:43 -0700 (PDT)
Message-ID: <42646771-d1ea-0b05-7cb8-233d6e42ac1d@redhat.com>
Date:   Wed, 29 Jun 2022 13:01:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.19-3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the second round of fixes for platform-drivers-x86 for 5.19:

 -  thinkpad_acpi/ideapad-laptop: mem-leak and platform-profile fixes
 -  panasonic-laptop: missing hotkey presses regression fix
 -  some hardware-id additions
 -  some other small fixes

This includes a small fix to the acpi_video_handles_brightness_key_presses()
ACPI helper function, this has been acked by Rafael for merging through
the pdx86 tree.

Regards,

Hans


The following changes since commit d4fe9cc4ff8656704b58cfd9363d7c3c9d65e519:

  platform/x86/intel: hid: Add Surface Go to VGBS allow list (2022-06-12 14:41:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.19-3

for you to fetch changes up to 9ab762a84b8094540c18a170e5ddd6488632c456:

  platform/x86: hp-wmi: Ignore Sanitization Mode event (2022-06-28 22:20:07 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.19-3

Highlights:
 -  thinkpad_acpi/ideapad-laptop: mem-leak and platform-profile fixes
 -  panasonic-laptop: missing hotkey presses regression fix
 -  some hardware-id additions
 -  some other small fixes

The following is an automated git shortlog grouped by driver:

ACPI:
 -  video: Change how we determine if brightness key-presses are handled

hp-wmi:
 -  Ignore Sanitization Mode event

ideapad-laptop:
 -  Add Ideapad 5 15ITL05 to ideapad_dytc_v4_allow_table[]
 -  Add allow_v4_dytc module parameter

intel/pmc:
 -  Add Alder Lake N support to PMC core driver

panasonic-laptop:
 -  filter out duplicate volume up/down/mute keypresses
 -  don't report duplicate brightness key-presses
 -  revert "Resolve hotkey double trigger bug"
 -  sort includes alphabetically
 -  de-obfuscate button codes

platform/mellanox:
 -  nvsw-sn2201: fix error code in nvsw_sn2201_create_static_devices()

thinkpad_acpi:
 -  profile capabilities as integer
 -  do not use PSC mode on Intel platforms
 -  Fix a memory leak of EFCH MMIO resource

----------------------------------------------------------------
Dan Carpenter (1):
      platform/mellanox: nvsw-sn2201: fix error code in nvsw_sn2201_create_static_devices()

Gayatri Kammela (1):
      platform/x86: intel/pmc: Add Alder Lake N support to PMC core driver

Hans de Goede (7):
      platform/x86: ideapad-laptop: Add allow_v4_dytc module parameter
      platform/x86: ideapad-laptop: Add Ideapad 5 15ITL05 to ideapad_dytc_v4_allow_table[]
      ACPI: video: Change how we determine if brightness key-presses are handled
      platform/x86: panasonic-laptop: sort includes alphabetically
      platform/x86: panasonic-laptop: revert "Resolve hotkey double trigger bug"
      platform/x86: panasonic-laptop: don't report duplicate brightness key-presses
      platform/x86: panasonic-laptop: filter out duplicate volume up/down/mute keypresses

Jean Delvare (1):
      platform/x86: thinkpad_acpi: Fix a memory leak of EFCH MMIO resource

Kai-Heng Feng (1):
      platform/x86: hp-wmi: Ignore Sanitization Mode event

Mark Pearson (2):
      platform/x86: thinkpad-acpi: profile capabilities as integer
      platform/x86: thinkpad_acpi: do not use PSC mode on Intel platforms

Stefan Seyfried (1):
      platform/x86: panasonic-laptop: de-obfuscate button codes

 drivers/acpi/acpi_video.c               | 13 +++--
 drivers/platform/mellanox/nvsw-sn2201.c |  4 +-
 drivers/platform/x86/Kconfig            |  2 +
 drivers/platform/x86/hp-wmi.c           |  3 ++
 drivers/platform/x86/ideapad-laptop.c   | 29 ++++++++----
 drivers/platform/x86/intel/pmc/core.c   |  1 +
 drivers/platform/x86/panasonic-laptop.c | 84 ++++++++++++++++++++++++++-------
 drivers/platform/x86/thinkpad_acpi.c    | 51 ++++++++++----------
 8 files changed, 127 insertions(+), 60 deletions(-)

