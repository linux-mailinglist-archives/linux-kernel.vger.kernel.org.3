Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF8C544EE6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343727AbiFIO0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244864AbiFIO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:26:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8A46D868;
        Thu,  9 Jun 2022 07:26:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3215BB82E02;
        Thu,  9 Jun 2022 14:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D31C3411B;
        Thu,  9 Jun 2022 14:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654784787;
        bh=Flt2fNTf33YYN+sp4CP8u8A0ibFdtD0FZot9OODKhMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z6Dbrwic5F84F51X07thTu9oMbZDMstjM+01q3iZ7hvl4W6So34zHGBwTY04bVELT
         KQ3HmjdcYPUbJX84ocs/zCjqF7eHhAZBr+KvZkLSRGo+7S1rY0rfv7+fw5jmLufKSj
         3R//aePQBVc3LWUQVS4jQdPaXZUWHeQnMwzM899FVP/fLwQ0puxtrXy290aN0YbxPS
         1m+t3t6xcBATTALQqe2pZPEdiW2w4ThXap9FvLFNy7ZXNwc8F03vhC0mZvt3xqTFIP
         QExUthrDaSDOwVQRGoOrTCK49wHqswfEn4fnHN/qnlKom7/lAPvMCU1CvrNjO5s8c7
         0fa8cRvGwBeOA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nzJ79-00069P-Fc; Thu, 09 Jun 2022 16:26:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] media: flexcop-usb: use usb_endpoint_maxp()
Date:   Thu,  9 Jun 2022 16:26:05 +0200
Message-Id: <20220609142605.23620-4-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609142605.23620-1-johan@kernel.org>
References: <20220609142605.23620-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

