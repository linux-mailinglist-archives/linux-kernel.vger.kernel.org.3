Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A0C4EA113
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344142AbiC1UBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbiC1UBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:01:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79427393D4;
        Mon, 28 Mar 2022 12:59:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id AA34B1F43850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648497592;
        bh=Wt3ayzGsMmxeOdSu0lSUaLnN2BhIuPB/Wbnfn/jKVUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DcQ+A85Uofv5sKjmZcd8r3GNXf8kJWW9PmI2jPYDVediCtxMop1xKNQx3h6tko46+
         oRoeTTQnq9vKhLlyxErUsuhz4Cou+Ze4fV9pcfU+yTzFsHI4rcZ8UgxT4s1YDn4lA4
         jAbO+TeggaVC02YTFXR3D8hRANdosjKEd91v86cmya+ss3yxYeEkeJftPpZc5g2JXK
         ZxVLdUJaq78GdJQc+/BGFUx1ErE1FO5htmvgQAOJoqjZGogkRZFx3h05+ZyvQoBjzN
         qeaxVwDifn5SufOPKSwiIO3Vx+K392YfnvE93Rz8QU3WyhNQX/xbNhkUinRLL+85c1
         jer60pS+HQhgQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/24] media: doc: Document dual use of H.264 pic_num/frame_num
Date:   Mon, 28 Mar 2022 15:59:14 -0400
Message-Id: <20220328195936.82552-3-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
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

These two fields needs documentation as they have dual meaning. It is also
confusing since pic_num is a derived value from frame_num, so this should
help application developpers. If we ever need to make a V2 of this API, I
would suggest to remove pic_num entirely.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 .../media/v4l/ext-ctrls-codec-stateless.rst            | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
index 6541e4c32b26..f634f20bcfbe 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
@@ -649,10 +649,16 @@ Stateless Codec Control ID
         :c:type:`timeval` in struct :c:type:`v4l2_buffer` to a __u64.
     * - __u32
       - ``pic_num``
-      -
+      - For short term reference, this should match the derived value PicNum
+	(8-28) and for long term references it should match the derived value
+	LongTermPicNum (8-29). Note that pic_num is the same as FrameNumWrap
+	for frame decoding.
     * - __u16
       - ``frame_num``
-      -
+      - For short term references, this should match the frame_num value from
+	the slice header syntax (the driver will wrap the value if neeeded). For
+	long term references, this should be set to the value of
+	long_term_frame_idx describes in the dec_ref_pic_marking() syntax.
     * - __u8
       - ``fields``
       - Specifies how the DPB entry is referenced. See :ref:`Reference Fields <h264_ref_fields>`
-- 
2.34.1

