Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D790449450D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 01:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357901AbiATAsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 19:48:42 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47094 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345135AbiATAsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 19:48:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 54977CE1F62;
        Thu, 20 Jan 2022 00:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76843C004E1;
        Thu, 20 Jan 2022 00:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642639717;
        bh=O5FhCiqGotWkfKuDJzbML+belVqsTNSDZFAhG2uKTxI=;
        h=Date:From:To:Cc:Subject:From;
        b=O6UsfJaBweTRb3E3PL6BEQkoHr3kW3cWWhSip+v/0YG/LgbVC2IC/yo1nyygZS07Y
         XEEVSuL1eJAM+ZfR7DwV5czgR4uojE6Vmmima7k9PXH5SgtWqOzZcHPJ46DxqfJy5M
         KhXHYam7I2JqZmtLuWFCI+5IHmMTfL+/Bb5a3Wq/b+5wNil77kxiCW3vXuxwoX4rKG
         gBqbrlGr3tW0Lfg6qUNYfayK/jfk8Py0GD9nUSPu25tkl6cd+bhX053wHrLnpxIGoI
         dktVFQd7LfFvNqGrApnNy+H6xHvVP0g7vsTSkkNBGOTYKyRA5it8OcA8V8xHSnyjxR
         V4oBicQ8D/Kgw==
Date:   Wed, 19 Jan 2022 18:55:12 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] USB: serial: garmin_gps: Use struct_size() and
 flex_array_size() helpers in pkt_add()
Message-ID: <20220120005512.GA72984@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() and flex_array_size() helpers instead of
an open-coded version, in order to avoid any potential type mistakes
or integer overflows that, in the worst scenario, could lead to heap
overflows.

Also, address the following sparse warnings:
drivers/usb/serial/garmin_gps.c:270:31: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/160
Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/serial/garmin_gps.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index e5c75944ebb7..1d806c108efb 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -267,13 +267,12 @@ static int pkt_add(struct garmin_data *garmin_data_p,
 
 	/* process only packets containing data ... */
 	if (data_length) {
-		pkt = kmalloc(sizeof(struct garmin_packet)+data_length,
-								GFP_ATOMIC);
+		pkt = kmalloc(struct_size(pkt, data, data_length), GFP_ATOMIC);
 		if (!pkt)
 			return 0;
 
 		pkt->size = data_length;
-		memcpy(pkt->data, data, data_length);
+		memcpy(pkt->data, data, flex_array_size(pkt, data, pkt->size));
 
 		spin_lock_irqsave(&garmin_data_p->lock, flags);
 		garmin_data_p->flags |= FLAGS_QUEUING;
-- 
2.27.0

