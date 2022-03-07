Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD004D0A6A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbiCGWBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiCGWBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:01:08 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792DC12AD4;
        Mon,  7 Mar 2022 14:00:10 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u10so23861775wra.9;
        Mon, 07 Mar 2022 14:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VrXaIwOZOVtIvy4hHy4AW36uJVE3txcBuUPvIgUQUTk=;
        b=XHgWXNwqYyjxnOvdpUvHpl/knt8ZquuiELDtEkVC3I6XKXdmxibh9o7cveOY8e3wIU
         4fRJhN/LdOpLZhOo0s3YPKnnbKQ65vUu+GxYY39iN5iNKVLm4dh8DL812cdKdLFIs6aR
         3VWNN0sxgmGH/zRZVi0F8adSG7gYSL4KQoAKZIlxWF+yQehb6FLp9JFrDiTEZXA6UAKz
         3JmY38syMUAr5b5rkhgU6hHoS2w4LEpybbBqWh3WFoJaUmaHMdbqjSaNN+3o8k5S/LO7
         6dGGt4W2vCcrgixU4UiPuilZq+eDs6OMGritSRXSUzldpXMrDkj10Y8/hMbq0DCB9xeD
         NAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VrXaIwOZOVtIvy4hHy4AW36uJVE3txcBuUPvIgUQUTk=;
        b=2fXohMbYEJCZednB0B3wrcnfVzyrD6iTZfKqTjuLRmrUyPGMoTRb2oG9kw0J+8hKd7
         /oDAQZGfLA5H/P6Bt3qe1icqXyizuAsTcNfeu8E869cJRnzDp0gAsgsPNbZnRZDmgrXm
         FwzvX2sr1cdax17lxd3cMpC/5Sq6yYWnvg/Z/CY07p4n2dI7AZMbF/k+Y/+53wU6J07S
         34LtDVH1b8LvSoWPqSOymucpdr7cqjNPZFVAeRB4xVq0s/RhMi7HPNEQ3hxwXKtogSwN
         vlv1ePeE4otSexEagKwar+iwXUP64yEyui8p6P2UFTQTkm3oDcIOsKyK433ZuF1WZCgb
         6PVg==
X-Gm-Message-State: AOAM533NiNUqPhEvoqVJSH39LVot/pN0bGW/X8Q/8py1r2aNuYI/1Lpu
        17t3aBP2VrrtBrsLXFq5ukE=
X-Google-Smtp-Source: ABdhPJyMRU1RrSDT5zpdVvAkOryRnx+5bU3JVk9GMtpjgNuO6wW51EbQcPQMSpkWh/twLP9jlWsFmA==
X-Received: by 2002:adf:8063:0:b0:1ef:78e3:330 with SMTP id 90-20020adf8063000000b001ef78e30330mr9940151wrk.424.1646690408993;
        Mon, 07 Mar 2022 14:00:08 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d62cc000000b001f048bc25dfsm12124754wrv.67.2022.03.07.14.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:00:08 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/dpll: make read-only array div1_vals static const
Date:   Mon,  7 Mar 2022 22:00:07 +0000
Message-Id: <20220307220007.162830-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array div1_vals on the stack but
instead make it static const. Also makes the object code a little
smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
index 569903d47aea..17668b58b30c 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
@@ -2759,7 +2759,7 @@ static bool icl_mg_pll_find_divisors(int clock_khz, bool is_dp, bool use_ssc,
 				     bool is_dkl)
 {
 	u32 dco_min_freq, dco_max_freq;
-	int div1_vals[] = {7, 5, 3, 2};
+	static const int div1_vals[] = {7, 5, 3, 2};
 	unsigned int i;
 	int div2;
 
-- 
2.35.1

