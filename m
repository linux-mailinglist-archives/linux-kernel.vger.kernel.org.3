Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D1F4C3596
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiBXTQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiBXTQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:16:56 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FDF25293A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:16:25 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so1993025otl.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TLiWpOnxapYAVvT4QJds8jwsCUqpq+N+eb8iJ1oxqPc=;
        b=FoSBsHzIox96KnpJAyliB1ZiuIjpzEzM4XYDkOlGoqloV5Eo7EZVSPu2ErTj4vLJMi
         upYaLfSb0X91GX+xn6TnAobrbP6ERdOB5KlZcpaoe7UbiAWgiKPgTlQEtKxHSzdLcHMS
         lOjpOydbBexU4vm5IkOYAkImwvyLuVtkbedyi2e7M1I2TfUrXXZR7/AB5zitxIeKy/IC
         x1F5Q91iYENsXt8Yd24tfJgrSbsl/BS2PPenavqRHuQd9YmcfFKmky7rirOq5DXnIC0b
         XSj6nBARIPzqtJUo0WYZfR72ddf+6yWvaL9fNzHTsevpQcAYyyylt8lzDJ2QWRku7DVr
         pJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TLiWpOnxapYAVvT4QJds8jwsCUqpq+N+eb8iJ1oxqPc=;
        b=2TVwU4CgMxzCnJ95mhXm86L5/HgKOJhppcczago7Mvjivsi6tAVhyDTplDH9TNEe31
         IGgORZgESmzMR9PYdFHSNxV2sXjSyY1GG65vAT+QwN8lAS/lKlERLkd6SOgQwn344OeK
         qABOFdI42QM62zx7B5gqGxXX/0ymleElAdS4Yk6Xh2L1Li1Ka0OAwY/2SoqrstwDDc8x
         00xD+1iTEilR8jVHNpFuKgiVhubKTTu/jQxkMPMMet7pGhoxSsslaDk3YlLalbvT477F
         jKf6YjSvuSt//SItCDc850p/hKrG78gaanrSRyiiVFt506atoCJQmJJAUEZA6njEyBow
         wsIw==
X-Gm-Message-State: AOAM532bGQxMS+sONWXy0bstob0VkmxIMgWI2JR5yNkqXZvnPuvE0vxm
        0VU5yd7su4KEM3y/1EcES/0=
X-Google-Smtp-Source: ABdhPJzBXhUKmpv0W6RRc6cmrcAkgPuFrtLmZVXDFelgeLtmLNAIwubxdHBKS6Tl11+U/IW4kchtiQ==
X-Received: by 2002:a9d:6e09:0:b0:5ad:1fcd:bfd0 with SMTP id e9-20020a9d6e09000000b005ad1fcdbfd0mr1532004otr.312.1645730183457;
        Thu, 24 Feb 2022 11:16:23 -0800 (PST)
Received: from localhost.localdomain (189-47-54-110.dsl.telesp.net.br. [189.47.54.110])
        by smtp.gmail.com with ESMTPSA id w3-20020a056830110300b005af14392276sm79509otq.62.2022.02.24.11.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:16:23 -0800 (PST)
From:   Magali Lemes <magalilemes00@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     siqueirajordao@riseup.net, mwen@igalia.com, maira.canal@usp.br,
        isabbasso@riseup.net, Magali Lemes <magalilemes00@gmail.com>,
        kernel test robot <lkp@intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/amd/display: Adjust functions documentation
Date:   Thu, 24 Feb 2022 16:15:48 -0300
Message-Id: <20220224191551.69103-2-magalilemes00@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224191551.69103-1-magalilemes00@gmail.com>
References: <20220224191551.69103-1-magalilemes00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Part of the documentation of the 'dc_process_dmub_aux_transfer_async'
function was misplaced, being put together with the
‘dc_enable_dmub_notifications’ documentation. This caused the following
warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3757: warning:
expecting prototype for dc_process_dmub_aux_transfer_async(). Prototype
was for dc_enable_dmub_notifications() instead

This commit fixes the warning by placing the function documentations in
their right place.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b1ce3c0cf477..61e3bb99375f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3737,8 +3737,8 @@ bool dc_is_dmub_outbox_supported(struct dc *dc)
 	return dc->debug.enable_dmub_aux_for_legacy_ddc;
 }
 
-/**
- * dc_process_dmub_aux_transfer_async - Submits aux command to dmub via inbox message
+/*
+ *****************************************************************************
  *  Function: dc_enable_dmub_notifications
  *
  *  @brief
@@ -3780,7 +3780,7 @@ void dc_enable_dmub_outbox(struct dc *dc)
 }
 
 /**
- *****************************************************************************
+ * dc_process_dmub_aux_transfer_async - Submits aux command to dmub via inbox message
  *                                      Sets port index appropriately for legacy DDC
  * @dc: dc structure
  * @link_index: link index
-- 
2.25.1

