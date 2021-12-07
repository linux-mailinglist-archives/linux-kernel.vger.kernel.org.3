Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D8146C0E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbhLGQoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:44:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238561AbhLGQoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638895246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=y96QmX07NJygKN8JuJScp9Bj4x4EQexTjjQocu59JHA=;
        b=VwT51JZsZI0IDLOQ752Gcvr1+GgetMcJxeDtG3Eqr5c72l8ICqnUpPuQrbHQ/xcI+qIGQb
        MGHXEDFsntzaHkuEfy8k/qBTpEvFh5JRRqi7RLeMX6tC8PnnOcqllEnIDUcw1On/MeW1+h
        dgG1Yal1ddYgN9gIXpwWeL2P3XvFLrQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-ifYPmWxfMkOfwUtjVHRFHw-1; Tue, 07 Dec 2021 11:40:45 -0500
X-MC-Unique: ifYPmWxfMkOfwUtjVHRFHw-1
Received: by mail-ed1-f69.google.com with SMTP id b15-20020aa7c6cf000000b003e7cf0f73daso11889785eds.22
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 08:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=y96QmX07NJygKN8JuJScp9Bj4x4EQexTjjQocu59JHA=;
        b=Hg8nIKt5I2U9UPBu8RSkULL7dw53oEY7p04ZK5Lw446zlSxc7nryyk0i5N3hGP3n7P
         7AnAk3NE9ovb8EasY+v2Tpj4tqvEFxwZTFDaO3Jow0wT31dJdBdsy1c/Hq6h/7oz+Fi2
         +4FIRbvFIzm4N6qymZgwg1FaN75TM0MIyHr9SsjzkO0bhkzsPUlQ7uhDmH+bySN5d6Yc
         mPzX/2sAYKLzVK6c+XAAmEXHSa34htnlBvYTtr971izhl4vsgjMLL40C6ytwqakdjDUZ
         LyfK3Ak1Vxpm1DlOxUIuSvozS4n1OSjKgQy1ab6txqndLpbWu4fHefILb0bny456N/m0
         UoeQ==
X-Gm-Message-State: AOAM533nYa3hZahn4VZSe7ZjB3N+HFNqgrQWG9oHHvhwZ0hXOutA7oQf
        Dt/b/59JAWEtELN4CplyAHWww1kFe4MJM2UAeme7UG0dHi3HQi5DAZKag0PHDtQZ2vC3pqtrZE9
        QFEv8DMvWTwPmS+wAA+HFJWme
X-Received: by 2002:a17:907:2d0e:: with SMTP id gs14mr524795ejc.249.1638895244163;
        Tue, 07 Dec 2021 08:40:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMMH3oJFb/oiebcMS06VV3/zkzgx7/NWskBFMyyZS1aG2zt27NZSpof4Z2LcKTL1meNIe6Ag==
X-Received: by 2002:a17:907:2d0e:: with SMTP id gs14mr524765ejc.249.1638895243887;
        Tue, 07 Dec 2021 08:40:43 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id hx21sm22544ejc.85.2021.12.07.08.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 08:40:43 -0800 (PST)
Message-ID: <d158b42c-5a3a-8441-594c-32ca180e519d@redhat.com>
Date:   Tue, 7 Dec 2021 17:40:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.16-3
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

Here is the second round of bug-fixes for platform-drivers-x86
for 5.16.

This consists of a few small bug-fixes and hardware-id additions.

Regards,

Hans


The following changes since commit d477a907cba317cfa58a8c89c09454d3fced1964:

  platform/x86: thinkpad_acpi: fix documentation for adaptive keyboard (2021-11-16 10:56:53 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.16-3

for you to fetch changes up to 7d0c009043f6a970f62dbf5aecda9f8c3ccafcff:

  platform/x86/intel: hid: add quirk to support Surface Go 3 (2021-12-06 22:28:18 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v5.16-3

Various bug-fixes and hardware-id additions.

The following is an automated git shortlog grouped by driver:

amd-pmc:
 -  Fix s2idle failures on certain AMD laptops

lg-laptop:
 -  Recognize more models

platform/x86/intel:
 -  hid: add quirk to support Surface Go 3

thinkpad_acpi:
 -  Add lid_logo_dot to the list of safe LEDs
 -  Restore missing hotkey_tablet_mode and hotkey_radio_sw sysfs-attr

touchscreen_dmi:
 -  Add TrekStor SurfTab duo W1 touchscreen info

----------------------------------------------------------------
Alex Hung (1):
      platform/x86/intel: hid: add quirk to support Surface Go 3

Fabrizio Bertocci (1):
      platform/x86: amd-pmc: Fix s2idle failures on certain AMD laptops

Hans de Goede (3):
      platform/x86: thinkpad_acpi: Restore missing hotkey_tablet_mode and hotkey_radio_sw sysfs-attr
      platform/x86: thinkpad_acpi: Add lid_logo_dot to the list of safe LEDs
      platform/x86: touchscreen_dmi: Add TrekStor SurfTab duo W1 touchscreen info

Matan Ziv-Av (1):
      platform/x86: lg-laptop: Recognize more models

 drivers/platform/x86/amd-pmc.c         |  2 +-
 drivers/platform/x86/intel/hid.c       |  7 +++++++
 drivers/platform/x86/lg-laptop.c       | 12 ++++++++++++
 drivers/platform/x86/thinkpad_acpi.c   |  6 ++++--
 drivers/platform/x86/touchscreen_dmi.c | 18 ++++++++++++++++++
 5 files changed, 42 insertions(+), 3 deletions(-)

