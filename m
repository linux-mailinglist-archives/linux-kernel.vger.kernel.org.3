Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A854E86FE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 10:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiC0IpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiC0IpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 04:45:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F4D12638;
        Sun, 27 Mar 2022 01:43:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sebastianfricke)
        with ESMTPSA id C330E1F43B72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648370613;
        bh=INLkQOuU6uxTQWGv+sxVcWj5yV5vGhrfHwKmC71mvdE=;
        h=From:To:Cc:Subject:Date:From;
        b=k0rV74oa1wGyGe4JFG9iXe0ukLvmzk7b4yNpzvdNneOkZydGuVjgjnT3DI18F3E57
         vZK2sOZp/R4uUhLKqR2++UmSDDeTxaPl+tD30FyN9fXZ83k3z8eZSWX7bd66vQjQHY
         BfjKUmkT5ACQxDMYBxxRW1HO7Qo6IjK5vaxawpIYqBj9Yj1l4ffYombSAHs6/4ibJh
         pJ62pLU01zqQYIcYFVwKaI2WyoWPFu6E3iFDzS587JJCPSNNcPE5rTr1U8MijZJiap
         23BXjPXtSsWS+DMxqxRYqVmeem1492onNn7xjlxWyM4yIZl5FIeV8BmlW/jCu5gxGY
         Oh7IvFN1hUtZA==
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
Subject: [RFC PATCH v3 0/2] HEVC enhancements
Date:   Sun, 27 Mar 2022 10:43:06 +0200
Message-Id: <20220327084308.9053-1-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes since V2:
- A few more missed replacements

Sebastian Fricke (2):
  media: docs-rst: Append HEVC specific term
  staging: media: cedrus: Rename H265 to HEVC

 .../userspace-api/media/v4l/dev-decoder.rst   |   8 +-
 drivers/staging/media/sunxi/cedrus/Makefile   |   2 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c   |  30 +-
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  14 +-
 .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
 .../cedrus/{cedrus_h265.c => cedrus_hevc.c}   | 438 +++++++++---------
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |   4 +-
 .../staging/media/sunxi/cedrus/cedrus_regs.h  | 394 ++++++++--------
 .../staging/media/sunxi/cedrus/cedrus_video.c |   4 +-
 9 files changed, 455 insertions(+), 449 deletions(-)
 rename drivers/staging/media/sunxi/cedrus/{cedrus_h265.c => cedrus_hevc.c} (53%)

-- 
2.25.1

