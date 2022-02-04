Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61584A947B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 08:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350424AbiBDHWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 02:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiBDHWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 02:22:43 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762FAC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 23:22:43 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id h125so4364861pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 23:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zLaU+OooQpjOGfOPUlBT8gq0wmyxboLR+0UWXHSx00U=;
        b=JZHFB3AS8z11YYHqeTrTOxHnhsrXrL5s9NE9aKmi+f6IzzmqBBRtFi5yJPIrRk20Is
         LaVz3sE7CJjQ2OuiI89/O7eHlMpBNNQ44S78rhBoJDmCqlY5iVXJF58Y+9TXiP0LZNB9
         43ou8WMQxOYRDxVCTFPTboQ2g8ygsuI9OQ8ckRZKBXfe3qd8lvxPqOr6FZFP24dDN8cv
         Zt3Ye0QaGpXCv7bHmWMzkZzdj1S+ob7T59AWuraGkxbpqB5OPcKwOqRPOW4enHa1B5E3
         qG7PgwM1vdhL71BxI5/E//RL0pGUGoErCBEZNOpuaI7cU2uMMvIu+RfP+xNoEgUDttv+
         U/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=zLaU+OooQpjOGfOPUlBT8gq0wmyxboLR+0UWXHSx00U=;
        b=2ZMsVvwBqQqeodBHLwmWaRoaRmRs23/EUe8DEjXeaXuZufdDJLQsrcQ+fhcGRgQb7M
         VsDu5rS28Mj4a9UFmRrDGgLUypX8fgzsnbIF25FPXVDNxOx7wY+IYPBdU3NmQYBoBkTs
         MnAVzb55Qf0mc6erLvO3KvAs6FU1vimTUZOJdIr0kMuHvPPTWHKcG4VUgoSE0KviOsOj
         UT0zod4V3qiokSO5ins9pq6kU92xxNEHAkHEhste/rmqMFml7YySJLVpmlGyTdHRK6Db
         ioBl0AvYSN6gjg3bBiN9RYHNRNfbBeiz4NS4WAL0IeKUd+2MuE8LjWfhuz9MqzPwFnmj
         5DcA==
X-Gm-Message-State: AOAM530HFD1G7mJeLv4k23zjdt1N2DpNKCvnSgedKaJ9W/VTJX/LXqog
        JL7M5OPNjQkhyTpcSXqfu3s=
X-Google-Smtp-Source: ABdhPJzgRaKNLRRcC5aRsfCldfqd3VmQV2yiZP9dmKE8/HvnW8TNcg+LXnnK0y9HCRkFUnE9LpEXjA==
X-Received: by 2002:a05:6a00:24d6:: with SMTP id d22mr1729342pfv.36.1643959362831;
        Thu, 03 Feb 2022 23:22:42 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id t14sm11665328pjd.6.2022.02.03.23.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 23:22:42 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH v3 0/3] firmware: Add boot information to sysfs
Date:   Fri,  4 Feb 2022 17:52:31 +1030
Message-Id: <20220204072234.304543-1-joel@jms.id.au>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 resolves Greg's review for the bootinfo header and macros, and drops
uart_boot as it's unlikely to be common across platforms.

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

 .../ABI/testing/sysfs-firmware-bootinfo       | 37 +++++++++
 arch/x86/kernel/setup.c                       |  6 ++
 drivers/base/firmware.c                       | 80 +++++++++++++++++++
 drivers/soc/aspeed/aspeed-socinfo.c           | 44 +++++++++-
 include/linux/firmware_bootinfo.h             | 48 +++++++++++
 5 files changed, 214 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-bootinfo
 create mode 100644 include/linux/firmware_bootinfo.h

-- 
2.34.1

