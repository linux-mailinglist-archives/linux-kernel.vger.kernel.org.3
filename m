Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C644E85D3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 06:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbiC0FBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 01:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiC0FBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 01:01:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399E860E7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:59:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id t5so9796046pfg.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 21:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHNsAztBjVSCg0m+uPcLp8dDTlkHwGXiJqY6E+mYezQ=;
        b=BDd1OXQLkyIhF2TPpy1yj4/krg3BTaW/tLCTAM2Fq8+vsjkw4ioNiv3nXxRyhgkX0r
         szvu9jb3Tue3e3OHb3wy4j/jLiyzFhk51D5srzy6coiAOX1L+IX0JfFKE3t9kpk+XMd5
         dnPrn2mt7A1ZI7jA87LJwIpq0ZsfZ8pe8nOQXyWhpws2r58UYsggy3Wne7ibLS3TNPtW
         9Sj+sOFo8H4aQp8vyPRhKcmBglxfjZKZvg0gBTiH+fwVUDm1PUy2V2/974cJUQlZ+AXS
         nuV4DuWM/Zz6bBgyTx6hciTRZhnyAVcDwE+w30m06OAY/lET4LizZrbw8oytnBMMLrSA
         nIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHNsAztBjVSCg0m+uPcLp8dDTlkHwGXiJqY6E+mYezQ=;
        b=GVwRcMBtOzgasSKkVE9qGA8bWJ5qp/IAak6rro2OCmfXyfNGuFPuKYY7gX+7XYY8bp
         mMYv06Qx7nbH9ojZulQthUXU9/buFJdEKwDpcwET0whzAhfAFmtO4ZkIaK79yUpltXAw
         0hJo9+h9UvuZG/JZHNFIzTw5clhNAGVuAAsGkq932bAiaj6UoDT6pz2elAek1hdluhyR
         TH3FQi+AW3XN2zDlSnpQiWufyo2uMZhQKNQAucSvxqOEcdr2r9QGxLFXhZyapdEoXfgp
         4CMpFDP1ClD7L+3u8yZDgDbg9wCbOxwZeNBXWY/egWsKziNNnHblsP2eEkwVX9TSzOnn
         2JZw==
X-Gm-Message-State: AOAM531n3lc5tv2KEd9utoT8w/iHG+PUXpqvP98FuQg3dEeed8+kjeEf
        UVXqYpl9fH7tnwgyc1+1fgluuFffIrlKiw==
X-Google-Smtp-Source: ABdhPJznd8i9Pt4f7msNeDAc89unzLayc73CdvCyPwxNi0VefbA4r+fkWniXjJxN/YZkdCUzOezejg==
X-Received: by 2002:a63:86:0:b0:36c:48e8:627e with SMTP id 128-20020a630086000000b0036c48e8627emr5730759pga.53.1648357175373;
        Sat, 26 Mar 2022 21:59:35 -0700 (PDT)
Received: from yusufkhan-MS-7B17.lan ([24.17.200.29])
        by smtp.gmail.com with ESMTPSA id w8-20020a63a748000000b0038117e18f02sm9336207pgo.29.2022.03.26.21.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 21:59:35 -0700 (PDT)
From:   Yusuf Khan <yusisamerican@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jasowang@redhat.com, mikelley@microsoft.com, mst@redhat.com,
        gregkh@linuxfoundation.org, javier@javigon.com, arnd@arndb.de,
        will@kernel.org, axboe@kernel.dk,
        Yusuf Khan <yusisamerican@gmail.com>,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v9 0/3] drivers: ddcci: upstream DDCCI driver
Date:   Sat, 26 Mar 2022 21:58:42 -0700
Message-Id: <20220327045845.144742-1-yusisamerican@gmail.com>
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

