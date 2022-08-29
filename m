Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A9A5A5187
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiH2QWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiH2QWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:22:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66A543E71;
        Mon, 29 Aug 2022 09:22:09 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:3d67:aec0:f788:1143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D42376600360;
        Mon, 29 Aug 2022 17:22:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661790128;
        bh=iBVc29gKZFKqyDDdPbh8NNqE2+5tS5jY80daWeZGfmw=;
        h=From:To:Cc:Subject:Date:From;
        b=i6qHqulyX4bx1mBsTqn1R7eaM5k9788KC9y/nCwrzs43gu99+zGQZLJgy21cV0gEk
         IdQ0bsVqESQOv40FBuADSyI2x0mZHF9XYkgtw8fqNDWoDMv/TenC7+vwCyNnFd+Rqp
         ZEfLa5EmB/Q/d1Wq+M9w1ISzETPO4R9WACAuWg8un+gsyeDPUnBqJw786ogbShNwtX
         SahsN/L8+LbNqtxpxPdcRUaBpJ8Nmz1OylEo8RMvqDmIVhEyiMWGatkCW/YIXZG4L8
         A7N0VpcyvJ6YMF8HGE9YhX895bUMAH2ylC7CJVJahqG2e8ldq+GdMrK+q8lFimP3iP
         ErSui+dKCqkow==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 0/7] Enable 10bits bitstream for Hantro/G2 HEVC codec
Date:   Mon, 29 Aug 2022 18:21:52 +0200
Message-Id: <20220829162159.881588-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add 10bits support for newer hardware blocks (i.e without
legacy regs) and for HEVC codec.

Tested on IMX8MQ with HEVC conformance tests, the result is that all 
10bits bitstreams are OK.

version 3:
- Based on top of Ezequiel's patch "media: destage Hantro VPU driver"

Benjamin Gaignard (7):
  media: hantro: Store HEVC bit depth in context
  media: hantro: HEVC: Fix auxilary buffer size calculation
  media: hantro: HEVC: Fix chroma offset computation
  media: hantro: postproc: Configure output regs to support 10bit
  media: Hantro: HEVC: Allows 10-bit bitstream
  media: hantro: imx8m: Enable 10bit decoding
  media: hantro: Allows luma and chroma depth to be different

 .../media/platform/verisilicon/hantro_drv.c   | 14 ++++++----
 .../platform/verisilicon/hantro_g2_hevc_dec.c |  4 +--
 .../media/platform/verisilicon/hantro_hevc.c  |  4 +--
 .../platform/verisilicon/hantro_postproc.c    |  7 ++++-
 .../media/platform/verisilicon/imx8m_vpu_hw.c | 27 +++++++++++++++++++
 5 files changed, 45 insertions(+), 11 deletions(-)

-- 
2.32.0

