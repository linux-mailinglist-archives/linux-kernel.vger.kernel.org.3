Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C5C4DC08C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiCQH6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiCQH6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F23CADBD01
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647503849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rsKGxCT5EMTMvvumRzuTsDlOPEhzZuYv4Wa7W0b1M0o=;
        b=gz2EgxrIRJCIHSE3/98FnTcjIcbvXSjnJmAfAPM0MOKPSZ6QgQ6rfBTY2PlwDP0+Kald1p
        xNM2Nagg8Ri02mieLZwsejorC2pZsfFzlOKiU/XrLiQE4bf+8LibOKh4atnXJdQJrw9QXR
        fJg26lKAn6pDm56s581Bu9yW+ZmqE+c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-PV7pdlTjNBShrICZNJoyNw-1; Thu, 17 Mar 2022 03:57:26 -0400
X-MC-Unique: PV7pdlTjNBShrICZNJoyNw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 603033804076;
        Thu, 17 Mar 2022 07:57:25 +0000 (UTC)
Received: from kate-fedora.redhat.com (unknown [10.2.16.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58D31C23DC3;
        Thu, 17 Mar 2022 07:57:22 +0000 (UTC)
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
Subject: [PATCH v4] staging: media: ipu3: Fix AF x_start position when rightmost stripe is used
Date:   Thu, 17 Mar 2022 15:57:13 +0800
Message-Id: <20220317075713.10633-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the AF configuration, if the rightmost stripe is used, the AF scene
will be at the incorrect location of the sensor.

The AF coordinate may be set to the right part of the sensor. This
configuration would lead to x_start being greater than the
down_scaled_stripes offset and the leftmost stripe would be disabled
and only the rightmost stripe is used to control the AF coordinate. If
the x_start doesn't perform any adjustments, the AF coordinate will be
at the wrong place of the sensor since down_scaled_stripes offset
would be the new zero of the coordinate system.

In this patch, if only the rightmost stripe is used, x_start should
minus down_scaled_stripes offset to maintain its correctness of AF
scene coordinate.

Changes in v2:
1. Remove the setting of the first stripe.

Changes in v4:
1. x_start is estimated based on the method for both stripes are enabled.
2. x_end is estimated based on the width.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/staging/media/ipu3/ipu3-css-params.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/media/ipu3/ipu3-css-params.c b/drivers/staging/media/ipu3/ipu3-css-params.c
index d9e3c3785075..f84cf11358a8 100644
--- a/drivers/staging/media/ipu3/ipu3-css-params.c
+++ b/drivers/staging/media/ipu3/ipu3-css-params.c
@@ -2556,6 +2556,15 @@ int imgu_css_cfg_acc(struct imgu_css *css, unsigned int pipe,
 		/* Enable only for rightmost stripe, disable left */
 		acc->af.stripes[0].grid_cfg.y_start &=
 			~IPU3_UAPI_GRID_Y_START_EN;
+		acc->af.stripes[1].grid_cfg.x_start =
+			(acc->af.stripes[1].grid_cfg.x_start -
+			 acc->stripe.down_scaled_stripes[1].offset) &
+			IPU3_UAPI_GRID_START_MASK;
+		b_w_log2 = acc->af.stripes[1].grid_cfg.block_width_log2;
+		acc->af.stripes[1].grid_cfg.x_end =
+			imgu_css_grid_end(acc->af.stripes[1].grid_cfg.x_start,
+					  acc->af.stripes[1].grid_cfg.width,
+					  b_w_log2);
 	} else if (acc->af.config.grid_cfg.x_end <=
 		   acc->stripe.bds_out_stripes[0].width - min_overlap) {
 		/* Enable only for leftmost stripe, disable right */
-- 
2.35.1

