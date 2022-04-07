Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944D74F7750
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiDGHVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiDGHVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:21:50 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D7C8878E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:19:51 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id c15so6277133ljr.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 00:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=spWrYcKOdFPkx7V/bTw1Vt2s30IOz+mRUF4zmksu6mQ=;
        b=FyqWdb6gIKxeVrVuAeWCf3FvBqLaOhrR/SjYm0KsyGakK5ERgmZ5Q1v/I4ntkwgobn
         hlYthisEch6PMC+myPJYKddxKfQ3BY8XT0IvHzQHz2oTxYrzXMmxIrlES5MiYPu6C+IC
         apRU8g2a6aaRjRJoWfIJqRgblGYmQXjJ8s57Ue5o2vNTYlsDE4DaomqJN9zeGVNDYYd9
         XHPk5n6eHeF2kERDafquqlfKN1oFDnYuHOccx2cjr10305FRmb7VsKXKsn+3XOAmVIvC
         bjTT+R1ONZYnskGzKTcWqkaweLj9swhAXWdZp+IaSwmFqS2w54zhHKUVKOL2NT35M0W5
         WsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=spWrYcKOdFPkx7V/bTw1Vt2s30IOz+mRUF4zmksu6mQ=;
        b=vmu3uWWwMSNPoeAawIay2Jmsd1Er2o6zWgOneOhjQeREZuCdM0ohX9JYxZdYZRKYp9
         rJkgTNyU3r8SLnmYQFygXuAbn7Fe/zuN9QfKZ2m2BL7m48/AP0QwHL4OA8W3uwLAR09b
         d+hZQz+g/kGSbJkTmcZg9hrraEhHMngURhGkRx05qpcIkqql39AGr8e8l9F+v6BYvCzI
         rgjIMwvn7lf2DwxqLjwtfqGabGes4uPAetlMiTgAFAgnu9BvtsqX4/7jAi/xP1pPUr32
         7TMCpV68kMmalHu+i1JgnzR81iU28wF3Mdaz6PO82A/SfsLq9TUVOsVnhO9a7tmynO9g
         aAfA==
X-Gm-Message-State: AOAM532A7Cp4rXyHypRy4RhEE2rS+Q/dYQNwkUFICKjMiR14z11SaAbY
        vChs3s/R/9p3aXARbR/2Z0Y=
X-Google-Smtp-Source: ABdhPJwJUzDEU28pZhfXC85eJi/upEh1gZjgy0Gwl5L5LOhJ2xO7R7mU4yWj/MRZ1U86ick83PUMAw==
X-Received: by 2002:a2e:3615:0:b0:24a:fc28:f0b3 with SMTP id d21-20020a2e3615000000b0024afc28f0b3mr7894757lja.4.1649315989563;
        Thu, 07 Apr 2022 00:19:49 -0700 (PDT)
Received: from inno-pc.lan (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id h10-20020a056512220a00b0044a308dad8csm2081465lfu.149.2022.04.07.00.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 00:19:48 -0700 (PDT)
From:   Zhi Wang <zhi.wang.linux@gmail.com>
X-Google-Original-From: Zhi Wang <zhi.a.wang@intel.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org
Cc:     Zhi Wang <zhi.a.wang@intel.com>
Subject: [PATCH v9 0/3] Refactor GVT-g MMIO tracking table and handlers
Date:   Thu,  7 Apr 2022 03:19:42 -0400
Message-Id: <20220407071945.72148-1-zhi.a.wang@intel.com>
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

To support the new mdev interfaces and the re-factor patches from
Christoph, which moves the GVT-g code into a dedicated module, the GVT-g
initialization path has to be separated into two phases:

a) Early initialization.

The early initialization of GVT requires to be done when loading i915.
Mostly it's because the initial clean HW state needs to be saved before
i915 touches the HW.

b) Late initalization.

This phases of initalization will setup the rest components of GVT-g,
which can be done later when the dedicated module is being loaded.

To initialize the GVT-g MMIO tracking table in the early initalization
stage, which will be done in i915, the GVT-g MMIO tracking table needs
to be sperated accordingly and moved into i915.

v9:
- Fix a problem might casue kernel panic.

v8:
- Use SPDX header in the intel_gvt_mmio_table.c
- Reference the gvt.h with path. (Jani)
- Add a missing fix on mmio emulation path during my debug.
- Fix a building problem on refreshed gvt-staging branch. (Christoph)


v7:
- Keep the marcos of device generation in GVT-g. (Christoph, Jani)

v6:
- Move the mmio_table.c into i915. (Christoph)
- Keep init_device_info and related structures in GVT-g. (Christoph)
- Refine the callbacks of the iterator. (Christoph)
- Move the flags of MMIO register defination to GVT-g. (Chrsitoph)
- Move the mmio block handling to GVT-g.

v5:
- Re-design the mmio table framework. (Christoph)

v4:
- Fix the errors of patch checking scripts.

v3:
- Fix the errors when CONFIG_DRM_I915_WERROR is turned on. (Jani)

v2:
- Implement a mmio table instead of generating it by marco in i915. (Jani)

Zhi Wang (3):
  i915/gvt: Separate the MMIO tracking table from GVT-g
  i915/gvt: Save the initial HW state snapshot in i915
  i915/gvt: Use the initial HW state snapshot saved in i915

 drivers/gpu/drm/i915/Makefile               |    2 +-
 drivers/gpu/drm/i915/gvt/firmware.c         |   25 +-
 drivers/gpu/drm/i915/gvt/gvt.h              |    3 +-
 drivers/gpu/drm/i915/gvt/handlers.c         | 1033 ++-------------
 drivers/gpu/drm/i915/gvt/mmio.h             |    1 -
 drivers/gpu/drm/i915/gvt/reg.h              |    9 +-
 drivers/gpu/drm/i915/i915_drv.h             |    2 +
 drivers/gpu/drm/i915/intel_gvt.c            |   92 +-
 drivers/gpu/drm/i915/intel_gvt.h            |   21 +
 drivers/gpu/drm/i915/intel_gvt_mmio_table.c | 1290 +++++++++++++++++++
 10 files changed, 1561 insertions(+), 917 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/intel_gvt_mmio_table.c

-- 
2.25.1

