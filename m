Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CDF4F5D67
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiDFMSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiDFMQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:16:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8769B820C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:57:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 125so1535730pgc.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5TeASqScFwwkP3ga5oGCfohTpgutsvPzGxNFkO13C4=;
        b=dKMdohNSUNb1VV4EpSBldV0sxbC2qZcFKgj5JaUcxsPdt0jQu/TBh1EIQDcjqPz3im
         I6io8uSg1yVclSAioT1LBzSS+4Fmn3XmEknTCM0HKGKAHSsjQE/FLd5s6cSNl6mWVnGd
         j3GGYE3G8VAJvz0Ji14eQVy51TxNTduEWsFIIYYuICTt2xWtf2U+HsW+i8to+tCUTVAt
         /SFiOTT/VlLEmCkdw+GTFYdDRRCspkItDeYpigR4kSSHovt9Tr5mEl6ibyp6RfLDzPiR
         NvDx0xl2wgqVS/FeXCOhhqO7haiZVIzmFkfTG/ArAqvVhNfEe/AkaHLgXQpXxCZzLymV
         QI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5TeASqScFwwkP3ga5oGCfohTpgutsvPzGxNFkO13C4=;
        b=lxYeFkcLWhDZvlXeBxtrNFySsANieumMMbgVDGcgPDNsPv9nPOenNaYDXeEhPDtEFX
         P3uNtXE3lws7eUyWJwb6FDKGpDTrADV+CxQFezgiof+9+WA/u4hhFyT2VWSASQ0x/yNN
         sf32lAGWyBCIv95hNZud13XQFnQlmNOL5ACp4McD55z2+3ts5I+/wSbR1FwqKqYXrHiG
         Rldl1kxBg+BYOk4psB5EI5NNKiTzSZPKISXjwIMiLGSr0LvvkiqJPRg6Zy9T5JePIDbZ
         ZMry25505oHl990XLOW4SS56HBBqXF6tZx2JfBNYo42OQhIO/abXb/e8ZUo48hPRkQu/
         0GvQ==
X-Gm-Message-State: AOAM531YqlgmkoXePjBEjEyINU/ZsISSl4TrR44TErzghGFJ2dugfkR+
        38lYjrd8118CIEMPwIQHi0H+mb5pVoLP3w==
X-Google-Smtp-Source: ABdhPJzGqOpLo+4QhJgiWLy/NvhEnE0UleX/xsTu79qPm1CYo/cT8O/eV9l1Ao5V/SZS0+a+44GtGQ==
X-Received: by 2002:a65:6e9a:0:b0:382:1804:35c8 with SMTP id bm26-20020a656e9a000000b00382180435c8mr6197058pgb.584.1649231835203;
        Wed, 06 Apr 2022 00:57:15 -0700 (PDT)
Received: from slim.das-security.cn ([103.84.139.52])
        by smtp.gmail.com with ESMTPSA id q18-20020aa78432000000b004fb0a5aa2c7sm18922949pfn.183.2022.04.06.00.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 00:57:14 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     eli.billauer@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] char: xillybus: fix a refcount leak in cleanup_dev()
Date:   Wed,  6 Apr 2022 15:57:03 +0800
Message-Id: <20220406075703.23464-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_get_dev is called in xillyusb_probe. So it is better to call
usb_put_dev before xdev is released.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/char/xillybus/xillyusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index dc3551796e5e..39bcbfd908b4 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -549,6 +549,7 @@ static void cleanup_dev(struct kref *kref)
 	if (xdev->workq)
 		destroy_workqueue(xdev->workq);
 
+	usb_put_dev(xdev->udev);
 	kfree(xdev->channels); /* Argument may be NULL, and that's fine */
 	kfree(xdev);
 }
-- 
2.25.1

