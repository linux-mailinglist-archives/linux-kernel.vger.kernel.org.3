Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4DF4BD193
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244959AbiBTUrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:47:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiBTUrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:47:04 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4E0C68;
        Sun, 20 Feb 2022 12:46:41 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id f11so4086855ljq.11;
        Sun, 20 Feb 2022 12:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZYif/qXUCjIlXItIJZJ7t7x6V7RCQjS1IN7zXFkcJZU=;
        b=eKYE/SVzFrsYSwywDGvy23yo/xNfycLoZInrKFeNjwBMKSnuMWl1bg0fiUTr/CQVJS
         DTgBYjO8SYsZoRj6khfuAU4KfuBqnpD/KFK/0vcw/rCoo6k3ymR9d8Jkeb9MP8f5Z6DB
         11wBCymr5UB2CEXShmQl9/Cj/KrVciwkm2Pfb9zHlW08a0G+k7Uh/DciG732PtqfLHCI
         SLhtppuvfiR426QcbVKXvFpRfdy0p1nhHxRKGAMpT89duNyNcyUlQhN8tXa05tda5wnJ
         YYZg9To241R9DOcae2SOvoOOtgV7/89teQjukCOL2jPEhcm2yaZU6nWLz1rMrkXKn/4J
         Xn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZYif/qXUCjIlXItIJZJ7t7x6V7RCQjS1IN7zXFkcJZU=;
        b=RnYdRilxFsCoxDOnQqqdf8SA2sIE8VGh+MPkSS0nGVzK/L+nXgTbQYPBs86VF2VH89
         RQjwlwG3jLJWSkP7JO7x/HXIzoLFMjEAKYIaAukReVn1FZ/KyQe7l/Rn60JEMrTqdguP
         HkXXnPBxFcY4ct/BoiaIysXg7Lz40PJLea2hlS/RhZ2cOtXQgaht9ADrdNR4mS/AlMRg
         9gbszLDD7MvilLaVU8RCkykpylomXtkKJrcUP/aN4nEfK1KlWCc49nYSDBVzOHEvyTxX
         DjN3LStvhzINxgsNh7QFZnhdQaoCvjxKNcLu0vO/5yM+KxKp6LlIV0u5R+nc6sJRXDtd
         zdDw==
X-Gm-Message-State: AOAM532YAobDSjwCKX2e3OLBFLfLwXicmFd3HfdEKsnn6X/VKUMAgaIa
        gFxRF3mywt/t6K+IqFI2Thw=
X-Google-Smtp-Source: ABdhPJzwnsgL0UGwEh/MmpLhmf8eYn/KZ+JyxtGZYB+a9vlz/q8zSg5rXLdNA2bfr5zD6Rl3LR49rQ==
X-Received: by 2002:a2e:ba12:0:b0:246:d5:ead3 with SMTP id p18-20020a2eba12000000b0024600d5ead3mr12797746lja.469.1645389999508;
        Sun, 20 Feb 2022 12:46:39 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id o14sm913955lfo.117.2022.02.20.12.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 12:46:39 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/8] Add V4L stateless video decoder API support to NVIDIA Tegra driver
Date:   Sun, 20 Feb 2022 23:46:15 +0300
Message-Id: <20220220204623.30107-1-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Support V4L stateless video decoder API by NVIDIA Tegra decoder driver.
Tested using GStreamer [1] and libvdpau-tegra [2][8].

[1] https://github.com/grate-driver/gstreamer/commit/b8509bdbb69b534e61419ea1798f32f9ad2f3597
[2] https://github.com/grate-driver/libvdpau-tegra/commit/f822e95911e5e0c39f8ba19f843ddc1e0138d5ce
[8] https://github.com/grate-driver/libvdpau-tegra/commit/80db4d02369f2a984ce3173d6bc305f32e9fdb97

Changelog:

v5: - Corrected drivers/staging/media/Makefile, where I removed the VI
      driver instead of VDE. This was reported by the 0-DAY build bot.

v4: - Added r-b from Nicolas Dufresne to the
      "V4L2_H264_DECODE_PARAM_FLAG_P/BFRAME flags" patch.

    - Added patches to de-stage driver, like was suggested by Hans Verkuil.

    - Added patch to enable driver in ARM's multi-platform defconfig.

v3: - Added new decode_params flags [7] instead of V4L2_BUF_FLAG_*FRAME flags,
      as was suggested by Nicolas Dufresne.

      [7] https://github.com/grate-driver/gstreamer/commit/c5cd847f9c26b7669720ae58f9058de2515f51a2

    - Added new patch that removes legacy UAPI.

v2: - Made V4L2_BUF_FLAG_*FRAME flags mandatory [3] and dropped reading
      of raw bitstream from the driver code, as was suggested by
      Nicolas Dufresne.

      [3] https://github.com/grate-driver/gstreamer/commit/aee292f0f2e84b7654a314dd7e63f916888ffaa5

    - Ran v4l2-compliance [4] and fluster [5][6] tests, like was suggested by
      Nicolas Dufresne. Fixed minor v4l2-compliance errors that were related
      to a partial initialization of the coded format and were harmless in
      practice, but made compliance checker unhappy.

      [4] https://gist.github.com/digetx/5d6bcdab633488f1dcc7c141ab90d30e
      [5] https://gist.github.com/digetx/b06c5d779e9d25afa41d9f46946fe399
      [6] https://gist.github.com/digetx/ac4198bc340e5065aa8ec3288bb21356

Dmitry Osipenko (8):
  media: v4l2-ctrls: Add new V4L2_H264_DECODE_PARAM_FLAG_P/BFRAME flags
  media: staging: tegra-vde: Factor out H.264 code
  media: staging: tegra-vde: Support V4L stateless video decoder API
  media: staging: tegra-vde: Remove legacy UAPI support
  media: staging: tegra-vde: Bump BSEV DMA timeout
  media: staging: tegra-vde: De-stage driver
  ARM: tegra_defconfig: Update CONFIG_TEGRA_VDE option
  ARM: config: multi v7: Enable NVIDIA Tegra video decoder driver

 .../media/v4l/ext-ctrls-codec-stateless.rst   |    6 +
 MAINTAINERS                                   |    2 +-
 arch/arm/configs/multi_v7_defconfig           |    1 +
 arch/arm/configs/tegra_defconfig              |    3 +-
 drivers/media/platform/Kconfig                |   17 +
 drivers/media/platform/Makefile               |    2 +
 drivers/media/platform/tegra/vde/Makefile     |    3 +
 .../platform/tegra/vde}/dmabuf-cache.c        |    2 +-
 drivers/media/platform/tegra/vde/h264.c       |  946 ++++++++++++
 .../platform/tegra/vde}/iommu.c               |    2 +-
 .../platform/tegra/vde}/trace.h               |    2 +-
 drivers/media/platform/tegra/vde/v4l2.c       | 1018 ++++++++++++
 drivers/media/platform/tegra/vde/vde.c        |  551 +++++++
 drivers/media/platform/tegra/vde/vde.h        |  242 +++
 drivers/staging/media/Kconfig                 |    2 -
 drivers/staging/media/Makefile                |    1 -
 drivers/staging/media/tegra-vde/Kconfig       |   10 -
 drivers/staging/media/tegra-vde/Makefile      |    3 -
 drivers/staging/media/tegra-vde/TODO          |    4 -
 drivers/staging/media/tegra-vde/uapi.h        |   73 -
 drivers/staging/media/tegra-vde/vde.c         | 1358 -----------------
 drivers/staging/media/tegra-vde/vde.h         |  125 --
 include/uapi/linux/v4l2-controls.h            |    2 +
 23 files changed, 2794 insertions(+), 1581 deletions(-)
 create mode 100644 drivers/media/platform/tegra/vde/Makefile
 rename drivers/{staging/media/tegra-vde => media/platform/tegra/vde}/dmabuf-cache.c (99%)
 create mode 100644 drivers/media/platform/tegra/vde/h264.c
 rename drivers/{staging/media/tegra-vde => media/platform/tegra/vde}/iommu.c (98%)
 rename drivers/{staging/media/tegra-vde => media/platform/tegra/vde}/trace.h (97%)
 create mode 100644 drivers/media/platform/tegra/vde/v4l2.c
 create mode 100644 drivers/media/platform/tegra/vde/vde.c
 create mode 100644 drivers/media/platform/tegra/vde/vde.h
 delete mode 100644 drivers/staging/media/tegra-vde/Kconfig
 delete mode 100644 drivers/staging/media/tegra-vde/Makefile
 delete mode 100644 drivers/staging/media/tegra-vde/TODO
 delete mode 100644 drivers/staging/media/tegra-vde/uapi.h
 delete mode 100644 drivers/staging/media/tegra-vde/vde.c
 delete mode 100644 drivers/staging/media/tegra-vde/vde.h

-- 
2.34.1

