Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD573549B08
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244776AbiFMSDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244051AbiFMSCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:02:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9C2D89;
        Mon, 13 Jun 2022 06:45:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z9so2995744wmf.3;
        Mon, 13 Jun 2022 06:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wyraSSKv1jqCeF4xZjEyVevZ1Z/RuxxufoUeosKgARw=;
        b=J87NyDPNSiU1rQKYzpcOjhK4eIXKQc6HaI8Zo+0rj+kofa3hwUYB15zd0OVwwl0zLI
         NKXBDCSmRlGZ8V2x2/6co0IlmdEA+FaDXzwMTT5Od52UJd/NBeafBVra/pGTwjy5LStU
         mw1wiQhrTfSnrEHCrALkAL72ws9o3SLhX4mt5aX/eR/pnNGm38oQ31x8+FhkFy0n4VBl
         VOAyOixqd8lbFTI0BDgZ+tSltUMYf09AABWK47q5LKYa2FuVhYplKEazj3Q4Kclai727
         XIFdig5c2iRtn7PgyUIbsZNFi6Rkop/4ZFMpeJylc6X8hQzmzUbeRPaDiBR/hHe2lf3h
         TAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wyraSSKv1jqCeF4xZjEyVevZ1Z/RuxxufoUeosKgARw=;
        b=w0OlXg0pZyTFko1ZdN4M/r+iKbv+Cqltrykwff30YTl1UavXFUeKUGkbLmSB9nDyV2
         sjMGpeJnTBziUnRcY/cNENwIUk2XjP+uV7yqpHkzXmQ8WtxfqOMrHiq5mmKiSrhjLoIg
         Y8UNo9NDeSgtKG8w0i7QsCBj+wyadw/wOJh16tOvRInxsRsxzXY9XWuwgH9IfthGuEUy
         Mh7CAg8Eiq9NX4ds6ZRoK7sVy2THWncLKm9s5FjvoMBe19HQkoNbiAlqSTE/VecfnOMj
         kh9xYmRXM0Oq9xNjlwIRtgotQ32Bg5MOegZQ7PbREqcczWnyFzKVgc2A7fSPwT95PjTj
         ddpA==
X-Gm-Message-State: AOAM533x0KMm5VLB5N/kICoPApdxC4xedSsCGTQ/ykTAQpSkGu2pQcKT
        u7c6tLSbtCr/si3t/37lZjc=
X-Google-Smtp-Source: ABdhPJx7Jm4v2NF4tcGT0yyIRXFuX+doT8y0QitWBmRUlV/6XJPlqijbB2tYMkQHcKA9eg2MQxBaGw==
X-Received: by 2002:a05:600c:35d2:b0:39c:8490:abbf with SMTP id r18-20020a05600c35d200b0039c8490abbfmr13106105wmq.86.1655127915690;
        Mon, 13 Jun 2022 06:45:15 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id i1-20020a5d5221000000b002103aebe8absm8647510wra.93.2022.06.13.06.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:45:15 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 5/5] PM / devfreq: Mute warning on governor PROBE_DEFER
Date:   Mon, 13 Jun 2022 15:42:13 +0200
Message-Id: <20220613134213.8904-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613134213.8904-1-ansuelsmth@gmail.com>
References: <20220613134213.8904-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
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

Don't print warning when a governor PROBE_DEFER as it's not a real
GOV_START fail.

Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
---
 drivers/devfreq/devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2e2b3b414d67..df6972bb0ce8 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -931,8 +931,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
 						NULL);
 	if (err) {
-		dev_err(dev, "%s: Unable to start governor for the device\n",
-			__func__);
+		dev_err_probe(dev, -EPROBE_DEFER, "%s: Unable to start governor for the device\n",
+			      __func__);
 		goto err_init;
 	}
 	create_sysfs_files(devfreq, devfreq->governor);
-- 
2.36.1

