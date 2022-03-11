Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DD24D660D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350199AbiCKQZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349035AbiCKQZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:25:32 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17596106C88
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:24:28 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id l1so6311388ilv.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TVv29Gu9R0lZt1E9Lqgvg+RLu73iRTIWopGteUyS5tk=;
        b=lCofLKqu1VnbBCzaNpXV1knnGKNcPMluFAY18Sxq0Ca91tipY9CRbnwsMQkTdvik8F
         SEOXnZRQxFAEERaWcST0h0s2XHvTs0kDaVF7br7uE7wlaR1SgaBnVMYVy1eVZhICq3d+
         J4I3/GXLR4cGzJ35vLVuTEhDhSy06DjuoxSI3qjS0Kn0JoWRDAEznTb/KQUodcliR77J
         6OqmsVAp8PJnJcvlKegxhcKKpPqO+KBXHYWpqgCmzQ8EKsO6M/sigADy85m0mea6f0b6
         FM2iay5XDea5wMhPdMdntbPIeDwXmzAj3zIBFASvL/N2MEKawd4LO6UfhpQX8Akv5Gyx
         uxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TVv29Gu9R0lZt1E9Lqgvg+RLu73iRTIWopGteUyS5tk=;
        b=rGmHCyLOe7DuxUUQXhbPdL+uZbDHF8QHS9gM3BZv01klxe6dFo3PoyzoIhYt2XRBLK
         Zb8QU5Yjy4H7SSgNXgpmdrSAGHBWtLlH0irEpNEDmnMQsf/dRkkbbM1uf8BN28LsUO8K
         w69nTlOUXsivPFvawDnaUopwlwaUxReAAca3a8setykfHree7Drb0EN16mb+HW1kme+E
         ILAlewThKM2w6NCbp8yc2tP0pcYR8SFbhMz/lQtzdsQl0iXwQx1X3jRK7nWsXMqo9RGT
         i0vqmSWLV9CdstWPD0N583n9ObtmGZkmlWslrum2fa+FtzxXYQvJutBdJngluLgOR/Ou
         Q05A==
X-Gm-Message-State: AOAM533syBB3ivtNLFmbQFOVHu6+8IclWXj1jSgsibiao8Nuku1kvBkZ
        LY2bt5NkwIDcrRjbLNYkwnTJbw==
X-Google-Smtp-Source: ABdhPJybfXZ+7K9olLoE/9/fWtbz4ao9QwudLVncfyyzWjxs1/RsmnajOwMe6+J+Q0mRrXeyMUZQ9Q==
X-Received: by 2002:a92:ce91:0:b0:2c6:272c:bb51 with SMTP id r17-20020a92ce91000000b002c6272cbb51mr8214045ilo.170.1647015867291;
        Fri, 11 Mar 2022 08:24:27 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id 4-20020a056e020ca400b002c6266f4876sm4477042ilg.84.2022.03.11.08.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:24:26 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, mka@chromium.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, avuyyuru@codeaurora.org,
        jponduru@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/1] net: ipa: use struct_size() for the interconnect array
Date:   Fri, 11 Mar 2022 10:24:23 -0600
Message-Id: <20220311162423.872645-1-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In review for commit 8ee7ec4890e2b ("net: ipa: embed interconnect
array in the power structure"), Jakub Kicinski suggested that a
follow-up patch use struct_size() when computing the size of the
IPA power structure, which ends with a flexible array member.

Do that.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_power.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 16ece27d14d7e..db5ac7552286e 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -374,8 +374,8 @@ ipa_power_init(struct device *dev, const struct ipa_power_data *data)
 		goto err_clk_put;
 	}
 
-	size = data->interconnect_count * sizeof(power->interconnect[0]);
-	power = kzalloc(sizeof(*power) + size, GFP_KERNEL);
+	size = struct_size(power, interconnect, data->interconnect_count);
+	power = kzalloc(size, GFP_KERNEL);
 	if (!power) {
 		ret = -ENOMEM;
 		goto err_clk_put;
-- 
2.32.0

