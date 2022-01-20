Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B1A49567F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 23:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378127AbiATW4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 17:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378120AbiATW4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 17:56:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B9CC061574;
        Thu, 20 Jan 2022 14:56:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92867B81E83;
        Thu, 20 Jan 2022 22:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031DAC340E0;
        Thu, 20 Jan 2022 22:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642719372;
        bh=cXJtDj1YNLbncmpLB50LEfCErflNhAbOSSXX6jCg2tI=;
        h=Date:From:To:Cc:Subject:From;
        b=fNnxkcmY5MoltXFUt/UFWtw6pVtYS56y2qi3xfoTI99Ehq7YFaYABxAa6admBSGxH
         BIXJXC1A6kgt/S4hYMIYytAHpT1ndR58ovxhI5fOkA7J6mMuC6cOJO9d8XFvVio80c
         cbGbXj9xMH1Uuq0FHeBRO58l4n1raNNoyKyJSkh/5JzybfXB0qutkjYbJwpRLRaFJu
         DA8jIalmLHNUJfIw0uFy3sBkzXM+1fiEZR+tU8RCQI9U/rQP21oukNkScIm5Xf//UW
         uF+ihxLaDBCt2PzQcTibhCBYsrJx679hP8uvKU9OhfwgvafJwJXsFWs/NG99+9Q1Yd
         m12H15zMlyoHA==
Date:   Thu, 20 Jan 2022 17:02:47 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] NTB/msi: Use struct_size() helper in devm_kzalloc()
Message-ID: <20220120230247.GA40182@embeddedor>
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
drivers/ntb/msi.c:46:23: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/ntb/msi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index dd683cb58d09..6295e55ef85e 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -33,7 +33,6 @@ int ntb_msi_init(struct ntb_dev *ntb,
 {
 	phys_addr_t mw_phys_addr;
 	resource_size_t mw_size;
-	size_t struct_size;
 	int peer_widx;
 	int peers;
 	int ret;
@@ -43,9 +42,8 @@ int ntb_msi_init(struct ntb_dev *ntb,
 	if (peers <= 0)
 		return -EINVAL;
 
-	struct_size = sizeof(*ntb->msi) + sizeof(*ntb->msi->peer_mws) * peers;
-
-	ntb->msi = devm_kzalloc(&ntb->dev, struct_size, GFP_KERNEL);
+	ntb->msi = devm_kzalloc(&ntb->dev, struct_size(ntb->msi, peer_mws, peers),
+				GFP_KERNEL);
 	if (!ntb->msi)
 		return -ENOMEM;
 
-- 
2.27.0

