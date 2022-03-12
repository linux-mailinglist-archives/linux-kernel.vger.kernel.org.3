Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685B34D6E16
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 11:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiCLK2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 05:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiCLK2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 05:28:25 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2151E6951;
        Sat, 12 Mar 2022 02:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=stEf22hi8ODEHQdWrg8iLu47DwcXnuaCT7isJzYDhRA=;
  b=deEbcJzgiOY2sCecLvFUg44QLuAtr9BErJnFjjX61WzAxxWAD+qCeUaH
   z2Mz+OTRc86RDPtIsNA3EKoZAcwkC4E9EmcruQilgOLprVgF2A+e8qBFr
   UbuP2lZhs94moodfwUuMtou2gQ9YUCOzNrNKogsYJk3QF8tsoxBpkHj4d
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,175,1643670000"; 
   d="scan'208";a="25781352"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 11:27:11 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] usb: raw-gadget: use kzalloc
Date:   Sat, 12 Mar 2022 11:27:05 +0100
Message-Id: <20220312102705.71413-7-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220312102705.71413-1-Julia.Lawall@inria.fr>
References: <20220312102705.71413-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzalloc instead of kmalloc + memset.

The semantic patch that makes this change is:
(https://coccinelle.gitlabpages.inria.fr/website/)

//<smpl>
@@
expression res, size, flag;
@@
- res = kmalloc(size, flag);
+ res = kzalloc(size, flag);
  ...
- memset(res, 0, size);
//</smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/usb/gadget/legacy/raw_gadget.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index d86c3a36441e..135e75b891f6 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -1157,7 +1157,7 @@ static int raw_ioctl_eps_info(struct raw_dev *dev, unsigned long value)
 	struct usb_raw_eps_info *info;
 	struct raw_ep *ep;
 
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
 		ret = -ENOMEM;
 		goto out;
@@ -1177,7 +1177,6 @@ static int raw_ioctl_eps_info(struct raw_dev *dev, unsigned long value)
 		goto out_free;
 	}
 
-	memset(info, 0, sizeof(*info));
 	for (i = 0; i < dev->eps_num; i++) {
 		ep = &dev->eps[i];
 		strscpy(&info->eps[i].name[0], ep->ep->name,

