Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E3C48A8C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348681AbiAKHsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiAKHsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:48:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAA6C06173F;
        Mon, 10 Jan 2022 23:48:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BADEB81616;
        Tue, 11 Jan 2022 07:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CABC36AE9;
        Tue, 11 Jan 2022 07:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641887328;
        bh=9JOkw+VWeYPNxcZNuDRsaZ8ozRwtIHSZxm6gsaTaUyI=;
        h=Date:From:To:Cc:Subject:From;
        b=TNhvLTHpyAAJ3FnB3MXuQ//gM8c7OGEdO7A+CY2p73E14yUWFwNWAZlkq6+jyX7v4
         ZVG5rxR3LjTDnrqn1zbTHqCkeckZJhnMPsfvZ0iRPUVqYT8hKXCU+FRPl2xQ6JQWj+
         P1g72VEsjI2gShpXVyZbxW8Yekk7u0gU2m3c/OedeEUXcyqJeEd6NRtND6Fzo78vXi
         pu6IhJ2LJO+yVyi8Ip9Jgvwh2vOqhTqut+59fROvHi8bOA1aj7EkEG4KZfE+k2Rn/9
         mIoGVgoFhuMTE54icuSnZqCDnFXtNRGP/SCWhnHMuf6rGHVpB/IkwowJsNplXsL9Lx
         /Jh4SDlZBjr+Q==
Date:   Tue, 11 Jan 2022 01:55:13 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] usb: dwc2: Use flex_array_size() helper
Message-ID: <20220111075513.GA76424@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the flex_array_size() helper to calculate the size of a
flexible array member within an enclosing structure.

This helper offers defense-in-depth against potential integer
overflows, while at the same time makes it explicitly clear that
we are dealing with a flexible array member.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/dwc2/hcd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index f63a27d11fac..2c21498662cd 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4054,8 +4054,9 @@ struct dwc2_tt *dwc2_host_get_tt_info(struct dwc2_hsotg *hsotg, void *context,
 			 * For single_tt we need one schedule.  For multi_tt
 			 * we need one per port.
 			 */
-			bitmap_size = DWC2_ELEMENTS_PER_LS_BITMAP *
-				      sizeof(dwc_tt->periodic_bitmaps[0]);
+			bitmap_size =
+				flex_array_size(dwc_tt, periodic_bitmaps,
+						DWC2_ELEMENTS_PER_LS_BITMAP);
 			if (urb->dev->tt->multi)
 				bitmap_size *= urb->dev->tt->hub->maxchild;
 
-- 
2.27.0

