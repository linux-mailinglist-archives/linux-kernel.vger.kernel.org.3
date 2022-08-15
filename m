Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE02592A01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 09:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiHOHB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiHOHBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:01:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3C71BE82
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:01:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so6043199pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=lBxuKExwJiydRUzCxRZG0pdDOfLn9vnu6Gvrg3IOunk=;
        b=N2pYGvniog5ztC4WpHJhrj6BeJx9tktZsy+GCUmnqRhXpAxABkZ5aqV9Q0nkMNfvgS
         ir2vahkblaz1/952V515s81n2Db6xV+r6LR9ZFy5etUzT0MD/rkgSC+aQS18vQ7PeQq3
         EV8RTskC5koFGiIDYAyZETNdqzN0BJQLix4lR7x8vmaMTI14jzOKqJvyAWzXi+Q0FaGK
         xpkXSvzYKRIpRF6K9td0tdRAwp+70PzydSVHL477nXuTwLZLw85Mb7fTaIwvHJdjpPGO
         cFMzSaiNmWBQ2Dq9jDn1rUCV8uFPuuNcsPPCf13pmU2xAAbvM2C3ToEIqPiVa6wQS0Wn
         epSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=lBxuKExwJiydRUzCxRZG0pdDOfLn9vnu6Gvrg3IOunk=;
        b=sTXFA6sVc6VOrFqLdRvupXag6Df732ac9frLVl3iqMR5vx798dOQhzBxY6tyTYQa9j
         EKjFsYTCc3046dwR0xBZl+ZdQagGtO/0Vu5LqESpLXWeVAbP/ZgH9NYqKlcBzxEjGYUg
         SyjBSHl0V8kKr74uAeiruyXbVjp1M8e3mHXmrEXUBAPgbVXBDEDfiILwJ9NOJ4c6cmkZ
         /owTv5fEWdw/dxZi1KzEXcRwrBnP8zK+md2GskkzxsXPTt5o3RDxYKP/HXBbK3STXYC6
         bqEm4xKyC2H27aXeIqhBhk4XkC83BKaauLk/lLCjr/PlWkcrsjwGJLuJQ+HxnSWTJBic
         UhDg==
X-Gm-Message-State: ACgBeo1bVTbSv0Ng4F1vyu2RjHqfvaNCLOzQmbWsCCxliE7yTq6cuJBl
        CPtZIIiMA/qjvhVvah4tABOoIjuqvmwNOAKo
X-Google-Smtp-Source: AA6agR7sVypDFOcf7uuBLF8hsvBcfE4nZsErFsVMqm9kaY77S3uHGMBjMpNocX1KWARSUXPR0DWzEA==
X-Received: by 2002:a17:902:d4c1:b0:16f:8311:54bc with SMTP id o1-20020a170902d4c100b0016f831154bcmr14884497plg.25.1660546882289;
        Mon, 15 Aug 2022 00:01:22 -0700 (PDT)
Received: from fedora.. ([103.159.189.139])
        by smtp.gmail.com with ESMTPSA id g2-20020aa79dc2000000b0052d27ccea39sm6224743pfq.19.2022.08.15.00.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 00:01:21 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, James Zhu <James.Zhu@amd.com>,
        Sonny Jiang <sonny.jiang@amd.com>,
        Ruijing Dong <ruijing.dong@amd.com>,
        Wan Jiabing <wanjiabing@vivo.com>, Leo Liu <leo.liu@amd.com>,
        Khalid Masum <khalid.masum.92@gmail.com>
Subject: [PATCH linux-next] drm/amdgpu/vcn: Remove unused assignment in vcn_v4_0_stop
Date:   Mon, 15 Aug 2022 13:00:56 +0600
Message-Id: <20220815070056.10816-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
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

The value assigned from vcn_v4_0_stop_dbg_mode to r is overwritten
before it can be used. Remove this assignment.

Addresses-Coverity: 1504988 ("Unused value")
Fixes: 8da1170a16e4 ("drm/amdgpu: add VCN4 ip block support")
Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index ca14c3ef742e..80b8a2c66b36 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1154,7 +1154,7 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev)
 		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v4_0_stop_dpg_mode(adev, i);
+			vcn_v4_0_stop_dpg_mode(adev, i);
 			continue;
 		}
 
-- 
2.37.1

