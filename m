Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0795B58F946
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiHKImu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbiHKImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:42:45 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DCE18E0DA;
        Thu, 11 Aug 2022 01:42:45 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 3A12E1E80CE3;
        Thu, 11 Aug 2022 16:40:42 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QgsDFPFouBp6; Thu, 11 Aug 2022 16:40:39 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 565891E80D32;
        Thu, 11 Aug 2022 16:40:39 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     gregkh@linuxfoundation.org
Cc:     johan@kernel.org, kernel@nfschina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        zhoujie@nfschina.com
Subject: [PATCH v2] usb/serial:Repair function return value
Date:   Thu, 11 Aug 2022 16:42:37 +0800
Message-Id: <20220811084237.6651-2-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20220811084237.6651-1-zhoujie@nfschina.com>
References: <YvS8AK9apa7tnYOz@kroah.com>
 <20220811084237.6651-1-zhoujie@nfschina.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repair function return value,The previous return value did not work.

v2:
  Modifying function return value type does not work.

Signed-off-by: Zhou jie <zhoujie@nfschina.com>
---
 drivers/usb/serial/mos7720.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 1e12b5f30dcc..215b1c87fa07 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -243,9 +243,8 @@ static inline int mos7715_change_mode(struct mos7715_parport *mos_parport,
 				      enum mos7715_pp_modes mode)
 {
 	mos_parport->shadowECR = mode;
-	write_mos_reg(mos_parport->serial, dummy, MOS7720_ECR,
+	return write_mos_reg(mos_parport->serial, dummy, MOS7720_ECR,
 		      mos_parport->shadowECR);
-	return 0;
 }
 
 static void destroy_mos_parport(struct kref *kref)
-- 
2.18.2

