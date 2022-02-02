Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4D64A700D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbiBBLgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiBBLgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:36:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19A7C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:36:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56C3D616E3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 11:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F07C004E1;
        Wed,  2 Feb 2022 11:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643801767;
        bh=UyZaJ0tB41ZV6qBFKK9qIgn5LBAmyc6MC+K+6DFNjjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Db18p5vr4c8W40fy+RORFCyNFR8aqxfBfI6Vy+ODBeUx/blR7PxB1PJ/iCWUVxnMb
         nxGC8BMUbjizY78IYE0jYgBs9+4BLCiwDSvBDdS6u2HikLWZeWflhd/DpPrvSAmoy8
         Jy+Z9GTjuJs3bowDt9RVwduyGJvWIvrrOoi3q1ywlE7hhVYEkrQ8sKpepnQJIZQ7rC
         3chnSUOFKc0juQIVvC6xOHzad8HVnhWGLdCErGjEfhzL5GH9yV7/YBjQoWYueKm5kn
         DhuoXjj6abIUFADblDBtaJg4mjp+mTSKf5wkBZYd9Ir5WCZvYe6MBiLlXAxvev8bRL
         JkpbnY/ZP4+JA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nFDvT-0000M1-EE; Wed, 02 Feb 2022 12:35:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Mitchell Tasman <tasman@leaflabs.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] greybus: svc: clean up link configuration hack at hello
Date:   Wed,  2 Feb 2022 12:33:47 +0100
Message-Id: <20220202113347.1288-4-johan@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202113347.1288-1-johan@kernel.org>
References: <20220202113347.1288-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ee2f2074fdb2 ("greybus: svc: reconfig APBridgeA-Switch link to
handle required load") added a temporary hack which reconfigures the
link at HELLO by abusing the deferred request processing mechanism.

Restructure the HELLO request processing so that the link-configuration
work is queued before creating the debugfs files and add a comment
explaining why it's there.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/greybus/svc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
index 4f93d6b2f4ed..56d2b44d6fef 100644
--- a/drivers/greybus/svc.c
+++ b/drivers/greybus/svc.c
@@ -864,16 +864,19 @@ static int gb_svc_hello(struct gb_operation *op)
 		goto err_deregister_svc;
 	}
 
-	gb_svc_debugfs_init(svc);
-
+	/*
+	 * FIXME: This is a temporary hack to reconfigure the link at HELLO
+	 * (which abuses the deferred request processing mechanism).
+	 */
 	ret = gb_svc_queue_deferred_request(op);
 	if (ret)
-		goto err_remove_debugfs;
+		goto err_destroy_watchdog;
+
+	gb_svc_debugfs_init(svc);
 
 	return 0;
 
-err_remove_debugfs:
-	gb_svc_debugfs_exit(svc);
+err_destroy_watchdog:
 	gb_svc_watchdog_destroy(svc);
 err_deregister_svc:
 	device_del(&svc->dev);
-- 
2.34.1

