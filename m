Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F2F53FD28
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242682AbiFGLQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242665AbiFGLQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:16:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD14396B2;
        Tue,  7 Jun 2022 04:16:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so20546111pju.1;
        Tue, 07 Jun 2022 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eyn/86c6liF5nYWGh9VyLqwQursjArpq+vyMDFNlc6Q=;
        b=lJSgL87NXAVkX4HsOGSumdR1cCQzgHG+hwOLjOuEvSSOnDvzXbBcK1qSGnr85+iGiI
         sIemmp+Qo8//8HwMOpA8byQpBC8n0ahRFcl/w0Vd6zJLLg6ezB+SV0TqW42pCwF/+jxa
         cqVuV30rPHvPd0GRB/19ILrquvbkwVD71D0nNjPizXqG7OAN9u/+EAWtVXK21b6SOYT3
         l+ID6KKwRS26/HRZWyAal5DWRW/PCPJQwrauv6xYY8AX1keacnmJL1BjkmNGaHpPfklu
         H6LX6NrnnDI+V9C5M1c/pSsbBIdsKTuXr4wi/yYGDbAGe/OgwEeAV9uQvqGxJiamR4fv
         +e6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eyn/86c6liF5nYWGh9VyLqwQursjArpq+vyMDFNlc6Q=;
        b=D0CS/EnkRH2PNBUCjNA2GtLp+MmL6EKjlVnN9jk9BW5dY1gv2aN1Ov+7YilRwWviGa
         pmofYQqCj1shcObuOxv8vHrlXw//muQYqhXHc0LGWaxGREb8iu3Ched2nv81ySRwhIff
         vJHbvauKzScD6OrEcrYub0cddpVe3bw3HkB36owpWAuswNQY0ttlaWoG5UwD3uy2Xcmj
         dEuRLW3jXs1rsP6kLsmUeNMMe5I49plmVz9i5vjq48KQGvAyhTpkCX0eEDn3C7dDobkT
         9YpSF431dY7LXAwahrqPl8Py9xytQoeX+F+qoa9bIVnXpeVQz+EbqFCITZolh600U4YM
         ruHg==
X-Gm-Message-State: AOAM532P5kKhf4h37Yyhym4kJ3DWRxISu1TnMl5iZwgl5ajEotu28uwu
        Kf676LBeC55qbCcWDPl6Syk=
X-Google-Smtp-Source: ABdhPJwsbxOSKLJ4weNQQd1EOj/uVEtmK7CBrmp6IGxccZZprAYQAw0GhOvk6bxPGoX0hsxG+uJvqw==
X-Received: by 2002:a17:902:f605:b0:14d:bd53:e2cd with SMTP id n5-20020a170902f60500b0014dbd53e2cdmr28383722plg.164.1654600570302;
        Tue, 07 Jun 2022 04:16:10 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056a001c5700b0050dc762816fsm5213778pfw.73.2022.06.07.04.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 04:16:09 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] pinctrl: nomadik: Fix refcount leak in nmk_pinctrl_dt_subnode_to_map
Date:   Tue,  7 Jun 2022 15:16:01 +0400
Message-Id: <20220607111602.57355-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak."

Fixes: c2f6d059abfc ("pinctrl: nomadik: refactor DT parser to take two paths")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 640e50d94f27..f5014d09d81a 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -1421,8 +1421,10 @@ static int nmk_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 
 	has_config = nmk_pinctrl_dt_get_config(np, &configs);
 	np_config = of_parse_phandle(np, "ste,config", 0);
-	if (np_config)
+	if (np_config) {
 		has_config |= nmk_pinctrl_dt_get_config(np_config, &configs);
+		of_node_put(np_config);
+	}
 	if (has_config) {
 		const char *gpio_name;
 		const char *pin;
-- 
2.25.1

