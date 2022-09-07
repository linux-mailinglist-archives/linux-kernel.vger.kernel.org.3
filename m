Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA05B0572
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiIGNj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiIGNia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:38:30 -0400
Received: from es400ra01.iit.it (mx.iit.it [90.147.26.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFE59F0E7;
        Wed,  7 Sep 2022 06:38:15 -0700 (PDT)
Received: from es400ra01.iit.it (127.0.0.1) id h32fbk0171sr; Wed, 7 Sep 2022 15:22:27 +0200 (envelope-from <prvs=1249fcc2cf=Andrea.Merello@iit.it>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iit.it;
        s=mx; i=@iit.it; h=Received:Received:From:To:CC:Subject:Date:
        Message-ID:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding:Content-Type; bh=SsaTJ0GNW2QK5AFniQ8eH
        3uqy8ZfD/cW3iB7la1eLtI=; b=lazNflDxU59oG/5eAXfEetyQt0l2VAahYpZSg
        CAsj26PTHrup9BOf1A7Rp1RBixSoB9HF+VP5cDB60TPXcOahttnd6gB5MShswhDD
        Za+MX1dsO3XigCkgGXnXNP28BJrsFYFxruAkKEZs6h9spYTXhqparzPw/sgaamFT
        HH5mXw=
Received: from mail.iit.it ([10.255.8.186])
        by es400ra01.iit.it ([172.31.0.241]) (SonicWall 10.0.16.7295)
        with ESMTPS (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256)
        id o202209071322270176973-11; Wed, 07 Sep 2022 15:22:27 +0200
Received: from poker.iit.local (10.10.20.64) by iitmxwge020.iit.local
 (10.255.8.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Wed, 7 Sep
 2022 15:22:26 +0200
From:   <andrea.merello@iit.it>
To:     <jic23@kernel.org>, <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>,
        <andrea.merello@gmail.com>, <bagasdotme@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v7 07/14] iio: add support for binary attributes
Date:   Wed, 7 Sep 2022 15:21:58 +0200
Message-ID: <20220907132205.28021-8-andrea.merello@iit.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220907132205.28021-1-andrea.merello@iit.it>
References: <20220907132205.28021-1-andrea.merello@iit.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.10.20.64]
X-ClientProxiedBy: IITMXWGE021.iit.local (10.255.8.187) To
 iitmxwge020.iit.local (10.255.8.186)
X-Mlf-DSE-Version: 6948
X-Mlf-Rules-Version: s20220810181453; ds20200715013501;
        di20220831211829; ri20160318003319; fs20220901203539
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: Andrea.Merello@iit.it
X-Mlf-Version: 10.0.16.7295
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202209071322270176973
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

When a IIO device is registered, the IIO core creates an attribute group on
its own, where it puts the channel attributes, and where it copies the
attributes in indio_dev->info->attrs.

Unfortunately it doesn't take care of binary attributes (i.e. it only
consider indio_dev->info->attrs->attrs, and it ignores
indio_dev->info->attrs->bin_attrs).

Fix this by making the IIO layer take care also of the binary attributes.

Note that while it is necessary to copy the non-binary attributes because
the IIO layer needs more room to add the channels attribute, it should be
enough to assign the bin_attrs pointer to the binary attributes pointed by
indio_dev->info->attrs->bin_attrs.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/industrialio-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 9e661efb6f47..75654cc70ede 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1576,7 +1576,7 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_clear_attrs;
 	}
-	/* Copy across original attributes */
+	/* Copy across original attributes, and point to original binary attributes */
 	if (indio_dev->info->attrs) {
 		memcpy(iio_dev_opaque->chan_attr_group.attrs,
 		       indio_dev->info->attrs->attrs,
@@ -1584,6 +1584,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 		       *attrcount_orig);
 		iio_dev_opaque->chan_attr_group.is_visible =
 			indio_dev->info->attrs->is_visible;
+		iio_dev_opaque->chan_attr_group.bin_attrs =
+			indio_dev->info->attrs->bin_attrs;
 	}
 	attrn = attrcount_orig;
 	/* Add all elements from the list. */
-- 
2.17.1

