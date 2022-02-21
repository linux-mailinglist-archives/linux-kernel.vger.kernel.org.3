Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910774BE293
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiBURiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:38:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiBURiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:38:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAEE11DA56
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645465073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DzRKkl9MBsnLJO0MZvrmofSvJyauAO6DGXYWnBBejVM=;
        b=WAaEYlGQ0uVkMajrekefdPnfWScNBw57K8J1QRLfIRePV8QSpJ2ksyY15rsWvBm8JIYcfD
        NHKXZoIrXC+UGOslfdh5dzjVspvOgDRJKXvhyfdth2jEaJJOX/oFbQy6xTLdPNcZUBPbWP
        wOO45Av1aYR1QSl7JausiMiy/oVeafQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-pJFnBdXkOR68DAeEXAl1yg-1; Mon, 21 Feb 2022 12:37:51 -0500
X-MC-Unique: pJFnBdXkOR68DAeEXAl1yg-1
Received: by mail-qk1-f200.google.com with SMTP id c19-20020a05620a11b300b00648cdeae21aso4262629qkk.17
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DzRKkl9MBsnLJO0MZvrmofSvJyauAO6DGXYWnBBejVM=;
        b=GhXKH08KnOkzkDML0J0FhOpK2UR+zdVkTeLipa1mg2Onbn4qoo8xEhSBSB7WQwdrtW
         WiV8dTNQP3TEu/44AaFl9v6c1f+wlJhhxvK4R8DZy0GTDJVMkX1QW8NqNsnONaBHQEwQ
         sYuSxJ1uXfWbxGwHPsnYpFYwq5GEaNFa1orCwkmkKg3osUwnz6mZMAquYmPKclVK7bki
         eGKPfTRCX3HrpFxIx83MRLHt0ARBbw8NSoxJBIGxGB5L/koc9O6YK5uNihWXThTvMsDs
         eJCaORfYJqGE2ee1qxBI0mbyRs67RKxfo9kCxYZd1OE3qHtU8OabLda/rnxZxzQsx668
         GC/Q==
X-Gm-Message-State: AOAM5303xBH/HMBGiMOCq78KtYzOn6KhHY6iR2tVnF0FKQTKU7u6cVYk
        n73+Ny2bqDeNJVRpEepbjQjv8RXyKg2B0BCLe0qP3nTn2kzrTBi+eTMUVo3Ip1Lw6CYqzlnQUeb
        03hybvKDAkvioMvrja2KmO/uo
X-Received: by 2002:a37:674c:0:b0:47b:8dc5:df77 with SMTP id b73-20020a37674c000000b0047b8dc5df77mr13055121qkc.95.1645465071214;
        Mon, 21 Feb 2022 09:37:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXF5C5Kq2+dKAFlNYYC/4KY8Ajcg6ukvTAULE4uB/5fl5oE1UylGbMhdwn4F9QcBZp1i/H3Q==
X-Received: by 2002:a37:674c:0:b0:47b:8dc5:df77 with SMTP id b73-20020a37674c000000b0047b8dc5df77mr13055105qkc.95.1645465071015;
        Mon, 21 Feb 2022 09:37:51 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id v15sm1895466qkl.37.2022.02.21.09.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 09:37:50 -0800 (PST)
From:   trix@redhat.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        guchun.chen@amd.com, Prike.Liang@amd.com, Hawking.Zhang@amd.com,
        luben.tuikov@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: fix printk format for size_t variable
Date:   Mon, 21 Feb 2022 09:37:37 -0800
Message-Id: <20220221173737.3725760-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

On mips64 allyesconfig, there is this build break
amdgpu_discovery.c:671:35: error: format '%ld' expects
  argument of type 'long int', but argument 4 has
  type 'size_t' {aka 'unsigned int'}
  DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);

For size_t, use %zu.

Fixes: a6c40b178092 ("drm/amdgpu: Show IP discovery in sysfs")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 7c7e28fd912e..58238f67b1d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -668,7 +668,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 			    le16_to_cpu(ip->hw_id) != ii)
 				goto next_ip;
 
-			DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
+			DRM_DEBUG("match:%d @ ip_offset:%zu", ii, ip_offset);
 
 			/* We have a hw_id match; register the hw
 			 * block if not yet registered.
-- 
2.26.3

