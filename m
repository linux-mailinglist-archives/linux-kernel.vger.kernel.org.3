Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F256B487FC2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiAGXyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiAGXxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:53:43 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE7DC06175C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:53:40 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id v11so6537170pfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BwZYnZ40KbeJ7AlpMWe+FaFD9GCv+xkqOCr7TXF+b3A=;
        b=cq+rL39e2SuXbNV4R/NBEY/tbIQC2k7A03THZsAhtXI3Wkr8/JpilReV4Fghu8TgMh
         1CPQXkneJkFGvUaCOvkxRZDzc9HZiFk6Z/hla3uQPk99FB914B4StlrYZfVj5SfSKuPS
         OYB+Ql1tjc1P7xattSY46D3sLwnAwQA49pMeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BwZYnZ40KbeJ7AlpMWe+FaFD9GCv+xkqOCr7TXF+b3A=;
        b=J4ejLtW05MNBVeXIxjlRuZeGlgCz95abmjRqO1COu3Dcl9D+0PutDDZz+ocoflhYV+
         ikvb4Stw3l5MyfUvqoJ+JjjWRxb9lQxKKBfUKSLsMXUkQ3u9oHqtehyG3ZSib/ZQHSZh
         /nYcBep2X1l5z6O/+cDj7XrZiboX70YfWuemInR/HCrBI90mQFdwxefe/W/0EgS6+9mW
         8dVkjIbHI9SD1xTUnn0k3A6uR5hhdLL6dArvOH7obO3MSTFJDXlBF/V4FCDSTlhdzKbs
         N7M6V9Qju6GFANG5NOgU5SlpenURvuoLt6UzYiVeKVI/8OzTFfaSYjALlK5R8rEgapLS
         Emlg==
X-Gm-Message-State: AOAM531R08q6KQPZG+k79gD8w5Ut7xHlTpUeTUGD6YszWTmpI28gCKRa
        K+pCZWfwh6qpqKmEnTN2jky7nw==
X-Google-Smtp-Source: ABdhPJwXb0FrFN8WR31ai2WKeI7DfmoehFLv8X/wr7YuQYumhseqi7xnA6sbbMiM/sFeYOdpRZa9iA==
X-Received: by 2002:a63:914c:: with SMTP id l73mr3103999pge.471.1641599620106;
        Fri, 07 Jan 2022 15:53:40 -0800 (PST)
Received: from localhost ([2620:15c:202:201:db:1c60:693f:c24e])
        by smtp.gmail.com with UTF8SMTPSA id p16sm55372pfh.88.2022.01.07.15.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 15:53:39 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 05/10] PM / devfreq: rk3399_dmc: Drop undocumented ondemand DT props
Date:   Fri,  7 Jan 2022 15:53:15 -0800
Message-Id: <20220107155215.5.I4bd77eb751d5bfce8346bfed576bcacb28e4550f@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220107235320.965497-1-briannorris@chromium.org>
References: <20220107235320.965497-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These properties are:

* undocumented
* directly representing software properties, not hardware properties
* unused (no in-tree users, yet; this IP block has so far only been used
  in downstream kernels)

Let's just stick the values that downstream users have been using
directly in the driver and call it a day.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/devfreq/rk3399_dmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 293857ebfd75..e982862f6ac2 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -430,10 +430,8 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 		goto err_edev;
 	}
 
-	of_property_read_u32(np, "upthreshold",
-			     &data->ondemand_data.upthreshold);
-	of_property_read_u32(np, "downdifferential",
-			     &data->ondemand_data.downdifferential);
+	data->ondemand_data.upthreshold = 25;
+	data->ondemand_data.downdifferential = 15;
 
 	data->rate = clk_get_rate(data->dmc_clk);
 
-- 
2.34.1.575.g55b058a8bb-goog

