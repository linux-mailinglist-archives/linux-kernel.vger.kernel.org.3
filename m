Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D12B509B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387240AbiDUJGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbiDUJGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:06:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3AA1EC72
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:03:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id iq10so625651pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=B0+tpECkjfe5fDGtISyAD3Lzpd0VL9h6G8D6KejEZfU=;
        b=M0YfVepMgFZBtbJpX/BDsVMwuOn2WMjeOT4HUmLIbWcrytXgyCbKQxwkC9dhJHEkJO
         pMSQBCbUeJRmVfo2LzBSfsIeandEKZhy7N2R7afD+I/CEg9KEKEv+BTPwEiwabZwqWHA
         x8b3Sa3cApk4ujtccHH0jbB1mlS9K1sfLkstVXN67bnZsctpFs6z93FE/df4hAn+UoIw
         0o3DHlKgvUIIe/f/Rp6+sFnZ9nn5ZUPxzobv9pznpnC8+BVBNd/qfxe/Ql0qPEKex5RC
         wEUSYbKMIjdLUA+ypQr2q/FP1aV7i1TjIxOiDZQ4Eg/pU9g0Bchuxcb+jYsHhu56IeLm
         PxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B0+tpECkjfe5fDGtISyAD3Lzpd0VL9h6G8D6KejEZfU=;
        b=u1snbIKCWtDCxxbnJDMOwqVSUf6y54kRXyBKVYVLgynIcLi6ij5iEWRYm5FJuU9NEs
         kDIdjCrQpsnBVjTs1x8I5kZzoMdrcjIUsFgdyzv/QYrzHUZzrp/4PAF5blk60NK+Ksny
         94yXSObzQx40JLVR07R3UsilqkAJdFTL5i6k9JNZ5ZSk1VNVkVzFfwILj+Te5n0uiFZX
         xqtv35wg6O7/O+3xKQmPREJfg1YEDCBZ7e4DBbt/s0EsRZBGhXSGpTekTqVcQIMZGoO9
         Wn9P2QE12ifb3lInV87UWMVZyprfzg7815DwF1SBX1mWkoiVbg5QLOai4Wi9jdEX1Lmy
         u2kA==
X-Gm-Message-State: AOAM532cqhtkR0FIC/ZmAvLlovC00avnLP7Y4en4uTRf87RYNP68DiWV
        6Y34Chd0fLlXXDWRqbWOpW6sHQS3oXkT2xuPi50=
X-Google-Smtp-Source: ABdhPJzGWXboLc6+AxBDqQ5cnfywyDHSQdg1utvBr/x/CsXVWXcxoOWHlY8LpPRT4YwB4syhAGVU8Q==
X-Received: by 2002:a17:90b:3503:b0:1d1:c700:e484 with SMTP id ls3-20020a17090b350300b001d1c700e484mr9271071pjb.245.1650531802071;
        Thu, 21 Apr 2022 02:03:22 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id 3-20020a17090a190300b001cd4989ff60sm1957980pjg.39.2022.04.21.02.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 02:03:21 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laktyushkin Dmytro <dmytro.laktyushkin@amd.com>,
        Solomon Chiu <solomon.chiu@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Victor Lu <victorchengchi.lu@amd.com>,
        Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
        Melissa Wen <mwen@igalia.com>, Angus Wang <angus.wang@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] drm/amd/display: Fix memory leak in dcn21_clock_source_create
Date:   Thu, 21 Apr 2022 17:03:09 +0800
Message-Id: <20220421090313.24864-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dcn20_clk_src_construct() fails, we need to release clk_src.

Fixes: 6f4e6361c3ff ("drm/amd/display: Add Renoir resource (v2)")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 3fe4bfbb98a0..faab59508d82 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -997,6 +997,7 @@ static struct clock_source *dcn21_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
-- 
2.17.1

