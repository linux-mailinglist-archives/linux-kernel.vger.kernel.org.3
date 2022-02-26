Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E9C4C57B3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiBZSnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiBZSmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:42:43 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DA727EDF3;
        Sat, 26 Feb 2022 10:42:03 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id w1so5529616qtj.2;
        Sat, 26 Feb 2022 10:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ghDZEj/NkkDjCwPou92KJHqMKUcvVac9Orj9JeFveY=;
        b=CoJLuQ9QXYuue/UED91igxeadvZxn8t8dCGl24Y8qKc1xDB7DdJb8fzg3tHjeKN3tY
         1j45CS3BKCMyP5CV6I/i6NIWDwE80hMD1TBrR8McazxO2scH1C/mDJJCeykBQJFe3nEn
         YN2DvqbrT96NCR5sVWJiIxFSIU8K51lna4LokjrgziOATuHdtLpt9d3fUoFhjIw7JjMc
         YYwWJRnGiyHSS5pG8KLCk0Z6+/ozjutzRvEpYel3rSmJL16jipVF1oD/8OCtZlxWvJEE
         6QLbqS0GwLIHqY3sxGVzoAXJuHR/oxwL0CtfiLq4MlLRjW+oZR9vhSFv7D9Edmveb1yZ
         j76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ghDZEj/NkkDjCwPou92KJHqMKUcvVac9Orj9JeFveY=;
        b=GMaSoMm6YzDxIJGoTvarFPuzI+aMNgKaKRynfIVqTvXOHBVp+sPOpg8XLb5wBU+NiG
         zRPiGN+MO1w83oAm0UJ6r8MEmfKyKZ+HWBszXB9wyhe13+xxfPfFzODeaOpSJIEnchVw
         Ln4eeolI1/hVPaVUMNFaFkxhayZWWy/20OqggPRsh0LjZYGiN+QIQDjI3feqFIEPInxn
         VMJ6Om2VL6xAl1G4IbClpZrFCAeE+sQDH5qkXDXJkv8L1E0qIcAjtbRYcDVOKSmuLYj8
         KdLD69XkJUU0oUIsYKV7kLPSo1I1FYFh/lopjIYMt17ES1VtsfA3/lnGEO/Yzvtu5py/
         GPdw==
X-Gm-Message-State: AOAM53160ZQK6b18HAHcuQJiGQEBZXEpCW0NCz8PBcaCy/Srtt4qwmnV
        izxgqWU/KIHfLywGmm61/Ys=
X-Google-Smtp-Source: ABdhPJzEwVSZFWS6p9V5PNcImVSS6RAQMFHr+8F7FqII+D+lzaGNJjf4jqQ550d71lqAgdgdn161ow==
X-Received: by 2002:ac8:5f46:0:b0:2de:783:5bea with SMTP id y6-20020ac85f46000000b002de07835beamr11367722qta.486.1645900922144;
        Sat, 26 Feb 2022 10:42:02 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id p68-20020a378d47000000b006491d2d1450sm2891983qkd.10.2022.02.26.10.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:42:01 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        michael.riesch@wolfvision.net, Peter Geis <pgwipeout@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/11] usb: dwc3: add rk3568 dwc3 support
Date:   Sat, 26 Feb 2022 13:41:44 -0500
Message-Id: <20220226184147.769964-9-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226184147.769964-1-pgwipeout@gmail.com>
References: <20220226184147.769964-1-pgwipeout@gmail.com>
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

The rk3568 dwc3 controller is backwards compatible with the rk3399 dwc3
controller.
Add support for it to the dwc3-of-simple driver.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index 57ba9427ad74..d9d1c5bfac3f 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -195,6 +195,10 @@ static const struct of_device_id of_dwc3_simple_match[] = {
 		.compatible = "rockchip,rk3399-dwc3",
 		.data = &dwc3_of_simple_data_rk3399,
 	},
+	{
+		.compatible = "rockchip,rk3568-dwc3",
+		.data = &dwc3_of_simple_data_rk3399,
+	},
 	{
 		.compatible = "sprd,sc9860-dwc3",
 	},
-- 
2.25.1

