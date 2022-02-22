Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86304BF903
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiBVNSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiBVNSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:18:41 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8841BF973
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:18:15 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so8314061oot.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BddlbliOr23dlDMdKBzq441XXaZGsl4trq5vl1IoJkg=;
        b=FUA2ctAo26U2VrMAKFt54E8PbaVy/9Q9zg1A3qXzzTgDZcTBWgReR8aOIbcyuhzsF5
         eZs6UwHAOqyX2RmmHXchNyyGwfu4QHZGvtnkj1pLEHgLmIqBkMhgf438CjVIgFFuq63w
         6LdcOTqLckFWTH8WJ7U5Tjr9h+muBirlacXpfy3sK/cBHVV9HOlUkfm9ri+eWH1MJ98I
         A6ZP8JyO+8MmfuedfI215qVFqwF1EX60l+jidbFr2G6Ie45RH+r86f5gArzwFc34SWsH
         vN67IJGYhoRz4fT7fTkk552gB+68Q2EyCqicVWLvrhtVtUSS3UP6FyGb7EoQRlFzMrO5
         N3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BddlbliOr23dlDMdKBzq441XXaZGsl4trq5vl1IoJkg=;
        b=Gtf5W05Hhl6pFMpQZrd8hv7mIsRFrO0hLP7eTEtN+QcKHzNPTREVMZQTFb82osdwOp
         BUhBix4cdScVPt39ZNPcgsH+PJuVjQDX8aiQLWpcpmP3sy6m+Nu8r5zPtJcKLTlDzLro
         VkP/yMDWheVyBbPRv1XXn3uqGLKvmZtjTzx6HMi7Fi5M4fsoLam+HJdukc3w00837C6O
         UbTK+Y+IoCgH0+Wp4mGy8xyQxWbEezG8HVedNrtPfQS2cmj4XX4C5N+in1caFDY0V3WJ
         yLQZ2vMIx/Oic+t42zabc91oT4aQcV5G73rYhUwdbiJJFOZttnoeqNZKbz/WEW6gDN08
         uPqg==
X-Gm-Message-State: AOAM531dR7LSx8jn6fMAJ3Gek8lSCyi55nR4OfABJxSgGtC5vMtKTiWs
        pbacdV00CTqv2202A3tPOMeMLQ==
X-Google-Smtp-Source: ABdhPJxEyM6aUtyhGo6ZTsWyPOth67Mi4P+5opQjl7KNJFm0YuxYey03Zaf5skFdls+byx/d7c4Vxg==
X-Received: by 2002:a05:6870:d59a:b0:c4:7dc0:d72a with SMTP id u26-20020a056870d59a00b000c47dc0d72amr1498997oao.253.1645535895164;
        Tue, 22 Feb 2022 05:18:15 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
        by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:18:14 -0800 (PST)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, Hawking.Zhang@amd.com, john.clements@amd.com,
        tao.zhou1@amd.com, YiPeng.Chai@amd.com, luben.tuikov@amd.com,
        Stanley.Yang@amd.com, Dennis.Li@amd.com, mukul.joshi@amd.com,
        harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, Anthony.Koo@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, magalilemes00@gmail.com,
        mwen@igalia.com, isabbasso@riseup.net,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
Subject: [PATCH 06/10] drm/amd/display: Remove vupdate_int_entry definition
Date:   Tue, 22 Feb 2022 10:16:57 -0300
Message-Id: <20220222131701.356117-7-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222131701.356117-1-maira.canal@usp.br>
References: <20220222131701.356117-1-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the vupdate_int_entry definition and utilization to avoid the
following warning by Clang:

drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:410:2:
warning: initializer overrides prior initialization of this subobject
[-Winitializer-overrides]
    vupdate_no_lock_int_entry(0),
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:280:39:
note: expanded from macro 'vupdate_no_lock_int_entry'
    [DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
    ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:404:2:
note: previous initialization is here
    vupdate_int_entry(0),
    ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:269:39:
note: expanded from macro 'vupdate_int_entry'
    [DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
    ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:411:2:
warning: initializer overrides prior initialization of this subobject
[-Winitializer-overrides]
    vupdate_no_lock_int_entry(1),
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:280:39:
note: expanded from macro 'vupdate_no_lock_int_entry'
    [DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
    ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:405:2:
note: previous initialization is here
    vupdate_int_entry(1),
    ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:269:39:
note: expanded from macro 'vupdate_int_entry'
    [DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
    ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:412:2:
warning: initializer overrides prior initialization of this subobject
[-Winitializer-overrides]
    vupdate_no_lock_int_entry(2),
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:280:39:
note: expanded from macro 'vupdate_no_lock_int_entry'
    [DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
    ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:406:2:
note: previous initialization is here
    vupdate_int_entry(2),
    ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:269:39:
note: expanded from macro 'vupdate_int_entry'
    [DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
    ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:413:2:
warning: initializer overrides prior initialization of this subobject
[-Winitializer-overrides]
    vupdate_no_lock_int_entry(3),
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:280:39:
note: expanded from macro 'vupdate_no_lock_int_entry'
    [DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
    ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:407:2:
note: previous initialization is here
    vupdate_int_entry(3),
    ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:269:39:
note: expanded from macro 'vupdate_int_entry'
    [DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
    ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:414:2:
warning: initializer overrides prior initialization of this subobject
[-Winitializer-overrides]
    vupdate_no_lock_int_entry(4),
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:280:39:
note: expanded from macro 'vupdate_no_lock_int_entry'
    [DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
    ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:408:2:
note: previous initialization is here
    vupdate_int_entry(4),
    ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:269:39:
note: expanded from macro 'vupdate_int_entry'
    [DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
    ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:415:2:
warning: initializer overrides prior initialization of this subobject
[-Winitializer-overrides]
    vupdate_no_lock_int_entry(5),
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:280:39:
note: expanded from macro 'vupdate_no_lock_int_entry'
    [DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
    ^~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:409:2:
note: previous initialization is here
    vupdate_int_entry(5),
    ^~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:269:39:
note: expanded from macro 'vupdate_int_entry'
        [DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
        ^~
6 warnings generated.

fixes: 688f97ed ("drm/amd/display: Add vupdate_no_lock interrupts for
DCN2.1")

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 .../amd/display/dc/irq/dcn21/irq_service_dcn21.c   | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index 0f15bcada4e9..717977aec6d0 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -265,14 +265,6 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &pflip_irq_info_funcs\
 	}
 
-#define vupdate_int_entry(reg_num)\
-	[DC_IRQ_SOURCE_VUPDATE1 + reg_num] = {\
-		IRQ_REG_ENTRY(OTG, reg_num,\
-			OTG_GLOBAL_SYNC_STATUS, VUPDATE_INT_EN,\
-			OTG_GLOBAL_SYNC_STATUS, VUPDATE_EVENT_CLEAR),\
-		.funcs = &vblank_irq_info_funcs\
-	}
-
 /* vupdate_no_lock_int_entry maps to DC_IRQ_SOURCE_VUPDATEx, to match semantic
  * of DCE's DC_IRQ_SOURCE_VUPDATEx.
  */
@@ -401,12 +393,6 @@ irq_source_info_dcn21[DAL_IRQ_SOURCES_NUMBER] = {
 	dc_underflow_int_entry(6),
 	[DC_IRQ_SOURCE_DMCU_SCP] = dummy_irq_entry(),
 	[DC_IRQ_SOURCE_VBIOS_SW] = dummy_irq_entry(),
-	vupdate_int_entry(0),
-	vupdate_int_entry(1),
-	vupdate_int_entry(2),
-	vupdate_int_entry(3),
-	vupdate_int_entry(4),
-	vupdate_int_entry(5),
 	vupdate_no_lock_int_entry(0),
 	vupdate_no_lock_int_entry(1),
 	vupdate_no_lock_int_entry(2),
-- 
2.35.1

