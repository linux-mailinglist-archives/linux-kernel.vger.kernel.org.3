Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C24563964
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiGASx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiGASxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:53:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B106140AC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656701597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=122qxecwdqzJ8Ugfz+kvOKIEtAtbHr1tJgGRsr7PPpU=;
        b=X2FnWw5sZlysOCJpE5P2lZOIV/Dj5fh11LdLSVlePF/sdJN+s52wvxUz8GO0p0hXaU7kPr
        St7wkKk++qOH5uqZ5qXJWwHZKgkpoXMYn62guzcVGxkac/HVDLADdgEB8/XSwe9c7twegE
        gS20h3xtPKKGCUj95wHQchd+1qPfnL0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-sadL9rk2O7OMbnDRF0yaIw-1; Fri, 01 Jul 2022 14:53:16 -0400
X-MC-Unique: sadL9rk2O7OMbnDRF0yaIw-1
Received: by mail-ed1-f69.google.com with SMTP id r12-20020a05640251cc00b00435afb01d7fso2281854edd.18
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 11:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=122qxecwdqzJ8Ugfz+kvOKIEtAtbHr1tJgGRsr7PPpU=;
        b=eMtvdY2Xl7VdmAgGGs+4WAXBH14K7ifghzfYDOWqO69AbzTB6aylOU/OzjdiP9HSq1
         6xCk/NOMkSKb/JZu6Yq+hJWu7g905RIi5dHhOKm007rf6/9QPbPRJT4oJQlIcGFYWnuG
         IC7D9IVGbhluelySjrf5HZjyIayxgdEGx4PsHbKy8GiQnc+MOWCD2juUZ2LUxIaQMDuh
         tSUisZe0N0d1pjZZzAEwWmrSuu6lHOSld+JEl7vO7d85+1eoBWA9yyc7rLSWqSURjNiZ
         ZNWwXAwLFDr1NusLIEzKqN5CveQT8euDyg+Zv5yOAybTTfsaugyYXAwmdDV6zHDrBDBe
         hFwg==
X-Gm-Message-State: AJIora+P0q2J9oe2vfwy2iZXTZcMI9EqGI54UTvy+rOHzwYCTEeP0WM7
        +EQ4VwJ9puDMlCUwpyAo0js5W0V5kSxXLYHx0ZLRfEp9J93Azfy8Nv4reEoppOxRyKkohwlbcEG
        5WQLdnuqFuv1rykcqt9QtqBsV
X-Received: by 2002:a05:6402:498:b0:435:daf0:915b with SMTP id k24-20020a056402049800b00435daf0915bmr20387349edv.322.1656701595155;
        Fri, 01 Jul 2022 11:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tfkBYtuvcwm4VYGQy9UccCKu7Qvni141Sl+kLC2NT5OI/FHv0D+4sTupIA3MUcMStiXF0FVw==
X-Received: by 2002:a05:6402:498:b0:435:daf0:915b with SMTP id k24-20020a056402049800b00435daf0915bmr20387327edv.322.1656701594973;
        Fri, 01 Jul 2022 11:53:14 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id cb25-20020a0564020b7900b004359dafe822sm15406658edb.29.2022.07.01.11.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:53:14 -0700 (PDT)
From:   dakr@redhat.com
To:     airlied@linux.ie, daniel@ffwll.ch, christian.koenig@amd.com,
        emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 05/10] drm: use idr_init_base() to initialize mode_config.object_idr
Date:   Fri,  1 Jul 2022 20:52:58 +0200
Message-Id: <20220701185303.284082-6-dakr@redhat.com>
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
index 37b4b9f0e468..e2a295a4ee0b 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -411,7 +411,7 @@ int drmm_mode_config_init(struct drm_device *dev)
 	INIT_LIST_HEAD(&dev->mode_config.property_blob_list);
 	INIT_LIST_HEAD(&dev->mode_config.plane_list);
 	INIT_LIST_HEAD(&dev->mode_config.privobj_list);
-	idr_init(&dev->mode_config.object_idr);
+	idr_init_base(&dev->mode_config.object_idr, 1);
 	idr_init(&dev->mode_config.tile_idr);
 	ida_init(&dev->mode_config.connector_ida);
 	spin_lock_init(&dev->mode_config.connector_list_lock);
-- 
2.36.1

