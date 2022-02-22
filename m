Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6C14BF8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiBVNSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiBVNSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:18:22 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AADBD2C9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:17:53 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id w10-20020a4ae08a000000b0031bdf7a6d76so17386428oos.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUjTQJmzrA7YmPv0U39+3zh4DUhMv7PoZUE1y8daTkU=;
        b=FPkH1X3s9Z4MaxrX4uqfjr3F7a7VH/XL8sjYBD6kv6nMhEpAtU0QfomFMaSf8GNpNb
         t8YlseyboP1Z50Mc5eIfXqwSJbkKQTQ9ZXMON7BiQCTV40wpQybAmTe494JaSNRDO+zC
         vbuySWtEozg1GqhKsGDm9fQ6jWZhJiM7f8lLHj9CylLBenQ2MER4QfyRBDuXXRIlTfvt
         5ryycyOYPDO6dj2uPS+Xzphui8DCkRzUX48xpDmIKU+nAvi9WGP2l70vmWQ0sQFkV6ea
         LdMIKNtGBicAKMdkC8dcenYvWdwTribZIuLNqcKIWS1LNJGiEYXiZp0ClRVbRr+Q0sZT
         YZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUjTQJmzrA7YmPv0U39+3zh4DUhMv7PoZUE1y8daTkU=;
        b=vy/Ax87e7ukcCR7AsyvHpBUld1vjMWtC6dcDj7GM0EfyEw2TbCvbIOamH2xCZZH8PM
         uDzOTU88qUIDOtnaTQsMrHfz9odB3tBHhPu4LOtN6wyL31PWh67s/jMzaA2w6U1t/1pN
         sgY6QXaQ9JZqxTMsq+rFWgHEu/Wp/kGiM74AbnfuSULERRgPdQKulML2RN6vgyJM7SUc
         OW5vP95H8RZn5MSDLa8eG6aoFza95dnMUYlKkaudqhIdHwM4/7h5uwqHiLYG/rJ4QgIT
         58FVWM2rmL0CpzbHyxr6OVEz5XCDQLMejURete++n1pJd5ENPz1/AKdi2Ff092G1QIce
         Fv+A==
X-Gm-Message-State: AOAM5301Pke6CR2WYIODLhaETsTCqsPuB4m7BerJl3Diz6qt7UHWgRTL
        dw97xVWUZtVYsnRmIQ1WncRCQg==
X-Google-Smtp-Source: ABdhPJzSWobKzGCiBglLAMfGQ3zQeN2B60sOxZj/bjK565W/h7V9hy4VhSqKHUZu46XzLWuT1K3MqQ==
X-Received: by 2002:a05:6870:2142:b0:d2:c3fe:83c8 with SMTP id g2-20020a056870214200b000d2c3fe83c8mr1630946oae.165.1645535873120;
        Tue, 22 Feb 2022 05:17:53 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
        by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:17:52 -0800 (PST)
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
Subject: [PATCH 03/10] drm/amdgpu: Remove unused get_umc_v8_7_channel_index function
Date:   Tue, 22 Feb 2022 10:16:54 -0300
Message-Id: <20220222131701.356117-4-maira.canal@usp.br>
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

Remove get_umc_v8_7_channel_index function, which is not used
in the codebase.

This was pointed by clang with the following warning:

drivers/gpu/drm/amd/amdgpu/umc_v8_7.c:50:24: warning: unused function
'get_umc_v8_7_channel_index' [-Wunused-function]
static inline uint32_t get_umc_v8_7_channel_index(struct amdgpu_device *adev,
                       ^

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index de85a998ef99..f35253e0eaa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -47,13 +47,6 @@ static inline uint32_t get_umc_v8_7_reg_offset(struct amdgpu_device *adev,
 	return adev->umc.channel_offs*ch_inst + UMC_8_INST_DIST*umc_inst;
 }
 
-static inline uint32_t get_umc_v8_7_channel_index(struct amdgpu_device *adev,
-						uint32_t umc_inst,
-						uint32_t ch_inst)
-{
-	return adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
-}
-
 static void umc_v8_7_ecc_info_query_correctable_error_count(struct amdgpu_device *adev,
 						uint32_t umc_inst, uint32_t ch_inst,
 						unsigned long *error_count)
-- 
2.35.1

