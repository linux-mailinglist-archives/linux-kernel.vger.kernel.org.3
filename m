Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08CC5B0CBE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiIGSz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIGSzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:55:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F5780371;
        Wed,  7 Sep 2022 11:55:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A3BC619A2;
        Wed,  7 Sep 2022 18:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8819BC433C1;
        Wed,  7 Sep 2022 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662576950;
        bh=dpJMvDdBTLp5BymS0AQR0+IWGQyDaRp/R/kXNsuQsfY=;
        h=Date:From:To:Cc:Subject:From;
        b=Evgabar0ezseNAy0a/spJe6h3v5c5D8n2L5/t0KrF4Y+5GUAaR+cCcBwbjtkKGFsi
         n12JjIQjkMcpLWaoYDs3xkbzLWsD9zZFgf1Xz08lWEo0/2U9TMvKZZs7FhkpJXLvi8
         NoEHuhpd+5bDAAmZARsf6DOYFq56wwIokoJo7cgmwRM8HRaV20VpZeU8c6evnZpfEM
         2BUMZeSIpzXCyCn/GPrCHOopWogbPSfKmfvZ53ZJZU3AxYuv+V/pw/GWUDIQrxY/xx
         imTpJPXmX1Khkuxi8Xkg0ZdRCutA0mrRt1gfbE6Sd8N+qunjYohIE1Jzp9awk5EDoM
         HWG/G8FOxK9gA==
Date:   Wed, 7 Sep 2022 19:55:44 +0100
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] media: usb: pwc-uncompress: Use flex array destination
 for memcpy()
Message-ID: <YxjpMMUb3WP5Rbu7@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing run-time destination buffer
bounds checking for memcpy(), specify the destination output buffer
explicitly, instead of asking memcpy() to write past the end of what looked
like a fixed-size object.

Notice that raw_frame is a pointer to a structure that contains
flexible-array member rawframe[]:

drivers/media/usb/pwc/pwc.h:
190 struct pwc_raw_frame {
191         __le16 type;            /* type of the webcam */
192         __le16 vbandlength;     /* Size of 4 lines compressed (used by the
193                                    decompressor) */
194         __u8   cmd[4];          /* the four byte of the command (in case of
195                                    nala, only the first 3 bytes is filled) */
196         __u8   rawframe[];      /* frame_size = H / 4 * vbandlength */
197 } __packed;

Link: https://github.com/KSPP/linux/issues/200
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/media/usb/pwc/pwc-uncompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/pwc/pwc-uncompress.c b/drivers/media/usb/pwc/pwc-uncompress.c
index faf44cdeb268..cf2591a9675c 100644
--- a/drivers/media/usb/pwc/pwc-uncompress.c
+++ b/drivers/media/usb/pwc/pwc-uncompress.c
@@ -39,7 +39,7 @@ int pwc_decompress(struct pwc_device *pdev, struct pwc_frame_buf *fbuf)
 			 * first 3 bytes is filled (Nala case). We can
 			 * determine this using the type of the webcam */
 		memcpy(raw_frame->cmd, pdev->cmd_buf, 4);
-		memcpy(raw_frame+1, yuv, pdev->frame_size);
+		memcpy(raw_frame->rawframe, yuv, pdev->frame_size);
 		vb2_set_plane_payload(&fbuf->vb.vb2_buf, 0,
 			struct_size(raw_frame, rawframe, pdev->frame_size));
 		return 0;
-- 
2.34.1

