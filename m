Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3759B53F43F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbiFGDBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiFGDBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:01:18 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC713CC146
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:01:17 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i1so13675082plg.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 20:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WQyqWY1DaF2KX7zCLh6Al5CBhTie1rko5iuwHl2wcu0=;
        b=g5tx3HSzjPwCPfnKaUUSX5bRcUPAxfnB3BrNTHzMAI3YPhZp1yZzEWNyrOmSv5AEId
         O2u25pKE4UoYC56ZYU3HX4o+OfIQpCkgG+rf6lbwiwJOXpVs8j/SyC378aRAVtF5v1EB
         amkqP4HcNnbo2wsVJ9Ra2zy2R501SjYgJSosQWRmC8ZinIq85SYLt7OA4/CE2dS33572
         6CaxZtv1fP8BmqW/HfJ6LKTPYkuxKEN9PGBOcgcyeLu3dA+iiz/uPHfpASlWuM3HA7cn
         yioBOUYcUu2n0hzEKJbOZyEYcn+JGRMkN96WWfQbf7raAxl49q7ThuFP1c//gArFoJwP
         y2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WQyqWY1DaF2KX7zCLh6Al5CBhTie1rko5iuwHl2wcu0=;
        b=Z8StyGOe1IWb6cndsa8Rb8cZHHtLVN+SCvroI74xO43eJk6E5ZaG6KV5yzSgROxaxB
         V7RlmxQUuRAoUADRaWbvacggp98pQfeSjpzSVvWdC79jnOEEGmZcc6MWXJ+5iJN1ZFY9
         FpoN1QQcLC3Pho5/1j87NhFBi8wmBOxMUYGx+w8BQVG1oELBz2yb0o113tWsU3/NJRfz
         3d6dOxU7xwHUUOvDhoAmN6EY5c++D+9WFVh4MrWElEsYc9evsJJwBRNwFTxe4k1PTKE2
         HHn01lLC/zTmCSyR9k58UwH1kjchuKv9BFBAippdfvIckSsuc5JXCTk7GGCWiCSRVfJX
         kDFQ==
X-Gm-Message-State: AOAM531AH9y/NJehK+QOXRYpoZlRZ3Hw43Sn19B1EL7090bxFhyU0d+N
        5bH0wCjYCmpZR+tDxQQsacq6D0YEhRNR2Sbo
X-Google-Smtp-Source: ABdhPJw8h6WtpEg/INJaH9p1F9/23RL/px1c4AekgPVVBjIRK7MKG0L0hBk1ulCS9RAUrEeZ7SGBdQ==
X-Received: by 2002:a17:90b:3b4e:b0:1e8:743a:735c with SMTP id ot14-20020a17090b3b4e00b001e8743a735cmr11707056pjb.189.1654570877129;
        Mon, 06 Jun 2022 20:01:17 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id gt24-20020a17090af2d800b001e3351cb7fbsm13217382pjb.28.2022.06.06.20.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 20:01:16 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Mihai Sain <mihai.sain@microchip.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers: soc: atmel: Fix refcount leak in atmel_soc_device_init
Date:   Tue,  7 Jun 2022 07:00:55 +0400
Message-Id: <20220607030058.53695-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
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

of_find_node_by_path() returns a node pointer with refcount incremented,
we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 960ddf70cc11 ("drivers: soc: atmel: Avoid calling at91_soc_init on non AT91 SoCs")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- create new variable match to refactor the patch.

v1 Link: https://lore.kernel.org/r/20220605084035.27127-1-linmq006@gmail.com
---
 drivers/soc/atmel/soc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index b2d365ae0282..7152a38c657a 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -368,8 +368,11 @@ static const struct of_device_id at91_soc_allowed_list[] __initconst = {
 static int __init atmel_soc_device_init(void)
 {
 	struct device_node *np = of_find_node_by_path("/");
+	const struct of_device_id *match;
 
-	if (!of_match_node(at91_soc_allowed_list, np))
+	match = of_match_node(at91_soc_allowed_list, np);
+	of_node_put(np);
+	if (!match)
 		return 0;
 
 	at91_soc_init(socs);
-- 
2.25.1

