Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFBA4F4D71
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582380AbiDEXm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348942AbiDEJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:48:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBB5A1457
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:38:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p189so7580603wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nkD/AciaywdTGKHQbOXWmFjk83Y1bSrfB27hzYXm0xI=;
        b=NnpxvYsBqdGhKQw10fl8I+jFW+0TSKk/XRN6GnXOlx41EpMviuxdB4rMN23OhliIgv
         tgAMQibc8aBuT3j/O0UAAOK/DduW4rP157w43znLLHbgb/7rEl7yQP9rr/p9WTJURqTB
         vOXiOPso0dO9K2ztcYbDXYJ0XYVq9TGRRgZcJid/H+yX3Jw8HDMBd85kWr4ltsJhxsFF
         c8gOWy+VAdKner92D4nhHtN0QabbsS9a3d81iWVu+cLIw8GzbapDNtqJ9AYHedlHZNWh
         wbn+GhdhhH+FLXMTwQ2xui30pywFHwACTjK2rQR1u4pW0ZfGS/cRJErFAsPY4IJb7ro4
         7m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nkD/AciaywdTGKHQbOXWmFjk83Y1bSrfB27hzYXm0xI=;
        b=4it/hoYzWtrWk5LGBP70nYdDjZZ/W7XveRefdzVv6CEeyRolhCVIIaUvLZJBLUGi9k
         b3GKWeI3oxweiZxU0gS1sZcfbfky3U6GxnarMwba7Qtpp3RSpdi+l1wfv5Yg4TisgBdv
         PPzhSmFPg7vdVeKHZEe0J1SIfUmH0KB61t8g0lK0dkgtlmU/9aSZBijON8RU6bCg8tcc
         25+4Me6KXyR6DU/iC/bX5cpXUNCoMg1b/hEtvp9DeQTvj0ThnWuYDrz3Be22hw0QpbIX
         Cwxgl5CUj9749zMghJCBpvF7o8t+Yy6MA5ANqZdSZ/lcgWIYAzgQsZY5CQbIBjRWkdV+
         GU1g==
X-Gm-Message-State: AOAM530oi5DzT7hSjQsSzBMNZRI8x80vZ3uKmXpLRHNeXFlDniWYM4pL
        o3MXuEclHAj86pFhFn4ispIJBTAPce+13Q==
X-Google-Smtp-Source: ABdhPJwkMEdcFMRSetOSc9QI210EtaRngB0m9hh4Crs0LghOWJkF24XQaLI4LFfl/+JKVDgrHnfOVA==
X-Received: by 2002:a05:600c:5106:b0:38e:38f8:858 with SMTP id o6-20020a05600c510600b0038e38f80858mr2185653wms.109.1649151481620;
        Tue, 05 Apr 2022 02:38:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c4e8900b0038cc29bb0e1sm2014358wmq.4.2022.04.05.02.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 02:38:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 00E8F1FFB7;
        Tue,  5 Apr 2022 10:38:00 +0100 (BST)
From:   =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     maxim.uvarov@linaro.org, joakim.bech@linaro.org,
        ulf.hansson@linaro.org, ilias.apalodimas@linaro.org,
        arnd@linaro.org, ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH  v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
Date:   Tue,  5 Apr 2022 10:37:55 +0100
Message-Id: <20220405093759.1126835-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is another attempt to come up with an RPMB API for the kernel.
The last discussion of this was in the thread:

  Subject: [RFC PATCH  0/5] RPMB internal and user-space API + WIP virtio-rpmb frontend
  Date: Wed,  3 Mar 2021 13:54:55 +0000
  Message-Id: <20210303135500.24673-1-alex.bennee@linaro.org>

The series provides for the RPMB sub-system, a new chardev API driven
by ioctls and a full multi-block capable virtio-rpmb driver. You can
find a working vhost-user backend in my QEMU branch here:

  https://github.com/stsquad/qemu/commits/virtio/vhost-user-rpmb-v2

The branch is a little messy but I'll be posting a cleaned up version
in the following weeks. The only real changes to the backend is the
multi-block awareness and some tweaks to deal with QEMU internals
handling VirtIO config space messages which weren't previously
exercised. The test.sh script in tools/rpmb works through the various
transactions but isn't comprehensive.

Changes since the last posting:

  - frame construction is mostly back in userspace

  The previous discussion showed there wasn't any appetite for using
  the kernels keyctl() interface so userspace yet again takes
  responsibility for constructing most* frames. Currently these are
  all pure virtio-rpmb frames but the code is written so we can plug
  in additional frame types. The virtio-rpmb driver does some
  validation and in some cases (* read-blocks) constructs the request
  frame in the driver. It would take someone implementing a driver for
  another RPMB device type to see if this makes sense.

  - user-space interface is still split across several ioctls

  Although 3 of the ioctls share the common rpmb_ioc_reqresp_cmd
  structure it does mean things like capacity, write_count and
  read_blocks can have their own structure associated with the
  command.

As before I shall follow up with the QEMU based vhost-user backend and
hopefully a rust-vmm re-implementation. However I've no direct
interest in implementing the interfaces to real hardware. I leave that
to people who have access to such things and are willing to take up
the maintainer burden if this is merged.

Regards,

Alex
    

Alex Bennée (4):
  rpmb: add Replay Protected Memory Block (RPMB) subsystem
  char: rpmb: provide a user space interface
  rpmb: create virtio rpmb frontend driver
  tools rpmb: add RPBM access tool

 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    9 +
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/rpmb/Kconfig                          |   28 +
 drivers/rpmb/Makefile                         |    9 +
 drivers/rpmb/cdev.c                           |  309 +++++
 drivers/rpmb/core.c                           |  439 +++++++
 drivers/rpmb/rpmb-cdev.h                      |   17 +
 drivers/rpmb/virtio_rpmb.c                    |  518 ++++++++
 include/linux/rpmb.h                          |  182 +++
 include/uapi/linux/rpmb.h                     |   99 ++
 include/uapi/linux/virtio_rpmb.h              |   54 +
 tools/Makefile                                |   16 +-
 tools/rpmb/.gitignore                         |    2 +
 tools/rpmb/Makefile                           |   41 +
 tools/rpmb/key                                |    1 +
 tools/rpmb/rpmb.c                             | 1083 +++++++++++++++++
 tools/rpmb/test.sh                            |   22 +
 19 files changed, 2828 insertions(+), 5 deletions(-)
 create mode 100644 drivers/rpmb/Kconfig
 create mode 100644 drivers/rpmb/Makefile
 create mode 100644 drivers/rpmb/cdev.c
 create mode 100644 drivers/rpmb/core.c
 create mode 100644 drivers/rpmb/rpmb-cdev.h
 create mode 100644 drivers/rpmb/virtio_rpmb.c
 create mode 100644 include/linux/rpmb.h
 create mode 100644 include/uapi/linux/rpmb.h
 create mode 100644 include/uapi/linux/virtio_rpmb.h
 create mode 100644 tools/rpmb/.gitignore
 create mode 100644 tools/rpmb/Makefile
 create mode 100644 tools/rpmb/key
 create mode 100644 tools/rpmb/rpmb.c
 create mode 100755 tools/rpmb/test.sh

-- 
2.30.2

