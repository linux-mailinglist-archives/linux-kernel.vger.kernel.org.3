Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063F554EB05
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378540AbiFPUZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378359AbiFPUZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:25:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85165B895;
        Thu, 16 Jun 2022 13:25:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z7so3658447edm.13;
        Thu, 16 Jun 2022 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcjgtAok98U2SdMAJ0Kw//o2AG36vAJD03liJbGmfKA=;
        b=QmCRISHCtLT+nw3UyvqMWIcz2JHpZRJ3D/RM3RoaQUco5QZdlnmA6O44Y4WVp8YSWs
         yoHUczvN/fqgBGNgXJQEUtGy95ns7Fu6s1kSfrF9F7zUoGf4l6EonDRTo8TIvRO/T9GM
         9NgleDUsZiDfY5O4grl6ShE0f9roHAPrIg4HW2S4Nnq6NSyaNoLWbnFxhiz949wGw2iS
         kJA4EcIAwVU9R1/GLXGN1Qj4Q5uBMUJ44WhV06KKSICX3GxrpLY6KEGF5XpuDEpopsAu
         SAwZmkBveS9R8OE2GX5hPiM7RK587tFIMSaal5EUQ7CQOLOsOSJmYLuxKx4o6VMHNqNK
         U6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcjgtAok98U2SdMAJ0Kw//o2AG36vAJD03liJbGmfKA=;
        b=rGEFqUQodDZYJibvuv+n1Vm29CfpkCFVplO6cLSDgyUFlHsy4F4WG7BK2EkuiURuwN
         akDf9Kj0zEBG9eyuxO0K8xNvvd/47ghT5JZhILGWme5CuDF7sRiQHqG7Ay7AJWuSdVE4
         5XfP6VeQMSl2v19h56w4ch03njRfIamPURR8cpHNVlbO69fWEgNMutEhehQ2wDq1IRWU
         zeZoFcmO21IVM7qrjmQoPNtnWydCCrqcTXTMAWGzdhdOGgLrRjKYeyzH/oZMmpdmwL9T
         lkVbZ28KOtgvI+P8VKFDFlYV99pyrgdr06k7lqO8GEAKniTiK+SQO+OcYuuhOlTOhs/T
         Kk5g==
X-Gm-Message-State: AJIora/EVhBA+cqWNAEn0Gigy3Xe1C1WkFTujkGqsOcOgmArz7x5KtVR
        qWbRJ+gNN4zhQOZgbkTUD5fhpkf3yQ/6NQ==
X-Google-Smtp-Source: AGRyM1va8bmngwqVTSbwaYJ/gAA2ee63zz6lO5d5tNZrnNA6y3P7Nr9g2uZFj4UdnOWIR3Jiv9JYjA==
X-Received: by 2002:a05:6402:60d:b0:42f:ac38:af75 with SMTP id n13-20020a056402060d00b0042fac38af75mr8463062edv.203.1655411119232;
        Thu, 16 Jun 2022 13:25:19 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906329500b006fe8a4ec62fsm1186760ejw.4.2022.06.16.13.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:25:18 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 0/7] media: hantro: Add 10-bit support
Date:   Thu, 16 Jun 2022 22:25:06 +0200
Message-Id: <20220616202513.351039-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
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

This series adds support for 10-bit format handling in Hantro driver.
Most patches adjust postproc behaviour to be more universal. There is
a lot of assumptions, which need to be replaced with more generalized.

Tested on Allwinner H6. Tested with vp92-2-20-10bit-yuv420.webm sample,
which produces correct checksum.

Please take a look.

Best regards,
Jernej

Changes from RFC:
- fixed typo in function name
- removed merged patch (P010 format)
- removed broken patch (sunxi frequency change)
- added new patch (media: hantro: postproc: Properly calculate chroma offset)
- added r-b from Ezequiel

Ezequiel Garcia (1):
  media: Add P010 tiled format

Jernej Skrabec (6):
  media: hantro: Support format filtering by depth
  media: hantro: postproc: Fix buffer size calculation
  media: hantro: postproc: Fix legacy regs configuration
  media: hantro: postproc: Properly calculate chroma offset
  media: hantro: Store VP9 bit depth in context
  media: hantro: sunxi: Enable 10-bit decoding

 drivers/media/v4l2-core/v4l2-common.c         |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
 drivers/staging/media/hantro/hantro.h         |  4 ++
 drivers/staging/media/hantro/hantro_drv.c     | 23 +++++++++
 .../staging/media/hantro/hantro_g2_vp9_dec.c  |  8 ---
 .../staging/media/hantro/hantro_postproc.c    | 38 +++++++++++---
 drivers/staging/media/hantro/hantro_v4l2.c    | 50 +++++++++++++++++--
 drivers/staging/media/hantro/hantro_v4l2.h    |  3 ++
 drivers/staging/media/hantro/sunxi_vpu_hw.c   | 27 ++++++++++
 include/uapi/linux/videodev2.h                |  1 +
 10 files changed, 136 insertions(+), 20 deletions(-)

-- 
2.36.1

