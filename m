Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD14BE313
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358704AbiBUNLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:11:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358689AbiBUNL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:11:29 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132BB1EC65
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:49 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k41so9504366wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LfKStxRvgTEmdqhNQGyq07ydIW9Hyz4sxw/jfz5hVYw=;
        b=xT89kU+5gglDuZfx6otMltL5s7sd25gDnq0q4fQB0XM+AhvrbYxRIJ5l7pBHySmK/k
         XO6zRM7SVmSs3EEvbmC+Tg7r5/CRu8k0Vrk+9McU4UPvtv2Z5MsIkW/+FjrXgZnqQZEZ
         K9cx/g/gTSYk6G0eO3UwnMWCFqOL7VWBHJXIK3vaIPejk0En/mPfx4VCAeFmkrtl38ZT
         lcd3l8QoSrdWhRyaQpxhPhdh9JECU1aFGtuSjKOo13cdGlqRiJqgpjC3nNLK6uHsTWC7
         tFi5qctN54EPThIa1wmKm4/RJEvUgrrv6nJBjfxIn+RJVJsWg02qe1t0QcGOipsKgfdh
         GLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LfKStxRvgTEmdqhNQGyq07ydIW9Hyz4sxw/jfz5hVYw=;
        b=pr9IpfLFjMpxgywPNiMOpIuHJRX/Fx1OLGLEkUbBToVHfC7GkdpWsR0pOeJa+6ZgT8
         QFA9ILPqJ9b3MDjI2sW7dsKOr5bDGzcTAtAHH5kmaIoTnr/N4jVPCNhyCe/Bm9Iwtnsq
         xIZSI5E1qgqkUHDP6kVEHCNTVqA1xpUNeU9lfHq3nqA2Q2KxAMRfa7xqeyqxNnFB43dx
         qeDpqDjsyQtpDt7tpPjTI+liRRHXNK0PQMS0C9HA/Txy6UdjEgvFEfQJUr7XI/n0PFON
         KxOQJB+AEJVmkG71oReSzMb8wh5jJeNxMA9tnYXFfO3tsVVhUSkmZKIysrL4RjBlQth3
         kwuA==
X-Gm-Message-State: AOAM533VI6S7m7+eoigLx2DslRvcHP9mFg3zGs9pljda7HnuLIQg1Rwt
        j9I6+jxqlA3Zi9cR6TxPcelZ1Q==
X-Google-Smtp-Source: ABdhPJyEohRKma9akNiOWsxMFqCf8yJ7AknxrWOekQ8wSnBWxATqwZPl0jD7d3d/0zk+IUHr41hoaw==
X-Received: by 2002:a05:600c:3b85:b0:37b:baf8:f542 with SMTP id n5-20020a05600c3b8500b0037bbaf8f542mr17847152wms.26.1645449047634;
        Mon, 21 Feb 2022 05:10:47 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 3sm49412801wrz.86.2022.02.21.05.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:10:47 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/10] ASoC: codecs: wcd938x: add simple clk stop support
Date:   Mon, 21 Feb 2022 13:10:33 +0000
Message-Id: <20220221131037.8809-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
References: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
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

mark WCD938x as clock stop capable.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x-sdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 1fa05ec7459a..1bf3c06a2b62 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -249,6 +249,7 @@ static int wcd9380_probe(struct sdw_slave *pdev,
 					SDW_SCP_INT1_BUS_CLASH |
 					SDW_SCP_INT1_PARITY;
 	pdev->prop.lane_control_support = true;
+	pdev->prop.simple_clk_stop_capable = true;
 	if (wcd->is_tx) {
 		pdev->prop.source_ports = GENMASK(WCD938X_MAX_SWR_PORTS, 0);
 		pdev->prop.src_dpn_prop = wcd938x_dpn_prop;
-- 
2.21.0

