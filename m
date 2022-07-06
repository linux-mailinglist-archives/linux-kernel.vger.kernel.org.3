Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9ED5691CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiGFS3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiGFS3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:29:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4506AE6;
        Wed,  6 Jul 2022 11:29:13 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c131-20020a1c3589000000b003a19b2bce36so6505948wma.4;
        Wed, 06 Jul 2022 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veq/Lh4TlAFiqd2as2QsDi+5Sf/Jvx1yYHKwqofOJ9o=;
        b=D/GBtbDoDrd9WwaKJrXkQPvMJSnhagjGlrMvRdZngoIOSQDMFwf3riNka9sKWeqUNZ
         68j9wAd8P1tOp6+eYbBL3LPhXmcL7ncpp3SJbkkONwh9iHnHCvJ0LgIh0ehHtblz6Xy/
         mROak7qhzqZU18vdXSDiBY8UhDFH5gcTJ+UksgT6qUUwNmbmFP3P2OKXyEC0qMF1jZfu
         f9p1UF3PpXu/MPUbJN44Um5RfZ/DowbA8xZPZKvbhPd27bczcpR90fcMTtf5GNkgIHXv
         CLclsFl7XWUrDyTonvk+LNSWdVcvt4vpOy0tqASojUCUBmYAGcuvq1TJ5JO93XcQfVq+
         lTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=veq/Lh4TlAFiqd2as2QsDi+5Sf/Jvx1yYHKwqofOJ9o=;
        b=g+7Hb8GVbWLGlf3vn69NRG9mPQ6YOzLB74u3fAlq7SIGzF78B91/os3iKQkE4KrO8T
         hgi9BSHV+Rr/AXRm5YyYJVYP+HI21EH8UETPZ1K3MJErbWoHxrZcJBOmTg//EPMXK6P/
         zrBpK1pomqhCVBZFxoGOZub15O0UTq5PYSzMlir/UKoIOyR3RF1Gf2SLpz4zdELWABTj
         vfFWGIO+dVygV3WasPte8pc5lGF/laxC9osNvGlu8pRmBXOeZGYpt9zoKMsaI2bHC8cr
         82EsYHLZXX2vhaNiUgnA3ZPXn0u31jx/ZG9rLkf7K8i2OWZt1giE4iSyXFX1ZuwoqMuM
         CmIg==
X-Gm-Message-State: AJIora+Cs8qv6U6kzJCUdE5im3szb7fMQJPZgStt/HBFsGN5t6sdOpIM
        XD7BEZnVPuUVn8QLWAYynRo=
X-Google-Smtp-Source: AGRyM1v+PzFf3H84UTOcP8kXa3ogDH7CjY7F56uHMLIutxGcHvpSyE47mzgtd7yg9gcVbPZPjDejGQ==
X-Received: by 2002:a05:600c:600d:b0:3a1:9712:5d31 with SMTP id az13-20020a05600c600d00b003a197125d31mr24463802wmb.67.1657132151725;
        Wed, 06 Jul 2022 11:29:11 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id r15-20020a0560001b8f00b0021d74906683sm5142406wru.28.2022.07.06.11.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:29:11 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v3 0/7] media: hantro: Add 10-bit support
Date:   Wed,  6 Jul 2022 20:28:54 +0200
Message-Id: <20220706182901.78949-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.37.0
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

Changes fron v2:
- rebased on media-stage/master
- added P010 4L4 format documentation
- added t-b and r-b tags

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

 .../media/v4l/pixfmt-yuv-planar.rst           | 18 +++++--
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
 11 files changed, 151 insertions(+), 23 deletions(-)

-- 
2.37.0

