Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EB557B527
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiGTLPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiGTLPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:15:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28821D32A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77BA761CBC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C438AC3411E;
        Wed, 20 Jul 2022 11:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658315731;
        bh=gWf/JPxU/WMHcgTlHrU03bQGz6DTy5MrGsm+CDI6p+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rIQQt3eXgb8YRt3A8nVIrxJ7mO4HTlo4vM417/7C4fhN/Gxeeuj35hFZyDoblIkYM
         pv3yVWhc+OAIspbsJGcmLzus6wzKFGHUXFpuNVoMvH+8sNjbEaZNjA9z09fgmwg3Zj
         2Da/EOM+wDDzyNqdiwnjczClNshZrjywR1RQWfqIU5GiRtHZ5PaIeLPkOGT+CUIDAl
         mk32eks4yUlOD4ROWag0VfkcFstGftP0761o74wlL6X//TtJc9NHWgg2xvPJ69EVOb
         BO/10onD/1LW6sVNhNdeFGhtuaBZYi7oAua31Gd6eo1DmDOPadzK2A7yCgh4dQYEMo
         KaSREGiv7qZtA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/9] habanalabs: set gnu_printf attribute for hl_engine_data_sprintf
Date:   Wed, 20 Jul 2022 14:15:17 +0300
Message-Id: <20220720111523.4069830-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720111523.4069830-1-ogabbay@kernel.org>
References: <20220720111523.4069830-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

Since hl_engine_data_sprintf receives formatted strings, it should be
compiled as gnu_printf format, so compiler could check the arguments
of the formatted string.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 1e1f2c494423..6d7b66cd50f1 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3755,7 +3755,7 @@ struct hl_mmap_mem_buf *
 hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
 		      struct hl_mmap_mem_buf_behavior *behavior, gfp_t gfp,
 		      void *args);
-void hl_engine_data_sprintf(struct engines_data *e, const char *fmt, ...);
+__printf(2, 3) void hl_engine_data_sprintf(struct engines_data *e, const char *fmt, ...);
 
 #ifdef CONFIG_DEBUG_FS
 
-- 
2.25.1

