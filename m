Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDA357B780
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiGTN3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbiGTN25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCB965407F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658323727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HT8NZrD1nNwbS5gwsuj1LsW1Zo8PIy3JRlNd/+istdc=;
        b=Dx3BET1tiVFyFVln43NcAvxvNKOKV7NvldIrs7/jOXLEjz2H6C98vlN626P6pm4VPEwAIb
        N8dTDvaceUYONBLTbKmtBrBLjq5YqT3QdBliJ20DDr4WEtbHxzF1aRFmWl/T1d+7HDJlGN
        zkNQvLSfmgzDGIe2RdLVrzR2pdjDLk4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-h9FqgtGGNU-ScUJ37_s66A-1; Wed, 20 Jul 2022 09:28:45 -0400
X-MC-Unique: h9FqgtGGNU-ScUJ37_s66A-1
Received: by mail-ej1-f72.google.com with SMTP id gt38-20020a1709072da600b0072f21d7d12dso2174331ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HT8NZrD1nNwbS5gwsuj1LsW1Zo8PIy3JRlNd/+istdc=;
        b=u+Rvnibca6Y/RCs9/YrliVgd9aOOVjSM/Ewntxh3UyVY7ahOdUMA96ST6jscvFssRn
         +E8h8uR8S+w0iFtNpfVjQGSHD37md4diBFnOucB0xxXBMkJDn+LAy0SGBmyi7W748i6g
         R2nywLPOfs0n0pEqIn1jseDpqYHmkPivxq4RXwtSCiGXLTF17g9FQeA5HtKgGGV+skNr
         MEaBfd8BrkACbBEIjIxET05FJqx5hxwhUx75zYcbg3YRb09/0Z2Y8tps83M0hB63BAa2
         KwQbQ7Bf3lU8HkQMvX6DVF0yAc/GsR52PSC425Rwjv0Q27fT2wwJPfPvCuRCwrtp2S9d
         0vwA==
X-Gm-Message-State: AJIora80zFIctw7FpDymSQqxWbiyEB/7y/tl/LI9t0NLMpMupI7+SkAg
        MhehbHuR/40IXYIFgxYgNgps/PwrVSkO5nfPnqyCR9BS6tyzjXliItx3W2mAA2wiNVlJQXvBB0F
        3jktDBPJCasyEKrCv5Dfoz5yR
X-Received: by 2002:a05:6402:448b:b0:43b:5ec6:8863 with SMTP id er11-20020a056402448b00b0043b5ec68863mr23093202edb.377.1658323724421;
        Wed, 20 Jul 2022 06:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sL0huhxDNzivABMSLHJOkvQvPhq+NEIJUtv2pSgx9lvIUBoWWPk+tq72bF8qSorQ5UBbg3qw==
X-Received: by 2002:a05:6402:448b:b0:43b:5ec6:8863 with SMTP id er11-20020a056402448b00b0043b5ec68863mr23093183edb.377.1658323724236;
        Wed, 20 Jul 2022 06:28:44 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id x7-20020a05640225c700b0043ac761db43sm12220687edb.55.2022.07.20.06.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:28:43 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, mripard@kernel.org,
        christian.koenig@amd.com, emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND 09/10] drm/via: use idr_init_base() to initialize dev_priv->object_idr
Date:   Wed, 20 Jul 2022 15:28:29 +0200
Message-Id: <20220720132830.193747-10-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720132830.193747-1-dakr@redhat.com>
References: <20220720132830.193747-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_init_base(), implemented by commit 6ce711f27500 ("idr: Make 1-based
IDRs more efficient"), let us set an arbitrary base other than
idr_init(), which uses base 0.

Since, for this IDR, no ID < 1 is ever requested/allocated, using
idr_init_base(&idr, 1) avoids unnecessary tree walks.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/via/via_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/via/via_map.c b/drivers/gpu/drm/via/via_map.c
index a9f6b0c11966..c20bb20c0e09 100644
--- a/drivers/gpu/drm/via/via_map.c
+++ b/drivers/gpu/drm/via/via_map.c
@@ -106,7 +106,7 @@ int via_driver_load(struct drm_device *dev, unsigned long chipset)
 	if (dev_priv == NULL)
 		return -ENOMEM;
 
-	idr_init(&dev_priv->object_idr);
+	idr_init_base(&dev_priv->object_idr, 1);
 	dev->dev_private = (void *)dev_priv;
 
 	dev_priv->chipset = chipset;
-- 
2.36.1

