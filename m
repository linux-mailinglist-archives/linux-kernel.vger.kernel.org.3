Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333B650A2E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389552AbiDUOqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiDUOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7077C4092D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650552196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ePPTKrCMwADglYVO5peeQ4QQVf5OFLO0wZ8LDZ1O6g8=;
        b=dfecRGW+qXw79jTVfA4P6Ly8jKHi3YMiG+u1y4yVPoIsGX9Ni822ZM6sxtBvUj6aMUl5kp
        XLP/2NJ3Zx54kRfQr0Ey1aMJ3i+73wrNwnXOq6EHgaDqLomp17gHtW1oYabkYACSZI833d
        j9w6oX3PfbHptCTCPXfqU9R3Odx/WZE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-6L1E9lw0PIeH0uQx5A2P4A-1; Thu, 21 Apr 2022 10:43:15 -0400
X-MC-Unique: 6L1E9lw0PIeH0uQx5A2P4A-1
Received: by mail-qv1-f69.google.com with SMTP id f18-20020ad442d2000000b0044642dd1d7eso4095013qvr.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePPTKrCMwADglYVO5peeQ4QQVf5OFLO0wZ8LDZ1O6g8=;
        b=N9wB6epof7XfxffTiRoB2jSchPAOvcvSvP68Z0/C61sZeVkyq9cK40bWnZNuYP3wdX
         UcfQwKX8zvVNjvhyPoo0cpVEMWM7QspQynd7yIjyfJWMVxLJ7NuAySUFpd0YBgVCcV44
         albqKfESU60M6UMKqBNcaOHxIIR6ZWq83heOfnPqRJgFB5eCJ4aXNCUljX3yrZifQoQt
         pFb9ub5iUgzMdh/rN4ce3hnbYtPdse7k1hmmDp0c3kVeu9HBX0khY6qfOMhVFHnunwPR
         zQTDimbC2ssgYEKETsAGi1bhARmTG2DwutVWn2gCuTAhdf9tG0xLXtWXwj1xYm1okNA0
         Cr/g==
X-Gm-Message-State: AOAM532P3p/VarDo6E49SNqqwJGfsCH2smNtWC3xfRDSr0MTeBMy8uev
        fAACzHsrV+S3U5RaeMnRgIw58O0rIc3rrYvDwAhIFSk/mUCVb3yWrHy1rx69AlmVt6TX7WQFqwp
        eXZXy0xEumXIsGdDZ+a0Xk+rh
X-Received: by 2002:ad4:5bc1:0:b0:42d:758c:f694 with SMTP id t1-20020ad45bc1000000b0042d758cf694mr19026789qvt.99.1650552194915;
        Thu, 21 Apr 2022 07:43:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2jn3q9z234SvBuh9QXKIyb+5gtFlLQqL5BZmnHLuyhZev75JSd04yeLJ/gjoODjM5Sghq+Q==
X-Received: by 2002:ad4:5bc1:0:b0:42d:758c:f694 with SMTP id t1-20020ad45bc1000000b0042d758cf694mr19026774qvt.99.1650552194715;
        Thu, 21 Apr 2022 07:43:14 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o14-20020a05622a138e00b002f335c3dbf2sm3538660qtk.37.2022.04.21.07.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:43:14 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/rockchip: cdn-dp: change rk3399_cdn_dp from global to static
Date:   Thu, 21 Apr 2022 10:43:04 -0400
Message-Id: <20220421144304.586396-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
cdn-dp-core.c:51:20: warning: symbol 'rk3399_cdn_dp' was not declared. Should it be static?

rk3399_cdn_dp is only used in cdn-dp-core.c so change
its storge-class specifier to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index d3e6c93739bf..ce67c9daa2b1 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -48,7 +48,7 @@ struct cdn_dp_data {
 	u8 max_phy;
 };
 
-struct cdn_dp_data rk3399_cdn_dp = {
+static struct cdn_dp_data rk3399_cdn_dp = {
 	.max_phy = 2,
 };
 
-- 
2.27.0

