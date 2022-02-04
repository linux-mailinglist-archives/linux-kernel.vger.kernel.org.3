Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338EC4AA074
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiBDTvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbiBDTu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:50:58 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EA7C061744
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:50:51 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id d188so8699112iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 11:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJSgbV82nLgKXKYaIVZ+XNSiEnkL4FwHctPzlM9hZrc=;
        b=TBH0vug6qzMDfkTjUwcRV6xDfQ0Mqum9N0MGVz/HzcJVHbrTjpQB8+okfUwRP8tf2B
         Yam7tHCuthYq3FceCn2e68E4b10FScquG59FmK+tqTmndIihxhzLypYKk63v6IlstG0p
         L8PtWtqI76mAS8srcF28bsa4wfSzf7Cu7Y/Epqt/9RZ/KXXLu3LbF3+eHThJDvAMJAKx
         FwNVv7vg28Gl9LVA+gfJNUx0yj/baf7Obi28RdEDW9kFakpTnhAXdiv0oYQfx1z9XXvS
         qD/IUGjQ7gBoJpkgJV5M0GMPp5vYsczEzUhTWn6aUWh5SO/6w/SkLzxgnBycBs6UsbA9
         TCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJSgbV82nLgKXKYaIVZ+XNSiEnkL4FwHctPzlM9hZrc=;
        b=oJijvTFlbNfGEmITU737QgZQYrQU3sk/w2wTmD1qeY1DaY0iJTJc0zoGcMkzo3liFB
         uX7bSDX1/qx7uEvBb94MV07vLFgoIf/yI9nc4lRbgnuZCqUgwPSUda4I3l6oD/d7e+hl
         qCdFAMNuxB4PbmBihFLEPwc3E6BbpU9apWT4b9lP9AIJOrme986B2Uo2VHb/6nXstfT0
         OlezImI/ZSmhxFKVSVkCIyLULkxK4e2MoPT6PJFs3oT9RnApi381r+I66Jw6MTI15doI
         vDNqRsxb8BUTB9TR/EJr/W00LOwB0fpmJhzsWvEytYS4U5BxPYQlmNFpg0qyF8i1KWF4
         0mZQ==
X-Gm-Message-State: AOAM530d9mSRYdeNIcBKUGFalZWq2GAfLaDp21HdzIXQeBUwlNnlYyTp
        sS8aKh1M6pREyPJXKU8NQAmhcA==
X-Google-Smtp-Source: ABdhPJwpBNCFvez/OLynGuHBQ2f9mdL2Z1qTx8ZzJBTX4+77xoY9IEAMS2FBbT407BP/f+st7brCwA==
X-Received: by 2002:a05:6638:10c5:: with SMTP id q5mr335290jad.113.1644004250388;
        Fri, 04 Feb 2022 11:50:50 -0800 (PST)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id k13sm1417564ili.22.2022.02.04.11.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 11:50:49 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     djakov@kernel.org, bjorn.andersson@linaro.org, mka@chromium.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        avuyyuru@codeaurora.org, jponduru@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/7] net: ipa: kill struct ipa_interconnect
Date:   Fri,  4 Feb 2022 13:50:38 -0600
Message-Id: <20220204195044.1082026-2-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220204195044.1082026-1-elder@linaro.org>
References: <20220204195044.1082026-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ipa_interconnect structure contains an icc_path pointer, plus an
average and peak bandwidth value.  Other than the interconnect name,
this matches the icc_bulk_data structure exactly.

Use the icc_bulk_data structure in place of the ipa_interconnect
structure, and add an initialization of its name field.  Then get
rid of the now unnecessary ipa_interconnect structure definition.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_power.c | 39 +++++++++++++------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index f2989aac47a62..28be0e45cccfd 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -34,18 +34,6 @@
 
 #define IPA_AUTOSUSPEND_DELAY	500	/* milliseconds */
 
-/**
- * struct ipa_interconnect - IPA interconnect information
- * @path:		Interconnect path
- * @average_bandwidth:	Average interconnect bandwidth (KB/second)
- * @peak_bandwidth:	Peak interconnect bandwidth (KB/second)
- */
-struct ipa_interconnect {
-	struct icc_path *path;
-	u32 average_bandwidth;
-	u32 peak_bandwidth;
-};
-
 /**
  * enum ipa_power_flag - IPA power flags
  * @IPA_POWER_FLAG_RESUMED:	Whether resume from suspend has been signaled
@@ -79,11 +67,11 @@ struct ipa_power {
 	spinlock_t spinlock;	/* used with STOPPED/STARTED power flags */
 	DECLARE_BITMAP(flags, IPA_POWER_FLAG_COUNT);
 	u32 interconnect_count;
-	struct ipa_interconnect *interconnect;
+	struct icc_bulk_data *interconnect;
 };
 
 static int ipa_interconnect_init_one(struct device *dev,
-				     struct ipa_interconnect *interconnect,
+				     struct icc_bulk_data *interconnect,
 				     const struct ipa_interconnect_data *data)
 {
 	struct icc_path *path;
@@ -99,13 +87,14 @@ static int ipa_interconnect_init_one(struct device *dev,
 	}
 
 	interconnect->path = path;
-	interconnect->average_bandwidth = data->average_bandwidth;
-	interconnect->peak_bandwidth = data->peak_bandwidth;
+	interconnect->name = data->name;
+	interconnect->avg_bw = data->average_bandwidth;
+	interconnect->peak_bw = data->peak_bandwidth;
 
 	return 0;
 }
 
-static void ipa_interconnect_exit_one(struct ipa_interconnect *interconnect)
+static void ipa_interconnect_exit_one(struct icc_bulk_data *interconnect)
 {
 	icc_put(interconnect->path);
 	memset(interconnect, 0, sizeof(*interconnect));
@@ -115,7 +104,7 @@ static void ipa_interconnect_exit_one(struct ipa_interconnect *interconnect)
 static int ipa_interconnect_init(struct ipa_power *power, struct device *dev,
 				 const struct ipa_interconnect_data *data)
 {
-	struct ipa_interconnect *interconnect;
+	struct icc_bulk_data *interconnect;
 	u32 count;
 	int ret;
 
@@ -146,7 +135,7 @@ static int ipa_interconnect_init(struct ipa_power *power, struct device *dev,
 /* Inverse of ipa_interconnect_init() */
 static void ipa_interconnect_exit(struct ipa_power *power)
 {
-	struct ipa_interconnect *interconnect;
+	struct icc_bulk_data *interconnect;
 
 	interconnect = power->interconnect + power->interconnect_count;
 	while (interconnect-- > power->interconnect)
@@ -158,7 +147,7 @@ static void ipa_interconnect_exit(struct ipa_power *power)
 /* Currently we only use one bandwidth level, so just "enable" interconnects */
 static int ipa_interconnect_enable(struct ipa *ipa)
 {
-	struct ipa_interconnect *interconnect;
+	struct icc_bulk_data *interconnect;
 	struct ipa_power *power = ipa->power;
 	int ret;
 	u32 i;
@@ -166,12 +155,12 @@ static int ipa_interconnect_enable(struct ipa *ipa)
 	interconnect = power->interconnect;
 	for (i = 0; i < power->interconnect_count; i++) {
 		ret = icc_set_bw(interconnect->path,
-				 interconnect->average_bandwidth,
-				 interconnect->peak_bandwidth);
+				 interconnect->avg_bw,
+				 interconnect->peak_bw);
 		if (ret) {
 			dev_err(&ipa->pdev->dev,
 				"error %d enabling %s interconnect\n",
-				ret, icc_get_name(interconnect->path));
+				ret, interconnect->name);
 			goto out_unwind;
 		}
 		interconnect++;
@@ -189,9 +178,9 @@ static int ipa_interconnect_enable(struct ipa *ipa)
 /* To disable an interconnect, we just its bandwidth to 0 */
 static int ipa_interconnect_disable(struct ipa *ipa)
 {
-	struct ipa_interconnect *interconnect;
 	struct ipa_power *power = ipa->power;
 	struct device *dev = &ipa->pdev->dev;
+	struct icc_bulk_data *interconnect;
 	int result = 0;
 	u32 count;
 	int ret;
@@ -203,7 +192,7 @@ static int ipa_interconnect_disable(struct ipa *ipa)
 		ret = icc_set_bw(interconnect->path, 0, 0);
 		if (ret) {
 			dev_err(dev, "error %d disabling %s interconnect\n",
-				ret, icc_get_name(interconnect->path));
+				ret, interconnect->name);
 			/* Try to disable all; record only the first error */
 			if (!result)
 				result = ret;
-- 
2.32.0

