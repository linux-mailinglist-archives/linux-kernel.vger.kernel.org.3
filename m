Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E9F59E15B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356456AbiHWKvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 06:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356662AbiHWKmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:42:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF12AA4E6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:10:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so7359145wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=DeGX8nF0J+NtV1pTcJJ/EmsZLaXqQa78Qzzsccc5Pfw=;
        b=TkCnT5TT/j1+VD+ja7Ce6+jps9TFVDUcjUPFgi3QD5qNTd4UtGD7kx5dQMNalf8H7Z
         HcKh9q8cerh1KGRJEUIugPs3/+rnZXiJPfFPiaEBqoGYUfGZWtd3q1D/Sa1Urr7coyXn
         7ptKIPuQMAqPxfH6dNNWaFvFmOXj6SmqxlsVZv9vOBZ8nSiZVGlRxitu8k1wfbbd7Cc9
         pbcOl4PyxZxLfCxj858Zf2bO5hPE5yHul438XbuiqQ6ue+mGGVEUmEnm9PrKuo5jM1h6
         Iz193k+0UpI4TRCP29J5JEUS5yUN0LIfpJvF1kCmgaMnVNvjYQ0/GZMvsOLj1DUypnqQ
         XOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=DeGX8nF0J+NtV1pTcJJ/EmsZLaXqQa78Qzzsccc5Pfw=;
        b=U0HaDJZqqjQbXx6VZdrq3MJX5rd1fLP7PqPLSf9+HsCG6NSZ8zj9EAIH/wLJISMeJy
         osG02BXG0BM4DxQhHvHSoh9vaRgEYCTILHpXdOJ/T0LUxZTAab6GspFcSL7kCmH7mcDT
         D9O2TcJOd5kVEjRZ9fPwxEgZ9UjkRC+TzPhM9mDDnYHl2D1/nzMBvGHxR/gwbnVwNXEw
         9ObvIdZWFIYTVzrtIbD3FwcHKw3l0FOufB2wbGw+MqBn29JpKsB76STGOIn9lvVm1O4e
         bd7fmA45CnzoHR4W2FLdG02Bw4tjFPSbtrAGSP3J+GF2jyGeB8YgKVQoqbLpTV/QN/xs
         LgUg==
X-Gm-Message-State: ACgBeo3YgCOwmqVEvenN7u4lQNuJfXHYckncBxZyCfL4/IbtY2mRCisN
        IVtbTM3wIpAANhXYQIKOXyko8g==
X-Google-Smtp-Source: AA6agR6Y5XJoqHuf1SW5JDiawMpiIHPzX/sjuPfTe/y8hUpqflUeXG2hO8snD1W2tHdoOOM7kcbiLg==
X-Received: by 2002:a05:600c:3b9f:b0:3a5:45d9:8a69 with SMTP id n31-20020a05600c3b9f00b003a545d98a69mr1506230wms.186.1661245815809;
        Tue, 23 Aug 2022 02:10:15 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:4553:cf11:6cff:b293])
        by smtp.gmail.com with ESMTPSA id w6-20020adfde86000000b002253d162491sm10760721wrl.52.2022.08.23.02.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:10:15 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 02/13] coresight: Remove obsolete Trace ID unniqueness checks
Date:   Tue, 23 Aug 2022 10:09:58 +0100
Message-Id: <20220823091009.14121-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220823091009.14121-1-mike.leach@linaro.org>
References: <20220823091009.14121-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

