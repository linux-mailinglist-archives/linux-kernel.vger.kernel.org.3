Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802FD4662A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346396AbhLBLsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhLBLr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:47:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DA3C06174A;
        Thu,  2 Dec 2021 03:44:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 873D3B822AB;
        Thu,  2 Dec 2021 11:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE9FC00446;
        Thu,  2 Dec 2021 11:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638445471;
        bh=q3EQqN3v/X1CEIfgTuQWp/+LwcISKCdBgB34K50KKAI=;
        h=From:To:Cc:Subject:Date:From;
        b=YAcsjPf9KAnTq6UR1HqU88tgXk9OWIGpFZDV26yeDegUwgU91d4SFn/ggMDPE+UNa
         nnWihYVKguH9tEzBIegD6I8LzTZFvm80WJk/rjQkwyewoxjSYODQ2IDg83jvEsbldQ
         9jQSH4wpFnUU9AUlWBfOdX2rIvL4QT8j7pWJiyhIH4qe8WBquHegy3HE15brpCNTas
         D/PvNz/i/1ddlvqyBpTbS18woF3IL8UavkLqCsI9GE9kz+IF7I2a78EOU1sImCTPpp
         BPTNH6UafaLg8PVDaHt9VYW6vmtZCLtG3tfzB3jYxTpYNVXHDK+gJVAEc6LiLgsINW
         fJWuBL7JuhMTw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mskVp-004YiH-3e; Thu, 02 Dec 2021 12:44:29 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Yong Zhi <yong.zhi@intel.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH] media: ipu3: don't use recursion at the Kernel
Date:   Thu,  2 Dec 2021 12:44:26 +0100
Message-Id: <cf020b6a04b3a9d7f08750927b1d100f63ff4689.1638445455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kernel stack is too small. Doing recursions there is a very
bad idea, as, if something gets wrong, it could lead to data
corruption. So, re-implement cio2_check_fwnode_graph() to avoid
recursion.

Compile-tested only.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
index 356ea966cf8d..8e4f250a8b56 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
@@ -1691,16 +1691,15 @@ static int cio2_check_fwnode_graph(struct fwnode_handle *fwnode)
 {
 	struct fwnode_handle *endpoint;
 
-	if (IS_ERR_OR_NULL(fwnode))
-		return -EINVAL;
-
-	endpoint = fwnode_graph_get_next_endpoint(fwnode, NULL);
-	if (endpoint) {
-		fwnode_handle_put(endpoint);
-		return 0;
+	while (!IS_ERR_OR_NULL(fwnode)) {
+		endpoint = fwnode_graph_get_next_endpoint(fwnode, NULL);
+		if (endpoint) {
+			fwnode_handle_put(endpoint);
+			return 0;
+		}
+		fwnode = fwnode->secondary;
 	}
-
-	return cio2_check_fwnode_graph(fwnode->secondary);
+	return -EINVAL;
 }
 
 /**************** PCI interface ****************/
-- 
2.33.1

