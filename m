Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1BD593869
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343627AbiHOTJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 15:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245731AbiHOTGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 15:06:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749F533E20
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:34:50 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 17so7060769plj.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=fpZDxV3FuvKhUJk99+fRvjd0nkg0TSmKhn6atJ1wty8=;
        b=a1K+P6NVeHSYaQMtXr/LyitVsOi7nOVeQHeTYjzFN9ULPSC59iBbE8SiHTl0W/rmkp
         fRSn62nD1SfUPJnD+khvkRZfhjIkb2buWTPfmjYE3iLXaj2PL8HpwpVeWMCpyn+VPoPA
         EcvW9DMwcscmwN1+PMPMPCK4ZnFmomRZxjvDv9faTz7z4byWzH/tYj6oi6dl+MLug7+Z
         iXye3WTEZwDkiCrqGp9qidOfFhjaQC+Q46v85npKusBU4nnWRSViJMpATPWWUVZwU50E
         Tz7Fqbxb/Rv+uksfmWRJ21PhkVNDlBvCWVKL8X2xJkMapqilUATc3QDp6N0ERShI+EYf
         fZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=fpZDxV3FuvKhUJk99+fRvjd0nkg0TSmKhn6atJ1wty8=;
        b=4XWxrZAoZ/Joe9DFwjdgNH9aJd9u6I3r0Ui49Y5ivFaCKc5E1y/W5Vs2cOwMBhHHHh
         h7Sur61hfKCBQQs1cKJ7oU63Bh1HGbJhLipGwjBIb6hdChrrJGVehi0q6ivTLO+B23w8
         T71E4UhH6SN2+JtrhotB50Y3GbsbVQvp8BT0HCXwmKpwL7vn1QGvjn6K9vNkrR27om5h
         /k0B85BocNDwf8OElcjQs+tlG9xwA72t5lWsZMo4Kl+fjJv4TglXn8vOKlklrlwDSp/F
         iheSZK/eXQWjgcxnh1y4ZC6ibx0owH5+oVH0Uo8FpyAcsfpOWMh2eapr06nWAq/LuImS
         HNig==
X-Gm-Message-State: ACgBeo0rLaU8sr+upBRxa2M1fS1Ef80M4h3O510YEjUmBJgQEpj4rmP4
        oM0BzJEYxV2T1vdiV8r9GYY=
X-Google-Smtp-Source: AA6agR6DID+aTGefAK9b7+8YBYaTXPl4EGnNCw/qrKaz5t3HTdVMKH0b7FbPSyTAVyNyT+6GEmiRqg==
X-Received: by 2002:a17:903:2601:b0:16d:b055:2985 with SMTP id jd1-20020a170903260100b0016db0552985mr18216404plb.161.1660588489692;
        Mon, 15 Aug 2022 11:34:49 -0700 (PDT)
Received: from fedora.. ([103.159.189.148])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016c78f9f024sm7305175plb.104.2022.08.15.11.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 11:34:49 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     Ruijing Dong <ruijing.dong@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, James Zhu <James.Zhu@amd.com>,
        Leo Liu <leo.liu@amd.com>, Sonny Jiang <sonny.jiang@amd.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Khalid Masum <khalid.masum.92@gmail.com>
Subject: [PATCH linux-next] drm/amdgpu/vcn: Return void from the stop_dbg_mode
Date:   Tue, 16 Aug 2022 00:34:25 +0600
Message-Id: <20220815183425.14867-1-khalid.masum.92@gmail.com>
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

There is no point in returning an int here. It only returns 0 which
the caller never uses. Therefore return void and remove the unnecessary 
assignment.

Addresses-Coverity: 1504988 ("Unused value")
Fixes: 8da1170a16e4 ("drm/amdgpu: add VCN4 ip block support")
Suggested-by: Ruijing Dong <ruijing.dong@amd.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
Past discussions:
- V1 Link: https://lore.kernel.org/lkml/20220815070056.10816-1-khalid.masum.92@gmail.com/

Changes since V1:
- Make stop_dbg_mode return void
- Update commit description

 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index ca14c3ef742e..fb2d74f30448 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1115,7 +1115,7 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
  *
  * Stop VCN block with dpg mode
  */
-static int vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 {
 	uint32_t tmp;
 
@@ -1133,7 +1133,6 @@ static int vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	/* disable dynamic power gating mode */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 0,
 		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
-	return 0;
 }
 
 /**
@@ -1154,7 +1153,7 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev)
 		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v4_0_stop_dpg_mode(adev, i);
+			vcn_v4_0_stop_dpg_mode(adev, i);
 			continue;
 		}
 
-- 
2.37.1

