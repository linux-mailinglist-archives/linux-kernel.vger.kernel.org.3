Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F75C499424
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 21:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357597AbiAXUja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:39:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355870AbiAXUSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643055500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LK256wQogjCX5wa9UmsP7s8Vi1buTBnWqTcBCjO4e1M=;
        b=dfjWvoV/nj/UHWbBCL6SJD5EwtpW6aDf8ZAg8l/QWXSDhbIwdTrruxaPEgV7wmvhg3kYdg
        gVLLjWm7azrHkh1KZfSov6Fzp9cvZbRlIqgVW+Wl81aHrAhWM41JTCfx/NyA+pza18YanW
        rh7cADrzR+u7dsku3UC4TIv+MLrlt1c=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-poG3y3CLPBOcpJry9AjO4w-1; Mon, 24 Jan 2022 15:18:19 -0500
X-MC-Unique: poG3y3CLPBOcpJry9AjO4w-1
Received: by mail-oi1-f200.google.com with SMTP id u35-20020a056808152300b002cd7df67524so2525420oiw.19
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LK256wQogjCX5wa9UmsP7s8Vi1buTBnWqTcBCjO4e1M=;
        b=qpdIZgb+WFGvZ/5RJocCCkMlsqhuYGXXQrnrUBt8t2m2kz70dtMoGQd+NlikOfbOT9
         MyYh4xnlS18255btKIMm4AkoHbWz34fK7Fl5w8bjuKx25Ddgp3UMqDCqCrlrWtNZjQAL
         a8mj0KvoXe2jAdeuxBlVSXDg9KqiRXZPvWKJiEq+nDj1EEC9ipa1EK57/BlDn+KS+eVT
         1j58fR7m/0zIi3TcCfLSqvzASBWRfms4g3U8SOhKwUBXfPaIMrjHkTkXPpphf8+1iuZ4
         vpt0XvLOnxXU5ALAV2ekXOqkA5LDwO3iw1SsmL/OIuY0X7S1JU+DIkfp7w/f/W7QKxPZ
         p7PQ==
X-Gm-Message-State: AOAM531/HMbPrRfu7wlPCgsLRKn6Ohv6nlSWd9ENMSe3VvHJp/EE6aXi
        5idiXoChZd1bArVv7h7k0zqLZuM9Ls2yibAGUYDNpEFoqAXMUr2KJjUsqT/1anHLIbNAeIJsE9l
        MKvrgI54Y9txQNTF/jE6DeZrO
X-Received: by 2002:a9d:d08:: with SMTP id 8mr13197870oti.334.1643055498329;
        Mon, 24 Jan 2022 12:18:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTEn4ya3/5eCInZIkS/C/4U2Q9wOWBRRyxGnlMA9linsmQiFFzkE//YKVVW2gVtrkOgoqmKw==
X-Received: by 2002:a9d:d08:: with SMTP id 8mr13197856oti.334.1643055498138;
        Mon, 24 Jan 2022 12:18:18 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id bk23sm6235774oib.23.2022.01.24.12.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 12:18:17 -0800 (PST)
From:   trix@redhat.com
To:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com,
        lijo.lazar@amd.com, darren.powell@amd.com, guchun.chen@amd.com,
        Arunpravin.PaneerSelvam@amd.com, andrey.grodzovsky@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] drm/amd/pm: return -ENOTSUPP if there is no get_dpm_ultimate_freq function
Date:   Mon, 24 Jan 2022 12:18:12 -0800
Message-Id: <20220124201812.1078824-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this represenative problem
amdgpu_smu.c:144:18: warning: The left operand of '*' is a garbage value
        return clk_freq * 100;
               ~~~~~~~~ ^

If there is no get_dpm_ultimate_freq function,
smu_get_dpm_freq_range returns success without setting the
output min,max parameters.  So return an -ENOTSUPP error.

Fixes: e5ef784b1e17 ("drm/amd/powerplay: revise calling chain on retrieving frequency range")
Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: return error instead of initializing min/max

drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5ace30434e603..264eb09ccfd51 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -116,7 +116,7 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 			   uint32_t *min,
 			   uint32_t *max)
 {
-	int ret = 0;
+	int ret = -ENOTSUPP;
 
 	if (!min && !max)
 		return -EINVAL;
-- 
2.26.3

