Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0562F4E658E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351160AbiCXOoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbiCXOoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:44:12 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24600AC91D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:42:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so7356036wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RUuYp2gzZTfveRrYj1nKJKJ6GLr04No5LqGCeqkgp50=;
        b=G9HidbaMnDHtTrEAhAkiDwkyMIMMc6Wqcu/xpKqMNAqZgScFmSCAILoCtXpISK+Hhy
         uB+8YBCUwdxf1Gocu8dCsTLDhaqkZGMeh6nNJ3sUFCCJImFnDwOyBw6dRyGd8Rm8I3OK
         4rKkIdOoe9qcnCYK25u26XittRZwpnKn4rAlusYwV9HlRFHoau53kWOf/+m6xWfwxB/h
         zQ54w0wxyEcRcwkFJuJ+1mJTTVlkBlhHn7TzrxHuLg+m4FtaPlh57mFRtuAS7w7hH6M9
         cbq8IvAUXGMjZvK+w4GvQp66umUGHCpUGcbSgAPAW4awO2p2dX6wGm5kdQWdDSl4axza
         EZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RUuYp2gzZTfveRrYj1nKJKJ6GLr04No5LqGCeqkgp50=;
        b=sGDjXH41eJ3iHr+rTzsLiUtGBXJgBfGSnoeqsNC7tYIooVQTAdw5SfbfmE4pvsW5jn
         z93vZMYyi4qCAZY+gumhU927Gxa4/cSUfKRpQb1f/fNJHsEz9XTECG9Eey+dtNeQWLHc
         5O68zAiDZ1/FFBt2RRO/f/6O7TcfodndJoR2vsCB0g+aGthq5z74VSHvUTsDBt2UbUVT
         7A2ld67qtgy77xmR4w57MgpglvtF4jD/pwAPK4lnJBVUE0df1gUEhXAUqgWkAAaMlYAB
         s7up6PoDoFOn0EpQupWJDhNb2s1N/PmEVnmwMy/orQmyf/nJsYqzGeH7NrEv841Vrw66
         +jCQ==
X-Gm-Message-State: AOAM5313/N0B8eEVskFi6U7yp6JOQy72XVEwNNEtdKjUGGkAoRjoSPQD
        ZUeZAfxTwyp0tfNyQ7PZQRK/FLZgT67pew==
X-Google-Smtp-Source: ABdhPJw3kEFmgdFvOYqPEE/cnML2UreW9i+I5UewFAmsjCiGfAtVJ0zEiql/LajWmccl86QQnyLLPQ==
X-Received: by 2002:a05:600c:4608:b0:38c:6ba3:1c9f with SMTP id m8-20020a05600c460800b0038c6ba31c9fmr14542211wmo.39.1648132958693;
        Thu, 24 Mar 2022 07:42:38 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm3273175wrz.29.2022.03.24.07.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:42:38 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@gmail.com, krzk+dt@kernel.org, robh+dt@kernel.org,
        samuel@sholland.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] dt-bindings: crypto: sun8i-ce: remove extra line
Date:   Thu, 24 Mar 2022 14:42:33 +0000
Message-Id: <20220324144233.1119495-1-clabbe@baylibre.com>
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

yamllint complains about this extra line.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml b/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
index 00648f9d9278..026a9f9e1aeb 100644
--- a/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
+++ b/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
@@ -82,4 +82,3 @@ examples:
       clock-names = "bus", "mod";
       resets = <&ccu RST_BUS_CE>;
     };
-
-- 
2.34.1

