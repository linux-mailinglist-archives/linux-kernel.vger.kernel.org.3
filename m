Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB6F55721F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiFWEty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345956AbiFWEVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 00:21:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E4D2D1E9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:21:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3178996424dso129412327b3.21
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PpsZDxpmLv6+/qqx3+rvSnNv1wpv3+TXqYxnLrVDMiw=;
        b=pm+EavrBSxygW9wvzqLjGcfKXhCGr/dBXeZRdOmzCF8Zi1nye/Et5+WVIO1C4lauO9
         M0leCRvfLM2AJxgg46x5MH/oEn1eoCecvj8b0+RU+zFimw9DruYrsNqaEk0hos+bVQaC
         SARmWkMTypjPWRsL0ayNGI2DgIqA5OCS0y3o62U2/708BVGIrsONfu1coiyFRA+io8YS
         cANR+cfjv8GyXTbIpXJz7EUfWGU8InNlh0Y/ctR3fdIgwsVQI0GT5yLT4wPJzW1aOwqI
         IK29lat5TnM27KQlno2Ueg4IGlB4lf5r0qXh84LqRLK3/eYdbCtqW8XEw50eTOexFIRE
         iGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PpsZDxpmLv6+/qqx3+rvSnNv1wpv3+TXqYxnLrVDMiw=;
        b=QWknw0q/Pryih8s7B8UH0ZRh3SS4ImUR4YLOLLVtAlaYkKvRkVRUuz3hFs6aejz8xQ
         tCs+5qFjmOQzg/WFmKFCv4Hepx8xEckb42Sdd5ng6JwvYRE7MChSoTf1n6HRgNWvRj2A
         Hj0tBt+y9qc2OngLC3QyeSBciOisKB/Biw//lF7HAzf6dnb0I68Gp4VORBl6QaSHXYTf
         aY6omokBEXUGQ9PLdNMVdCiJdVHrCsdzxtRmJK+EVm1M44iYLKR2KtItq3Skx2eyQprl
         b+zB/x2oGULrgq1B4ZDM1XopJcdqLGOm91gWYyP3Fvb2OYDJc+aI8yWgHbo6xa9nnMeQ
         t9+A==
X-Gm-Message-State: AJIora//VQggLRExg/XkzofufCXReey0+m3EPKrR/yhOIi0qZ1vtzHbR
        AFIqfJBI2ojpj1xOeiEyOfVEJUqEv2FVmZQ=
X-Google-Smtp-Source: AGRyM1sw4pfSqRlLWjCBS1hEyjS9ZkZZkdnqpUsYZum7q8zUnQM5xufoFVhVU+O40bAUjXvk3LspzoM/oI94neU=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:be1f:89ac:a37d:6bb4])
 (user=saravanak job=sendgmr) by 2002:a05:6902:84:b0:63d:4a3d:eb5 with SMTP id
 h4-20020a056902008400b0063d4a3d0eb5mr7368682ybs.145.1655958114239; Wed, 22
 Jun 2022 21:21:54 -0700 (PDT)
Date:   Wed, 22 Jun 2022 21:21:50 -0700
Message-Id: <20220623042150.762330-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v1] driver core: Ignore driver_async_probe cmdline param for
 module drivers
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the module's async_probe option isn't set, the module loading code
will do a async_synchronize_full() before returning to userspace. This
effectively negates any benefits of driver_async_probe listing the
module's driver.

If the module's async_probe is set, then we already do async probe for
that module's driver even if driver_async_probe does not list that
driver. So, again, the driver_async_probe's value doesn't matter for a
module's driver.

So this change ignores the driver_async_probe for module drivers to
avoid useless async probes.

In addition, if driver_async_probe lists a module's driver and the
driver's async probe ends up calling request_module() in the async
thread context, that's going to trigger a spurious WARNING stack dump
without any real benefits of async probing. So this will avoid that
unnecessary warning in that situation.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index e600dd2afc35..f1ac28a4ce62 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -823,7 +823,7 @@ bool driver_allows_async_probing(struct device_driver *drv)
 		return false;
 
 	default:
-		if (cmdline_requested_async_probing(drv->name))
+		if (cmdline_requested_async_probing(drv->name) && drv->owner == NULL)
 			return true;
 
 		if (module_requested_async_probing(drv->owner))
-- 
2.37.0.rc0.161.g10f37bed90-goog

