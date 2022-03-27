Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2D14E85CD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 06:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiC0EuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 00:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiC0Et4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 00:49:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E82725EC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:48:17 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id c2so9694437pga.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHNsAztBjVSCg0m+uPcLp8dDTlkHwGXiJqY6E+mYezQ=;
        b=nsZp+Jb0qHclM+hp0W9RKqgqcrVHS95OgK/8YpDo8s/I+2n7/pDxqex+m40AxkBUbW
         ue9sUADaOmMs6nfWUQdqoLGtwdNmal3fBiJeY6tIdOu0JmotBjPeLownRogEjp5joAEB
         qGfstoYs6YsnoXe/Qss3ZRP9aQkLYqwHAXEk4pXEO47le6bhexcxEqI5wBdTqlWGwF5r
         mycA/SKqXWJXgXJ8LhDkG3bOWG2ViSTVbfEqrR1pahPuGR2gNNVNwpVwtOW/f+OGwve2
         SjRMyZ38zDASmm9Sy3Sb64NScYG58MfF1z801vpiqM1EGjsvhbLdk1hU8kx84ENn5dFI
         tpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHNsAztBjVSCg0m+uPcLp8dDTlkHwGXiJqY6E+mYezQ=;
        b=N1d6fJ0pW6MMIdy8mB8xDQS7EIth8LIpIlu22Wr4tBMGB4iF+axRXRlde2NhAk5+Tg
         GJMVC+PpbV/Cy378WpH4iDe6hR9LO62GQabuoVU96ZwxjONg9aHwNxr7TFbgUn9ZPZ4+
         WKsrbK0oAlWoH6t/NcjDgfgb9Hp5QuTosWH05PviAdWYFf4G3tfsVGqGwXkFmV66M5IO
         1cmimVZwEfo6AQj6evg8JvY6/x7DVEGS7Im9J5Eg8Veg0moNO+MEEclRfyFoH2r2BBAC
         XEytle2z2MzRUR5N8oK07O7JV+mCg/vnWXKFlFuI1P+5S6MXMDR+sUyUPRYznBNcHAeS
         EEVg==
X-Gm-Message-State: AOAM533Q4vRJCF5dCvhEGJdZWfW73Yzt1oeHsOF5eai/1reE0kQozk/k
        PA3lv/YLWJ/suGqtRXo0jdwm2EtVt6Ms3g==
X-Google-Smtp-Source: ABdhPJzaKIV2kzbIHcwHXEKiTxfLfveUH5YYB//go9o/UJFJ0JoJ90dhJnxVLuuY83tc70oU/tnLyA==
X-Received: by 2002:a65:6a4a:0:b0:380:fd52:1677 with SMTP id o10-20020a656a4a000000b00380fd521677mr5538620pgu.597.1648356496755;
        Sat, 26 Mar 2022 21:48:16 -0700 (PDT)
Received: from yusufkhan-MS-7B17.lan ([24.17.200.29])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b004e17e11cb17sm12063138pfc.111.2022.03.26.21.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 21:48:16 -0700 (PDT)
From:   Yusuf Khan <yusisamerican@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jasowang@redhat.com, mikelley@microsoft.com, mst@redhat.com,
        gregkh@linuxfoundation.org, javier@javigon.com, arnd@arndb.de,
        will@kernel.org, axboe@kernel.dk,
        Yusuf Khan <yusisamerican@gmail.com>,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v9 0/3] drivers: ddcci: upstream DDCCI driver
Date:   Sat, 26 Mar 2022 21:46:54 -0700
Message-Id: <20220327044656.142958-1-yusisamerican@gmail.com>
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

