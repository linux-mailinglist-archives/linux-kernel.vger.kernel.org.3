Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA034CC702
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiCCUUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiCCUUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:20:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B20771728BB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 12:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646338791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W+Yb3jSVbGXS2UsBEDl+Z51/w7cVcv7OgJoaeEwhScE=;
        b=TDPDi9ImdtrRLqSYdD8e5tDnAEgL5J/bH1U5O/TxRxYrnL78O/AMu+FM/X2ivEO9phNQyQ
        hyJQZAycycUiewZfCFaGJKeLyT+ehwMTAUT72zol1pRBOMdY+vGmF1l++i99rC8q4IBZvd
        BbHmDVQmMctzWfr+uJok0a3OYI1eDUc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-HAGVpanXNPqoUweb_mDMnw-1; Thu, 03 Mar 2022 15:19:50 -0500
X-MC-Unique: HAGVpanXNPqoUweb_mDMnw-1
Received: by mail-oi1-f199.google.com with SMTP id w19-20020a0568080d5300b002d54499cc1eso3897955oik.19
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 12:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+Yb3jSVbGXS2UsBEDl+Z51/w7cVcv7OgJoaeEwhScE=;
        b=vbrFENArc//6ljnLN6LzhH3WaXX6G9NipRMjyUG6jP7OtlPGRL2sPB40nWbx25yvVt
         8F+4chorg/Tmsddzi8Zqi1irtr84eG3YJ/69ZWmQokiXG1an0Zr5dzcsIEG3ldEJTo0z
         cUiuwHa0p5zTObit8pNOzmPP4hfCYNY3lT9qJp3VCP82WKcb6Ulx/xH/nIpvmvDKx77S
         1KM0/9k/64lp/lahV4DL5cL7ZCM2WH4GIkJkMDe+Pq+gzeD+edehngBMVbnDhXvisTlv
         KUXYYAwwBIDOvTWeDTwoWq50eN8mPtHnBbctnMeU6GAkAGt1Fj95uVw0MWXCFwfNJ9WN
         6MRg==
X-Gm-Message-State: AOAM530zYLBW0jD7UJtkwecrRJBYzHkbqYMx3XPhEfATgx/nQUfmEnOB
        LGdyFZo14opEscjM25oJKJU202HdsD9kGq/nvg7OzImZZigr6y8fKr1oDh6o3iYFB/OmI8uiMw2
        bsAeLTtq/hhmF1G1Q1yBdGgD0
X-Received: by 2002:a05:6870:128c:b0:ce:c0c9:5ba with SMTP id 12-20020a056870128c00b000cec0c905bamr5481236oal.12.1646338789963;
        Thu, 03 Mar 2022 12:19:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9UL7z0i5c0I1zBYkPbE2sDhIbft3n5S0zsg8O5Iu/S8GWiXtXSO4aUx3Hz5c0J+4lOC6M2Q==
X-Received: by 2002:a05:6870:128c:b0:ce:c0c9:5ba with SMTP id 12-20020a056870128c00b000cec0c905bamr5481217oal.12.1646338789724;
        Thu, 03 Mar 2022 12:19:49 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id 52-20020a9d0bb7000000b005afa463d9f8sm1411532oth.19.2022.03.03.12.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 12:19:49 -0800 (PST)
From:   trix@redhat.com
To:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        xji@analogixsemi.com, hsinyi@chromium.org, sam@ravnborg.org,
        tzungbi@google.com, pihsun@chromium.org, maxime@cerno.tech
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/bridge: anx7625: check the return on anx7625_aux_trans
Date:   Thu,  3 Mar 2022 12:19:43 -0800
Message-Id: <20220303201943.501746-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this issue
anx7625.c:876:13: warning: The left operand of '&' is
  a garbage value
  if (!(bcap & 0xOA01)) {
        ~~~~ ^

bcap is only set by a successful call to
anx7625_aux_trans().  So check.

Fixes: cd1637c7e480 ("drm/bridge: anx7625: add HDCP support")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 633618bafd75d..f02ac079ed2ec 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -872,7 +872,10 @@ static int anx7625_hdcp_enable(struct anx7625_data *ctx)
 	}
 
 	/* Read downstream capability */
-	anx7625_aux_trans(ctx, DP_AUX_NATIVE_READ, 0x68028, 1, &bcap);
+	ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_READ, 0x68028, 1, &bcap);
+	if (ret < 0)
+		return ret;
+
 	if (!(bcap & 0x01)) {
 		pr_warn("downstream not support HDCP 1.4, cap(%x).\n", bcap);
 		return 0;
-- 
2.26.3

