Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7744C50FE00
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350335AbiDZNBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349620AbiDZNBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:01:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEAE177D42;
        Tue, 26 Apr 2022 05:58:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id E17851F4398D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650977880;
        bh=9s/jwY2vdLbXyetN/42aw11t+0XH2cY1iw+Tw9pwgjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SD2dBeBEPnw4SkKggKXX/LgBYHxa0D6QIbxvHQ8/1wQl/7UOkD6cR0nng3rxHTK4G
         n7TTUOrZIfzBJtD567KrT5hA1/ysn1AD9ftnij4IGMB74FEfkJY628zjIOAiPXvc2r
         SP4xE6HTr9ibOgOhPGCaXkm79eH2w5A7+VjhJOwzZB8TcsGE5juocOfezPv1eOHO4o
         fR2Cs1deoXfdrCXcPkP86lfYe1L0gy82ntgKY65xgtPKF/ZgNRkQmxg5rlU13xEBOx
         KeUDK5Qba1zszzOL2QfBobU9Ah45QbrHelGSBaTW4W672qEaMl2ELZOvSxr8oKFXNC
         Xl/rppY7ZHQDA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/24] media: doc: Document dual use of H.264 pic_num/frame_num
Date:   Tue, 26 Apr 2022 08:57:27 -0400
Message-Id: <20220426125751.108293-2-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
References: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two fields need documentation as they have dual meaning. It is also
confusing since pic_num is a derived value from frame_num, so this should
help application developers. If we ever need to make a V2 of this API, I
would suggest to remove pic_num entirely.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 .../media/v4l/ext-ctrls-codec-stateless.rst            | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
index 6541e4c32b26..bee73065e993 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
@@ -649,10 +649,16 @@ Stateless Codec Control ID
         :c:type:`timeval` in struct :c:type:`v4l2_buffer` to a __u64.
     * - __u32
       - ``pic_num``
-      -
+      - For short term references, this must match the derived value PicNum
+	(8-28) and for long term references it must match the derived value
+	LongTermPicNum (8-29). When decoding frames (as opposed to fields)
+	pic_num is the same as FrameNumWrap.
     * - __u16
       - ``frame_num``
-      -
+      - For short term references, this must match the frame_num value from
+	the slice header syntax (the driver will wrap the value if needed). For
+	long term references, this must be set to the value of
+	long_term_frame_idx described in the dec_ref_pic_marking() syntax.
     * - __u8
       - ``fields``
       - Specifies how the DPB entry is referenced. See :ref:`Reference Fields <h264_ref_fields>`
-- 
2.34.1

