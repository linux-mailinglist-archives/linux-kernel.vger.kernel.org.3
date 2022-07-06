Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B725691B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiGFS1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiGFS1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:27:07 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB40EBE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:27:06 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id j1so15921276vsj.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCuvC3KKARgxwjZu+UWwv64ohDgzISxggCsLmmOKaJg=;
        b=CW026Qhnh/Fg/pcdz5SXChnvNjXWW9GEWSXnDFiIJ2KUVgt7Yc+3C8zyJ/fesnlZWs
         017Hyvi4L1ztyiqEG8QcTM/wCugeYn2jQHMZ882tSMwEeGudbwf7z13Xxwl3GwAg4Ofo
         stDgBo1K/Du4YZE80dzrdtXICRcNHZ7so8fKLe6YcCZ1GqqMMNeldsa4mj0AIWvr3WPz
         KfC8sGr/E5Gy/BguKD3Cnvg5+bRau7Q69HVynuyobysZx70HRjyzl3I5mDYgfId1QZgf
         u+I+GTpiGI05bfIfFecM1o1mBr40PVSaD4LR/H5PyGUUytI4ZLyLnjiTRYuV5oXpkLc6
         7ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCuvC3KKARgxwjZu+UWwv64ohDgzISxggCsLmmOKaJg=;
        b=ZTSnuRUBV2RiuTBAqzC2bsFojNEPVXWmi/mFHY39vb5vVB0hwXUoOcu8rbVOr/A4zz
         JN02bBnOJPSimgrEaVF9bLrvaLHqsIkWdm76ObAaZOsB8+gNW+OyP5k5dVN8IgOgkoCI
         Wz/Wjmr7a5oFX2Tlsm3uvWIeens8TXxcQpTO3fVskrwMiK6uWr/gKQqLDozSfCNGzv0B
         8SkTl6dDH1147rKhzZvExt4CXusjWYFmxkPlVkCNcbuCfHihesxxU115SEvlhfGSZdqS
         +m6NazYB+Hq1uPOxP2bP2j9WQECUd6bD+z4LD/NUxGi7VamNKyWYFJO9863kAwMMbdBm
         lDBA==
X-Gm-Message-State: AJIora+2K58eyCEzowKDML10e7WhYCals90weRdtPo0o28exPTAAbTv5
        HH995La9Lc1xMtL8OxvzNEscIw==
X-Google-Smtp-Source: AGRyM1s7Nq2UFcr8QMUWBH5PneMXg23yKHFlH21Yzq/ZtPRc3+93wCZfXf/5BjDupWoP35R+BA1gUw==
X-Received: by 2002:a67:ba09:0:b0:354:5d45:67ed with SMTP id l9-20020a67ba09000000b003545d4567edmr23472142vsn.18.1657132025124;
        Wed, 06 Jul 2022 11:27:05 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id bl9-20020a056102508900b003563680212asm7445539vsb.27.2022.07.06.11.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:27:04 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 0/8] videobuf2: Replace vb2_find_timestamp() with vb2_find_buffer()
Date:   Wed,  6 Jul 2022 15:26:49 -0300
Message-Id: <20220706182657.210650-1-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users of vb2_find_timestamp() combine it with vb2_get_buffer()
to retrieve a videobuf2 buffer, given a u64 timestamp.

Therefore, this series removes vb2_find_timestamp() and instead
introduces a vb2_find_buffer, which is more suitable, making
videobuf2 API slightly cleaner.

Ezequiel Garcia (8):
  videobuf2: Introduce vb2_find_buffer()
  mediatek: vcodec: Use vb2_find_buffer
  tegra-vde: Use vb2_find_buffer
  vicodec: Use vb2_find_buffer
  hantro: Use vb2_find_buffer
  rkvdec: Use vb2_find_buffer
  cedrus: Use vb2_find_buffer
  videobuf2: Remove vb2_find_timestamp()

 .../media/common/videobuf2/videobuf2-v4l2.c   | 12 ++---
 .../vcodec/vdec/vdec_h264_req_common.c        |  7 ++-
 .../mediatek/vcodec/vdec/vdec_vp8_req_if.c    |  7 ++-
 .../vcodec/vdec/vdec_vp9_req_lat_if.c         |  8 +--
 .../media/platform/nvidia/tegra-vde/h264.c    |  9 ++--
 .../media/test-drivers/vicodec/vicodec-core.c |  8 +--
 drivers/staging/media/hantro/hantro_drv.c     |  6 +--
 .../staging/media/hantro/hantro_g2_vp9_dec.c  | 10 ++--
 drivers/staging/media/rkvdec/rkvdec-h264.c    | 41 ++++++---------
 drivers/staging/media/rkvdec/rkvdec-vp9.c     | 10 ++--
 drivers/staging/media/sunxi/cedrus/cedrus.h   | 13 +----
 .../staging/media/sunxi/cedrus/cedrus_h264.c  | 16 +++---
 .../staging/media/sunxi/cedrus/cedrus_h265.c  | 16 +++---
 .../staging/media/sunxi/cedrus/cedrus_mpeg2.c | 36 ++++++-------
 .../staging/media/sunxi/cedrus/cedrus_vp8.c   | 50 ++++++-------------
 include/media/videobuf2-v4l2.h                | 12 ++---
 16 files changed, 100 insertions(+), 161 deletions(-)

-- 
2.34.3

