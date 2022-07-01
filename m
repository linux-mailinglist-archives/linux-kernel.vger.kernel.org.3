Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC2756396D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiGASx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiGASxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2546E13F52
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656701596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lD0UgE3dxvQIzw1sirJUBY/8o36UmN7hqjArgRHfL+E=;
        b=PLsYfurraVYc8dr5ryrKR7XIqSCSDgwKwZHKUH4Gyivif09jP7JTBZYsdf4sxm1gL4Z6eB
        ZvLT3mMMFn5hG1i95pctTvg8JzghhpUfCo4SlbKDhKyt5qlIq4bJaDm7EQyzaDsVelIXuk
        CsdFFErIGnIHbCspyfYyHEHnAW11uzg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-WV4YLMDDOACuu9WfEPBsIA-1; Fri, 01 Jul 2022 14:53:15 -0400
X-MC-Unique: WV4YLMDDOACuu9WfEPBsIA-1
Received: by mail-ed1-f70.google.com with SMTP id z19-20020a05640240d300b00437633081abso2308677edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 11:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lD0UgE3dxvQIzw1sirJUBY/8o36UmN7hqjArgRHfL+E=;
        b=7fmPy5mzr192YCbOAyJybXnCLz0O1yPAoDmDV/Vywc5BKjy7OOmmdY3Hm0hMqIdj6H
         YllRiI3X8WSEmOPZTwivf5x5D9LPMjHZlC4Ssn5rBQFc/94vnuhQYnwwPd6gsVR0y+Si
         dcBvgk4iN5Y9kbYEKhlCPnWajy3Ak4EoxxHidwDcV6yWJFs2vK/KxTb1YYJ9xephw8K9
         6K/AMFUaesklT0bfAtELbw2KhQxNXcQKx21882PH/FxZme2KB2k+jK9OHO4jF0fh16o+
         ZY40Bt8dLvtSKnjAm6teQ6P2VNU8VLKflZB0yH+AyBOB7RLPJSdQU5/SOO9ZlRNQWQ50
         aGWg==
X-Gm-Message-State: AJIora9nFcdhNUbAd3WFe1UXjG0t2qwC/5nt+FKv4NOzPd0S46sRVpn2
        Z5vY0E/fKCL3xKNfEGz4naVQhNU/PdnGzs1AfUQvXWkE5INGg/iUqYE8LDwghJ25iFQNSUcwy3W
        zfK35PaRxsRczn5H+WCxXlT/B
X-Received: by 2002:a17:906:1b01:b0:726:be5e:7125 with SMTP id o1-20020a1709061b0100b00726be5e7125mr15735022ejg.678.1656701594154;
        Fri, 01 Jul 2022 11:53:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tpE4potQHDaod4k+BwhozruburD50UmURvnLAMEsNDMRIJU1naqj6jrZJomh6q2+TomW/yPg==
X-Received: by 2002:a17:906:1b01:b0:726:be5e:7125 with SMTP id o1-20020a1709061b0100b00726be5e7125mr15735005ejg.678.1656701593960;
        Fri, 01 Jul 2022 11:53:13 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id cb25-20020a0564020b7900b004359dafe822sm15406658edb.29.2022.07.01.11.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:53:13 -0700 (PDT)
From:   dakr@redhat.com
To:     airlied@linux.ie, daniel@ffwll.ch, christian.koenig@amd.com,
        emma@anholt.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 04/10] drm: use idr_init_base() to initialize master->lessee_idr
Date:   Fri,  1 Jul 2022 20:52:57 +0200
Message-Id: <20220701185303.284082-5-dakr@redhat.com>
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

