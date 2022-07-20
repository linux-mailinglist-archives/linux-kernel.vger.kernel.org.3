Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6915A57B77B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiGTN3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbiGTN2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F0B23ED41
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658323724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rk9AhtZmor412ab1pdm8kQawl+ZyAY1dgO0bYINvs54=;
        b=JVftSvihiHJ2qLaCpVA9xn3HarRQjfuurYvo/ZkhncvMGj6y/OsyyNl24PfkVDfh5I5iY5
        gjrOgqCss3mQLkiASgdQvY0qfTtvv9a+VcmGlUVQyGEzzMan5eV+dp975VnBvarYH3MnlR
        aVyJgqXWKY8Gk3DDSNPj2YB9/x3E2U0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-FBYjYj8CPRm0Rd7uh6BcGA-1; Wed, 20 Jul 2022 09:28:42 -0400
X-MC-Unique: FBYjYj8CPRm0Rd7uh6BcGA-1
Received: by mail-ej1-f71.google.com with SMTP id ga9-20020a1709070c0900b0072b4d787f5dso4105782ejc.21
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rk9AhtZmor412ab1pdm8kQawl+ZyAY1dgO0bYINvs54=;
        b=dMAcaXRZayBl8XngK3YOMrXqE4zrDqvSlpJur2DJltysgpjhqUZMjzN0lNrIuBt2ls
         CFxlUPoGtW55vj3uryp8ji2ozO9QmJlx1MarrFZ1UbXPncfgd4kp3ZPqPEDCi+qU1p8B
         6rPdhX7WeChWREI1fB9AOp46fTTWPTLQn+cWFrRSsm1kXlDZhZy/77ln5Ob5l/f5RbQh
         TqiBzKMYj3hNEwqhhq9R7HHcqkBdBwv+2qLZr3p365C3+el41KH1TvUuV14Q2sOTHMf2
         smqkGK7RYEYXLC3yp81XJrQAqz98eXSq4ouhTSlHoUmj8VsSNKcqEOglqXkva0ZOCLVL
         tyCg==
X-Gm-Message-State: AJIora9KxsrHEUfPY8tr9FAXJTCtvFg02V0AqpibAWWDOHYaYCZaUtBP
        lHVoRwgCpOWg7oG8u2ZuXfHtzsTmhQXfV6jYff0k3NruWNsW/zNf3CoWPOJKk0uwKUz5hXXRgCC
        ukRKAVrnVlQJDdUSE5TlZDSxC
X-Received: by 2002:a17:907:72d2:b0:72b:d238:4e81 with SMTP id du18-20020a17090772d200b0072bd2384e81mr34316145ejc.104.1658323721572;
        Wed, 20 Jul 2022 06:28:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1thris3Hs7kI1+V5PiU8wpgCAuZjyMTOSv7gtwkI3GRkFHOAUXOMZoByN9Z0aScoROqDsYNwA==
X-Received: by 2002:a17:907:72d2:b0:72b:d238:4e81 with SMTP id du18-20020a17090772d200b0072bd2384e81mr34316128ejc.104.1658323721356;
        Wed, 20 Jul 2022 06:28:41 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id x7-20020a05640225c700b0043ac761db43sm12220687edb.55.2022.07.20.06.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:28:41 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, mripard@kernel.org,
        christian.koenig@amd.com, emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND 07/10] drm/sis: use idr_init_base() to initialize dev_priv->object_idr
Date:   Wed, 20 Jul 2022 15:28:27 +0200
Message-Id: <20220720132830.193747-8-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720132830.193747-1-dakr@redhat.com>
References: <20220720132830.193747-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 drivers/gpu/drm/sis/sis_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sis/sis_drv.c b/drivers/gpu/drm/sis/sis_drv.c
index e35e719cf315..6173020a9bf5 100644
--- a/drivers/gpu/drm/sis/sis_drv.c
+++ b/drivers/gpu/drm/sis/sis_drv.c
@@ -50,7 +50,7 @@ static int sis_driver_load(struct drm_device *dev, unsigned long chipset)
 	if (dev_priv == NULL)
 		return -ENOMEM;
 
-	idr_init(&dev_priv->object_idr);
+	idr_init_base(&dev_priv->object_idr, 1);
 	dev->dev_private = (void *)dev_priv;
 	dev_priv->chipset = chipset;
 
-- 
2.36.1

