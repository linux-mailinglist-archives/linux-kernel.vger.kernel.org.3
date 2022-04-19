Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97531506F97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbiDSOCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345080AbiDSOC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:02:27 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D595039174;
        Tue, 19 Apr 2022 06:59:43 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650376782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mFWtlF0oHPGP6DlOf6E0rXJ/V6DYNXr//ANS9HvqQvw=;
        b=aJtULM7iH7zTY3r4fHqFFgnk7UShgfYh7JBWbfvVijbe+NAZk7o5lf0cGTu4BrE8W68yHM
        5o9hD6w59zxGhT62iGBdulTuLB1xhfCnA3e+QqpQXs6mueg80DkTVbXmdLZShHm+I/ZG/d
        kwxrgWiHz7qYebXVBViiZxDA+YvydT8=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 0/2] drm/nvdla: Add driver support for NVDLA
Date:   Tue, 19 Apr 2022 21:58:58 +0800
Message-Id: <20220419135908.39606-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NVIDIA Deep Learning Accelerator (NVDLA) is an open source IP
which is integrated into NVIDIA Jetson AGX Xavier,
so add driver support for this accelerator.

NVDLA introduce:
http://nvdla.org/primer.html

User mode driver:
https://github.com/caihuoq/nvdla/tree/main/sw/umd


Cai Huoqing (2):
  MAINTAINERS: Add the driver info of the NVDLA
  drm/nvdla: Add driver support for NVDLA

 MAINTAINERS                             |    7 +
 drivers/gpu/drm/Kconfig                 |    2 +
 drivers/gpu/drm/Makefile                |    1 +
 drivers/gpu/drm/nvdla/Kconfig           |    8 +
 drivers/gpu/drm/nvdla/Makefile          |   19 +
 drivers/gpu/drm/nvdla/nvdla_bdma.c      |  200 +
 drivers/gpu/drm/nvdla/nvdla_cache.c     |  215 +
 drivers/gpu/drm/nvdla/nvdla_cdp.c       |  300 ++
 drivers/gpu/drm/nvdla/nvdla_common.c    |  295 ++
 drivers/gpu/drm/nvdla/nvdla_common.h    |  835 +++
 drivers/gpu/drm/nvdla/nvdla_conv.c      |  683 +++
 drivers/gpu/drm/nvdla/nvdla_drm.c       |  695 +++
 drivers/gpu/drm/nvdla/nvdla_drm.h       |  127 +
 drivers/gpu/drm/nvdla/nvdla_engine.c    |  233 +
 drivers/gpu/drm/nvdla/nvdla_engine.h    |  272 +
 drivers/gpu/drm/nvdla/nvdla_gem.c       |  393 ++
 drivers/gpu/drm/nvdla/nvdla_ioctl.h     |   99 +
 drivers/gpu/drm/nvdla/nvdla_pdp.c       |  446 ++
 drivers/gpu/drm/nvdla/nvdla_reg.h       | 6411 +++++++++++++++++++++++
 drivers/gpu/drm/nvdla/nvdla_rubik.c     |  217 +
 drivers/gpu/drm/nvdla/nvdla_sched.h     |   52 +
 drivers/gpu/drm/nvdla/nvdla_scheduler.c | 1005 ++++
 drivers/gpu/drm/nvdla/nvdla_sdp.c       |  728 +++
 23 files changed, 13243 insertions(+)
 create mode 100644 drivers/gpu/drm/nvdla/Kconfig
 create mode 100644 drivers/gpu/drm/nvdla/Makefile
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_bdma.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_cache.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_cdp.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_common.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_common.h
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_conv.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_drm.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_drm.h
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_engine.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_engine.h
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_gem.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_ioctl.h
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_pdp.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_reg.h
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_rubik.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_sched.h
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_scheduler.c
 create mode 100644 drivers/gpu/drm/nvdla/nvdla_sdp.c

-- 
2.25.1

