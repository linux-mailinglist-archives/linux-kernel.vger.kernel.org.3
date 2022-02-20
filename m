Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888364BCBC8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 03:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243397AbiBTCrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 21:47:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243375AbiBTCrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 21:47:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB25117A9C;
        Sat, 19 Feb 2022 18:46:47 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso15804772pjg.0;
        Sat, 19 Feb 2022 18:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o7fOFIds8w0t8thTccyYNHJARMbew1IEIkz/ilir+/0=;
        b=qHmD1f1bdUc569/X51lzKH9xvNBKHlOXIDV1PpGKK0zfNyqj8ZOX36ym1in6X/RDM8
         rJX59I94MO2VpQzwWTZcbDhX6Wah3KpsxHsy/NDn+UymNbsmeAWQJwHu3NgIXzccyd+X
         uawi88S7aUJeA1AkzrygWjCPbpC/3X4mFGqpZzhVZ38zHf9JMqCp+PfuIbAq3IuE8ynV
         LFYqdaJai8OsYDQ1skSKoi1+ZAPb4NJTsYh+PCe7rwLDQTekSdsumHP7lt2zbEIjVe6X
         th3cfzLn8jx0UifrmHiBoPYTExUtakj6M1WVFVHq8GOfRoxxSTwSsxAUC0IpW0wI7Ndw
         NWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o7fOFIds8w0t8thTccyYNHJARMbew1IEIkz/ilir+/0=;
        b=SmUUfsWCBtez+dpQbQ3vaIAsZe3/JTwumoTN4O0c1GLgXfuH8RWmGeU4YXXGxf4HNk
         O00wJ3UGmtPSEl67yY0WIz8/8fOOifO0LT9jSAq3wF+rufzgG/oW9fm8DYvZXNAQ4Li3
         wItSYZ/qc1MAh8k8txuVDUtgLxiy5FZX1FruL2pEnyf67GDYTGEnO5Rhh9jPZrMLKcVk
         qUleVF/ZRN0Wxd9SBtiVe+/4VEOY26tmnES0WJkJlglS4HiZtB6uY25addxIN/gRjN24
         ctYbwgO6FkKesd//Vd7tsd2SABfjq0IGRaP2fatXW2doBtq8F9RO945XG/nJ3F0cHs9u
         ptOQ==
X-Gm-Message-State: AOAM532KhEpHUO4YPMPByT5H/cjLFF2UCd1IcpCspjXM0WkM+gA2ZSxV
        ++mQZTMc5GF08fVpRC2boQY=
X-Google-Smtp-Source: ABdhPJzNJbVBw2uLPAxyJXF3ydfgtqGbefOOWuQlEH2EAhgPLHkhmqqy9eBhT6MPJ5MksxVcS+Hn+g==
X-Received: by 2002:a17:902:d4c9:b0:14f:929c:f3c9 with SMTP id o9-20020a170902d4c900b0014f929cf3c9mr4170623plg.45.1645325207348;
        Sat, 19 Feb 2022 18:46:47 -0800 (PST)
Received: from localhost.localdomain ([116.73.72.178])
        by smtp.gmail.com with ESMTPSA id lw16sm3488761pjb.51.2022.02.19.18.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 18:46:47 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] iio: potentiometer: Change to firmware provided data
Date:   Sun, 20 Feb 2022 08:16:29 +0530
Message-Id: <20220220024632.4183-5-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220220024632.4183-1-jagathjog1996@gmail.com>
References: <20220220024632.4183-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using firmware provided data to get the device specific
structure if not available fall back to id->driver_data.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/potentiometer/ds1803.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index cf822e21284e..3b86a4106277 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -154,7 +154,9 @@ static int ds1803_probe(struct i2c_client *client, const struct i2c_device_id *i
 
 	data = iio_priv(indio_dev);
 	data->client = client;
-	data->cfg = &ds1803_cfg[id->driver_data];
+	data->cfg = device_get_match_data(dev);
+	if (!data->cfg)
+		data->cfg = &ds1803_cfg[id->driver_data];
 
 	indio_dev->info = &ds1803_info;
 	indio_dev->channels = data->cfg->channels;
-- 
2.17.1

