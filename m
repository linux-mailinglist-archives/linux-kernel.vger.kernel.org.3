Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F6C4945A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 02:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358123AbiATBtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 20:49:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44948 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiATBtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 20:49:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3314B81BFA;
        Thu, 20 Jan 2022 01:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA429C004E1;
        Thu, 20 Jan 2022 01:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642643353;
        bh=XVNGFC1UcemnELjzQ0k/YD0qA9SM3qfudnkbbNl7eqE=;
        h=Date:From:To:Cc:Subject:From;
        b=Oj4rKPsIwX2nhI+KKfEncfk32rHuyVRxiOhLR9sN7mCedxrBAwxOAM2S+04QZMvhB
         2CFyfb2nqjwRG07Cy5TBeYDYr+OyZPzT/iYrNE1PdXdgN9E5+VSCaae7NVr4AO8keo
         /qw9pRpUTEbG6ies/dSh05mnFpX6+imOb1VihoEPx/jwqhTzy5ABSzbDSvyrFLq0r5
         XjOR9rtiS4xskS7WywYM0GtizrXQ7tskiwY/01yU9o+CXn0xhWOc+p8yhr2UWNcM/y
         yOEPvut2r8wd/fGyQ2RGyjc4f7E83DO37cArweQKwB1HGMXGuLwm4aZJC0PI4pkZPe
         xBxI9A5LMmjYw==
Date:   Wed, 19 Jan 2022 19:55:46 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] usb: xhci-mtk: Use struct_size() helper in
 create_sch_ep()
Message-ID: <20220120015546.GA75917@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Also, address the following sparse warnings:
drivers/usb/host/xhci-mtk-sch.c:265:20: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/160
Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/host/xhci-mtk-sch.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index edbfa82c6565..f3139ce7b0a9 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -248,7 +248,6 @@ create_sch_ep(struct xhci_hcd_mtk *mtk, struct usb_device *udev,
 	struct mu3h_sch_bw_info *bw_info;
 	struct mu3h_sch_tt *tt = NULL;
 	u32 len_bw_budget_table;
-	size_t mem_size;
 
 	bw_info = get_bw_info(mtk, udev, ep);
 	if (!bw_info)
@@ -262,9 +261,9 @@ create_sch_ep(struct xhci_hcd_mtk *mtk, struct usb_device *udev,
 	else
 		len_bw_budget_table = 1;
 
-	mem_size = sizeof(struct mu3h_sch_ep_info) +
-			len_bw_budget_table * sizeof(u32);
-	sch_ep = kzalloc(mem_size, GFP_KERNEL);
+	sch_ep = kzalloc(struct_size(sch_ep, bw_budget_table,
+				     len_bw_budget_table),
+			 GFP_KERNEL);
 	if (!sch_ep)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.27.0

