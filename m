Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC634AC1A3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383024AbiBGOny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356602AbiBGOUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:20:23 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF73C0401C5;
        Mon,  7 Feb 2022 06:20:22 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id i34so27238973lfv.2;
        Mon, 07 Feb 2022 06:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3tbiA/lTi3RceFrCX7kiLbJf35Q7/dK3vulX9P+oDY=;
        b=JW2DmgktGCtA3lWb39uboPmJ/rAOmziMI7D4FBMRu/JiWFb9Bc6bLr5fOzz9rFUAfJ
         NK6wb12oDKAPKRhNZ/njTuhqH3rm2S+jbCUPptrfVJvn8Bh9pXKBZfHMjXjl0p95S50K
         NNrKCnwFhWW81SOC1w3GvYNo4nEXMD87p0mGxYnboB44dBiB0ByLSCj0GZgs77XcvzyP
         aIzQ9pxln+8wLs9D+DjrTuU8IKmK5Bd/hsPHf/c3vdguyYDc36ezSmZhb8eJOVDJKwOT
         RdYOqBYM09vlVdcUbPMcjQWFdH/F1KPo3xWR51ptcNMmjXgu0DUVdnyJjBb/pVNZByL/
         Y4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3tbiA/lTi3RceFrCX7kiLbJf35Q7/dK3vulX9P+oDY=;
        b=Un7EAI9H9/6pjJO3KcSFME2lTXYDOfiMuuypKFBQ8W8hBlFMVpR3eNaTrmxCbLIkxP
         gWlEQF7/yPULlIFL2Yxe/MRCtUuMUp211YnZPKtqRleU29PG30OG2xpgoZiQnvHVwbXq
         24hcyWYWJXaaNFJ0mzJmHGIylhUTfNhnuYIZG4yPI+yJhTSQdEHLFGkUqHsMXEOilahk
         TfXf1VZ1UR3pFpmrjsn8dPZyhq2Jj0yxaiAYsQB+nbiwUn7xCYWlJALPdpnf2OhPthlU
         U9BCD7w1/tcy/jHAm8qE9StPox3wM7Q+56lncSE3Hz7ezbFAfjjtOWgRiy05EPEdz5zM
         tXqw==
X-Gm-Message-State: AOAM532I8nvqqvxgZ4mhX4ZsM8WLN7I4KfkLbcCA2Oe0CLkwtK5Nz+9M
        6XOEY/F2THJ8GWo6Rm6W1P8Jhad3WGU=
X-Google-Smtp-Source: ABdhPJz2jRYtIQf+VDpFxEpPreJRl6beEed6w0QevCoUzi6YYmwUUYAO93liG/ahZTUzdPK/TXnA8Q==
X-Received: by 2002:ac2:59ca:: with SMTP id x10mr8666478lfn.499.1644243620782;
        Mon, 07 Feb 2022 06:20:20 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id t13sm1515599lfl.94.2022.02.07.06.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 06:20:20 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Add V4L stateless video decoder API support to NVIDIA Tegra driver
Date:   Mon,  7 Feb 2022 17:19:33 +0300
Message-Id: <20220207141937.13089-1-digetx@gmail.com>
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

Dmitry Osipenko (4):
  media: v4l2-ctrls: Add new V4L2_H264_DECODE_PARAM_FLAG_P/BFRAME flags
  media: staging: tegra-vde: Factor out H.264 code
  media: staging: tegra-vde: Support V4L stateless video decoder API
  media: staging: tegra-vde: Remove legacy UAPI support

 .../media/v4l/ext-ctrls-codec-stateless.rst   |    6 +
 drivers/staging/media/tegra-vde/Kconfig       |    7 +
 drivers/staging/media/tegra-vde/Makefile      |    2 +-
 .../staging/media/tegra-vde/dmabuf-cache.c    |    2 +-
 drivers/staging/media/tegra-vde/h264.c        |  946 +++++++++++++++
 drivers/staging/media/tegra-vde/iommu.c       |    2 +-
 drivers/staging/media/tegra-vde/uapi.h        |   73 --
 drivers/staging/media/tegra-vde/v4l2.c        | 1018 +++++++++++++++++
 drivers/staging/media/tegra-vde/vde.c         |  945 ++-------------
 drivers/staging/media/tegra-vde/vde.h         |  121 +-
 include/uapi/linux/v4l2-controls.h            |    2 +
 11 files changed, 2170 insertions(+), 954 deletions(-)
 create mode 100644 drivers/staging/media/tegra-vde/h264.c
 delete mode 100644 drivers/staging/media/tegra-vde/uapi.h
 create mode 100644 drivers/staging/media/tegra-vde/v4l2.c

-- 
2.34.1

