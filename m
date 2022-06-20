Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73639551360
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbiFTIv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240086AbiFTIvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:51:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9430112D17;
        Mon, 20 Jun 2022 01:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31A136131F;
        Mon, 20 Jun 2022 08:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93498C3411B;
        Mon, 20 Jun 2022 08:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655715103;
        bh=cCjUEpE4tfIxUY7qbHwYPFmyW8LE7YJOL0Ay7McEbUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dm0/aXPSCdIe5fFAcnEXeV2Q7piESuUbsNFC2P+SvXd81ncfYwcdAVpqd1xFXqj+z
         zPguwFDRIXFEiyXDdGLkozp1ELag7EqtWZeGmy+SGbFZFXgZ0LWIjM7KJeb37w9G0u
         YZX65z6VUnlw2phm9MsTiEn+a6bxvPCOx1NE/z2IRluK4qumxHNOHA8deMOvZxCBBC
         ias7s0eESCiu46WLcNsOs5Xn4DaWbkfpZ9Abl5rADZBZiPAMH+DRlYMgvlY1tmtolo
         4TdzHTtqbt0NeR1E/xtB5URHLPQ9glTKa7SUA3FKzPqIo9JUiDV1naGf4HVYbXORYK
         r+hhVGVqdWVqA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3D8F-0005Tq-No; Mon, 20 Jun 2022 10:51:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] Input: usbtouchscreen - add driver_info sanity check
Date:   Mon, 20 Jun 2022 10:46:28 +0200
Message-Id: <20220620084628.20894-3-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620084628.20894-1-johan@kernel.org>
References: <20220620084628.20894-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sanity check on the device id-table driver_info field to make sure
we never access a type structure (and function pointers) outside of the
device info array (e.g. if someone fails to ifdef a device-id entry).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/input/touchscreen/usbtouchscreen.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 6683554f0e92..f90acbeea74f 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1656,6 +1656,9 @@ static int usbtouch_probe(struct usb_interface *intf,
 	if (id->driver_info == DEVTYPE_IGNORE)
 		return -ENODEV;
 
+	if (id->driver_info >= DEVTYPE_COUNT)
+		return -EINVAL;
+
 	endpoint = usbtouch_get_input_endpoint(intf->cur_altsetting);
 	if (!endpoint)
 		return -ENXIO;
-- 
2.35.1

