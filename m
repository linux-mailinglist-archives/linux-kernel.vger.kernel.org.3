Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CAC4EA838
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 08:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiC2G7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 02:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiC2G7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:59:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54202ED50;
        Mon, 28 Mar 2022 23:57:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:a:f397:f6bc:b726:2678:839f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2BF361F43635;
        Tue, 29 Mar 2022 07:57:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648537049;
        bh=szOBLpLdwQa32D4Bqsi6fFyIDa3A9/cqpY4tz/Nklrg=;
        h=From:To:Cc:Subject:Date:From;
        b=BZuw1pQbc6RTFxE4WEZdiGXaQvWl4IjCDX2u0NUtPgKIQqjCWu9rrTazFkSYNn2gr
         rChbXY4UGnlOVwX8+5YN4wSwCbtz5K/Qp/64K3vmZ9EhOTVQwzGaW2rDC5uAxo5mAs
         nSmqNNiEhfsl/30adAsMXAhJc63KRG1YQ78ER/6byhknvusLVxTxjUO6cQIKJVQkd4
         vRRSeIr/FWDxEZREK/L3hmP+9FYHojFWJoJ5ikzHM7d7lg7YtK/JJHGgJ4/xogB4kB
         4B1xcyFfOvE4grOXmtm3sePfD7zCsHOO/oZ5F+zkfpYZTYb31/juyxyyfLtTi4J6dt
         oeBKojLYyn9jw==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] media: docs-rst: Append HEVC specific term
Date:   Tue, 29 Mar 2022 08:56:56 +0200
Message-Id: <20220329065657.8509-1-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the coding tree unit as replacement for the macroblock in the
HEVC codec. Highlight a key difference of the HEVC codec to predecessors
like AVC(H.264) to give a better overview of the differences between the
coding standards.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 Documentation/userspace-api/media/v4l/dev-decoder.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/dev-decoder.rst b/Documentation/userspace-api/media/v4l/dev-decoder.rst
index 3cf2b496f2d0..eb5b1b1e3a51 100644
--- a/Documentation/userspace-api/media/v4l/dev-decoder.rst
+++ b/Documentation/userspace-api/media/v4l/dev-decoder.rst
@@ -72,6 +72,11 @@ coded resolution
 coded width
    width for given coded resolution.
 
+coding tree unit
+   processing unit of the HEVC codec (≘ macroblock units in H.264, VP8, VP9);
+   can use block structures of up to 64×64 pixels;
+   Good at sub-partitioning the picture into variable sized structures.
+
 decode order
    the order in which frames are decoded; may differ from display order if the
    coded format includes a feature of frame reordering; for decoders,
@@ -104,7 +109,8 @@ keyframe
 macroblock
    a processing unit in image and video compression formats based on linear
    block transforms (e.g. H.264, VP8, VP9); codec-specific, but for most of
-   popular codecs the size is 16x16 samples (pixels).
+   popular codecs the size is 16x16 samples (pixels). The HEVC codec uses a
+   slightly more flexible processing unit called coding tree unit (CTU).
 
 OUTPUT
    the source buffer queue; for decoders, the queue of buffers containing
-- 
2.25.1

