Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3FD53E80E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiFFLLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiFFLL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:11:26 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C94244083;
        Mon,  6 Jun 2022 04:11:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bg6so8401022ejb.0;
        Mon, 06 Jun 2022 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wyraSSKv1jqCeF4xZjEyVevZ1Z/RuxxufoUeosKgARw=;
        b=gN2URvSCIFgOIj8O3vyW2x9dmdcrp82nsm2WX4njUmTu4bFORwLbtjqUQU8x+fck5/
         31gwKtNU1a5H0bfMTIivsnB9OXhzYk5EFXLCBwXkiRXrSbgnKmm4uU0ksGSdorb/uItg
         cI6YEtfM4yPiT6eTKdgoyGsTLl170sxvzDWLmh6cx0z36k2HbVHYxheHP5TIz+cfmSH9
         3GKjqWrI9/E3ugmjKVoi71jaAhSgliWOgm05f6O92ffQdfi7ijFV4vuCRUO5L24DqyTe
         IhDO3WgvpydxwqnyOTkm97JegQ+YK+I7n6FLrjsitlNvRFwUmsI41cajou11G3b7JHMD
         qREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wyraSSKv1jqCeF4xZjEyVevZ1Z/RuxxufoUeosKgARw=;
        b=HDdipATkH5dKT7IQyrj+IbvkXVCh3N0Srmqyec2TdKVLpdr7SrGLr6hrzX95/NxKeb
         IXt4xUz8AYJZwGXKRJI9XxNYYtj9+lBWKBYhB6GVEmV03zOJ789v6w5cqDYUnG8hzQCv
         AdTHu2aOaQL6TGYmKSpjUibgcb3FUMZQwxWDjZUsidar4gBdUd26YcSnSAsMa+bI/SC9
         iG3saA2nj13CLxnsJzOWh3feLNGRdpy+uGQz0vvjVYoUjSZZKyKM82UaQdX0cPBxJUOs
         YwxgiwJEEaApxxkiCPg/FcyH+XQHFQau3MGqsXRtqgo4kHert0jnWMadf+mf50gtIZGA
         uLjw==
X-Gm-Message-State: AOAM5333HNF3ag9k9ZlTgNRKlFNAd58XeROzoo6dBsquUoTFa2Ge9RCD
        ndUiubPWQgPHTzILV3HdQV8=
X-Google-Smtp-Source: ABdhPJz4/Ip6V9rfJ2HWlXYYsLe8Tc814tna4P3sefyGkr2iRltgw/iiLOx10uODvBsYar3ZdSoWUw==
X-Received: by 2002:a17:907:7f20:b0:6fe:f0c8:8e6f with SMTP id qf32-20020a1709077f2000b006fef0c88e6fmr20586608ejc.453.1654513882936;
        Mon, 06 Jun 2022 04:11:22 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id z14-20020a170906074e00b006fecf62536asm3843506ejb.188.2022.06.06.04.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 04:11:22 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 5/5] PM / devfreq: Mute warning on governor PROBE_DEFER
Date:   Mon,  6 Jun 2022 13:11:04 +0200
Message-Id: <20220606111104.14534-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220606111104.14534-1-ansuelsmth@gmail.com>
References: <20220606111104.14534-1-ansuelsmth@gmail.com>
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

