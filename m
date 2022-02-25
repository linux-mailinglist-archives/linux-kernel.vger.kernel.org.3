Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D91F4C4D17
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiBYR7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiBYR7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:59:18 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D321BBF59
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:58:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id p9so5635429wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KdJ2FuMgAyAwbLGKNB+M/QY0Fvh3jw6kKr9Fyh7jJI=;
        b=wGTTgtTOINGcGh8LMGUGXuLE7Cs/hN6BmzVHFaZV9hj0zLjF0GlvJN2OK2CXRrUqqh
         AQF4Nf5r3TY2W/UTjlVKLWWcZI/1wXMvHSo8flb8j3GdFDDB4YB8o594pmwKFptLkbN1
         0h5FQDnsEwRfsEGzYvnKRlmkeerXly02XTXqe24BQHdmScu5aAWJ8CtnKw2JasgU9/lE
         4R81WMNVOY0VtxbQ3jPxocwCu4vcriE17Fr9J7UYkj2COKtlJJy4MrZj3c6qWCOiVwmp
         ZGlezW5B2uyUoKZQaBvXHhU/15STqsQjQMuN3hx4jsvtEPw0neSfwYW3y0Xr1F939xC7
         JBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KdJ2FuMgAyAwbLGKNB+M/QY0Fvh3jw6kKr9Fyh7jJI=;
        b=X29HXcL2MjSkgn8hEKljzvfHtah1bjNX8yiyOTZNuUpzkD6yEet7Nz7mqP2LL+e1a7
         gh9/7ifdHwHyz7JQ4rQ5AF144HkJOf/jGY/8G60ZaaQHsvAQ3dmMAQJ5/nlituVMOSDg
         FAbkQzMbqEnonl2qdIDCkFckzDpK+BwBWfRnkm7XehG0WCh74RsJQ5kE4FWp3oOPUjlO
         FogO4vFUvdLL20rKoJCBG8zU9ceKD375zRGUYMukf9zZxvD64HOG8WzK5jspksSDZOVS
         e0UQwaBJeNJQL3dlw/ZvQbB3I4NZel88lxwkttyr8nPrvEuXJVnlGibfQEB2euKpzpw3
         w4bg==
X-Gm-Message-State: AOAM533VZlqAKNdsQs6NxgRPkTBFnlAQefmwQe7u/wg1lY/kZmoV8jVl
        nzyXLhVBK5QvxbjCfx5FKXpzWw==
X-Google-Smtp-Source: ABdhPJxRAraWWrduA8zR6qPJ1E7eeRNDlYWCml7+zaSHqDg+lA5TJCnmOcQpcE31Zv39OZ8W6Fuvjw==
X-Received: by 2002:a5d:64ec:0:b0:1e6:8d72:b8af with SMTP id g12-20020a5d64ec000000b001e68d72b8afmr7087179wri.165.1645811923796;
        Fri, 25 Feb 2022 09:58:43 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c2f8800b00381428ad88dsm74172wmn.15.2022.02.25.09.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 09:58:43 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] nvmem: dt-bindings: Fix the error of dt-bindings check
Date:   Fri, 25 Feb 2022 17:58:19 +0000
Message-Id: <20220225175822.8293-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220225175822.8293-1-srinivas.kandagatla@linaro.org>
References: <20220225175822.8293-1-srinivas.kandagatla@linaro.org>
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

From: Vincent Shih <vincent.sunplus@gmail.com>

1. Remove the unnecessary header file for dt-binding check
2. Replace OTPRX with 0x15 since it is not defined here.
3. Modify the name of the node of the clock driver.

Fixes: 8fb29b450182 ("dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP driver")
Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml       | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
index 4b28f37dfb67..a7644ebbc2ca 100644
--- a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
@@ -60,13 +60,11 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/sp-sp7021.h>
-
     otp: otp@9c00af00 {
         compatible = "sunplus,sp7021-ocotp";
         reg = <0x9c00af00 0x34>, <0x9c00af80 0x58>;
         reg-names = "hb_gpio", "otprx";
-        clocks = <&clks OTPRX>;
+        clocks = <&clkc 0x15>;
 
         #address-cells = <1>;
         #size-cells = <1>;
-- 
2.21.0

