Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A255818A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbiGZRjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbiGZRjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:39:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CED32060
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:38:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y15so13958019plp.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QqvKH6fccVd80baHbnBCY4qodjMiSVmgD5LIGbvU2Z4=;
        b=B9/WWbhVyNMDG3jI569+7uLqSi0JK9ZiTjxEDD6Fo922/IUX3+iu02/YtEOj+vzgOM
         WPWEaxVHZ3tk9Ev34/jgvIPK5FRcg3gIqUTJFrjnJ5YMPWW3eshhvBUXlEwD+crvzMgt
         8sLLH3atcRYwER1T8/1snBYPojt8tfmuvOdVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QqvKH6fccVd80baHbnBCY4qodjMiSVmgD5LIGbvU2Z4=;
        b=bWxkjcoUB2Dai6Ai0FCbmW1kgmCWFwNLaRDZXWVYw3r0kyoLsnKMxBw44OygsyK+6g
         2/QusbiZzaIMUvSZ6YURC8ybG4r6+WeCqNXYua4hTXncje+O0qmeYJ6Mg7prrXeE89xK
         vnsfYqPICQbWPsg3jlqfQihBy5xb3roTxmn3xHGEW/JhmEiXOIe36XZ0kBrbZoweymZO
         x1cxQxPbOOWXVuPGHz8C5i31xUEmcYMt9wV0K00GoXbDzcjDn3sHxLyN+GRMsA2F17UO
         tuL2liCiq096n93IXa1bmIy+3qi/l0Ssd0Ze77P3ZBb0FMKFlhnd2jhdqYBgo0BleBgN
         ZfBg==
X-Gm-Message-State: AJIora/ZIV4+++TBmNgf979JFFAM4QzI/0jG2k8v3eGuHfZuyQdmEYFP
        MqfDE3sgqSu6DlaFToAr5IONMw==
X-Google-Smtp-Source: AGRyM1trr98gdklxubSGKVrsW/w7EKhRKIGIQlo+z7UMmwbo6HElyMi5CU7nlM/Xnx3B4vQl7fSzrQ==
X-Received: by 2002:a17:902:e841:b0:16c:3053:c7e6 with SMTP id t1-20020a170902e84100b0016c3053c7e6mr17679425plg.163.1658857128631;
        Tue, 26 Jul 2022 10:38:48 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:8693:e9aa:75c0:5134])
        by smtp.gmail.com with ESMTPSA id ik29-20020a170902ab1d00b0016d9ecd71f4sm245884plb.77.2022.07.26.10.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:38:47 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] regulator: core: Allow specifying an initial load w/ the bulk API
Date:   Tue, 26 Jul 2022 10:38:21 -0700
Message-Id: <20220726103631.v2.4.Ie85f68215ada39f502a96dcb8a1f3ad977e3f68a@changeid>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
In-Reply-To: <20220726173824.1166873-1-dianders@chromium.org>
References: <20220726173824.1166873-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of drivers that follow a pattern that looks like
this:
1. Use the regulator bulk API to get a bunch of regulators.
2. Set the load on each of the regulators to use whenever the
   regulators are enabled.

Let's make this easier by just allowing the drivers to pass the load
in.

As part of this change we need to move the error printing in
regulator_bulk_get() around; let's switch to the new dev_err_probe()
to simplify it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("Allow specifying an initial load w/ the bulk API") new for v2.

 drivers/regulator/core.c           | 20 ++++++++++++--------
 include/linux/regulator/consumer.h | 12 ++++++++----
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1e54a833f2cf..17c476fc8adb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4783,22 +4783,26 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
 		consumers[i].consumer = regulator_get(dev,
 						      consumers[i].supply);
 		if (IS_ERR(consumers[i].consumer)) {
-			ret = PTR_ERR(consumers[i].consumer);
 			consumers[i].consumer = NULL;
+			ret = dev_err_probe(dev, PTR_ERR(consumers[i].consumer),
+					    "Failed to get supply '%s'",
+					    consumers[i].supply);
 			goto err;
 		}
+
+		if (consumers[i].init_load_uA > 0) {
+			ret = regulator_set_load(consumers[i].consumer,
+						 consumers[i].init_load_uA);
+			if (ret) {
+				i++;
+				goto err;
+			}
+		}
 	}
 
 	return 0;
 
 err:
-	if (ret != -EPROBE_DEFER)
-		dev_err(dev, "Failed to get supply '%s': %pe\n",
-			consumers[i].supply, ERR_PTR(ret));
-	else
-		dev_dbg(dev, "Failed to get supply '%s', deferring\n",
-			consumers[i].supply);
-
 	while (--i >= 0)
 		regulator_put(consumers[i].consumer);
 
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index bbf6590a6dec..5779f4466e62 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -171,10 +171,13 @@ struct regulator;
 /**
  * struct regulator_bulk_data - Data used for bulk regulator operations.
  *
- * @supply:   The name of the supply.  Initialised by the user before
- *            using the bulk regulator APIs.
- * @consumer: The regulator consumer for the supply.  This will be managed
- *            by the bulk API.
+ * @supply:       The name of the supply.  Initialised by the user before
+ *                using the bulk regulator APIs.
+ * @init_load_uA: After getting the regulator, regulator_set_load() will be
+ *                called with this load.  Initialised by the user before
+ *                using the bulk regulator APIs.
+ * @consumer:     The regulator consumer for the supply.  This will be managed
+ *                by the bulk API.
  *
  * The regulator APIs provide a series of regulator_bulk_() API calls as
  * a convenience to consumers which require multiple supplies.  This
@@ -182,6 +185,7 @@ struct regulator;
  */
 struct regulator_bulk_data {
 	const char *supply;
+	int init_load_uA;
 	struct regulator *consumer;
 
 	/* private: Internal use */
-- 
2.37.1.359.gd136c6c3e2-goog

