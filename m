Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BB254F717
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382159AbiFQL6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380395AbiFQL6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:58:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC87220EB;
        Fri, 17 Jun 2022 04:58:12 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:faf2:1a12:f903:cc5e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 54D35660179A;
        Fri, 17 Jun 2022 12:58:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655467090;
        bh=bmkptHQUlkkCdHC5ksCT9Ab01Sj/lrYkZJFYy5abr5o=;
        h=From:To:Cc:Subject:Date:From;
        b=frdPQspHObR+qQp+aMt1vMTPsEKhPxUimVzD3mf5lVBRs4QpJILObfMH9YhyawfbW
         nJNWbZDKAyt+ILWlmeWko/eNcjEvZHSqxP+GkHvNGH64PzofVTk+ZvMud6k6eZ31cl
         sOXt8FDUjoG10MYruAk3U9q9T6h0rQKaljoCUsSoWQOhmHxzzhci6elqRH6irsqBkY
         CU0Z6FtviZPJDxraRylHumnwPDVIvTnZ6srn8EVQY/yoLv3fXbWRbssXUTRS3P5hYh
         9JFlp1J6cukoY65uaZNzwj8tgCPIA50GPGshdvjNOn2/leQux2HSTsi/LMRyy/UNNd
         A4bzxH0yF1Juw==
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
Subject: [PATCH 0/7] Enable 10bits bitstream for Hantro/G2 HEVC codec
Date:   Fri, 17 Jun 2022 13:57:55 +0200
Message-Id: <20220617115802.396442-1-benjamin.gaignard@collabora.com>
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

This series is based on top of Jernej series: "media: hantro: Add 10-bit
support" v2.
Jernej series is focusing on VP9 and hardware block with legacy regs.
This one add 10bits support for newer hardware blocks (i.e without
legacy regs) and for HEVC codec.

It based tested on IMX8MQ with HEVC conformance tests.
The results are that all 10bits bitstreams are OK.

Benjamin Gaignard (7):
  media: hantro: Store HEVC bit depth in context
  media: hantro: HEVC: Fix auxilary buffer size calculation
  media: hantro: HEVC: Fix chroma offset computation
  media: hantro: postproc: Configure output regs to support 10bit
  media: Hantro: HEVC: Allows 10-bit bitstream
  media: hantro: imx8m: Enable 10bit decoding
  media: hantro: Allows luma and chroma depth to be different

 .../staging/media/hantro/hantro_g2_hevc_dec.c |  4 +--
 drivers/staging/media/hantro/hantro_hevc.c    | 13 +++++----
 .../staging/media/hantro/hantro_postproc.c    |  7 ++++-
 drivers/staging/media/hantro/imx8m_vpu_hw.c   | 27 +++++++++++++++++++
 4 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.32.0

