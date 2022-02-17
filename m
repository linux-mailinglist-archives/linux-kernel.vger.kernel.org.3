Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1526D4BA641
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbiBQQln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:41:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242077AbiBQQlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81C062B356B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645116078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NZLivYuLnXFIGdCejA7zd1S5U4NvNvoWvtuXURyH+rc=;
        b=h79he9WuAJjJ0OCtbZWF/MLIWSIYC94jHmKidHeL24+sNW6/gzpl994WItMn37DTX81jjf
        K2Bg+Sd3GOnzBDoYuLwQGppP9PwdJFRHTJ5IJ2sjza4oHqr8qV0BrIX7Rc/BayQMKyFnLd
        lSgeBz9gRzYo8NU7XbeJQH+i4i+oixo=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-cf_jxhFbNMecLhcEv5569g-1; Thu, 17 Feb 2022 11:41:17 -0500
X-MC-Unique: cf_jxhFbNMecLhcEv5569g-1
Received: by mail-oo1-f71.google.com with SMTP id v10-20020a4ade8a000000b003177422e81dso88286oou.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NZLivYuLnXFIGdCejA7zd1S5U4NvNvoWvtuXURyH+rc=;
        b=N7K2DbIqFmq9AKKymPmVmy0yVjzaDjiukXjD5ZGzAhR8QS7/sraYFNagbEUt0kFCK5
         6QM/hBr2uyKuuzWAeNk/sSrC8FSKoIQJglzYV/q+ap5x8jKZiXFpxoYnVjwGzfihF3ki
         KBKVJeYKcmptOq4/+ryuog2/2jRe0mIhhBglrWZoqlHvG0DUh+vkWSnc3Niatag8AELP
         MkenfcAmwuLDOu9w6+J+esWxHFA+N2zX3ZiVZnXfZRtPpDIIqGeCBvFujW5UNKCVKQ4d
         uZWnVHk2dJX/GNQBLXxhsfcd+DAs9VjsBwo8bmkm0328EEjVzzlU5A16ipiSOd6eTdi/
         A6sw==
X-Gm-Message-State: AOAM532lrET6E81kWglFreNhayketUdZHG7R+QC9amiiYYfDOI5We1Pl
        JPxbeKqBN9vNoGCCbOvUbidNTjAdpLR218O8xB25AsVOvPqfcDyDt5e4m8DJb8CzRFiPEKASmLR
        o8d7bxy1mSzRUBG/nURyNEQq+
X-Received: by 2002:a05:6808:1808:b0:2d4:6241:4b68 with SMTP id bh8-20020a056808180800b002d462414b68mr1459840oib.144.1645116076616;
        Thu, 17 Feb 2022 08:41:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzY81YLz3R+btUH+HwXzqO3VuFqto6H0t4DtW0M3Mj5JPgoD/uw4ueVsQaD+uGA6bBPpr4M4w==
X-Received: by 2002:a05:6808:1808:b0:2d4:6241:4b68 with SMTP id bh8-20020a056808180800b002d462414b68mr1459828oib.144.1645116076436;
        Thu, 17 Feb 2022 08:41:16 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id p23sm106844otk.17.2022.02.17.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:41:16 -0800 (PST)
From:   trix@redhat.com
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        jonathan.kim@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdkfd: fix typo in setting enum value
Date:   Thu, 17 Feb 2022 08:41:10 -0800
Message-Id: <20220217164110.3258269-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang build fails with
kfd_packet_manager_v9.c:267:3: error: implicit conversion
  from enumeration type 'enum mes_map_queues_extended_engine_sel_enum'
  to different enumeration type
  'enum mes_unmap_queues_extended_engine_sel_enum'
   extended_engine_sel__mes_map_queues__sdma0_to_7_sel :
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This looks like a typo, the function is _unmap_, the enum
extended_engine_sel__mes_map_queues__sdma0_to_7_sel  is _map_.
To match the packet->bitfields2.extended_engine_set type
it should be extended_engine_sel__mes_unmap_queues__sdma0_to_7_sel.

Fixes: 009e9a158505 ("drm/amdkfd: navi2x requires extended engines to map and unmap sdma queues")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 806a03566a24..18250845a989 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -264,7 +264,7 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 					sizeof(struct pm4_mes_unmap_queues));
 
 	packet->bitfields2.extended_engine_sel = pm_use_ext_eng(pm->dqm->dev) ?
-		extended_engine_sel__mes_map_queues__sdma0_to_7_sel :
+		extended_engine_sel__mes_unmap_queues__sdma0_to_7_sel :
 		extended_engine_sel__mes_unmap_queues__legacy_engine_sel;
 
 	packet->bitfields2.engine_sel =
-- 
2.26.3

