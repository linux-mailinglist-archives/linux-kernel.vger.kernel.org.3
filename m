Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2E04C0ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiBWJIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239178AbiBWJIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:08:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61B8C7F6F7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645607276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gfC7FKK9Tj6qRopurhld/VACUy0L/VBWgw9IapSZm3E=;
        b=V2T5ARkekedd8AHXECO6AQP2fRtWgw3zhAa5m6Ob59SFcG5Le3XqU+S52cjCxEqzrcs73Y
        pybs00ZW6cwXZO+pmDAPJ5jRdhOdzKq90HF8WZ4YVTMKY5uyzLxbIoBF2CMIWEs4Pm8HpA
        EvjGzyfA2J6I3PTarAObCARB2tqdjFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-WcpNSMC3M3W5URCWIc9oDw-1; Wed, 23 Feb 2022 04:07:53 -0500
X-MC-Unique: WcpNSMC3M3W5URCWIc9oDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AB1F1091DA0;
        Wed, 23 Feb 2022 09:07:52 +0000 (UTC)
Received: from kate-fedora.redhat.com (unknown [10.2.16.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7DAC80899;
        Wed, 23 Feb 2022 09:07:48 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        Kate Hsuan <hpa@redhat.com>
Subject: [PATCH 1/1] staging: media: ipu3: Fix AF x_start position when rightmost stripe is used
Date:   Wed, 23 Feb 2022 17:06:48 +0800
Message-Id: <20220223090648.41989-2-hpa@redhat.com>
In-Reply-To: <20220223090648.41989-1-hpa@redhat.com>
References: <20220223090648.41989-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/staging/media/ipu3/ipu3-css-params.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu3/ipu3-css-params.c b/drivers/staging/media/ipu3/ipu3-css-params.c
index d9e3c3785075..efe4de8ef205 100644
--- a/drivers/staging/media/ipu3/ipu3-css-params.c
+++ b/drivers/staging/media/ipu3/ipu3-css-params.c
@@ -2556,6 +2556,14 @@ int imgu_css_cfg_acc(struct imgu_css *css, unsigned int pipe,
 		/* Enable only for rightmost stripe, disable left */
 		acc->af.stripes[0].grid_cfg.y_start &=
 			~IPU3_UAPI_GRID_Y_START_EN;
+		acc->af.stripes[0].grid_cfg.x_start -=
+			acc->stripe.down_scaled_stripes[1].offset;
+		acc->af.stripes[0].grid_cfg.x_end -=
+			acc->stripe.down_scaled_stripes[1].offset;
+		acc->af.stripes[1].grid_cfg.x_start -=
+			acc->stripe.down_scaled_stripes[1].offset;
+		acc->af.stripes[1].grid_cfg.x_end -=
+			acc->stripe.down_scaled_stripes[1].offset;
 	} else if (acc->af.config.grid_cfg.x_end <=
 		   acc->stripe.bds_out_stripes[0].width - min_overlap) {
 		/* Enable only for leftmost stripe, disable right */
@@ -2563,7 +2571,6 @@ int imgu_css_cfg_acc(struct imgu_css *css, unsigned int pipe,
 			~IPU3_UAPI_GRID_Y_START_EN;
 	} else {
 		/* Enable for both stripes */
-
 		acc->af.stripes[0].grid_cfg.width =
 			(acc->stripe.bds_out_stripes[0].width - min_overlap -
 			 acc->af.config.grid_cfg.x_start + 1) >>
-- 
2.35.1

