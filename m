Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1BE565A21
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiGDPm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiGDPmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:42:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5EE11472
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:42:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l68so5622822wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cBYKztTgLIZXtAHXN6ufusaGqO1+qT245DniRkr75B0=;
        b=hepq4twEffNi47SjGmYWEMPKiv48Idb7HIkctWFoQCcTYH+dJ2riBXTCfMc3lC7T/2
         r5y+kCYWgBBMkrdlciqLySVUzVsfp2eo58FO56Ompno3USElgDd31cNkQtHc3ZZpip0C
         6PUItynR1m2+n79fDN6oqvanY2rGiYUFf8FO5yx/B/hcypFf77WYDBm5VzeUjNYgLPeC
         tw5JDui+nMq2GrbHokx/eyU+kg6CLUynN8o72q67168rYFWqnbMYZDN/JDljkpQAemut
         o5gQmepoviq5a/EdV7i9kxOjHfzUHySiaj6SbjPXLa5j/zfy/sorMhqxBCih9D4N3h3j
         X57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cBYKztTgLIZXtAHXN6ufusaGqO1+qT245DniRkr75B0=;
        b=bSWOSZ70qStaYiq2i0vc0OWa0upB0DJ1P1DgyrrMGdH4ZthQVzSNLK5O6w0KsYs+/K
         Li9A0V4yrdg6GrxXbVLcwdyMJ1RIugU7GtJyuOyyNn2v9njDo2YtgHbj/KzokCiGORyI
         9fci3YVbEr4Rsxj6UfBSvjrGhSQtahWXSU+9vVz3WyPS6yjWAjEwKZVqWDxFWt0DSn51
         97bx7Cqnl4ogV7n0dcvTjTo8kwrfShliB05GXMTVUh+eRkDOSoVwkvIW3z89U7NR/wWw
         F8CYObOROpCi4BN2cWv1BejZIEFl+0qJIZhdV09IJrKHCo8KAQfz9pz4/vBdcCnVV742
         oSJw==
X-Gm-Message-State: AJIora+AiYpkJVJOkxnMcVYc83Fv3IKxGtNYCUrrWwrXpKCRgHqL/iru
        CNZztCkTsfzXqOGzek0+fU1p8Q==
X-Google-Smtp-Source: AGRyM1vYDL+f/RomUEcTuT8P9geDQbjGZlU+LWFvGlWZLsEo+pEMXr0ylTGtIPWD28n5FzP9ycbjtg==
X-Received: by 2002:a05:600c:a47:b0:39e:f953:84e2 with SMTP id c7-20020a05600c0a4700b0039ef95384e2mr33582967wmq.202.1656949371714;
        Mon, 04 Jul 2022 08:42:51 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a9e8:9fdd:fa2d:1c72])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b0021d6b851ca1sm2763749wrr.111.2022.07.04.08.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:42:51 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        leo.yan@linaro.org, acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 0/7] coresight: syscfg: Extend configfs for config load
Date:   Mon,  4 Jul 2022 16:42:42 +0100
Message-Id: <20220704154249.11501-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set extends the configfs support to allow loading and unloading of
configurations as binary files via configfs.

Additional attributes - load and unload are provided to in the
/config/cs-syscfg subsytem base group to implement the load functionality.

Routines to generate binary configuration files are supplied in
./tools/coresight.

Example generator and reader applications are provided.

Tools may be cross compiled or built for use on host system.

Documentation is updated to describe feature usage.

Changes since v3:
1) Rebase & tested on coresight/next - 5.19-rc3 - which includes the
fix patch for earlier configfs works.
2) Lockdep investigations resulted in re-design of some of the code
accessing configfs.
3) moved load and unload attributes to root of cs-syscfg. (Mathieu)
4) Additional minor fixes suggested by Mathieu.
5) Memory for configfs loaded and unloaded configurations is now
explicitly freed.
6) LOCKDEP nesting fix for configfs base code (fs/configfs/dir.c)

Changes since v2:
1) Rebased & tested on coresight/next - 5.18-rc2
2) Moved coresight config generator and reader programs from samples to
tools/coresight. Docs updated to match. (suggested by Mathieu)
3) userspace builds now use userspace headers from tools/...
4) Other minor fixes from Mathieu's review.

Changes since v1:
1) Rebased to coresight/next - 5.16-rc1 with previous coresight config
set applied.
2) Makefile.host fixed to default to all target.

Mike Leach (7):
  coresight: configfs: Update memory allocation / free for configfs
    elements
  coresight: configfs: Add in functionality for load via configfs
  coresight: configfs: Add in binary attributes to load files
  coresight: configfs: Modify config files to allow userspace use
  coresight: tools: Add config file write and reader tools
  Documentation: coresight: docs for config load via configfs
  configfs: Fix LOCKDEP nesting issues with fragment semaphores

 .../trace/coresight/coresight-config.rst      | 202 +++++-
 MAINTAINERS                                   |   1 +
 drivers/hwtracing/coresight/Makefile          |   2 +-
 .../coresight/coresight-config-file.c         | 583 ++++++++++++++++++
 .../coresight/coresight-config-file.h         | 139 +++++
 .../hwtracing/coresight/coresight-config.h    |  27 +
 .../coresight/coresight-syscfg-configfs.c     | 300 +++++++--
 .../coresight/coresight-syscfg-configfs.h     |   3 +
 .../hwtracing/coresight/coresight-syscfg.c    | 107 ++++
 .../hwtracing/coresight/coresight-syscfg.h    |   2 +
 fs/configfs/configfs_internal.h               |   3 +
 fs/configfs/dir.c                             |  45 ++
 tools/coresight/Makefile                      |  52 ++
 tools/coresight/coresight-cfg-bufw.c          | 309 ++++++++++
 tools/coresight/coresight-cfg-bufw.h          |  26 +
 tools/coresight/coresight-cfg-example1.c      |  62 ++
 tools/coresight/coresight-cfg-example2.c      |  95 +++
 tools/coresight/coresight-cfg-examples.h      |  22 +
 tools/coresight/coresight-cfg-file-gen.c      |  61 ++
 tools/coresight/coresight-cfg-file-read.c     | 227 +++++++
 tools/coresight/coresight-config-uapi.h       |  76 +++
 21 files changed, 2298 insertions(+), 46 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-config-file.c
 create mode 100644 drivers/hwtracing/coresight/coresight-config-file.h
 create mode 100644 tools/coresight/Makefile
 create mode 100644 tools/coresight/coresight-cfg-bufw.c
 create mode 100644 tools/coresight/coresight-cfg-bufw.h
 create mode 100644 tools/coresight/coresight-cfg-example1.c
 create mode 100644 tools/coresight/coresight-cfg-example2.c
 create mode 100644 tools/coresight/coresight-cfg-examples.h
 create mode 100644 tools/coresight/coresight-cfg-file-gen.c
 create mode 100644 tools/coresight/coresight-cfg-file-read.c
 create mode 100644 tools/coresight/coresight-config-uapi.h

-- 
2.17.1

