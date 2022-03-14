Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9644D7F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbiCNKRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbiCNKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42AB33CFF8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647252954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TN2T3pV/RSYPJmQU4+Rpzf9IHps10qbPty7fqrdTQLg=;
        b=OqhH3EQIgxgHcbRXf47ArJ1c4W57x7W/vm4tKXCKdRlvtXoYQkhSwWu8ou18EC9gIFhQ+s
        etbg2f5XwajS6+BWxMkicXKQbcvcuFyfjd/6GFXjW5kBmz32kQeWJbJX+rhBcTwfhNX+rw
        2xgLNXhEGCoqDYZYLtAz/64Fm/+Mk2g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-B5x3RyY_PcyA-qn-QsZVnQ-1; Mon, 14 Mar 2022 06:15:51 -0400
X-MC-Unique: B5x3RyY_PcyA-qn-QsZVnQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A0DC29A9CCB;
        Mon, 14 Mar 2022 10:15:50 +0000 (UTC)
Received: from kate-fedora.redhat.com (unknown [10.2.16.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 587C34AE323;
        Mon, 14 Mar 2022 10:15:47 +0000 (UTC)
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
Subject: [PATCH v3 2/2] staging: media: ipu3: fixing stripe1 x_end is greater than BDS width
Date:   Mon, 14 Mar 2022 18:15:23 +0800
Message-Id: <20220314101523.129672-2-hpa@redhat.com>
In-Reply-To: <20220314101523.129672-1-hpa@redhat.com>
References: <20220314101523.129672-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If both stripes are enabled, an improper AF grid configuration leads
the AF scene width to be wilder than the BDS width. Also, the second
stripe x_end is estimated based on the remaining AF scene width.
Therefore, the second stripe x_end will be greater than the second
stripe BDS width.

In this patch, if the second stripe x_end is greater than BDS width,
x_end will be set to BDS width.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/staging/media/ipu3/ipu3-css-params.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/media/ipu3/ipu3-css-params.c b/drivers/staging/media/ipu3/ipu3-css-params.c
index 5a8c07f34756..8923760aa913 100644
--- a/drivers/staging/media/ipu3/ipu3-css-params.c
+++ b/drivers/staging/media/ipu3/ipu3-css-params.c
@@ -2593,6 +2593,10 @@ int imgu_css_cfg_acc(struct imgu_css *css, unsigned int pipe,
 					  acc->af.stripes[1].grid_cfg.width,
 					  b_w_log2);
 
+		if (acc->af.stripes[1].grid_cfg.x_end >= acc->stripe.bds_out_stripes[1].width)
+			acc->af.stripes[1].grid_cfg.x_end =
+				acc->stripe.bds_out_stripes[1].width - min_overlap;
+
 		/*
 		 * To reduce complexity of debubbling and loading statistics
 		 * fix grid_height_per_slice to 1 for both stripes
-- 
2.35.1

