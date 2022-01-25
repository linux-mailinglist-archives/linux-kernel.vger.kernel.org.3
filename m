Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935E349BF52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiAYXEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiAYXDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:03:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6C6C06161C;
        Tue, 25 Jan 2022 15:03:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6FBC2CE19A7;
        Tue, 25 Jan 2022 23:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5A8C340E0;
        Tue, 25 Jan 2022 23:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643151826;
        bh=j21Bv3ihuDIqFh63lBoPgd7clmpHK7UKh1kdC+XWpAE=;
        h=Date:From:To:Cc:Subject:From;
        b=Wq/rpAPH+zWq5OzOXZ8qSslul+4yXrHab4r5LVIUOTblZplHC7zOwiylgP4gjVScA
         bpoiQcROcLUFVhsQThsb4tT5772yC7brI2u5SOla8o1A56mHm669lr1Dwyav/Z2WIa
         MaHgSl8ayo9hx7pL8nb+AGCBDORdcaSrdTOOCJxjng4S6KDhGzIYM64akX+6EluOFV
         CGlCJyR3fq3P+a4P0Arsaq0G7THBr0OQNPjugN1yk9830k4ZLC9iOvTriPRxdxQWrc
         +fNAL56ucoZyIFlpCFjWiA+0OihvTXH0shJMWYatjuDQo0kIoI/Gx+xpbr3dtuYBaR
         hLx1RdyfSqccw==
Date:   Tue, 25 Jan 2022 17:10:33 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] scsi: core: Use struct_size() helper in kmalloc()
Message-ID: <20220125231033.GA79247@embeddedor>
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
drivers/scsi/scsi.c:390:27: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 211aace69c22..949cb530e360 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -387,7 +387,7 @@ static struct scsi_vpd *scsi_get_vpd_buf(struct scsi_device *sdev, u8 page)
 	int vpd_len = SCSI_VPD_PG_LEN, result;
 
 retry_pg:
-	vpd_buf = kmalloc(sizeof(*vpd_buf) + vpd_len, GFP_KERNEL);
+	vpd_buf = kmalloc(struct_size(vpd_buf, data, vpd_len), GFP_KERNEL);
 	if (!vpd_buf)
 		return NULL;
 
-- 
2.27.0

