Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B90358E33F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiHIWeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiHIWeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:34:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3FD6564F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:34:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z16so15753981wrh.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DeGX8nF0J+NtV1pTcJJ/EmsZLaXqQa78Qzzsccc5Pfw=;
        b=H0HlXUkQpJdgEYtpWV+ElfAYT1ZXsr67OzrljzDFFkh7XjjzdFcdZVXOoZO5FSj5P5
         XSrufCh4fp6w92iH+t48NsG4qRZQgc+duWUXXlYKeKaG6z4WB1w7aVMFgYb/sIXayTmD
         7eciqpczvMuWJPr5P/v2GVzCwnEWQSAiT6XknQ42YqThpS3X0/T8Oi8+4ant1QxwnXYO
         HcGiSvJKtPsKT04+O3m/GFuwzjL159B79YAE8dni5VrjXG47loS3OP6oWtRfBIJeCESt
         nUvkJRDkPOTsv4KHAObGI5BzaqwDJv57x7n13dAypXwO2agsJMUS2zhLSEYEey7MoPIF
         BScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DeGX8nF0J+NtV1pTcJJ/EmsZLaXqQa78Qzzsccc5Pfw=;
        b=nCQ+guzlct/DUZgnyGeyB9B/AJBQLKCoRJIq9FQxt/x24d7X8a+ewihdkH+t06Bhc3
         GDk+/hn3DDOwLI3Uy6BoO5KcCpJ92i769q0WV7MpwicG9j8OL2p2yOG++y/FCPZteQ6m
         JOEOK96b+H6XPDLL4GcsTXff6xGivlFM2cgd/O8qO6kqclpK2ysMRhUroRVr1D6Frcb0
         VyJH4kkOhX30+kWOxvvFzQZhWSPqa51Lm909VHNFZxWzn62ysIAfIohJP7mknkqW8Lha
         Bznsg/zvVZ+exYC5yBpELHLB1uzeIm0gFWPNqWzCjFI1l4Xvx3zNg1pWMnblqwkK3fRy
         gZ1g==
X-Gm-Message-State: ACgBeo1bPOsPk2CfmZcOwQvufUFMi5MlB0K9KODz/Ha1+FYmrODpOApM
        va+TJW0NHsJ023dUJk9MPYO76A==
X-Google-Smtp-Source: AA6agR7B4EKPKod5fL4m/2YtVvmqVRZa4owY4+pLORhXmW9cJEfbHZxi6mLHNZ/imEtuPsUJXBYKEQ==
X-Received: by 2002:a5d:6d46:0:b0:21f:8b7:4c1d with SMTP id k6-20020a5d6d46000000b0021f08b74c1dmr15567158wri.455.1660084448295;
        Tue, 09 Aug 2022 15:34:08 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a6:74a6:5a0e:f3e2])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c4b9400b003a2cf1ba9e2sm311650wmp.6.2022.08.09.15.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:34:07 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v3 02/13] coresight: Remove obsolete Trace ID unniqueness checks
Date:   Tue,  9 Aug 2022 23:33:50 +0100
Message-Id: <20220809223401.24599-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220809223401.24599-1-mike.leach@linaro.org>
References: <20220809223401.24599-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checks for sources to have unique IDs has been removed - this is now
guaranteed by the ID allocation mechanisms, and inappropriate where
multiple ID maps are in use in larger systems

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 45 --------------------
 1 file changed, 45 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index c7b7c518a0a3..cde1b4704727 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -85,45 +85,6 @@ struct coresight_device *coresight_get_percpu_sink(int cpu)
 }
 EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
 
-static int coresight_id_match(struct device *dev, void *data)
-{
-	int trace_id, i_trace_id;
-	struct coresight_device *csdev, *i_csdev;
-
-	csdev = data;
-	i_csdev = to_coresight_device(dev);
-
-	/*
-	 * No need to care about oneself and components that are not
-	 * sources or not enabled
-	 */
-	if (i_csdev == csdev || !i_csdev->enable ||
-	    i_csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
-		return 0;
-
-	/* Get the source ID for both components */
-	trace_id = source_ops(csdev)->trace_id(csdev);
-	i_trace_id = source_ops(i_csdev)->trace_id(i_csdev);
-
-	/* All you need is one */
-	if (trace_id == i_trace_id)
-		return 1;
-
-	return 0;
-}
-
-static int coresight_source_is_unique(struct coresight_device *csdev)
-{
-	int trace_id = source_ops(csdev)->trace_id(csdev);
-
-	/* this shouldn't happen */
-	if (trace_id < 0)
-		return 0;
-
-	return !bus_for_each_dev(&coresight_bustype, NULL,
-				 csdev, coresight_id_match);
-}
-
 static int coresight_find_link_inport(struct coresight_device *csdev,
 				      struct coresight_device *parent)
 {
@@ -432,12 +393,6 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
 {
 	int ret;
 
-	if (!coresight_source_is_unique(csdev)) {
-		dev_warn(&csdev->dev, "traceID %d not unique\n",
-			 source_ops(csdev)->trace_id(csdev));
-		return -EINVAL;
-	}
-
 	if (!csdev->enable) {
 		if (source_ops(csdev)->enable) {
 			ret = coresight_control_assoc_ectdev(csdev, true);
-- 
2.17.1

