Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B244F7D5E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244610AbiDGK7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiDGK7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEE761C111
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649329060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OODoJ8pFOZGJN2UYeqJECfB5fJd3ylT7ksI+gG/N4Z4=;
        b=Ug3nTSQPvuBJe0BGXqZ0iZdwtyfHjqBSKN96ahqpU/HPG/HJ9M7Q4Bej/MgDXdH4d3OnBe
        2NOSM7Fh9p72dkSgzIBUQiepvKjz0Zt5YnqlHcvj8I9ba5l6XdnFSluZ4cfGfC2/DAimsb
        qM17DshKaylkaMmh+ChnwXFUc3OdMYM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-24LuU1uEPFiGVMyNxK409A-1; Thu, 07 Apr 2022 06:57:32 -0400
X-MC-Unique: 24LuU1uEPFiGVMyNxK409A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D71D4100BAA7;
        Thu,  7 Apr 2022 10:57:31 +0000 (UTC)
Received: from kate-fedora.redhat.com (unknown [10.2.16.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E290E407DEC9;
        Thu,  7 Apr 2022 10:57:28 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v2] staging: media: ipu3: Fix AWB x_start position when rightmost stripe is used
Date:   Thu,  7 Apr 2022 18:57:24 +0800
Message-Id: <20220407105724.308930-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A not calibrated x_start setting would result in an incorrect AWB location
configuration on a sensor when only the rightmost stripe is used. x_start
should be calibrated by subtracting the stripe offset to set the coordinate
to the correct position on the second stripe.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
Correct the patch. The correction should be awb, not awb_fr.
---
 drivers/staging/media/ipu3/ipu3-css-params.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/staging/media/ipu3/ipu3-css-params.c b/drivers/staging/media/ipu3/ipu3-css-params.c
index f84cf11358a8..76ad802d694e 100644
--- a/drivers/staging/media/ipu3/ipu3-css-params.c
+++ b/drivers/staging/media/ipu3/ipu3-css-params.c
@@ -2636,6 +2636,17 @@ int imgu_css_cfg_acc(struct imgu_css *css, unsigned int pipe,
 	    acc->stripe.down_scaled_stripes[1].offset + min_overlap) {
 		/* Enable only for rightmost stripe, disable left */
 		acc->awb.stripes[0].rgbs_thr_b &= ~IPU3_UAPI_AWB_RGBS_THR_B_EN;
+
+		acc->awb.stripes[1].grid.x_start =
+			(acc->awb.stripes[1].grid.x_start -
+			 acc->stripe.down_scaled_stripes[1].offset) &
+			IPU3_UAPI_GRID_START_MASK;
+
+		b_w_log2 = acc->awb.stripes[1].grid.block_width_log2;
+		acc->awb.stripes[1].grid.x_end =
+			imgu_css_grid_end(acc->awb.stripes[1].grid.x_start,
+					  acc->awb.stripes[1].grid.width,
+					  b_w_log2);
 	} else if (acc->awb.config.grid.x_end <=
 		   acc->stripe.bds_out_stripes[0].width - min_overlap) {
 		/* Enable only for leftmost stripe, disable right */
-- 
2.35.1

