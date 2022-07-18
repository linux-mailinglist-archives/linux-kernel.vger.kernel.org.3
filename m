Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02614577DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiGRIj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGRIj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:39:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30872BC92;
        Mon, 18 Jul 2022 01:39:55 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4754:89ee:32c6:e620])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 441056601A12;
        Mon, 18 Jul 2022 09:39:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658133593;
        bh=VGO6bJB0It56njxoW1ZluHISXuIAwk0hlWOpYr3qvh0=;
        h=From:To:Cc:Subject:Date:From;
        b=izorKfV6D59nkihSVVKwQzSDN6Be6j30U2dXb1Obk6eo/wo2kD4uc10x9gpPwKBez
         LCuYFa3wmKb1txsaIlMzbu9X3P9OY7ldwE9iQVKcchwLub1flI/Al8DY6J2Wrg+Us6
         +dQUhW1zx0fLkn6aDgZ5mr382mVn1Xgi5nfywkJbjYPa0rAnxsbZ+aaZRkrlAPeAeD
         oZn3P0PbCbYtXQAjp78j3SZx/b+XceGR9DHogelEN05zCeKLFPjJmhALUHUVRcCgP7
         kX+uzdMm4NyQcA1xnayA5AM/u8WgZHUBN2XCWDrYUm/QhPdNYe+s8KMv8hPa38TPyQ
         4OLYDHIsr+zyg==
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
Subject: [PATCH v2 0/7]  Enable 10bits bitstream for Hantro/G2 HEVC codec
Date:   Mon, 18 Jul 2022 10:39:38 +0200
Message-Id: <20220718083945.200845-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since v1 Jernej patches to support 10 bits decoding have been merged.
This v2 rebase the previously send patches and add Ezequiel reviewed-by
tag.
This series add 10bits support for newer hardware blocks (i.e without
legacy regs) and for HEVC codec.

It based tested on IMX8MQ with HEVC conformance tests.
The results are that all 10bits bitstreams are OK.

The problematic point raise by this series is the question of where 
to put HEVC validation function. Does it have to be only hantro_try_ctrl()
or shall it be done also in .run().
This series doesn't change that behavoir so I will argue in farvor to
merge it and to work on this validation time problem when unstaging 
the driver.
Hans, Ezequiel may that sound acceptable for you ? 

Regards,
Benjamin

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

