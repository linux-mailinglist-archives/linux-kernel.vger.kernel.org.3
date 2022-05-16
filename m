Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40901527E77
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbiEPHU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiEPHUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:20:24 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7CB14082
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:20:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 204so13281148pfx.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eCmVhbpaMLMmcTFdi6DgkFjueZN+yXGyrRASDyrwkks=;
        b=MimcTO2WieI6l/6Khw/SNAmf82P6jKFwx547sGazZdWl8jRlMD2VMo9wPw1mUBdEz+
         pYFe6FYiJfJKf2Ch4vXIvy2Fr/ZR7QNJS2lDlNL2jgRq1VvhGUA6OzLaxR8ZSupOeMJh
         1HUdraWPUJkoDwqjXYts1EBLu27FtoRajh0DAb7TDQaTmQsPN5Ll3Wm4I4QgaE7MMrEH
         /jgqad0rwlrhn8n1OChb3ksvHzDqPrJXPzhjjzcqkkUHN3c0VoHjPaE2NNFObHV8T39B
         JuRjaTYsjiQm3kLDtI3kPME6aMd2f6kmZZtQB6pmzW5Jidmpg2q/EJTgWmfaqWZsDccQ
         HSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eCmVhbpaMLMmcTFdi6DgkFjueZN+yXGyrRASDyrwkks=;
        b=WfyppNldKFfHKLyCSqyKUmNQhxTczBMIk5bdbsq40vXkyqcPto306merQX8JsI3ss5
         vlwIg/yrt7dFS7pdk/rwTxiQwD/kR87tdEVNsqg2h3cDxUAXLhpSVe8hZWaX9WzUph3A
         jndiRJiESI+P48ZrPUNu7dnEyGPMUdHBNLQ2t3a+qX+IDCO8amgnvHidDe8eFahEbweN
         mWNZ38qNU94IwfmsV0kM1SqCzYt3QZTziUZ/wkcOU+A6RUQY4CumLIfXfkXOzNWUum2y
         eS9rBxS1iwiDiL3P1NVN4ItqexPaw5rUAlubIhfqQMsajNcfgUF3laZJPdLvf0faHo+A
         RWTA==
X-Gm-Message-State: AOAM530JtcxHwZDPLwjrxEgctmiwDcXejBaVWYXpfFb5Q1MypnvsQAqZ
        tju1M+b/YiMYwwselhBbzHc=
X-Google-Smtp-Source: ABdhPJzf+Ui53KjS86ZZVJHXvuIFOxk2AVw75xGanp9kj3NyZDFE2NKOkhUVdf8WeXh/a/C5tCPwJg==
X-Received: by 2002:a05:6a00:b52:b0:510:5cbd:de94 with SMTP id p18-20020a056a000b5200b005105cbdde94mr16009274pfo.19.1652685621649;
        Mon, 16 May 2022 00:20:21 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id o130-20020a62cd88000000b0050dc7628179sm6035949pfg.83.2022.05.16.00.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 00:20:21 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: rockchip: Fix refcount leak in rockchip_grf_init
Date:   Mon, 16 May 2022 11:20:10 +0400
Message-Id: <20220516072013.19731-1-linmq006@gmail.com>
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

of_find_matching_node_and_match returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 4c58063d4258 ("soc: rockchip: add driver handling grf setup")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/rockchip/grf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 494cf2b5bf7b..343ff61ccccb 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -148,12 +148,14 @@ static int __init rockchip_grf_init(void)
 		return -ENODEV;
 	if (!match || !match->data) {
 		pr_err("%s: missing grf data\n", __func__);
+		of_node_put(np);
 		return -EINVAL;
 	}
 
 	grf_info = match->data;
 
 	grf = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (IS_ERR(grf)) {
 		pr_err("%s: could not get grf syscon\n", __func__);
 		return PTR_ERR(grf);
-- 
2.25.1

