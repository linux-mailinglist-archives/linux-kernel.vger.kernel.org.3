Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FE559C288
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbiHVPWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiHVPV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:21:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CBB40E02;
        Mon, 22 Aug 2022 08:15:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02F15CE12E6;
        Mon, 22 Aug 2022 15:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43675C433B5;
        Mon, 22 Aug 2022 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661181312;
        bh=Flt2fNTf33YYN+sp4CP8u8A0ibFdtD0FZot9OODKhMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hrAxaiOh6dVwItj/jEl7ojMqVVBChpG9MdST54WmEYfYLd3Gfj91IQ6lQU0XvBiSg
         KP/8p4Ha98p6hP2a6/BeAKdaNXWGjk9A/pO4BahtMMBYp8hAHR+jcJXivnAcCTdYz8
         2krWE2xJoHW6a8J6WSSAxd1FcqyVdJmKkNe5iYDGyQl56pBAxXzOJ77L/DhIKHudzd
         4r2J9AYsrNmKFOEfdv7t67jRz28cmxaReE+labLvfK5NQT8sexrEMwlK6DSdeLnr9V
         ZYD49hgibMI7GA7Gw8uTUGSFC/I4cyzCoQc1cKd6Ky1aB94L33NSp8rGrZDz6AOl41
         7Vc2Pudg1Oe2w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oQ98w-00074m-H2; Mon, 22 Aug 2022 17:15:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH RESEND 3/3] media: flexcop-usb: use usb_endpoint_maxp()
Date:   Mon, 22 Aug 2022 17:14:56 +0200
Message-Id: <20220822151456.27178-4-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220822151456.27178-1-johan@kernel.org>
References: <20220822151456.27178-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the usb_endpoint_maxp() helper instead of open coding.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/media/usb/b2c2/flexcop-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
index 7102b346db05..790787f0eba8 100644
--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -430,7 +430,7 @@ static int flexcop_usb_transfer_init(struct flexcop_usb *fc_usb)
 	int bufsize, i, j, ret;
 	int buffer_offset = 0;
 
-	frame_size = le16_to_cpu(alt->endpoint[0].desc.wMaxPacketSize);
+	frame_size = usb_endpoint_maxp(&alt->endpoint[0].desc);
 	bufsize = B2C2_USB_NUM_ISO_URB * B2C2_USB_FRAMES_PER_ISO * frame_size;
 
 	deb_ts("creating %d iso-urbs with %d frames each of %d bytes size = %d.\n",
-- 
2.35.1

