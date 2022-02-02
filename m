Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE434A700C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343929AbiBBLgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:36:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46360 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245578AbiBBLgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:36:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0828FB83092
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 11:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE600C340F0;
        Wed,  2 Feb 2022 11:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643801767;
        bh=mQieYQKkKj2DTVG1ustfGTpy5JdAXgMiVkEJnFEOhjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuEkAgjgVmPST/TCrjUN16vOXGT6aWlRPrByc3G+5md6qNHgYmXqHcSqkyDcXR5Qa
         xQcds3WB1XeFCe+oYNj+qlT4JRYIn4KTiKTREKUM6erVtbUAq8qpSDJmzUsybJudft
         Z3L5/Z+QjSXSKLyrf1i1rOgCtgYFS/Pmpa/FBqh+JAfJqd7MVP/j/kwTspNSLnBLtx
         Aexjz2tNeNxb3CWt1vRDqVSEYsCP/nNlPtb0ExHN36TfHgvtootACFlhb60sQFkFua
         +aQ+NPZX0eLPuRm2Wc8wuF1BbPsVc5nMUO99AhF+Vn+2CsYejaWUX1oMJBwvDv7sBZ
         v/PQebZAOYfvg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nFDvT-0000Lz-BK; Wed, 02 Feb 2022 12:35:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Mitchell Tasman <tasman@leaflabs.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] greybus: svc: clean up hello error path
Date:   Wed,  2 Feb 2022 12:33:46 +0100
Message-Id: <20220202113347.1288-3-johan@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202113347.1288-1-johan@kernel.org>
References: <20220202113347.1288-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While currently safe, it is unnecessary (and confusing) to try to
destroy the watchdog when watchdog creation fails.

Change the corresponding error path to only deregister the svc.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/greybus/svc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
index 51d0875a3480..4f93d6b2f4ed 100644
--- a/drivers/greybus/svc.c
+++ b/drivers/greybus/svc.c
@@ -861,7 +861,7 @@ static int gb_svc_hello(struct gb_operation *op)
 	ret = gb_svc_watchdog_create(svc);
 	if (ret) {
 		dev_err(&svc->dev, "failed to create watchdog: %d\n", ret);
-		goto err_unregister_device;
+		goto err_deregister_svc;
 	}
 
 	gb_svc_debugfs_init(svc);
@@ -874,9 +874,10 @@ static int gb_svc_hello(struct gb_operation *op)
 
 err_remove_debugfs:
 	gb_svc_debugfs_exit(svc);
-err_unregister_device:
 	gb_svc_watchdog_destroy(svc);
+err_deregister_svc:
 	device_del(&svc->dev);
+
 	return ret;
 }
 
-- 
2.34.1

