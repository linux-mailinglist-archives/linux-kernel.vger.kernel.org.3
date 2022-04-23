Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B646650C8AC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 11:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbiDWJnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 05:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiDWJmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 05:42:33 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3EF7DE33
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:39:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a21so924059edb.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yi/KWMdEjAECEQqVSPs3J5XHwdnZDBuBrnOuI1PVsGc=;
        b=DGc8Sn7k6aJZQWpk8RYgPbSw6k2zTB/vM0gD6NDsZKI9E0VGOCNlfyzhzyJnHcTzGl
         DlFtvB2K3XdYjv92YuEZd/ijas4Qob8oAgxavap8hi3A+EAxCb1SK630S4V6LJBTBY6B
         tEzGyc53fRgwZxbR92ITXhltgT8QYWyILRjZsfkwqslQF1ze/ZqAUjLjkdjlQroN/PaO
         8O/MBwdH8MIRH4adf6hFDii2cPJqFqpWYrFp2JGBjO0lC3jwfmttt+rEBOHf94I3nkwL
         W82hZnY9o5g3rvSyK/V4/3pz3mAl8/RlnJ73R22cVELImFV5AbFbmFGLeWmevA8BtEAl
         8+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yi/KWMdEjAECEQqVSPs3J5XHwdnZDBuBrnOuI1PVsGc=;
        b=7ifQVJtZ82zrjL9dL5o+NJQEvSMCuJ01zWSGy6zqBbiOXvJO1fBg5TklhtKy/MnGOK
         CXgRwlMobSxip0ElolXtcIb2jtcEEF0mPssKBrvKV88V9IbWBtAv304bor6qn8ht/nBI
         KuhVP6Ju+soRsKsMvYytn7PHb6DxRL+/sj0VdSHR1lqtB8ha1xTzVf1ccOBGNhxOo4kC
         4VwG7DbytujQTVSNE04C/n/nQW2WXxvdo82PHNYyMh+cn/NAfGau3s9M0531lLhTvgKb
         J7JKxKU1RjXxPvHgb6AK9N0bC8e3lhR6yC9i+bqhs11K4oUmSKU2JBZEnj0gg+kmafss
         2aFA==
X-Gm-Message-State: AOAM532fTTD+t6pzCauwYaOu85V+w6KVs/+0TLZaNoWFrJgqQ4VayLHr
        BN+7hs9bI6luwH9GfjvIV2iLXYMyU2Mdyg==
X-Google-Smtp-Source: ABdhPJx/vBPd2DZ/ue/LXDVxPGJkHdiS434Zk9hz/YnuVTXUIhs/whv0tWbG+s+70kXa+sdql69TFA==
X-Received: by 2002:a05:6402:294e:b0:41c:c191:64bc with SMTP id ed14-20020a056402294e00b0041cc19164bcmr9550151edb.166.1650706775500;
        Sat, 23 Apr 2022 02:39:35 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k19-20020a1709061c1300b006e8843b0729sm1518201ejg.76.2022.04.23.02.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 02:39:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] rpmsg: qcom_smd: Fix returning 0 if irq_of_parse_and_map() fails
Date:   Sat, 23 Apr 2022 11:39:32 +0200
Message-Id: <20220423093932.32136-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_of_parse_and_map() returns 0 on failure, so this should not be
passed further as error return code.

Fixes: 1a358d350664 ("rpmsg: qcom_smd: Fix irq_of_parse_and_map() return value")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

A fix for: https://lore.kernel.org/all/20220422105326.78713-1-krzysztof.kozlowski@linaro.org/
Commit sha from Bjorn's email, so might not be stable/correct.

Consider squashing it.
---
 drivers/rpmsg/qcom_smd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 6ccfa12abd10..1957b27c4cf3 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1409,7 +1409,7 @@ static int qcom_smd_parse_edge(struct device *dev,
 	irq = irq_of_parse_and_map(node, 0);
 	if (!irq) {
 		dev_err(dev, "required smd interrupt missing\n");
-		ret = irq;
+		ret = -EINVAL;
 		goto put_node;
 	}
 
-- 
2.32.0

