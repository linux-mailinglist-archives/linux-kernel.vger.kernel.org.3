Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34BE4BF8F4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiBVNSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiBVNSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:18:00 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10EFA9A77
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:17:31 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id k9-20020a056830242900b005ad25f8ebfdso9577621ots.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bcSxnOgYRWuwEWYsw+jDqFwC/iPiLyo1fAK+m7rTBM=;
        b=FARwwudhrbiHNm+ymHkQ0oMqAOKF0Vf42hLTkLPVD7ODdcqqajzRrQGBdwOih/K0bb
         RUxopYSwKuxLMBZiJ79Q+DgoMrhCzQOsjQmLPvgQINoXR0wtyLlPZYzuYRPIZ8swe962
         ZgigI+e6snret4Jj4aG3OOyEc4M9wSawdbeC545UbyBvOExwqEX5bbLbG/As/xk4zLhr
         Gp/IMdQXMT73GBWuxTLlts5DVT60AgyXaAZeMf+VwrX0ptevIAl+8aj9IDEteHsTkRJH
         BN24yfy/ysLfDcXaCnkXr4TUHMV7v22mVn0BKE3jLi4rzvrC/KeNn/IfwhiVcKcW0gOD
         Ni2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7bcSxnOgYRWuwEWYsw+jDqFwC/iPiLyo1fAK+m7rTBM=;
        b=Jk676FwyXJkMkOpBEHbTM/7078VJBNNwfHF2td6A+liAhUtY4Bjnqw7/4PVDzMIWTC
         lxy2BWg97E32aolQK1dAmSYBfLVpeRuEbn4QGzXX/H62oRvOUceTx7FJlbH8mkEUW2kx
         /HayOA+GXBMARRWjQ+CdaLmscKrECY9Rs0twRbbZDZ/lgYHjXcsxBQXbv/lnw/IvWvcq
         P2iN7a6qe529JKSC3zb3GxgQRrhCw64fCoTevedXbHqEPVPKEwUy+inifYUNxR5YCClB
         LRyrLQbp4pDXfHDtAWK5BLutJCPk1xrXM+Z89vb+YQvS7k/zkMJzWsr94OSKe+HAF1fj
         txEw==
X-Gm-Message-State: AOAM532jAcL8MlAYYoSv/n8asgyua2yXno1koj96sdtnpwVHKDQqjRSO
        guzV4pZsMcLIjcQwaZk1Y1IfpA==
X-Google-Smtp-Source: ABdhPJwd8xzR9s0jcNwaKdd2s6R5udAwjLK2LLk1zR46KzB4XuGEtlKmrg0YPTU0KivbVcgwBzB58Q==
X-Received: by 2002:a05:6830:268c:b0:5ad:1000:397e with SMTP id l12-20020a056830268c00b005ad1000397emr8446171otu.35.1645535851081;
        Tue, 22 Feb 2022 05:17:31 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
        by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:17:30 -0800 (PST)
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
Subject: [PATCH 00/10] Fix multiple compilation warnings
Date:   Tue, 22 Feb 2022 10:16:51 -0300
Message-Id: <20220222131701.356117-1-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.1
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

This patchset intends to deal with a couple of warnings in the AMD graphic
drivers. All warnings were generated with Clang and W=1 flag.

Maíra Canal (10):
  drm/amdgpu: Change amdgpu_ras_block_late_init_default function scope
  drm/amdgpu: Remove tmp unused variable
  drm/amdgpu: Remove unused get_umc_v8_7_channel_index function
  drm/amd/display: Remove unused temp variable
  drm/amd/display: Remove unused dcn316_smu_set_voltage_via_phyclk
    function
  drm/amd/display: Remove vupdate_int_entry definition
  drm/amd/display: Remove unused dmub_outbox_irq_info_funcs variable
  drm/amd/display: Remove unused variable
  drm/amd/display: Add missing prototypes to dcn201_init
  drm/amd/display: Turn global functions into static functions

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c          |  4 +---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c          |  4 +---
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c          |  7 -------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  4 ++--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c    |  2 +-
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c   |  3 ++-
 .../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |  2 +-
 .../amd/display/dc/clk_mgr/dcn316/dcn316_smu.c | 18 +-----------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c  |  2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  3 ---
 .../drm/amd/display/dc/dcn201/dcn201_init.c    |  1 +
 .../display/dc/irq/dcn20/irq_service_dcn20.c   |  2 +-
 .../display/dc/irq/dcn201/irq_service_dcn201.c |  5 -----
 .../display/dc/irq/dcn21/irq_service_dcn21.c   | 14 --------------
 .../display/dc/irq/dcn30/irq_service_dcn30.c   |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  5 +----
 17 files changed, 15 insertions(+), 65 deletions(-)

-- 
2.35.1

