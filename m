Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D238955A5EB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 03:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiFYBmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 21:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFYBmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 21:42:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0633650B0A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 18:42:08 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n10so3549894plp.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 18:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdeIHQVuGIq74deo1wq4KcCpm8Z3V/4ahZjeL3ne7+8=;
        b=JZollLIDhwsOxrqh/kIbwN3pl1uMWkUobCywBL/OTzI6aS8SvxU/5iZfD2+zfDb9rm
         5brWxDDqYtLrjhk6jDrCYpcUSeEM881A+oqpKPnMuGi60s/6ykKxfxnqrhKtaqjLK/5s
         senljBsT/4eFU7LUWu1FqjMwQzXXSskr6lBFzE1loeWeFnw0SF4xomh8E5sXdCTilDVe
         If5PIWHBarJ8UMtd6SxXcPdCPuD7BmHSNxL+1ks5oTkPcY6tD8svM4ozwFVktK2yxEA0
         iYFuh1vXVqz8VMkzRn4whTc4lLtfbazv9qphnX0vPueWyWRN9bJP23LdwK2nFTSvx9JJ
         dYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdeIHQVuGIq74deo1wq4KcCpm8Z3V/4ahZjeL3ne7+8=;
        b=sJcMUSEKFOJtRraELtqVDOgJfX6+WL9WrjeiZF9V9llgnM1JGubMqQb4jsN+mBRAIR
         1RCV7R8JhP9GA91tWyYI0ho5q8m9a2wrHoJCccEkhHvUaj4CvS/OsDgp4deXhTlfWZpX
         +zpUILr7Ni6kh0d5q+kgeEzQEkwkm7+XmLENh7ZQuQuOBQr6IRogbnSkeTEU3lLfEU25
         vrT8hxqRX7/e17ulWEKhP+JfpDhXQTi9L4iXs3h0c0kmUOIf9kMQ6OBqnIFM8pT5ufi/
         u8coKVMKuBYavYMYMit822XHdH8sX8E8uHTZqGv5ZAhtajSbHAWKPK4WLiOJjnKwThbT
         UGXQ==
X-Gm-Message-State: AJIora+e3bhZv+rAgX+A1vVvEjO5Z8CcrhmylvDhprTxlki/FtHMnwzN
        qTO11k/04MCWmMsvaEfcVrXVuPKph1EDPa0G
X-Google-Smtp-Source: AGRyM1uZAHtn24InCTHwiAwpG/NEyIdpbEc0pkFGkCXvPsXO8VyUNPMZeaXitH3RhCxNFWM+5p6pfw==
X-Received: by 2002:a17:902:d504:b0:16a:4846:3f46 with SMTP id b4-20020a170902d50400b0016a48463f46mr1900105plg.159.1656121327298;
        Fri, 24 Jun 2022 18:42:07 -0700 (PDT)
Received: from localhost.localdomain ([122.167.211.160])
        by smtp.gmail.com with ESMTPSA id x20-20020a056a00189400b005251b9102dbsm2467173pfh.144.2022.06.24.18.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 18:42:06 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, wenjing.liu@amd.com, Jun.Lei@amd.com,
        Jimmy.Kizito@amd.com, Jerry.Zuo@amd.com,
        meenakshikumar.somasundaram@amd.com, hanghong.ma@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amd/display: Removed unused variable ret
Date:   Sat, 25 Jun 2022 07:11:57 +0530
Message-Id: <20220625014157.5004-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

Kernel test robot throws below warning ->

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:
In function 'dc_link_reduce_mst_payload':
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:3782:32:
warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    3782 |         enum act_return_status ret;

Removed the unused ret variable.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 55a8f58ee239..445357623d8b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3706,7 +3706,6 @@ enum dc_status dc_link_reduce_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw
 	struct fixed31_32 pbn_per_slot;
 	struct dp_mst_stream_allocation_table proposed_table = {0};
 	uint8_t i;
-	enum act_return_status ret;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	DC_LOGGER_INIT(link->ctx->logger);
 
@@ -3777,7 +3776,7 @@ enum dc_status dc_link_reduce_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw
 			&link->mst_stream_alloc_table);
 
 	/* poll for immediate branch device ACT handled */
-	ret = dm_helpers_dp_mst_poll_for_allocation_change_trigger(
+	dm_helpers_dp_mst_poll_for_allocation_change_trigger(
 			stream->ctx,
 			stream);
 
-- 
2.25.1

