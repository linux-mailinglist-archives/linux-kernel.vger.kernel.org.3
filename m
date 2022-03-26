Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39374E8475
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 22:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiCZVlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 17:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiCZVlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 17:41:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0555E647A;
        Sat, 26 Mar 2022 14:39:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:b:56bb:fa6d:7c35:3706:d2b9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9D0C91F44384;
        Sat, 26 Mar 2022 21:39:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648330779;
        bh=slQoeK6b6StFtm2hZoQBdtzcrLQJWl5fg+7Pyg1mb9s=;
        h=From:To:Cc:Subject:Date:From;
        b=XP3jTwnq2dQ4WFzePRR5BCQvg6TQoPKzJAd3jhwVxaFIR9j5DhGq3qVlsB2ZNjBSR
         m2zwaXKzALymE2rJ2uj3vcki3LGKGJqBzL/X0nFjGN6dpuJ0cTAGbouQDAWIxfkYjF
         tL7WK6SrngyGm7SFqHK/qTEBToKwMpO+Ce/yHwUCvhw+6FOG38EzIaKeHkpDHjECEP
         BHDpRHEgucQHFN1xKFtCDcAw5UuD84tiyJvrBLRzsR6rXpCf/sbLWVttRjjgu8L4LE
         D2Lq/oQJHntAEjuBwE7o5WrcPlczL+L2+xUF7WHgfO2in8Xf0y4Ekir0PXpYmfmvXr
         UNgv3GS6sU4vQ==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     acourbot@chromium.org, tfiga@chromium.org,
        hverkuil-cisco@xs4all.nl,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2 0/2] HEVC enhancements
Date:   Sat, 26 Mar 2022 22:39:25 +0100
Message-Id: <20220326213927.103680-1-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reading the definitions for codecs, I felt that the definition
list could be appended with the term used in HEVC. This makes the list
more complete from my point of view, but I see that this is a slippery
slope as we surely don't want to add every term from every codec (Thus
the RFC).

Secondly, I renamed the H265 identifier found in the cedrus driver to
HEVC. The idea here is mainly to align it with the other drivers like
Hantro and RkVDEC, but also with the goal of using one identifier within
the source tree (to simply searching for the term and also for less
confusion).

Changes since V1:
- Kernel test robot reported some variables that had not replaced, I
changed those.

Sebastian Fricke (2):
  media: docs-rst: Append HEVC specific term
  staging: media: cedrus: Rename H265 to HEVC

 .../userspace-api/media/v4l/dev-decoder.rst   |   8 +-
 drivers/staging/media/sunxi/cedrus/Makefile   |   2 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c   |  30 +-
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  14 +-
 .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
 .../cedrus/{cedrus_h265.c => cedrus_hevc.c}   | 438 +++++++++---------
 .../staging/media/sunxi/cedrus/cedrus_regs.h  | 394 ++++++++--------
 .../staging/media/sunxi/cedrus/cedrus_video.c |   4 +-
 8 files changed, 453 insertions(+), 447 deletions(-)
 rename drivers/staging/media/sunxi/cedrus/{cedrus_h265.c => cedrus_hevc.c} (53%)

-- 
2.25.1

