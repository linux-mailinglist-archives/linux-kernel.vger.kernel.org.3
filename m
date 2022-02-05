Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6080E4AA991
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 16:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380274AbiBEPAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 10:00:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380259AbiBEPAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 10:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644073220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=713HQL5x//o/KghlUsgMrDORBx+gP5N718ebtgS9CfI=;
        b=BHMqirobupL0qHDUTGS18gG/t9A4jYcSlEaeKbyzeCtAq23Gh7dDu7Pa5zjjT9+f1Dq6ZE
        ruanLcTCOLDyDr+f5JO/7aIYEHY2s3SoaEYRJgTUermajXf7L47ixRog9PjToG3QrHP+4l
        doB0RrTEXYu5mVjYOEj8EDRzKH72OpM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-Cq78lpotPN2_ZK8V0EQG8g-1; Sat, 05 Feb 2022 10:00:19 -0500
X-MC-Unique: Cq78lpotPN2_ZK8V0EQG8g-1
Received: by mail-qt1-f199.google.com with SMTP id a6-20020ac844a6000000b002cf3968d32aso7218330qto.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 07:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=713HQL5x//o/KghlUsgMrDORBx+gP5N718ebtgS9CfI=;
        b=Kf9iI2aGFJuD9WvxyQkepZO1pSTdmvxv5AM8oSQ2bCnj3ICVbZYyieT983/d0PHXFr
         KZLs1K76+UUh9lM00bvMyYCt23Mo3ugfdVD363B2IIkMlZaAL780xAhl8ZaiwChVtc6B
         jT7mzby2hZci/wbPduOqTFT3M346bOjWgJOm6/xNqYiGpgVzc3SiplSu/HnozORBGp8U
         UAD8XPsh3ItaudLgBkMZ6OMXsWQqNQ4NjWbY7pkxVMYQWpxLzHHBg+6e4VIy20E55dAW
         BYimpiyupBoqzaj7IX2PtW8MR8y9lBD9Bgn1JS5DL1OQ4XLkWLcOhN1l/Dec7GWbCdEP
         rZtg==
X-Gm-Message-State: AOAM532zJ6/2LhCiPIygYKY71GGr2OZO//wxpwDD/QY5Ui4nbf93o8Iy
        i0a1HqKidyk4gjlCbizMGm77uaoC0llbaod36Ejrs9VMQauok1Pl1EuTrazBtllOrS2IY2rh/XL
        8e9gnoqbUcN3+ZiPClhwL31Ju
X-Received: by 2002:a05:620a:371d:: with SMTP id de29mr2218861qkb.300.1644073219112;
        Sat, 05 Feb 2022 07:00:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQMqxJhjsehYnlrGdRYlEx/4uzDQf3AvY1i5RUhxDDhxx+wOwMtIaQmWd3GyZr4OF2gUxNaQ==
X-Received: by 2002:a05:620a:371d:: with SMTP id de29mr2218834qkb.300.1644073218865;
        Sat, 05 Feb 2022 07:00:18 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id d22sm2657159qkn.112.2022.02.05.07.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 07:00:17 -0800 (PST)
From:   trix@redhat.com
To:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        lijo.lazar@amd.com, darren.powell@amd.com, guchun.chen@amd.com,
        andrey.grodzovsky@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/pm: fix error handling
Date:   Sat,  5 Feb 2022 07:00:08 -0800
Message-Id: <20220205150008.1968218-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this error
amdgpu_smu.c:2289:9: warning: Called function pointer
  is null (null dereference)
        return smu->ppt_funcs->emit_clk_levels(
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There is a logic error in the earlier check of
emit_clk_levels.  The error value is set to
the ret variable but ret is never used.  Return
directly and remove the unneeded ret variable.

Fixes: 5d64f9bbb628 ("amdgpu/pm: Implement new API function "emit" that accepts buffer base and write offset")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index af368aa1fd0ae..5f3b3745a9b7a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2274,7 +2274,6 @@ static int smu_emit_ppclk_levels(void *handle, enum pp_clock_type type, char *bu
 {
 	struct smu_context *smu = handle;
 	enum smu_clk_type clk_type;
-	int ret = 0;
 
 	clk_type = smu_convert_to_smuclk(type);
 	if (clk_type == SMU_CLK_COUNT)
@@ -2284,7 +2283,7 @@ static int smu_emit_ppclk_levels(void *handle, enum pp_clock_type type, char *bu
 		return -EOPNOTSUPP;
 
 	if (!smu->ppt_funcs->emit_clk_levels)
-		ret = -ENOENT;
+		return -ENOENT;
 
 	return smu->ppt_funcs->emit_clk_levels(smu, clk_type, buf, offset);
 
-- 
2.26.3

