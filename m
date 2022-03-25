Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4004E7DC5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiCYTZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCYTZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:25:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC4D3DFD05
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 11:57:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id yy13so17156449ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 11:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVjY+0+WQdrpFP0Z4+mXCq1mql+ycXs6eG3CZHDrAmU=;
        b=lojiQifx8p87NyqVcH+S1qS6PCpqH5hv3kq4ooLqiFC6LxWDa9UgXn8DlfDAioSt1j
         KSAuBaTunUxouxmXWo2+15PDH/VN/ieCBsBJjuXFbc2xfnfwVCtSGvaagNNpTDQGdZgE
         GP918nP4FtvgObAnrg127i02SvnAsUwXRs55MBrgGN+iQOAb1f6li/1MjBa9/AIbQjcl
         mgniBgRiqj/I+/X+mqlQZ3Yf4r8wOKWKwWOdxvUj92XMj6UjWxYclsnxsu9WGd2BMtBK
         AKM5VkfdFaGTir6C62aKUl6BF7HJFlvGSMaTZIWstEg+TiHsrgU4JcvQ7X03/T8g0qeI
         4+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVjY+0+WQdrpFP0Z4+mXCq1mql+ycXs6eG3CZHDrAmU=;
        b=2TabadfczzJhLbkVOQcbqhv4hAk0N4f42xQoNQQIIae082Hj4G2O68zK/qfqF7Tucx
         aRPjXYm5GCcE5oy+q6xwLWU2gvEl69mV0yTkt7fzXwKV207vAiKFrUeX4x4OlqmtVKgx
         6tVwr/TcqxyqyGcjfwrOZRCJyNNcd+SrrDhSV/quYh++EeKX3m1RQJNrzBlvkRDR8+mY
         QA9AzkWWWcR/DVGfwsaJcvyc1MUQDbYkqz9/TV2F11wN2wmK3049U/d8afqSjgQdJsen
         iMyCEkgrCW1TCtyTl+6cusNZ7wqjrIswc02SM39kXc1BjkKEGpSQf2XI2mT2kNL7L1H9
         e3ng==
X-Gm-Message-State: AOAM5317fvUMnPGwHt8WygVOJdsM8rxZETsNPfa6NKQxq8/O/LaWwNBD
        m7t2JB5hvu1mEAKXi4TwzEDYfkmZT+E=
X-Google-Smtp-Source: ABdhPJxAEnH5lsTxK0dwzXh9eTKtgIhBWkNU0rp0Ctj3hfRmVeqJzFqWeVIH6b285IubNGFGBU7ROg==
X-Received: by 2002:ac2:57d4:0:b0:448:2cba:6c86 with SMTP id k20-20020ac257d4000000b004482cba6c86mr8667977lfo.201.1648230681400;
        Fri, 25 Mar 2022 10:51:21 -0700 (PDT)
Received: from inno-pc.lan (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id h18-20020a056512339200b0044a2e5b94afsm777155lfg.56.2022.03.25.10.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:51:20 -0700 (PDT)
From:   Zhi Wang <zhi.wang.linux@gmail.com>
X-Google-Original-From: Zhi Wang <zhi.a.wang@intel.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Zhi Wang <zhi.a.wang@intel.com>
Subject: [PATCH v7 0/3] Refactor GVT-g MMIO tracking table and handlers
Date:   Fri, 25 Mar 2022 13:51:13 -0400
Message-Id: <20220325175116.167097-1-zhi.a.wang@intel.com>
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
 drivers/gpu/drm/i915/gvt/handlers.c         | 1031 ++-------------
 drivers/gpu/drm/i915/gvt/mmio.h             |    1 -
 drivers/gpu/drm/i915/gvt/reg.h              |    9 +-
 drivers/gpu/drm/i915/i915_drv.h             |    2 +
 drivers/gpu/drm/i915/intel_gvt.c            |   92 +-
 drivers/gpu/drm/i915/intel_gvt.h            |   21 +
 drivers/gpu/drm/i915/intel_gvt_mmio_table.c | 1308 +++++++++++++++++++
 10 files changed, 1577 insertions(+), 917 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/intel_gvt_mmio_table.c

-- 
2.25.1

