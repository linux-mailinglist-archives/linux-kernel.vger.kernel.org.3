Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120144AEEE6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiBIKGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiBIKGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:06:09 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE4DE0F7592
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:05:27 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id i6so1479252pfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1wTIjLivrgPfop/XqqzPH2ki4x3bw9zR7SXERTNkUpE=;
        b=u0bP8AcW4JKB6uFPlD/6EvDc6OH2J6/QxPLfzzO9DCbpuvMHItjEAFwH7YyYYboBw6
         n704pOV6iN12VEXGWjdJAy8jLxl2JVi8CyjVBv7b97FDS4qM44lN84ibhSIYL2xS2+Rl
         4c30rMEmepmRtjGts85Joc+ChxcZtmQLpAA22EJEktgcysoVikUTInL7Wxg/mMWkGgxe
         3qlIEGaCahMU78Rd7mFpd2odqQfmFdsBd9K3+EpiySbUVzR+7Opwp3mwluvWBngpJlwG
         xxSj1WM4DdwS2vNRi64NO5hMpHnso/HUg7cS7v9/U+eUJPjJgRE0RRvmSRGQTm3/cmTe
         npfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1wTIjLivrgPfop/XqqzPH2ki4x3bw9zR7SXERTNkUpE=;
        b=bGJRR/BJ8n5r+7OlkyloSvCiY4KvTnTOMLq2Fo0zmsXIzaM4wJC79lEdpf/JIje/Fy
         sOO3V+OAekpsHSvLzumOGWnnQLOAA6f9wqNVpD3uT+qXgMkjZRq3sHIkuamUYaCg/Zgq
         6qaHiYj9P+WbufwJW+Y9QyWaJ+W6OAd+QgC02Q2F1uyXm3gROMQjO5zwXaBS8WWMXiiY
         EVxbgsUdW5HzPn20MqsSaC+YP8A37e+IY1W7l3xUZnmMF3yVtrpdp5ju6ymzy3x6Gl4U
         OIK/jm34BjIEFZ4fGSX/rN+TlicdYo/jeqrjVJiaQg+bnqQg1mEhRALQtcgMXyVZCN9j
         ODQw==
X-Gm-Message-State: AOAM531GWIa4uvA8j6hKQNHx2PL1Pt+cR1XUIP6KIadKE5VO6dqgwytM
        9MQgfmskyksRpV95gzE+Z4Zc
X-Google-Smtp-Source: ABdhPJwimw0vUk+r3YV1nDhN9CvOyCMAaHzUFNankW6HvnxTLCRTmuCcdkUNnGtmQeAXMU19hUmhPA==
X-Received: by 2002:a63:d14c:: with SMTP id c12mr1292263pgj.300.1644401113548;
        Wed, 09 Feb 2022 02:05:13 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.178])
        by smtp.gmail.com with ESMTPSA id p2sm6722024pfo.125.2022.02.09.02.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:05:13 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        vbadigan@codeaurora.org, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Paul Davey <paul.davey@alliedtelesis.co.nz>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>, stable@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 01/23] bus: mhi: Fix pm_state conversion to string
Date:   Wed,  9 Feb 2022 15:26:02 +0530
Message-Id: <20220209095624.26389-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
References: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
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

From: Paul Davey <paul.davey@alliedtelesis.co.nz>

On big endian architectures the mhi debugfs files which report pm state
give "Invalid State" for all states.  This is caused by using
find_last_bit which takes an unsigned long* while the state is passed in
as an enum mhi_pm_state which will be of int size.

Fix by using __fls to pass the value of state instead of find_last_bit.

Fixes: a6e2e3522f29 ("bus: mhi: core: Add support for PM state transitions")
Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Cc: stable@vger.kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 046f407dc5d6..0d588b60929e 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -79,10 +79,12 @@ static const char * const mhi_pm_state_str[] = {
 
 const char *to_mhi_pm_state_str(enum mhi_pm_state state)
 {
-	unsigned long pm_state = state;
-	int index = find_last_bit(&pm_state, 32);
+	int index;
 
-	if (index >= ARRAY_SIZE(mhi_pm_state_str))
+	if (state)
+		index = __fls(state);
+
+	if (!state || index >= ARRAY_SIZE(mhi_pm_state_str))
 		return "Invalid State";
 
 	return mhi_pm_state_str[index];
@@ -789,7 +791,6 @@ static int parse_ch_cfg(struct mhi_controller *mhi_cntrl,
 		mhi_chan->offload_ch = ch_cfg->offload_channel;
 		mhi_chan->db_cfg.reset_req = ch_cfg->doorbell_mode_switch;
 		mhi_chan->pre_alloc = ch_cfg->auto_queue;
-		mhi_chan->wake_capable = ch_cfg->wake_capable;
 
 		/*
 		 * If MHI host allocates buffers, then the channel direction
-- 
2.25.1

