Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E614EEC94
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345625AbiDALwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 07:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiDALwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:52:15 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C041D4C30
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 04:50:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so5101870pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 04:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=iZW4cTjGkgQQnvoH1SH2yfBq0jAEd28dgp9ZEgKYlCU=;
        b=FMBXKpVMw6CHOWmZdyjdP7IFP5q30KPxLUhq7S0lu5uLr50iVVtQU5VarR/qT8NUwY
         1QzaF3bIJ3trJF9NApoRKTdTn/n6TWgJR2lME5SBR5gze5mctoSt1cL8lfH56a2CcqbL
         oCGsqVq865sBkfe+kg/gwChXKZvLlX5Z3Cn7MGcrtKura4HWO6KvcVFcRHIcYj3VQgsn
         OHHR58HwZtSN1HLt179hvIbpNHmdn9Q/j3JhaPf+BQ8XCSg7tSErsBpiH4pOoeI2EPH5
         9gltfqRC1Firwbp8/vUVL4HwSucuaytPEZq1nas+W6m7YMN75Avd3cuZo1L0YXKVwipV
         FHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iZW4cTjGkgQQnvoH1SH2yfBq0jAEd28dgp9ZEgKYlCU=;
        b=3YflS0hQoYAoyIJkMYaEiScqdQ7ZzOF6K302kW0bxMHG4M/BZcjknyKKACwjxyaE+k
         t0n4K8hs4eYi4V3anKJRthf9S034lwEeD5hZmNFkNePeG9wd10dT6O8wyZZhmqXKK3fR
         KZWm1eYbM/qGjHnUqpqJW1SL5cxf2gx6u7tk3TJilSTeLQxPFXzbCXjVZOmQyD5GkrMU
         /EezYvm8AiLWt2Rl/bWeK30gUIRXXIFeR+8fOH07WDXdIvGF4PBBJ/O5l5Y2oRXhFzN7
         RQpGU2J812BTG5cvr6POS09htkplSCS7Qjvekff/g4lZx7G4CZ0TSBMH3RVknYWFqb0u
         F/tw==
X-Gm-Message-State: AOAM5336cHiCgJMM7GRf9QqZsAN9WZBe3kuby6rAWqZi8TO/vweuJ4Nr
        sJiHkaTC9z4rxHYZOb/Gx68=
X-Google-Smtp-Source: ABdhPJwK+lD22J11hHSwZVvW2ESfd4FbII74EeJ9+yfoA7Wm06YhiQVqUAA6LIA/Tv4P82+VbNmjwQ==
X-Received: by 2002:a17:90b:3807:b0:1c7:6cd5:cb3f with SMTP id mq7-20020a17090b380700b001c76cd5cb3fmr11399977pjb.201.1648813825648;
        Fri, 01 Apr 2022 04:50:25 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id y41-20020a056a001ca900b004fb000ccd92sm2679532pfw.96.2022.04.01.04.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 04:50:25 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     patrik.r.jakobsson@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, airlied@redhat.com,
        alan@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] drm/gma500: fix a missing break in psb_intel_crtc_mode_set
Date:   Fri,  1 Apr 2022 19:50:18 +0800
Message-Id: <20220401115018.9335-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of exiting the loop as expected when an entry is found, the
list_for_each_entry() continues until the traversal is complete.
when found the entry, add a break after the switch statement.

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/gpu/drm/gma500/psb_intel_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm/gma500/psb_intel_display.c
index dc467996cce4..9a5ea06a1a8e 100644
--- a/drivers/gpu/drm/gma500/psb_intel_display.c
+++ b/drivers/gpu/drm/gma500/psb_intel_display.c
@@ -135,6 +135,8 @@ static int psb_intel_crtc_mode_set(struct drm_crtc *crtc,
 			is_tv = true;
 			break;
 		}
+
+		break;
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
-- 
2.17.1

