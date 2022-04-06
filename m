Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CBF4F68DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbiDFSNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 14:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbiDFSNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:13:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DF213D49
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:50:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f16so297674lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7mcxCMUsY68b1C+y1FYJV5SZRpo8yl4CCyl7R2mFnT0=;
        b=LCXDwOcQDeA5enlC7K6Ie77FKlqGpjFTFPq/iH0xIFNgegH0lHp95s3B+k5PMn1p/5
         D75OJnHRVlBjkfYEjU5hiEStLBBWmsnq+vlJV/wJ2DaovZetBIyCfgo4YUqsa1CvJ7w3
         kdQUr8kMDa2qI7EbHIxcPRqt68eA7k4Bl0zlKcog6azWtr9r4fpfXH7fE+9Ph459D6ve
         cdOgD8Zjzi8jethjodBKELXCjaKfot89VjplCw28l6k9HK2APqZ5735RRtYm9Sw8nTU7
         WLTvHCCfFpSeVql5Oi6KjsyyTTfgSySWDDbIcOH1l82MVLXbZWQ9vbpt8O5H6prPfYm/
         AL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7mcxCMUsY68b1C+y1FYJV5SZRpo8yl4CCyl7R2mFnT0=;
        b=HPpEFLmn+fo1MmXQNBIwMw28DYkEiP6L1XdHJjMIQB7yrDq+0kNF/Rl4V4wGEvQd+7
         5kZKEiFVu9IzF6qd4y6bWT+pPl7YR0KVCco24SaMEnbOZCina3kdi+RauTbUQoR6JirJ
         QgsuMb1CWtEpgIpd2tZ+enI7Uy8T6GHRsXfk8B997nmmrsUlRDWsI+0e1zUb74aJaJTS
         lipFBUSmVGuEZu9ImLORgQF5SiQ8neYPBDCSVj/SPS6RXE1sroHUdIes3zPZ+Lr2gZTg
         V2wHt6Yqh6BF9wgouWpM9q7SWkKu1tpXTmEtfXKFH9/F3cgPNgf5ImKKUoVMesENR+84
         jkcw==
X-Gm-Message-State: AOAM531ejvFJ5ouKXTIPvP31TJTuxnWWIu2LFIZ6gepHugOR6mYBD8rw
        OxPWryJKcSkNjF1LR9yhFHQ=
X-Google-Smtp-Source: ABdhPJzPCpdf6bHUll904yF8Otv10ELarDhb1BAS3riXpkas1kvTZGd3KYrfieHGJ3plUkcvkm/2ZQ==
X-Received: by 2002:a05:6512:108f:b0:44a:4317:a066 with SMTP id j15-20020a056512108f00b0044a4317a066mr6614576lfg.236.1649263851576;
        Wed, 06 Apr 2022 09:50:51 -0700 (PDT)
Received: from noname.. ([2a02:2698:8c2a:226e:6d9:f5ff:fecb:a8ab])
        by smtp.googlemail.com with ESMTPSA id k9-20020a056512330900b0044a1be3bdbbsm1877872lfe.196.2022.04.06.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:50:51 -0700 (PDT)
From:   Grigory Vasilyev <h0tc0d3@gmail.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>
Cc:     Grigory Vasilyev <h0tc0d3@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guchun Chen <guchun.chen@amd.com>,
        Joseph Greathouse <Joseph.Greathouse@amd.com>,
        Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix code with incorrect enum type
Date:   Wed,  6 Apr 2022 19:50:56 +0300
Message-Id: <20220406165057.97492-1-h0tc0d3@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of the 'amdgpu_ring_priority_level' type,
the 'amdgpu_gfx_pipe_priority' type was used,
which is an error when setting ring priority.
This is a minor error, but may cause problems in the future.

Instead of AMDGPU_RING_PRIO_2 = 2, we can use AMDGPU_RING_PRIO_MAX = 3,
but AMDGPU_RING_PRIO_2 = 2 is used for compatibility with
AMDGPU_GFX_PIPE_PRIO_HIGH = 2, and not change the behavior of the
code.

Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5554084ec1f1..9bc26395f833 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1929,7 +1929,7 @@ static int gfx_v8_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 		+ ring->pipe;
 
 	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring) ?
-			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_RING_PRIO_DEFAULT;
+			AMDGPU_RING_PRIO_2 : AMDGPU_RING_PRIO_DEFAULT;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
 	r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
 			     hw_prio, NULL);
-- 
2.35.1

