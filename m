Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C1D4A5604
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiBAFFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiBAFFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:05:11 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEA1C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:05:10 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q63so16023224pja.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p0Mf1pHgKLt44R6XPdoONMmYbFvFAfcUL2WgqQxrsAY=;
        b=aT+IUQJ6Tt/CjegESk7cg0DT2FeroIJIIxaAFM5G4s8Rg9QaxwObqyxMkHrOpDqdLg
         3AIN1rDqnk2AOG46cY+qPoNfxx/06EvO6ynGhfs84jy2PYJAWzMDw+UISt2bkTSvSxOg
         /+G4lOkLLapdAReBuzi3cR8vuqmK2XjKgnnwRioZGKPZeSfdMltm//5XBQxQJL39xykk
         AqhWCw6dJ4HN7dUWK3SIP+32xm28SMwV4fCY1RJXKqp3YFsZpPJwoIh5onfsUsZ4i5mo
         k0BWmQmFFFEbEjtq/sO7VzmDefsPYUPw/gFvfy9tkp45tri0qyO27vXYdQpZSHrwj19H
         tZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=p0Mf1pHgKLt44R6XPdoONMmYbFvFAfcUL2WgqQxrsAY=;
        b=z9W+nv6TsXP7B7IpNVcBTvLy5u0JXy0jLZ06X7oqFVdDYRm8xzlwFqJt49WmcIFvhI
         TwGhnoxauQ8cARLL37LRn1UTNQS1Bq8V/tQxHnoUHKJPKOD5cvTON/XqFMI94Er1CL3J
         5kjEcsBVrru5w4i7atg/y9OaBXu3g2wlsQNej9faIS0JNRwNQxZ65hazeBIA8TqTH6RX
         qGK72mE8m43HNbvhfrU8JkGgTafI5T/2DTKiLaGBKV93L5RiUIqEjITD0ulkRiHlkIzq
         WkM2wVk2h2HEkq6mLZdSsdyOx+oqXrk0lfYAFs/+Az6n2GrQGCIShHKkhQYfIvT6zrhh
         b7Vw==
X-Gm-Message-State: AOAM5326zgosPNOhTnMnei28tzzxMN7w43cBrfwaxwm6rdAF6gfNtvhX
        ElxiIZo0qiQSSTc2qxW+hjw=
X-Google-Smtp-Source: ABdhPJx1OxZZ3RKrxjSrKQtiVOjcEKe2hZLtXa+SV4AiPF06dGcRfVxGwqlxXacD5FNY1dgeGx+M6g==
X-Received: by 2002:a17:902:d4ca:: with SMTP id o10mr24427520plg.28.1643691910056;
        Mon, 31 Jan 2022 21:05:10 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id u37sm6181991pga.2.2022.01.31.21.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:05:09 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: [PATCH 0/2] firmware: Add boot information to sysfs
Date:   Tue,  1 Feb 2022 15:34:59 +1030
Message-Id: <20220201050501.182961-1-joel@jms.id.au>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second iteration of this idea. The first used socinfo
custom attribute groups, but Arnd suggested we make this something
standardised under /sys/firmware instead:

 http://lore.kernel.org/all/CAK8P3a3MRf0aGt1drkgsuZyBbeoy+S7Ha18SBM01q+3f33oL+Q@mail.gmail.com

Some ARM systems have a firmware that provides a hardware root of
trust. It's useful for the system to know how this root of trust has
been configured, so provide a standardised interface that expose this
information to userspace.

This is implemented as a sysfs attribute group registration to be called
at boot, with the properties described in the ABI document.

Alternatively we could put the properties in the driver core, and have
platforms register callbacks for each supported property. This would
make it harder to insert non-standard properties, with the trade off of
more code to selectively show supported properties.

An user of the properties is provided in the second patch.

Joel Stanley (2):
  firmware: Add boot information sysfs
  ARM: aspeed: Add secure boot controller support

 .../ABI/testing/sysfs-firmware-bootinfo       | 43 ++++++++++
 drivers/base/firmware.c                       | 14 ++++
 drivers/soc/aspeed/aspeed-socinfo.c           | 84 ++++++++++++++++++-
 include/linux/firmware_bootinfo.h             |  8 ++
 4 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-bootinfo
 create mode 100644 include/linux/firmware_bootinfo.h

-- 
2.34.1

