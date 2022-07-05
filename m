Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B725663A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiGEHBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiGEHA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:00:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA531181E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:00:52 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e132so10624437pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsy8RgpVRpOJDolyph05nBpVAaILT2BYyd7LLXQK8tY=;
        b=tWLIhvIMi3bqQ1WIU1mnGOdt9m5zPw3uFewvM95H9pkuxcUMFi9im2HymV9Fe/cfL6
         oRp8cnD6MSosK/ZVue8RFaKk5x6Pb68e0oVxf1YXUk41etd+7w6x5sXwvJcqFgVN7xjX
         mI5743zHcb9t5iGMOMfKFbHCZemw+02HpiqGt6FPtxLzkKurDK5jub1/BclltguVyBpK
         1GNF9pjO1jjUDKjDmwNdGNTpV8UOS6oep3Ih1BDdnyWfacdKsPG7BHRkn1VdWT+H1tqK
         m5MWPGv8Vp7zV710mEa8SX8y1UznzMYdiXuaOBhJVfLetd9mr5Zjc6cxhkS2ah/XgVwS
         +wWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsy8RgpVRpOJDolyph05nBpVAaILT2BYyd7LLXQK8tY=;
        b=6bn6MFKHy+flT6bn+bw5c6sVp/SWALNsjGvJB6aeTLSGFN+n/Ceu5UbUt3tDm23X+v
         xw4gZSoQYYTI11Xw9DLM7KTTOek5t4oWTteEcqI+AsCUDCE62wZsgG3wapyoo3lfyki5
         ewfWagm6AFszND+7KeRjVU+WNuEmWghaohD7HDcaFI8mqelGoHW8lSK6XNSf2yqYOOyI
         hUF9ejLTq4J6Xw2LeF5AR7TtUHbqXt2qY96w3tLAF8fWMO1Z0YfZqxQOiM83QTthAbuE
         FoaCYEzZe9JJdERyaf3XR4+BjVejA0nC3tqbSmrxyziy5VzorCaVsd7J1Ppni5yqqv1m
         wcCA==
X-Gm-Message-State: AJIora9gvP1uyQHCa62AVg0QuF9YT8PQwGMPlUkSnJH90S1OYoMtnfqQ
        +2H/4iSfeWHLzJUi/l2XotyhqA==
X-Google-Smtp-Source: AGRyM1vn717VOM81aTHiUjQo6ju+/4RDSOtae3Ze+4pYF3x3lXmyfcGmGRPPtyy9DaQowEDB7AD83w==
X-Received: by 2002:a63:185b:0:b0:411:75ee:c87a with SMTP id 27-20020a63185b000000b0041175eec87amr27710197pgy.607.1657004451865;
        Tue, 05 Jul 2022 00:00:51 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id f20-20020a170902ab9400b0016a109c7606sm22609436plr.259.2022.07.05.00.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:00:51 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 07/13] OPP: Compare bandwidths for all paths in _opp_compare_key()
Date:   Tue,  5 Jul 2022 12:30:10 +0530
Message-Id: <1bbfdbf08c010bf6687b906a6865981d0a075acd.1657003420.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657003420.git.viresh.kumar@linaro.org>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
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

Replicate the same behavior as "rates" here and compare all values
instead of relying on the first entry alone.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 003cd48123d7..261f5e1abfe1 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1683,6 +1683,20 @@ static int _opp_compare_rate(struct opp_table *opp_table,
 	return 0;
 }
 
+static int _opp_compare_bw(struct opp_table *opp_table, struct dev_pm_opp *opp1,
+			   struct dev_pm_opp *opp2)
+{
+	int i;
+
+	for (i = 0; i < opp_table->path_count; i++) {
+		if (opp1->bandwidth[i].peak != opp2->bandwidth[i].peak)
+			return opp1->bandwidth[i].peak < opp2->bandwidth[i].peak ? -1 : 1;
+	}
+
+	/* Same bw for both OPPs */
+	return 0;
+}
+
 /*
  * Returns
  * 0: opp1 == opp2
@@ -1698,9 +1712,9 @@ int _opp_compare_key(struct opp_table *opp_table, struct dev_pm_opp *opp1,
 	if (ret)
 		return ret;
 
-	if (opp1->bandwidth && opp2->bandwidth &&
-	    opp1->bandwidth[0].peak != opp2->bandwidth[0].peak)
-		return opp1->bandwidth[0].peak < opp2->bandwidth[0].peak ? -1 : 1;
+	ret = _opp_compare_bw(opp_table, opp1, opp2);
+	if (ret)
+		return ret;
 
 	if (opp1->level != opp2->level)
 		return opp1->level < opp2->level ? -1 : 1;
-- 
2.31.1.272.g89b43f80a514

