Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7364A4BF8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiBVNSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiBVNSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:18:05 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5361BB097
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:17:39 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so8311369oot.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8PBq7kLR2y8s9lJx+dEOyUvKlmC0izFjBVBTrNAah9s=;
        b=zDyEXMRdcUX5t9jSuG3U62H5xWO+QvfUk2ZhsY58HqOIx9ZnUABFz3X6sbr6HP2ZhL
         ZkFEielo35ToVAG0T3KZnKFZq+ielr9LclAFAtCFbGqTnnYtoKb7yn+g2Wh/D1oyNezp
         0RzfGweLjxjfmYxWe3eS/tpFENTrHDFIM1lRMKJfCTu5sLLvV+KgHW/UD4nV2hJu5/ru
         vHNnxC1OY2tbeUAWCE6VEdaA3Pmothkk3CLzUH7rW2rSEu81lUeI6kTuGObzanZXxggT
         n5njzrT5GV82couAkS7S9CYMi+8RD1d+knUl/5DwG8spMBQ1BE576XER/mfh9CqYZbnp
         VScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8PBq7kLR2y8s9lJx+dEOyUvKlmC0izFjBVBTrNAah9s=;
        b=JrLyyTUV/ZWdcivSX4fUfJCAY1A9bRtk5R+fRq/IRVa4K1iGtTLgsEwQuKX8XT2uZC
         PzRypbOO7uSpBPj+kIOrrcebNUUrOn2yXEJzKclC1UabnkI8teycHKdvAX/RWQOoLyrE
         pBBnio2mnhpGVk6/Up6JYiNQ8qeR57C9+3TDGqDceU7eJfISBVCqw/PVkbT5xCMOpyyE
         1DY8iEqnO1H62VbNTnGgpy19jastG7hMMVHQJoolFVlfMgBz5zbTQxK12WxW96dZl13B
         sNwaiWmhMXbHfN1mqGU8xaRkOGFqewhZRty2+zhF2QrW/Wrdm9M2RISXde9QwSGkwqVW
         JdnA==
X-Gm-Message-State: AOAM533qt4h3E0c38UT9pNBPsXWcIDuJ2x2HmQKck46uxSBscKT6XRyc
        QMnUwJT1TPX3xO4Q5dVGJSpBHw==
X-Google-Smtp-Source: ABdhPJw09Q2GTtVLbWQ/lSO046k89Fi/+pAQfC7O7eca3GixOjwGWDj/ecijDSXxl83tN2+o5PHkWg==
X-Received: by 2002:a05:6870:580c:b0:d1:7d97:19a with SMTP id r12-20020a056870580c00b000d17d97019amr1592418oap.281.1645535859003;
        Tue, 22 Feb 2022 05:17:39 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
        by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:17:38 -0800 (PST)
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
Subject: [PATCH 01/10] drm/amdgpu: Change amdgpu_ras_block_late_init_default function scope
Date:   Tue, 22 Feb 2022 10:16:52 -0300
Message-Id: <20220222131701.356117-2-maira.canal@usp.br>
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

Turn previously global function into a static function to avoid the
following Clang warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2459:5: warning: no previous prototype
for function 'amdgpu_ras_block_late_init_default' [-Wmissing-prototypes]
int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
    ^
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2459:1: note: declare 'static' if the
function is not intended to be used outside of this translation unit
int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
^
static

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e5874df3c9ca..dff5240efcc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2456,7 +2456,7 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 	return r;
 }
 
-int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
+static int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
 			 struct ras_common_if *ras_block)
 {
 	return amdgpu_ras_block_late_init(adev, ras_block);
-- 
2.35.1

