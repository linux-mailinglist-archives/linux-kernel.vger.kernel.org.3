Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C85257B77E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240978AbiGTN3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbiGTN2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7BA25288E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658323725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAU7g0XmtNHmK1D83ahVz2l+EzcgZOJWEbwKcBBevW4=;
        b=HjcqYtLRY0SERqxxqO6PSxuhkRE8TDQptXL0hyH6NOHr+st6gfwbxyu0xB2UpM3R60zCLC
        9FhCXOLBgp4kRcRU8yoQC9rUK4J7YmrlZTyBGUCzqp6qwamSzflkSTPKcF0mv8bfiTNQIY
        YdGr1TgC7LVYI1GmDc/V3cmkH8qxXDg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-6M9J8xT6PxW6uNq3bCqLHg-1; Wed, 20 Jul 2022 09:28:44 -0400
X-MC-Unique: 6M9J8xT6PxW6uNq3bCqLHg-1
Received: by mail-ej1-f71.google.com with SMTP id oz11-20020a1709077d8b00b0072f2f17c267so2139284ejc.16
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 06:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAU7g0XmtNHmK1D83ahVz2l+EzcgZOJWEbwKcBBevW4=;
        b=JDscGWAUQP+hxc4NqsJqUIaW2s9gCwfFognC8YvNmxIJ1LN6khEu2dLHskb+fKH0qe
         BBfXjboRJYxuV8Cx2WKDHDGW8ykndLF/uqy6aAYiDjLBWFKfhPeRNS2zD+oliShvUpyE
         T/1/ZT3qlk9SpYdOYLSVV42LwnPsh8YtTj3BKuOxHQFYqLWqjDb3r+tILRqrU3rLRUlr
         VD9pSMiLpUOyVKp141oBEAyxQ6qU8SIwmc5MgL9RwIEWz5q8wHjN31h+HWO2YaBt3WVY
         q37qmtpOIoyVWtYKT1UjqsVVEHFDXj+z21UP07+oBg7QWF/Me2/IKDnK9iKDocy2MO7K
         PLeg==
X-Gm-Message-State: AJIora+CjW3ySyiJV2DaYoN3sH+XG4oK0COYTx9+e7FzbeQb/L1GHd0U
        ABJzcHWXcCqcDhPwg74mFfvXNAp/6HLrql089D1W0Zyh33d3bYMesewcEYsVXLsOLhr4ENk6hF+
        lbUAkEDH7AC69W8zPTA0pBdqx
X-Received: by 2002:aa7:c6d5:0:b0:43b:a52b:2e9d with SMTP id b21-20020aa7c6d5000000b0043ba52b2e9dmr7641384eds.55.1658323723285;
        Wed, 20 Jul 2022 06:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t+XJVzPyzWCIWUNCHkW1104cuBpXxWzX9K7AQTSOhaTvyBzI9SqYq7cbAFcGCNK4j3Viv8mQ==
X-Received: by 2002:aa7:c6d5:0:b0:43b:a52b:2e9d with SMTP id b21-20020aa7c6d5000000b0043ba52b2e9dmr7641368eds.55.1658323723147;
        Wed, 20 Jul 2022 06:28:43 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id x7-20020a05640225c700b0043ac761db43sm12220687edb.55.2022.07.20.06.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 06:28:42 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@linux.ie, daniel@ffwll.ch, mripard@kernel.org,
        christian.koenig@amd.com, emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH RESEND 08/10] drm/v3d: use idr_init_base() to initialize v3d_priv->perfmon.idr
Date:   Wed, 20 Jul 2022 15:28:28 +0200
Message-Id: <20220720132830.193747-9-dakr@redhat.com>
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
 drivers/gpu/drm/v3d/v3d_perfmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index f6a88abccc7d..48aaaa972c49 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -95,7 +95,7 @@ struct v3d_perfmon *v3d_perfmon_find(struct v3d_file_priv *v3d_priv, int id)
 void v3d_perfmon_open_file(struct v3d_file_priv *v3d_priv)
 {
 	mutex_init(&v3d_priv->perfmon.lock);
-	idr_init(&v3d_priv->perfmon.idr);
+	idr_init_base(&v3d_priv->perfmon.idr, 1);
 }
 
 static int v3d_perfmon_idr_del(int id, void *elem, void *data)
-- 
2.36.1

