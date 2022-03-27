Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97EA4E858B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 06:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiC0E0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 00:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiC0E0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 00:26:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59666655B
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:25:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f10so1707116plr.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHNsAztBjVSCg0m+uPcLp8dDTlkHwGXiJqY6E+mYezQ=;
        b=qzTWniMqA4o089OK0JdH53P6KVzLvqbdsMj/GGYuPCtVU1Ok4AmKiHgmsPgoxPFIIx
         OQjX4PQ8B6kAinA0uftq/4EvP6cloEtT/u0iv5VMIzdrEDIDL1/ToS0X/Ah2ZGb+F2KX
         6Toto/JQd5RUYVhNKy5A6qW5Ws2j/Vvlr0/SLL3XnhbZxXXGEBjHRr64ZHFukM3PLTOj
         Nk38a02MbNkNQjjl75NaQI5wturaJGmGam5Qto7a7WvIEKCLgMDuolJNHd1GVurzqXFw
         BaY1vcRkCsI6p0XNpL+aro6vdC+3rVp+F3YDXBAJWzTIbwcNcaiVWBFpMZY+UmVuyZXk
         0vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHNsAztBjVSCg0m+uPcLp8dDTlkHwGXiJqY6E+mYezQ=;
        b=HMehHwggwnsFS1KDMxQfdu1VSR4sviZkZa6IXNRy0KK1Mq5E/5drWqFKDRESmmy00b
         FTOYSQWvoUXx2aWzgWxjTl66l0e6GNajJDeWIsaUMHVRRWxZnqo2HunlfcG6t6KAdrP4
         wdaPaZxnq+EQAxqF5yWbPb/WJcFGU4lVanVWz7BWZnWFeI5dXFagvxHk2H1RvRwV47YA
         2yhoPZ0cqFce+ot5uLXxN/qOvObBlderiFefxB+mgVoJuB85RJ8j+ezgwJrh+yASaKvh
         9FOL+ELDvk2RywQVmKfglwEKSGcBju6kpamuyDiSwhVuOcqQ5SBZWY3J8gMdHZvHC9ix
         4PwQ==
X-Gm-Message-State: AOAM533wiS6GbcEAbpfOLbSkswBpRRvE2JWeWNInsbSxgPueeYesE0AP
        5f0jKx2FbiPXwGoH/f59p8MDCZgKTd80kw==
X-Google-Smtp-Source: ABdhPJxBlHHhZV2vTNQrFiMYST06lr7fDFuSlspAh9tdBFP5Xg8bCr7I3uUSARgiH8DVHSHeQ8qahA==
X-Received: by 2002:a17:90b:4a48:b0:1c7:bb62:446c with SMTP id lb8-20020a17090b4a4800b001c7bb62446cmr19340081pjb.146.1648355102559;
        Sat, 26 Mar 2022 21:25:02 -0700 (PDT)
Received: from yusufkhan-MS-7B17.lan ([24.17.200.29])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b0038085c0a9d7sm9121038pgo.49.2022.03.26.21.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 21:25:02 -0700 (PDT)
From:   Yusuf Khan <yusisamerican@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jasowang@redhat.com, mikelley@microsoft.com, mst@redhat.com,
        gregkh@linuxfoundation.org, javier@javigon.com, arnd@arndb.de,
        will@kernel.org, axboe@kernel.dk,
        Yusuf Khan <yusisamerican@gmail.com>,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v9] drivers: ddcci: upstream DDCCI driver
Date:   Sat, 26 Mar 2022 21:24:56 -0700
Message-Id: <20220327042459.141515-1-yusisamerican@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch upstreams(adds) the DDCCI driver by Christoph Grenz into
the kernel. The original gitlab page is loacted at https://gitlab
.com/ddcci-driver-linux/ddcci-driver-linux/-/tree/master.

DDC/CI is a control protocol for monitor settings supported by most
monitors since about 2005. A chardev and sysfs interface is provided.
The seccond patch in this series provides a backlight driver using
DDC/CI.

Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
Signed-off-by: Christoph Grenz <christophg+lkml@grenz-bonn.de>
---
v2: Fix typos.

v3: Add documentation, move files around, replace semaphores with
mutexes, and replaced <asm-generic/fcntl.h> with <linux/fcntl.h>.
"imirkin"(which due to his involvement in the dri-devel irc channel
I cant help but assume to be a DRM developer) said that the DDC/CI
bus does not intefere with the buses that DRM is involved with.

v4: Move some documentation, fix grammer mistakes, remove usages of
likely(), and clarify some documentation.

v5: Fix grammer mistakes, remove usages of likely(), and clarify
some documentation.

v6: Change contact information to reference Christoph Grenz.

v7: Remove all instances of the unlikely() macro.

v8: Modify documentation to provide updated date and kernel
documentation, fix SPDX lines, use isalpha instead of redefining
logic, change maximum amount of bytes that can be written to be
conformant with DDC/CI specification, prevent userspace from holding
locks with the open file descriptor, remove ddcci_cdev_seek, dont
refine sysfs_emit() logic, use EXPORT_SYMBOL_GPL instead of
EXPORT_SYMBOL, remove ddcci_device_remove_void, remove module
paramaters and version, and split into 2 patches.

v9: Fix IS_ANY_ID matching for compilers and archs where char is
unsigned char and use the cannonical patch format.
Reported-by: kernel test robot <lkp@intel.com>

Patch 1: Add the main DDCCI component.

Patch 2: Add the backlight driver that utilizes DDCCI.

Patch 3: Add documentation for the DDCCI drivers.

Yusuf Khan (3):
  drivers: ddcci: upstream DDCCI driver
  drivers: ddcci: upstream DDCCI driver
  drivers: ddcci: upstream DDCCI driver

 Documentation/ABI/testing/sysfs-driver-ddcci |   57 +
 Documentation/driver-api/ddcci.rst           |  122 ++
 drivers/char/Kconfig                         |   11 +
 drivers/char/Makefile                        |    1 +
 drivers/char/ddcci.c                         | 1805 ++++++++++++++++++
 drivers/video/backlight/Kconfig              |   11 +
 drivers/video/backlight/Makefile             |    1 +
 drivers/video/backlight/ddcci-backlight.c    |  411 ++++
 include/linux/ddcci.h                        |  163 ++
 9 files changed, 2582 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-ddcci
 create mode 100644 Documentation/driver-api/ddcci.rst
 create mode 100644 drivers/char/ddcci.c
 create mode 100644 drivers/video/backlight/ddcci-backlight.c
 create mode 100644 include/linux/ddcci.h

-- 
2.25.1

