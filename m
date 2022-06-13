Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDBC54B140
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244701AbiFNM2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiFNM16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:27:58 -0400
Received: from es400ra02.iit.it (mx.iit.it [90.147.26.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF8921273;
        Tue, 14 Jun 2022 05:27:50 -0700 (PDT)
Received: from es400ra02.iit.it (127.0.0.1) id hl1vc40171s9; Mon, 13 Jun 2022 14:05:53 +0200 (envelope-from <prvs=1163b4114e=Andrea.Merello@iit.it>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iit.it;
        s=mx; i=@iit.it; h=Received:Received:From:To:CC:Subject:Date:
        Message-ID:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding:Content-Type; bh=aUZoxGpYAhYC/qP/o8ec4
        zHzeX9HWMOW/GroHMaGBCk=; b=ASugzlOew2+qvpfHQzOJXbQtdZAnfYTzWbnWH
        bayhIrC6x62JBlA3miEePLPYAO/Hg3KN0gL7UIajJBGkhlJ0c1n9H9W7jlE835no
        lWOgNFgSdH+Np1yCE3ynOrANxTs8njH+TsqQlMydPKT93IPMoAz8CSi6bDbvJsTc
        Muvd6o=
Received: from mail.iit.it ([10.255.8.186])
        by es400ra02.iit.it ([172.31.0.242]) (SonicWall 10.0.16.7295)
        with ESMTPS (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256)
        id o202206131205530231023-8; Mon, 13 Jun 2022 14:05:53 +0200
Received: from poker.lan (90.147.26.235) by iitmxwge020.iit.local
 (10.255.8.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.17; Mon, 13 Jun
 2022 14:05:52 +0200
From:   <andrea.merello@iit.it>
To:     <jic23@kernel.org>, <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v6 07/14] iio: add support for binary attributes
Date:   Mon, 13 Jun 2022 14:05:27 +0200
Message-ID: <20220613120534.36991-8-andrea.merello@iit.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613120534.36991-1-andrea.merello@iit.it>
References: <20220613120534.36991-1-andrea.merello@iit.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [90.147.26.235]
X-ClientProxiedBy: IITMXWGE021.iit.local (10.255.8.187) To
 iitmxwge020.iit.local (10.255.8.186)
X-Mlf-DSE-Version: 6873
X-Mlf-Rules-Version: s20220519150137; ds20200715013501;
        di20220610180234; ri20160318003319; fs20220610211824
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: Andrea.Merello@iit.it
X-Mlf-Version: 10.0.16.7295
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202206131205530231023
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
index 4d95d4df5e91..2ea5e19ea56a 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1581,7 +1581,7 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_clear_attrs;
 	}
-	/* Copy across original attributes */
+	/* Copy across original attributes, and point to original binary attributes */
 	if (indio_dev->info->attrs) {
 		memcpy(iio_dev_opaque->chan_attr_group.attrs,
 		       indio_dev->info->attrs->attrs,
@@ -1589,6 +1589,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
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

