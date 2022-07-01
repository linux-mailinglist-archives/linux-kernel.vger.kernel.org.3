Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB36A563968
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiGASxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiGASxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E8D813E89
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656701595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CdygpZqh9NvpmiEiKhKOinbjqxdLDChD2fJR1JgBJ3I=;
        b=ZLagBYIKyTnbPlMB7tlGB+Uwh1gVy5Uick81k6G1kQ/SsEDaLoIT75Ur35EGOinYqwldYX
        YftPgWtYuf5IxNvQ1TRzn26uudIqQXRmxeImLLGTkGF12q1XjGbtfGQGBIzIgn+/nRP1KW
        rLjMvNWcc4GQd5yQ5Uj8jEK/BzJXLvk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-UprX4n0fMJqriqnQJ3juNA-1; Fri, 01 Jul 2022 14:53:14 -0400
X-MC-Unique: UprX4n0fMJqriqnQJ3juNA-1
Received: by mail-ed1-f72.google.com with SMTP id y18-20020a056402441200b0043564cdf765so2304708eda.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 11:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CdygpZqh9NvpmiEiKhKOinbjqxdLDChD2fJR1JgBJ3I=;
        b=q8Qh4u7092cI57HUenkAFzaOrmltutHd4svrLZcRgoYYClLHxatwi4WEaNvQcTcGQP
         RYnmcNkHfTBJvpnFvI3EpReGby/iEjOEqtBLkGuVhdENejpYqa1Wbks0sOyXIOSFPVWo
         qpamCd7J9QLrzTjJXhvhvFjhDUW59fRCNGnRPPMYkqs53ifLl5ZnP65K1r8OI8pkH9x/
         iWnRJgSPffvfNsgDAHq4fpLtdGiV5TDDrg9tXJd5AHZirxV/UUdS+qIshHK0KAFZZjkW
         choqI6SfME1jM8iRruaaHzeDQgJliH7XxoUikU03gji/uQOXuKkdCnYXgVvYgXBy1uoh
         3Aow==
X-Gm-Message-State: AJIora/+P9Qk1NEfuqP5gWvScxd0ymjZveHdARlw8I5JhYwA/K8Sxmz4
        YM6KC/yOparmgFNXjtquX0kEn0EikWWjjfL+iwZX3wgyMEhebnp0TPTXlf9Eb+G0IUcufz1bg3c
        7M8ub0SvWo1Mc/M+aV2DLx/Su
X-Received: by 2002:a17:907:1c11:b0:726:851e:179e with SMTP id nc17-20020a1709071c1100b00726851e179emr16035593ejc.39.1656701593200;
        Fri, 01 Jul 2022 11:53:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s0Fdu/TsECHntNJrudLVig+OOZhMwqESCp2Ml9dWHu45h34F9jhd9i+N3vVzxtmd/q3deigw==
X-Received: by 2002:a17:907:1c11:b0:726:851e:179e with SMTP id nc17-20020a1709071c1100b00726851e179emr16035577ejc.39.1656701593048;
        Fri, 01 Jul 2022 11:53:13 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id cb25-20020a0564020b7900b004359dafe822sm15406658edb.29.2022.07.01.11.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:53:12 -0700 (PDT)
From:   dakr@redhat.com
To:     airlied@linux.ie, daniel@ffwll.ch, christian.koenig@amd.com,
        emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 03/10] drm: use idr_init_base() to initialize master->magic_map
Date:   Fri,  1 Jul 2022 20:52:56 +0200
Message-Id: <20220701185303.284082-4-dakr@redhat.com>
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
 drivers/gpu/drm/drm_auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index 6e433d465f41..63395bebaa6b 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -140,7 +140,7 @@ struct drm_master *drm_master_create(struct drm_device *dev)
 
 	kref_init(&master->refcount);
 	drm_master_legacy_init(master);
-	idr_init(&master->magic_map);
+	idr_init_base(&master->magic_map, 1);
 	master->dev = dev;
 
 	/* initialize the tree of output resource lessees */
-- 
2.36.1

