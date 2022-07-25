Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89E57FAAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiGYIAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiGYIAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:00:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDCD13D10;
        Mon, 25 Jul 2022 01:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40083B80DFD;
        Mon, 25 Jul 2022 08:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E47C341C6;
        Mon, 25 Jul 2022 08:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658736001;
        bh=foX6nf1pYS8r8PQACJBat3Wk6rDL4/p2BD6eGaKMujI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMP6cfhgD8NZdjE0/kEUhFFzKnxpxcp402c3tWetzjeP7OsuvvqjcpWe1ja5i4w6z
         ELMl0ruvhApRJH5SZKayPsqoN+eC0Fkhx3d4DgaSjbcn02iuKFlPEcd5jIAeTWl39j
         EUEUbze1SjaeBkO2kIcIbzBRAvLv5fngOs+SKjqVxeTd7Hu3ZLFlo2yboceFa8OxGN
         zb3OZ25ESyEjSSmbbdtdOqVTtQEAx3Ed6/tNC8sN6x92KvV0dPwqO8FaOmdDP28UlM
         zaH3mJku1p2zocQExzUYxVUJEaw5FaDtVC39eVkNYLo4TUvUVF2EFjpR9bPe7tUeEH
         35J7fQUWZuFJg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFt0d-0000K1-TY; Mon, 25 Jul 2022 10:00:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Yan Xinyu <sdlyyxy@bupt.edu.cn>, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/7] USB: cdc: add control-signal defines
Date:   Mon, 25 Jul 2022 09:58:35 +0200
Message-Id: <20220725075841.1187-2-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725075841.1187-1-johan@kernel.org>
References: <20220725075841.1187-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add defines for the Control Signal Bitmap Values from section 6.2.14
SetControlLineState of the CDC specification version 1.1.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/uapi/linux/usb/cdc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/usb/cdc.h b/include/uapi/linux/usb/cdc.h
index 6d61550959ef..372c81425cae 100644
--- a/include/uapi/linux/usb/cdc.h
+++ b/include/uapi/linux/usb/cdc.h
@@ -271,6 +271,10 @@ struct usb_cdc_line_coding {
 	__u8	bDataBits;
 } __attribute__ ((packed));
 
+/* Control Signal Bitmap Values from 6.2.14 SetControlLineState */
+#define USB_CDC_CTRL_DTR			(1 << 0)
+#define USB_CDC_CTRL_RTS			(1 << 1)
+
 /* table 62; bits in multicast filter */
 #define	USB_CDC_PACKET_TYPE_PROMISCUOUS		(1 << 0)
 #define	USB_CDC_PACKET_TYPE_ALL_MULTICAST	(1 << 1) /* no filter */
-- 
2.35.1

