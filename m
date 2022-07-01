Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C914E56396F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiGASxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiGASxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEC7F22B2E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656701598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UvErFdRb+yQ6d7xkP3vZiS7WsAN0qxK+4nKZEOvYY58=;
        b=C57GUPTuGpRjYacBZp0X0L4c0a1NX1lVDt0tB98hquLDhG9OGUrVfdv4z+admxnGoZef7/
        gr9hhMKb6ffcSizqVwgC2TXSe/RfyWD/ZbSjTyXVs6iamUptJ6yu9DBGV/c6TX3BB14j2p
        3Xrg6MuNr5JPeDeY7FcDXvSs7MlC7XE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-RBca2msuNki7PHGm-kLbKw-1; Fri, 01 Jul 2022 14:53:17 -0400
X-MC-Unique: RBca2msuNki7PHGm-kLbKw-1
Received: by mail-ed1-f70.google.com with SMTP id v16-20020a056402349000b00435a1c942a9so2305876edc.15
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 11:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UvErFdRb+yQ6d7xkP3vZiS7WsAN0qxK+4nKZEOvYY58=;
        b=kHIxz97+BYWdvy6q/VMFzGXzVvqAprQcb2hyr3G5Kx5tgixM/oeV4Si2bUG0Fpr30t
         l5Equ0d/Qd9X+qBquoBOnoG5hbF+vTXeuAqh5lC/TDoZJI/2VLo+qqw1Mp7RNzp49ZTS
         H/Xbr5o3vOk5DpP7XjqUBCYjM5ELwVAoa9lxpwGIQGvVL/kU7TE9djj857VWzUkORIr4
         NGEgHmqN1f1pIBAxGmtsBgldhSE6aiAvdWbqZdmKPgQ5J5cD88ftMccMhxQNhjQNEWc5
         m5vv200rsaMfH0Y07sTl9oftdiVJ2BA6FkyY9DRx/cStsItTEU5gW3mcgxUr2rN1/c1F
         DzVg==
X-Gm-Message-State: AJIora/uszG+MlQUuw7MQHHIyWTCf7uvQhc1pb8l2Jxz2TVsLvFhfWLO
        mI5ypSJCm+0Fy2FQ+MVCRp0ZZ/9X+SQ7kA56z9qtVUpijD/f491qecgszSHE7bG1c0kw4fdNmE/
        529yWrLI9EqxBdIRCKsVA3Gg1
X-Received: by 2002:a17:907:75ee:b0:72a:a01c:b33e with SMTP id jz14-20020a17090775ee00b0072aa01cb33emr188078ejc.357.1656701596075;
        Fri, 01 Jul 2022 11:53:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1veRfvTxLKnAHR14bR+YyLNsxQ1zyfx/tMaPFdQz2XxgjELs/czmewOir+5HUN/vin0c0W+zw==
X-Received: by 2002:a17:907:75ee:b0:72a:a01c:b33e with SMTP id jz14-20020a17090775ee00b0072aa01cb33emr188064ejc.357.1656701595883;
        Fri, 01 Jul 2022 11:53:15 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id cb25-20020a0564020b7900b004359dafe822sm15406658edb.29.2022.07.01.11.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:53:15 -0700 (PDT)
From:   dakr@redhat.com
To:     airlied@linux.ie, daniel@ffwll.ch, christian.koenig@amd.com,
        emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 06/10] drm: use idr_init_base() to initialize mode_config.tile_idr
Date:   Fri,  1 Jul 2022 20:52:59 +0200
Message-Id: <20220701185303.284082-7-dakr@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220701185303.284082-1-dakr@redhat.com>
References: <20220701185303.284082-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danilo Krummrich <dakr@redhat.com>

idr_init_base(), implemented by commit 6ce711f27500 ("idr: Make 1-based
IDRs more efficient"), let us set an arbitrary base other than
idr_init(), which uses base 0.

Since, for this IDR, no ID < 1 is ever requested/allocated, using
idr_init_base(&idr, 1) avoids unnecessary tree walks.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_mode_config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index e2a295a4ee0b..3d1c1ade5a25 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -412,7 +412,7 @@ int drmm_mode_config_init(struct drm_device *dev)
 	INIT_LIST_HEAD(&dev->mode_config.plane_list);
 	INIT_LIST_HEAD(&dev->mode_config.privobj_list);
 	idr_init_base(&dev->mode_config.object_idr, 1);
-	idr_init(&dev->mode_config.tile_idr);
+	idr_init_base(&dev->mode_config.tile_idr, 1);
 	ida_init(&dev->mode_config.connector_ida);
 	spin_lock_init(&dev->mode_config.connector_list_lock);
 
-- 
2.36.1

