Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2004F51FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849053AbiDFCc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442140AbiDEWTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:19:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DC270F55;
        Tue,  5 Apr 2022 13:44:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 94D421F441AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649191482;
        bh=p/CNjMUurjHMQVHA7WJucC4cA80P6l/szurKGX62Y7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mskQK/nH0vpAgfYoAirxVigo8RjEmumNogd53c4rEWQscB5g8VBotwTkA/ulPot+U
         R5eQSMXE02jbBrqzZS1FIhAcTGnK3i0EopGf6x/tx/wTwEH3ptl6YBspGtdfo7YCxS
         uUGbpNbUxwRbxzPXqa+7u5evZOsRIeIYoUTemb7SN4BoQg02v/AGEY1SfcEuJZdxKl
         WlTCPLsfU8/D3jmDu2RfzOTkc7XBvllTNvaawWSNGbAsUYTeWgbQ08do4H+9FQGUWm
         WrOhqKtB/2VXlPcoeOoEA3FIV2yspu48EngJCIgQaIhSibp+cVlVdpCZzGZHRHlrTx
         5gVj6LzmTTLjw==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org
Subject: [PATCH v3 01/24] media: doc: Document dual use of H.264 pic_num/frame_num
Date:   Tue,  5 Apr 2022 16:44:02 -0400
Message-Id: <20220405204426.259074-2-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
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
index 6541e4c32b26..49f89b702068 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
@@ -649,10 +649,16 @@ Stateless Codec Control ID
         :c:type:`timeval` in struct :c:type:`v4l2_buffer` to a __u64.
     * - __u32
       - ``pic_num``
-      -
+      - For short term references, this should match the derived value PicNum
+	(8-28) and for long term references it should match the derived value
+	LongTermPicNum (8-29). Note that pic_num is the same as FrameNumWrap
+	for frame decoding.
     * - __u16
       - ``frame_num``
-      -
+      - For short term references, this should match the frame_num value from
+	the slice header syntax (the driver will wrap the value if neeeded). For
+	long term references, this should be set to the value of
+	long_term_frame_idx described in the dec_ref_pic_marking() syntax.
     * - __u8
       - ``fields``
       - Specifies how the DPB entry is referenced. See :ref:`Reference Fields <h264_ref_fields>`
-- 
2.34.1

