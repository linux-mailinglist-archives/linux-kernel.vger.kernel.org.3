Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8362A4F0CE0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 01:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376615AbiDCXLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 19:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiDCXLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 19:11:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB5624F06
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 16:09:20 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n18-20020a17090ade9200b001ca699ee462so3118403pjv.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 16:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4n7tXEEi6/dD80wxn36nKd/u2gQw6G3LUR4veaHiktE=;
        b=Ox8jSiTcLwN6tu2ijRwDEIbtML1xA/FisVPSqBftFBey+/Ah6sSMvwhuN6YLfhC9wA
         uRpK5d5GsojInMRBTFyXi9MLOR3fpaCw4atj1lFNH2O1OUjfgmg6PADTbNVHgnJAo/AU
         eAmVLLipFBXopL2FdEiT6VI1CzxbXHmNeDpft7xhWfop++Ud6rULmVeREQaUdSQPIhrh
         55FnbagJAFDg1jDgMpDfiqNGARLA1oKIfNwtoucGU3Sl6RrqMav1jPbncnNZ84u4GUmt
         J2d8pwPiMx1tNBgSAvZxg6DvbJXdxXqXAUxydoOB/g7d+/KLihXn1nbHz2l9crAsd34D
         sw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4n7tXEEi6/dD80wxn36nKd/u2gQw6G3LUR4veaHiktE=;
        b=7B5GKxXmGcDuZwXhV4ECtZtdW9VQq3wf03qa3Ms96BhEJoGhk7nDDaH873w8Snk4ca
         0tdGPycGxt7kKozAdGiLyPPaofCzI1PqLrSvZaVi5XwSVxMk+I5JAoxLkZVKfdOBcfnc
         2iSuv1ptF9Hzp+7P6M+GggUc0/ON2hdC+lbRcBm2uY8qZnEOpe40YKqH59VezvK3GyqK
         ZjyAMZdUXPp5m/1toxHDbHCdWPOf2EcH3H78U6xCU5m1xpsoIAj6phO1CWYUt6j4XO+L
         gca7zidSapH9GfmP6zMIgig82O69ynCT/7r0RRxhvOlJrTGf6XTiYsFK0YU25BIPga8k
         /C0w==
X-Gm-Message-State: AOAM531OfbjAwSyqhcDsB/libYePI3uc3RE/intX/94qr1XHicWAqAfJ
        oR+Hk9wFlpRD/kflmzvKFi4q4UZGvcVibg==
X-Google-Smtp-Source: ABdhPJyXUzGg2F6zOj2/VzZmzV1R14VluaPg9WeJPjSB0H5eXPB157TudkojqOsqAgvm85B8bGMiRA==
X-Received: by 2002:a17:902:7c94:b0:14d:77d2:a72e with SMTP id y20-20020a1709027c9400b0014d77d2a72emr20602127pll.153.1649027359191;
        Sun, 03 Apr 2022 16:09:19 -0700 (PDT)
Received: from yusufkhan-MS-7B17.lan ([24.17.200.29])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004faed463907sm10164503pfo.0.2022.04.03.16.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 16:09:18 -0700 (PDT)
From:   Yusuf Khan <yusisamerican@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jasowang@redhat.com, mikelley@microsoft.com, mst@redhat.com,
        gregkh@linuxfoundation.org, javier@javigon.com, arnd@arndb.de,
        will@kernel.org, axboe@kernel.dk,
        Yusuf Khan <yusisamerican@gmail.com>,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v10 0/3] drivers: ddcci: add drivers for DDCCI
Date:   Sun,  3 Apr 2022 16:08:48 -0700
Message-Id: <20220403230850.2986-1-yusisamerican@gmail.com>
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

This patch adds the DDCCI driver by Christoph Grenz into the kernel.
The original gitlab page is loacted at https://gitlab.com/ddcci-driv
er-linux/ddcci-driver-linux/-/tree/master.

DDC/CI is a control protocol for monitor settings supported by most
monitors since about 2005. A chardev and sysfs interface is provided.
A backlight driver using DDCCI is also provided in the seccond patch.

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

v10: Change patch title to "drivers: ddcci: add drivers for DDCCI
and change" and change patch descriptions to add more detailed
explanations of function.

Patch 1: Add the main DDCCI component.

Patch 2: Add the backlight driver that utilizes the DDCCI driver.

Patch 3: Add documentation for the DDCCI drivers.

Yusuf Khan (3):
  drivers: ddcci: add drivers for DDCCI
  drivers: ddcci: add drivers for DDCCI
  drivers: ddcci: add drivers for DDCCI

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

