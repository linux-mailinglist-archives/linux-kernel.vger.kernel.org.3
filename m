Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ECA4E6578
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351109AbiCXOlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351107AbiCXOlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:41:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E22E5AA4E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:39:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r64so2846279wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yuX9u5ic7NYyoUUkYeHSUuK8umCvOBjLstYMGoYWvr4=;
        b=g1sB5B/7wd0ibbAj2gulvKlRbRrGzUE4BmMu8K/X/ZjDNtCjj7RTKgucDZbzsoeeXn
         ZWdsC4WxBD/YLiebuvaV1XiJS/g+3CkEFeVmUJ/eqeBx438WjD7L/0Veitv63ixKdu38
         d3LMYGex9GnO7eccdvJDhv3J/3UvYSZf+f92jJb0QXca7vGDyPdcFQv1YKUG/FFqtqbC
         xkViGbC1Jp3xUhaQfnbGI96e2Q2OX/Q3+69AWvV1QNwCaHHnmxfdYJEaJEnTAvX1K7oT
         +YhzhTrOuUInXL0fRAmlSG+SBOr1KHzMuSQSedq7qlE2cPrhjOe2n2uTVa4cjNX7YtSu
         3JXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yuX9u5ic7NYyoUUkYeHSUuK8umCvOBjLstYMGoYWvr4=;
        b=WKDi6ZEoq/XxyRZcz7sqOEQjxLa4jJ4RczM2Jv94KV6WVf1aMv99f2T/MIvRQkemkQ
         j5qaV2bt22MA90J2Yr78A7EzcnV8cf/TL2JKUYNBiNQy8gxdNYeX+1Cxw83LcIG5kWUR
         sPfBWOpJMxJxiw2Ep2ZSzcwLXDw0VBtHJWMG9irrdg9T7c+fhDyXNU0vkyvNHEd1fpne
         NZR41AoSFffFRkSyilO4bbPsbJ+23vhXksOGDBsCSb6NT8hC+3gskbu4RN49JsI1buPj
         wOs0Od7CvNC71gmcvAH3/L01Q9I1ZZHVVp+3KSuU3ghSe5ICGuXHzgEPyYE7h0LVXIFD
         TrdQ==
X-Gm-Message-State: AOAM530AZctc9X+cFNvJEbwvGevGCv9dW2FFQH2IOtx5PtORrZ7cEzZB
        mC15yLFgXW0UGlutn2BEEBljAg==
X-Google-Smtp-Source: ABdhPJwwutAFQH46sr/Eifshdz0kv/5F3hT4G3rOQl2zfBYrq9a7wGb9kXNA8/sONUK2ruMxMETdAA==
X-Received: by 2002:a1c:7313:0:b0:38c:8690:1f30 with SMTP id d19-20020a1c7313000000b0038c86901f30mr14890199wmb.188.1648132780856;
        Thu, 24 Mar 2022 07:39:40 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a1-20020a056000188100b002041a652dfdsm3075745wri.25.2022.03.24.07.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:39:40 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] dt-bindings: clock: qcom: prevent interpret of See also: as keyword
Date:   Thu, 24 Mar 2022 14:39:35 +0000
Message-Id: <20220324143935.1117426-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "See also:" in description generates a DT check error since it is
interpreted as a field. Setting description as formatted description fix
that.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
index 4dc0274dbd6b..6c45e0f85494 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Stephen Boyd <sboyd@kernel.org>
   - Taniya Das <tdas@codeaurora.org>
 
-description:
+description: |
   Qualcomm global clock control module which supports the clocks, resets and
   power domains.
 
-- 
2.34.1

