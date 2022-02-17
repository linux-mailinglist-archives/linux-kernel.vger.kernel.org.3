Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE004BA5AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243044AbiBQQWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:22:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243041AbiBQQWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:22:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B5B1738DD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:22:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22620B8068E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 16:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94018C340E8;
        Thu, 17 Feb 2022 16:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645114921;
        bh=6AiVtQPZxKjZrUPjZF3U+Z3rpqKeUUYJFL49OuEmknk=;
        h=From:To:Cc:Subject:Date:From;
        b=IuG0zs9Z1yrsjh+2PL4JMjl6i6yz4LJMl9gf22KdCuuZqJVsczteN+kG56UjaEp2t
         lMClIFgnmIhm0nn02Dv7DKHhJp9Dy2rBWo9MbU78+37qlGmitF/JG6tUp1JGKzra1u
         ij0a7peN5leGXJmEnk5tpVjSGJFsj3Q0bsFTXTznvpa7UcIBQFzgqRgMg+lXw8g54R
         8EEnWCntkKZwmcxTP3g7I0OhYZHvwoXoj7eib30CyOUwhzBF+woc/2CR+HXBDJUVma
         rwRt8NX8bIpUp3zs2KQMUjkY7FJISSmLdbbcAO91WSioUchXt50dY8XwYG6SaDj7jY
         GtN5ZlIFQ97jw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc:     Jonathan Kim <jonathan.kim@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] drm/amdkfd: Use proper enum in pm_unmap_queues_v9()
Date:   Thu, 17 Feb 2022 09:21:42 -0700
Message-Id: <20220217162142.1828990-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_packet_manager_v9.c:267:3:
  error: implicit conversion from enumeration type 'enum
  mes_map_queues_extended_engine_sel_enum' to different enumeration type
  'enum mes_unmap_queues_extended_engine_sel_enum'
  [-Werror,-Wenum-conversion]
                  extended_engine_sel__mes_map_queues__sdma0_to_7_sel :
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1 error generated.

Use 'extended_engine_sel__mes_unmap_queues__sdma0_to_7_sel' to eliminate
the warning, which is the same numeric value of the proper type.

Fixes: 009e9a158505 ("drm/amdkfd: navi2x requires extended engines to map and unmap sdma queues")
Link: https://github.com/ClangBuiltLinux/linux/issues/1596
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
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

base-commit: 3c30cf91b5ecc7272b3d2942ae0505dd8320b81c
-- 
2.35.1

