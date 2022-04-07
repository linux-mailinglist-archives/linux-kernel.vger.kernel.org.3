Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF924F7680
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbiDGGpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiDGGpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2724213CCFE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 23:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649313788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pmmtr6abvNL/Cnfenuo9pFIn0+iTlC3IIqtYnn6nFjw=;
        b=NR1Z29HCLz27e+CmsIrAMQQriYuY4q6/Iq/mBsLRojp9km2vq1SjhLaiDW686+TcCAplhT
        UoLgBnFIm1Q4QL5JfS5rJzf4+YSjCb8yN19mYQqcgb/FphkfTGvEYb7ZGVazV1yXuUfuES
        bGOhvIgmv996f1C9JogcpYgmEAioYAs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-GSTIqSZ6M8CXmxZHA61k5w-1; Thu, 07 Apr 2022 02:43:05 -0400
X-MC-Unique: GSTIqSZ6M8CXmxZHA61k5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A30C380005D;
        Thu,  7 Apr 2022 06:43:04 +0000 (UTC)
Received: from kate-fedora.redhat.com (unknown [10.2.16.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAFE940D2822;
        Thu,  7 Apr 2022 06:43:01 +0000 (UTC)
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
Subject: [PATCH] staging: media: ipu3: Fix AWB x_start position when rightmost stripe is used
Date:   Thu,  7 Apr 2022 14:42:41 +0800
Message-Id: <20220407064241.100500-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/staging/media/ipu3/ipu3-css-params.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/media/ipu3/ipu3-css-params.c b/drivers/staging/media/ipu3/ipu3-css-params.c
index f84cf11358a8..050d7df7e72a 100644
--- a/drivers/staging/media/ipu3/ipu3-css-params.c
+++ b/drivers/staging/media/ipu3/ipu3-css-params.c
@@ -2393,6 +2393,15 @@ int imgu_css_cfg_acc(struct imgu_css *css, unsigned int pipe,
 		/* Enable only for rightmost stripe, disable left */
 		acc->awb_fr.stripes[0].grid_cfg.y_start &=
 					~IPU3_UAPI_GRID_Y_START_EN;
+		acc->awb_fr.stripes[1].grid_cfg.x_start =
+			(acc->awb_fr.stripes[1].grid_cfg.x_start -
+			 acc->stripe.down_scaled_stripes[1].offset) &
+			IPU3_UAPI_GRID_START_MASK;
+		b_w_log2 = acc->awb_fr.stripes[1].grid_cfg.block_width_log2;
+		acc->awb_fr.stripes[1].grid_cfg.x_end  =
+					imgu_css_grid_end(acc->awb_fr.stripes[1].grid_cfg.x_start,
+							  acc->awb_fr.stripes[1].grid_cfg.width,
+							  b_w_log2);
 	} else if (acc->awb_fr.config.grid_cfg.x_end <=
 		   acc->stripe.bds_out_stripes[0].width - min_overlap) {
 		/* Enable only for leftmost stripe, disable right */
-- 
2.35.1

