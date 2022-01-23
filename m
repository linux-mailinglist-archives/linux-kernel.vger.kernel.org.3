Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5833C497602
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 23:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbiAWWaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 17:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbiAWWad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 17:30:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A43C06173B;
        Sun, 23 Jan 2022 14:30:33 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so26355108wms.3;
        Sun, 23 Jan 2022 14:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=05N9uh+4Ak2VGTM8SLSYA5VF5ZUwizJAzi30P4Q0iRw=;
        b=NPt3mdSMhrv9lsWtnCpYgVJT+P4r6DvFFVhWMEF+qsCMv8p/KM3MY7GzS08yOUteuT
         LHagLw8sHXlFvgO5E7F0DAzgxBgUTrPXv4yXumLELORCfCMPHjN8lGSSHuPtwArbJ4gO
         1jTCF5oZteYXfjGjloKP2mmrwgvDAwkUgZ84SYQSMyAS1HoiT+6+FUNVUwjhz1wjAoLc
         +Lp5xCdC1CF9p6d0fn0sfbk4L00rrxkJrARp+FqqNrhtdPvhnNDq0jZS4DQfr5STlSVu
         LjaqfnKEDhI+29JSc07xts8njJhV1vUV5PirqvK/+XRuIqasz7YESbIHXaA7SxlgDQjv
         MtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=05N9uh+4Ak2VGTM8SLSYA5VF5ZUwizJAzi30P4Q0iRw=;
        b=T/ECKjksK96pHKgW40x1DSukEggG5Y0gcR1CtFSXCVz3vwtLQ47L3B6sALGnJraIKC
         5hwrTDuKbpgvqydDCrG4AVWX070+8KU9LNLFFAcnK7m9KlwFR8ZXlvw3r1mePatx25ck
         888IDsUVPSeBd+XziP45YseUZfsBkQZocAvLhoPYl6ZtcvKIPrsIO3UQ1OxLPF4zFcDe
         km2SBpu8GNZnFLzUB4oCFEXQMUMZOxe9GyknIVjir3PnDee2BlCniiKYj3WJQUBIPlWE
         +4zd6j+M7yS7Eb3T3XTFa1Ko6FWKi/4v5jLHc9Xr9UyNg7Qryiq+CBs21t22bh6e+sxp
         NJAQ==
X-Gm-Message-State: AOAM532SxBBST7bMQaNjoblZh+4vN8op2jfvUTkgxC3KdXqWX3JGsPPV
        Mo9hPympNhyMUKn7iZ6CihY=
X-Google-Smtp-Source: ABdhPJyMJ8VXx50B3SxP9I2RY6ip0w1a1Kzi1Kf73vVfrPUNQ54IUDnlElLRNFHeZuitW7cwxfi/eA==
X-Received: by 2002:a1c:7316:: with SMTP id d22mr9132678wmb.5.1642977032008;
        Sun, 23 Jan 2022 14:30:32 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n10sm14436700wrf.96.2022.01.23.14.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:30:31 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/selftests: make static read-only array page_count const
Date:   Sun, 23 Jan 2022 22:30:30 +0000
Message-Id: <20220123223030.6005-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static array page_count is read-only so it make sense to make
it const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/selftests/scatterlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/scatterlist.c b/drivers/gpu/drm/i915/selftests/scatterlist.c
index d599186d5b71..a4f2fbb451e2 100644
--- a/drivers/gpu/drm/i915/selftests/scatterlist.c
+++ b/drivers/gpu/drm/i915/selftests/scatterlist.c
@@ -195,7 +195,7 @@ static unsigned int random_page_size_pages(unsigned long n,
 					   struct rnd_state *rnd)
 {
 	/* 4K, 64K, 2M */
-	static unsigned int page_count[] = {
+	static const unsigned int page_count[] = {
 		BIT(12) >> PAGE_SHIFT,
 		BIT(16) >> PAGE_SHIFT,
 		BIT(21) >> PAGE_SHIFT,
-- 
2.33.1

