Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BA74FB936
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345219AbiDKKQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345183AbiDKKQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:16:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8C313F34;
        Mon, 11 Apr 2022 03:14:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u3so22273238wrg.3;
        Mon, 11 Apr 2022 03:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jo7tWOSsCgtTcP6fE9H4HS3FFxnoGMJ2maOVgOmkHE0=;
        b=iffnUFjHZ2UOEaWor02KSBDnkhR+50d4cHTv5sJrZLKIftrT3gOx/8t9yy9ghrllcH
         hrTz6lStIHzsI9qPxNEGxAYapYmFm4krK7g6O+u+k4XAz5/QrOwKoXKFzpPezbp2BLcg
         D6D8sJGRCUzG6AfJKIxPoUl/1e+C6OOmidpaiXaggZFqJiMAnxfV6vCM6P2Np00+aq0G
         kmeomBJewPcQh8aEarE2Lbv50fdEnypEyDECd5jBWSmYNLIKdFhpRUIJA3oMT89L2o2U
         Uz2Fhh2zlbPB5fSlgPqasq5IANy388K8CRTl7CuaTGSi/6J54vUKltqxqO7Dq47xM57a
         TEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jo7tWOSsCgtTcP6fE9H4HS3FFxnoGMJ2maOVgOmkHE0=;
        b=XbfZrKG6xWwZ/aJgfzp5L6/WPlGx+ZQAlzrVhm5z3qDCGHptdF0i+t5qGqycS/VkGg
         Rq/TFRqUOI4ganLXIcR8rVNB9Ybxc5oA9OqZboOHmwt0KU1xeSjOk/Jfg6qDHGSN+in6
         md+hl/46/Wt1GlX7Z0q2fW9luRugD6hnKxHhFRvslsASEsYutcG0J3s5tSY0gmwIlCMP
         mJ1x9/V+y/x7CN6ZPkmRPHjpTigCqgrNrZxc0l4Fw5rnFSv75dQ8dtHY+ulMWmoWhfn1
         QD9x3JlcWVnM3nv3aRu/mKt2+hmdJ1Vrtr0oom/01WoCff7gt8gc45Dg590SySPU5fWm
         +AdA==
X-Gm-Message-State: AOAM531vAK2Jo1VIquItKi9EieW+/NyhNAAFnEUQuuVn++RW58p/jtfN
        CPKMCanBLoWtYGk98Y24ACk=
X-Google-Smtp-Source: ABdhPJysaIoFhiHSoTtVAJlzluzsNoNwqWc02I9Ga2xJWOEVrVRS1MIE4uRlj8kxMK6F/cmvbMY4sg==
X-Received: by 2002:adf:ff8d:0:b0:207:a0e2:4487 with SMTP id j13-20020adfff8d000000b00207a0e24487mr7597532wrr.570.1649672060359;
        Mon, 11 Apr 2022 03:14:20 -0700 (PDT)
Received: from localhost (92.40.202.18.threembb.co.uk. [92.40.202.18])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0038ceb0b21b4sm20526369wmq.24.2022.04.11.03.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:14:19 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, paulburton@kernel.org,
        tsbogend@alpha.franken.de, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [RESEND PATCH 1/3] clk: ingenic: Allow specifying common clock flags
Date:   Mon, 11 Apr 2022 11:14:39 +0100
Message-Id: <20220411101441.17020-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220411101441.17020-1-aidanmacdonald.0x0@gmail.com>
References: <20220411101441.17020-1-aidanmacdonald.0x0@gmail.com>
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

Provide a flags field for clocks under the ingenic-cgu driver,
which can be used to set generic common clock framework flags
on the created clocks. For example, the CLK_IS_CRITICAL flag
is needed for some clocks (such as CPU or memory) to stop them
being automatically disabled.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/cgu.c | 2 +-
 drivers/clk/ingenic/cgu.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index af31633a8862..861c50d6cb24 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -660,7 +660,7 @@ static int ingenic_register_clock(struct ingenic_cgu *cgu, unsigned idx)
 	ingenic_clk->idx = idx;
 
 	clk_init.name = clk_info->name;
-	clk_init.flags = 0;
+	clk_init.flags = clk_info->flags;
 	clk_init.parent_names = parent_names;
 
 	caps = clk_info->type;
diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index bfc2b9c38a41..147b7df0d657 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -136,6 +136,7 @@ struct ingenic_cgu_custom_info {
  * struct ingenic_cgu_clk_info - information about a clock
  * @name: name of the clock
  * @type: a bitmask formed from CGU_CLK_* values
+ * @flags: common clock flags to set on this clock
  * @parents: an array of the indices of potential parents of this clock
  *           within the clock_info array of the CGU, or -1 in entries
  *           which correspond to no valid parent
@@ -161,6 +162,8 @@ struct ingenic_cgu_clk_info {
 		CGU_CLK_CUSTOM		= BIT(7),
 	} type;
 
+	unsigned long flags;
+
 	int parents[4];
 
 	union {
-- 
2.35.1

