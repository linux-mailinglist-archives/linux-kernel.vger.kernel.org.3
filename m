Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3CA4A8358
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbiBCLx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiBCLx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:53:56 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49707C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 03:53:56 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o16-20020a17090aac1000b001b62f629953so9775791pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 03:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vbzi3fankqPmSVkF0HyJbIAmlqbeSY/pVqmGMKJwLJk=;
        b=pc58NPAZa3q9fcA8NX1O7NkuWR6f8yxUDU8PA3ghuG09G6aKqYPvh//tJc0tjAyzmy
         Qo2sb3rRDNCa+JMVh8SacAjZ7tWyaEhDMLSW5MyBtd35UPLr//YzKLm/Y0ZBaXBtZ8ek
         OyOSkYQtSFIYOyuW00wbvMpk96FUDBkOhtrzlBUnKD0viFZFcc2ATRnVFKrosvR2oHRY
         liuHGiml+xvFwjedACesMlxh7xTOXq9Mmw8erU/QXjhnZpOP8OVbJZC8ZNBMndXkp1Jo
         8eDC89DZV+xfc5+FY7Q3bxVWi2yGidFrzRW4vc31Kv4ZfuQ79F54CkvOC8dZPtGDoBzr
         Dv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Vbzi3fankqPmSVkF0HyJbIAmlqbeSY/pVqmGMKJwLJk=;
        b=KdT3YwmpvWFcXqiyx6CD8dBFMtzqX1CfsRp7hRXQpVt8ZtVFvkwlZiRwsQZJ/NASxf
         iR7XWJTdoaaRYEtnW2WlCeaVri5MZ5R7R1y/wjXhFGLaPEHdZ7+EFeE8lL+2ZscjUdBC
         tsW+qTQmxlCrh6abHxqPYjM+QNMSZvPje4P42agJY0gQSVQbTyTslnXdU5ROOmhvNcZ5
         RgxZxGKeN9CDuO4ef8mEpZZPK5i46RyHWqaQELXDYb6rVTwy2ZzuvJzhF6++qX+kDE1D
         cxzvIXwrlFSAKnZrF007V1S7PliIKCCVn11xNutLtKv9YYSIiYUG5EI3wsXghRk9E5vd
         n40Q==
X-Gm-Message-State: AOAM5336X+iRJbnd58xQGkLX0n/HV0RjCyh8vrddJWg3paDCUXS45bc2
        +dWX17QCODti+KA0MDr0Nbc=
X-Google-Smtp-Source: ABdhPJwUN0BUpDlgp6c08hsp752MSFhAFyo6awcZ0a7owxfYBlbD/uFPHQjHzo63O3ZbwHKc143c7w==
X-Received: by 2002:a17:902:ecd1:: with SMTP id a17mr35603421plh.28.1643889235521;
        Thu, 03 Feb 2022 03:53:55 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id mp22sm9586389pjb.28.2022.02.03.03.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 03:53:54 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 0/3] firmware: Add boot information to sysfs
Date:   Thu,  3 Feb 2022 22:23:41 +1030
Message-Id: <20220203115344.267159-1-joel@jms.id.au>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 reworks the series to put the sysfs properties in the core, and
optionally show them with the is_visible() callback.

This is the second iteration of this idea. The first used socinfo
custom attribute groups, but Arnd suggested we make this something
standardised under /sys/firmware instead:

 http://lore.kernel.org/all/CAK8P3a3MRf0aGt1drkgsuZyBbeoy+S7Ha18SBM01q+3f33oL+Q@mail.gmail.com

Some ARM systems have a firmware that provides a hardware root of
trust. It's useful for the system to know how this root of trust has
been configured, so provide a standardised interface that expose this
information to userspace.

This is implemented as a sysfs attribute group registration in the
driver core, with platforms populating values obtained from firmware at
kernel boot time.

Patch 2 provides a user of the properties on an ARM system.

Patch 3 is new in v2 and is an example of populating bootinfo with the
EFI secure boot status.

Joel Stanley (3):
  firmware: Add boot information to sysfs
  ARM: aspeed: Add secure boot controller support
  x86/setup: Populate bootinfo with secure boot status

 .../ABI/testing/sysfs-firmware-bootinfo       | 43 +++++++++
 arch/x86/kernel/setup.c                       |  6 ++
 drivers/base/firmware.c                       | 90 +++++++++++++++++++
 drivers/soc/aspeed/aspeed-socinfo.c           | 46 +++++++++-
 include/linux/firmware_bootinfo.h             | 22 +++++
 5 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-bootinfo
 create mode 100644 include/linux/firmware_bootinfo.h

-- 
2.34.1

