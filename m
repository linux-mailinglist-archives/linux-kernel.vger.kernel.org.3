Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42E64BD05A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244347AbiBTRc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:32:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242967AbiBTRc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:32:27 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C88FC4;
        Sun, 20 Feb 2022 09:32:05 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id d23so14457773lfv.13;
        Sun, 20 Feb 2022 09:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Q3n0Y+E0iTibxw2SrDvuKXdCqveJjmzvnX1uL9SsFk=;
        b=cKMVnhdlUwCAtAKS5QVRJrtD4kMH3k8LViPPur+Ewnfz94uTlcu12C4nQR5YCCtw/O
         aOcoKT43DUlCEthXvDSkg4K5tDIvFneswEn9i42xd82/iB4IgMHaT9uVfdd0zRAhEGLn
         N7h4Y1a4CJnvVUxSdUL6ev2/EB8if9KoGEm046+AGj8rVf2nABLYFZcsZuk1VeQQfXUL
         R8jHQxDM8JZKXsXMue09HzX5ojJbulLCpg+YEBJzNuBTwUXxInFDHN8NEla6YtISj+pX
         MfFQ7/CLNvb2gVtHbHiAyL9c3FWEpM8rIZB0wejDHAbU/xmv1qlFK3MSSIt5/7mFA1U1
         CJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Q3n0Y+E0iTibxw2SrDvuKXdCqveJjmzvnX1uL9SsFk=;
        b=JbIYeukpS6vMXan8FVVioLS5GdFpeVASk2tjfEtG7kNoG41/Vh9CvVsCjG4qk7JKPA
         1cphpOi0UMGp7Cw7pPO2hgCt1E2+uuMnTazusM2Wl1MCK8tI3D4QcKnSKA4xcS2WU3tl
         0OC8AknXsCheCTsk0g5DNf6SHj1AeSN/AkW51LU11t/IYfhuWZ/PWW5Xx4Kjis5v/Qxj
         FubazX7jHihxis8zOx0qseSP+Bj8MbjfufjsSYzGA+kOBTpLUm1BTOO2OQ/l1evYFfb/
         S3E536tG/D2uSHpND6jXIJr9b0AMovI5tu7zaXdaLehlksdeTCo3zs8IiYnC3FNlb/nt
         pV3A==
X-Gm-Message-State: AOAM532HpAfC4Eth9UcXAK+3TyeEW1MMv23wI7U0hdPwkzhQ7aczgyjR
        J6iI5k01m2RLworHCibJ0CE=
X-Google-Smtp-Source: ABdhPJz4DtWFGHyllZUkWLV5wC0O4UDqNaJILkd8FJqwAd32gi5qrzWvQXMmgGn1W6Xkk1zyh7fYvw==
X-Received: by 2002:a19:761a:0:b0:43c:79ae:6aef with SMTP id c26-20020a19761a000000b0043c79ae6aefmr11883967lff.630.1645378323194;
        Sun, 20 Feb 2022 09:32:03 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id f8sm880490ljk.97.2022.02.20.09.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:32:02 -0800 (PST)
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
Subject: [PATCH v4 0/8] Add V4L stateless video decoder API support to NVIDIA Tegra driver
Date:   Sun, 20 Feb 2022 20:29:42 +0300
Message-Id: <20220220172950.3401-1-digetx@gmail.com>
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

