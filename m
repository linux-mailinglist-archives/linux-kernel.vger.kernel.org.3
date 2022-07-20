Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B855657B77F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiGTN3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbiGTN2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81E152AE3A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658323720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5ddLIULHU4lCGQd0NSPYCIu5p1tGKAtdnoOfURMriM=;
        b=c1M2DmaX8lEV+hHA8wtN1LbIcfg+/d7vKSkD3MG6z60ety/dMe3CQipmSd/6jjs+IgtAuf
        FEZeQ1ZeiuZLTlZndgA9Gz7XE5DQwGf9D6Bfcff5MGUmQrUhEy8IjTqJV3UxyrqdIc6vgY
        tVb8/V0pUitNh94xDo5f4OmIxPSLanU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-tTskUb4WNSa5aFySkUELQQ-1; Wed, 20 Jul 2022 09:28:39 -0400
X-MC-Unique: tTskUb4WNSa5aFySkUELQQ-1
Received: by mail-ej1-f70.google.com with SMTP id hb41-20020a170907162900b0072f044ca263so2931032ejc.15
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5ddLIULHU4lCGQd0NSPYCIu5p1tGKAtdnoOfURMriM=;
        b=mdieMLV+KSaZrcXNmHbRVA0lFeQKrMJKtceNCY3Fda5hPdQN1K+KQeEX8xwyp/v3CT
         FSyYypmUiW8BkIhJq4TSFZh8oz6pR+2WCFsAg8p9+m26zaAwAOhm1EThJaTzujLfWPVt
         eq+yS2gBoBwVYehHMexU/oxbm7Cl1ZElpBlfJGQXAVJ2Hw40F0F3HFUM+bU6AFwWaVoc
         sW8AgDeP9r3XbtDWqmRP6tYZnv1zvt44DTu53X8JaxP2B7vwX0ZJsQdxP+CupP9XC039
         lwiUK64PbFpjfYVWlylKU5JoEVoP5+xBSf0KmSOVgFGf2zzDugcCXy+b3oDcVtf6dhuw
         zDGg==
X-Gm-Message-State: AJIora9ekdGn/4DvJp1OeUFz5Bx0reHX1azjnlNf023eSKa+oz3iiVt+
        A0XFafEdkoETrOiQV7iFi3YDaAV2tFqFcXYXlX+fRSYKNEfM3Iwii8mItNSxNsd8u4q/BnO9xXq
        R7OmaLKCQgk2c9yyMd135OkQ1
X-Received: by 2002:a17:906:844d:b0:72b:307d:fb52 with SMTP id e13-20020a170906844d00b0072b307dfb52mr36174059ejy.182.1658323718290;
        Wed, 20 Jul 2022 06:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sY/1Zm6BfoPARI1YbiV4ibajD1bahl1m6CRJ1x477gp7Vj0dinJMpAeZDF8tcyy5jgf5+z8Q==
X-Received: by 2002:a17:906:844d:b0:72b:307d:fb52 with SMTP id e13-20020a170906844d00b0072b307dfb52mr36174049ejy.182.1658323718132;
        Wed, 20 Jul 2022 06:28:38 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id x7-20020a05640225c700b0043ac761db43sm12220687edb.55.2022.07.20.06.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:28:37 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, mripard@kernel.org,
        christian.koenig@amd.com, emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND 04/10] drm: use idr_init_base() to initialize master->lessee_idr
Date:   Wed, 20 Jul 2022 15:28:24 +0200
Message-Id: <20220720132830.193747-5-dakr@redhat.com>
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
 drivers/gpu/drm/drm_auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index 63395bebaa6b..cf92a9ae8034 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -147,7 +147,7 @@ struct drm_master *drm_master_create(struct drm_device *dev)
 	INIT_LIST_HEAD(&master->lessees);
 	INIT_LIST_HEAD(&master->lessee_list);
 	idr_init(&master->leases);
-	idr_init(&master->lessee_idr);
+	idr_init_base(&master->lessee_idr, 1);
 
 	return master;
 }
-- 
2.36.1

