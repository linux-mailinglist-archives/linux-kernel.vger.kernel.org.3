Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE44EAFE3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbiC2PJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238260AbiC2PJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:09:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0081EC61E;
        Tue, 29 Mar 2022 08:07:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id yy13so35801652ejb.2;
        Tue, 29 Mar 2022 08:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hIr5PvQf5fAOI0436U7wwcVh5jl/xQHKrpc6xbFom/g=;
        b=fxKfzTApBxSRYrsYaJILMTwr/PE06U274HGvZsBw+QCZfWWgIfpfXExXXHsNFXHV7g
         F1gWxlTF7mTpZjkF9S16CyiRvmrWnSdkSNlBO45OD+XX/Fq/JAcZYJlQwuWlh5hFS4Od
         nkZic3NB4C25FqSWV7Nxgj9blOtLP9+3CHecdoelJvkoT4/qIEJu/K9dix6Zlvjwswti
         ef9z35DzxkKXKxcx9TWipXeCNJiUM8jHk02SGr+1Ri4vDjQz2x5g+IvJFey/txsPumPU
         8ZlUJaKOI0S2DNNU128p+MwRNCiSg/0v++D1YJHyc6Hj4MdWWC+qUk1dEzCtYM5UhP5N
         GYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hIr5PvQf5fAOI0436U7wwcVh5jl/xQHKrpc6xbFom/g=;
        b=A9DBOkkGINUKlHPARpURna13xeW09SU9eoO5w0/imxKCdmXmDv4VzQvA08QvkH12yE
         A5fTiqN6+rvx8737IMd71LHi4MUOKbaxuNTkvuseaCCWzWgaMoLjgjLNNknmOJut7nln
         FaAk0k97dP4czHlkvriInlj+D9XZL1JL8tJj23S3vkErBLKkNUVQP2SWNVOfDl/UDx4Q
         8ICcx727ddo7lzxSlKB1+D46z9GA+wlVD0Xom/6+3/aPq6+s8Dd1ki123Ijxm5Qj0/EB
         /AnlD0ScCk7VlFD48hf6Yo/gYCaiur6sh7fV7os1jorTVm48Uj8vjvQN7mnlBfYrl9ln
         FUsQ==
X-Gm-Message-State: AOAM532B8/MQCVRBzmVD37b0/4Q0y8ah6aAp2oZ4tNddcpQJUrzksW6H
        UiQvk03bErrAeqhxnSoYr3Q=
X-Google-Smtp-Source: ABdhPJzdWuR/Ip7WHPKwZ8Ei1Ym2WuXobIb/szldrSwb7qxobdqcCVGvEeOwV4+Df3ERQcmyHFFWEA==
X-Received: by 2002:a17:907:72c5:b0:6da:e99e:226c with SMTP id du5-20020a17090772c500b006dae99e226cmr35385241ejc.515.1648566474746;
        Tue, 29 Mar 2022 08:07:54 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id eq7-20020a056402298700b00419d8d46a8asm3261643edb.39.2022.03.29.08.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:07:53 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] dt-bindings: clock: fix rk3399 cru clock issues
Date:   Tue, 29 Mar 2022 17:07:40 +0200
Message-Id: <20220329150742.22093-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220329150742.22093-1-jbx6244@gmail.com>
References: <20220329150742.22093-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current rk3399 cru DT node gives warnings like:
'clocks' is a dependency of 'assigned-clocks'.

With the YAML conversion somehow "assigned-xxx" properties where added.
If a proper clock is added to the cru node these properties are no longer
needed, so removed them. Currently only one clock will be added, so limit
the clock maxItems to 1. Add a clock name to be able to differentiate
and filter bogus entries.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/clock/rockchip,rk3399-cru.yaml       | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
index 18a009311..54da1e31e 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
@@ -46,19 +46,10 @@ properties:
     const: 1
 
   clocks:
-    minItems: 1
-
-  assigned-clocks:
-    minItems: 1
-    maxItems: 64
-
-  assigned-clock-parents:
-    minItems: 1
-    maxItems: 64
+    maxItems: 1
 
-  assigned-clock-rates:
-    minItems: 1
-    maxItems: 64
+  clock-names:
+    const: xin24m
 
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
-- 
2.20.1

