Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4A7563970
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiGASxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiGASxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:53:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7618A31DDD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656701599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N35X8EVl6N4eTj7vgsDHIfuc6TYftLr3sZ8XvRt4V9Q=;
        b=M1aSbow4Qg6bHUx0ddjZZbF+THP1Uqo/9qyWU54CDjZpKzT2fBgXgFUr5OFsKkj413F0ks
        JsJueA49lxNOxLo8Lk9pyqpgDS6wiou4VStR3apux6LZzeRkWP7OURoJZO44nLehzSC5D1
        DRw8eaZstt9gJh8ZYM5xN8Mbfsjeeu4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-3_3iOEx2NKir-xAlVGw-zQ-1; Fri, 01 Jul 2022 14:53:18 -0400
X-MC-Unique: 3_3iOEx2NKir-xAlVGw-zQ-1
Received: by mail-ej1-f71.google.com with SMTP id ne36-20020a1709077ba400b00722d5f547d8so1061386ejc.19
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 11:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N35X8EVl6N4eTj7vgsDHIfuc6TYftLr3sZ8XvRt4V9Q=;
        b=EDxHCRbhhXf9Nh84tHx+P8AbH8x3YeeKIlMRjjxqk9lqx/KCAQ0r31F9PVFlWALLkt
         qO8vqaMqmp+eI7to4iFtRmGXLooh/PXMI1lhdFh/gAktSQqUpZZkhuc4NT8RbkIKAfjf
         djw9uWYa2Y8Cs6lwWbcVNC3vaX20JbbPtseC4flh/7jfbtIvjxrTdkCDmwjIEeFV/y5z
         f0IQUU0HjUSy343QhVdk9isHo4detWZSyQnVxgCJwp9OoQpZx92uLPO1n2Zlk6v/yhAc
         BK+tQlJdag8un9aGZ5zXEMK1Fur+vbG+ySkMNKLDGiZ89W8cZYgsUwOY06/1Wvf+gJz0
         oofg==
X-Gm-Message-State: AJIora9vQXFwtRBfAaXoK+YwvwWd39EIez3rkA86oIFfSNvocfjbifyK
        Ajm4RPnLSC0bPhW9l7AQcgMuCyOmFFVNclw0IOvgaalV3YKgoENjBQLUbSvrl6nItK4Mbv0FeDn
        kGuSnEplolwVIlOKjQtnDNWtn
X-Received: by 2002:a17:907:c0a:b0:726:22b1:9734 with SMTP id ga10-20020a1709070c0a00b0072622b19734mr15870865ejc.195.1656701597028;
        Fri, 01 Jul 2022 11:53:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v0XHDYfm4r0XmFgHtm8gNeedy8AUdmxbSBjIkcJqyzr9E+jWJqK2lf61vNX6ItKlHcWiTFng==
X-Received: by 2002:a17:907:c0a:b0:726:22b1:9734 with SMTP id ga10-20020a1709070c0a00b0072622b19734mr15870857ejc.195.1656701596880;
        Fri, 01 Jul 2022 11:53:16 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id cb25-20020a0564020b7900b004359dafe822sm15406658edb.29.2022.07.01.11.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:53:16 -0700 (PDT)
From:   dakr@redhat.com
To:     airlied@linux.ie, daniel@ffwll.ch, christian.koenig@amd.com,
        emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 07/10] drm/sis: use idr_init_base() to initialize dev_priv->object_idr
Date:   Fri,  1 Jul 2022 20:53:00 +0200
Message-Id: <20220701185303.284082-8-dakr@redhat.com>
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

