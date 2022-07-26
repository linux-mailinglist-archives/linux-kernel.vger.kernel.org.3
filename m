Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7FD581404
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbiGZNQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238841AbiGZNQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:16:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FE12C11A;
        Tue, 26 Jul 2022 06:16:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v13so12332618wru.12;
        Tue, 26 Jul 2022 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Duf9LNn9G+2SxZbSGdM9LaiaWUfM9ULAz6lC3vIn2Ww=;
        b=O0nWXBcRZRg9NMM5pVwln7f7CutSP5ljI6MDNHGsSg4V4kZMp6DqJAI+1T04VHrlDA
         Z7UYCiPID76oZOvAw5uKWf1R/oRb5OcrKZfm14qHQC4Hj4KMQRfUlKdSvz/UaWTfFOWS
         MOdF8J2wFUv1zEZ6Xv5JY51HNSuS81S5lf3VvpuCWyzixwSCgGthghcAdfTbzx8uwvI9
         3x7JTbeOTt3EF9VvIQ1TWiaiYG3h2xC09KuI4V2nPnMq23dgZTymF+m+OS3NaaXGipfl
         1y33AnMWL0I3kTda9zTWVHt7jLqvMT2loEo2vEsS0Ytk3ga1seCAqPsToJ4XVqc43em8
         Nv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Duf9LNn9G+2SxZbSGdM9LaiaWUfM9ULAz6lC3vIn2Ww=;
        b=P84iEGJAbPiLWuA0wcSQlFgmjnl2TgOWNKwZp1SGnB7iXQKoKvedwqI+KDknudqdGv
         EiVu3byHbnfxbmHz6taJ3G25AHyr/KH0XwYYn/EQ80EKg458Q4YgLJhLs0xDtPYNOf6H
         u+i5Q2ftzhGW8AyFu+UWOjshSXFtnTrpD67rzZZmiiuTOAgADzdGTFu+Zk4Y5kZE+sJO
         n01vAHKG6Hl63qTPh30/nPQ+N2wYQaph0i/Kb2eQcKqxnaoMnDNXKtCvi97AfPfcZ9oh
         /GJCDu2RNRxLvW+XD5uLdexidCfwyohPCxVJvSEpb5fvZbAeDWDjAhA4IEMxBc53i+B6
         +Kgw==
X-Gm-Message-State: AJIora/C0AzS29Aos0d2Oog+2cMU7h/0aqQKAsPS+1X5MjkiR5orGVaM
        qkcq3osYcOCXCbvXJtwTtrs=
X-Google-Smtp-Source: AGRyM1u/y0Lpgy3onUxB/fFhSH4nTKydssx+mfUucmbARsinAuebYkKCLc8L7oHivhtbm4ywR7V/zQ==
X-Received: by 2002:adf:f452:0:b0:21e:86ac:cd74 with SMTP id f18-20020adff452000000b0021e86accd74mr7280992wrp.194.1658841414530;
        Tue, 26 Jul 2022 06:16:54 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id az14-20020adfe18e000000b0021e529efa60sm9052731wrb.1.2022.07.26.06.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:16:53 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/gt: remove redundant pointer sseu
Date:   Tue, 26 Jul 2022 14:16:52 +0100
Message-Id: <20220726131652.46462-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer sseu is being assigned a value that is never read. The pointer
is redundant and can be removed. Cleans up clang scan warning:

drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c:300:2: warning: Value stored
to 'sseu' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
index 75257bd20ff0..c0578194ab16 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
@@ -286,7 +286,6 @@ guc_capture_alloc_steered_lists_xe_lpd(struct intel_guc *guc,
 	const struct __guc_mmio_reg_descr_group *list;
 	struct __guc_mmio_reg_descr_group *extlists;
 	struct __guc_mmio_reg_descr *extarray;
-	struct sseu_dev_info *sseu;
 
 	/* In XE_LPD we only have steered registers for the render-class */
 	list = guc_capture_get_one_list(lists, GUC_CAPTURE_LIST_INDEX_PF,
@@ -297,7 +296,6 @@ guc_capture_alloc_steered_lists_xe_lpd(struct intel_guc *guc,
 
 	num_steer_regs = ARRAY_SIZE(xe_extregs);
 
-	sseu = &gt->info.sseu;
 	for_each_ss_steering(iter, gt, slice, subslice)
 		num_tot_regs += num_steer_regs;
 
-- 
2.35.3

