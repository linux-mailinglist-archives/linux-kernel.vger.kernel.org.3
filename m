Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D024F55D083
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbiF0Ixo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiF0Ixm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:53:42 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7456D6358
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:53:38 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 982AB3F210
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1656320016;
        bh=cVIA1rzk9lEClXQUVijI1mtxn42A8LDHnGLvrJ0uW4c=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=UHHapKF9EmLJwnFOQQ6S7DziubF+fHVost1Z3bnf4im//rUfYsRNeuxZRX7LC56lT
         /v0x6FL8VKlqzPfdyecNqEmVH+9HaSGGJvbWpd7v/9aO8LqasF5Osr30297jbNyFVe
         vtv4bX3JIXBHoAjGiNgw2plyfeuJJ6zGgA+dduVXAZWmeFTxm9tNmFx4fOhr59U2kF
         uGg2fNHk2V4Iw6JdsOZeTbaV44HKepvVfCzjy9EvIk8SMnvDMuL/MSopnV+nIqJGN8
         foSKMaOs590mVFfyDwj+siHvBQRv1tDNDETty6UIo4yVNtsRe9jd7L8XKibL6jjwGM
         AVaFMs/6DiMkg==
Received: by mail-ej1-f69.google.com with SMTP id sg40-20020a170907a42800b00722faf0aacbso2125065ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cVIA1rzk9lEClXQUVijI1mtxn42A8LDHnGLvrJ0uW4c=;
        b=oA8uXHf/1oR3WIqZd12H1dG3yI/H/t84Zx+3y4OJIVhEoPcFB2Pg+pwqriJmRFhGR9
         SYSWVvXZQVpGk3CL5ojVba6NlKTsVMSqPKfMamc4LpVhtYM9yNOX05v61XoqetCmhs/A
         31TNVEN70yRxMaRE2I2OBlAqeONheuTo33LMxxP5nvGeYazqtztSOtLVxNHs7Kks7XrW
         pVRlsbqK2PstGx/KI+odUI53AdaN+u8FjZ6pbngiB/lOE3j3T3pPRTpM/bsiosYtlHQm
         DX8TW0hKAhu+gHd1ZYv3wh+a8tnT4gLxADWvVNtBCx36oQafIFK7ZjvwfQuawQDTdLJq
         Dkrg==
X-Gm-Message-State: AJIora/2KGB3hhWOdSu73UImqFIWglxJP3MEuzyUTCFMoXShXPlIQAxV
        OUxLu1UAEEA2BrzTDHIfFKCZYDX3p8hYpIRWw8BpGjVVgYcx23Xgseug3/kxB8E/ySMMhV5mI3o
        K7hTgxzSD+hQCXfC4VmwbOC2W/YNzve/WazEtOgmU2Q==
X-Received: by 2002:a05:6402:1907:b0:435:c243:a66e with SMTP id e7-20020a056402190700b00435c243a66emr14848120edz.44.1656320015580;
        Mon, 27 Jun 2022 01:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sNHSVdtmZNUqbh6HEAFeSWdppkBk08VGF7GzfJ6T5jHtMcBxx0Ir+RtXruR6wV2wBKuoa6Rw==
X-Received: by 2002:a05:6402:1907:b0:435:c243:a66e with SMTP id e7-20020a056402190700b00435c243a66emr14848107edz.44.1656320015403;
        Mon, 27 Jun 2022 01:53:35 -0700 (PDT)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id el3-20020a056402360300b0043585bb803fsm7049090edb.25.2022.06.27.01.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 01:53:34 -0700 (PDT)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-gpio@vger.kernel.org
Cc:     Jianlong Huang <jianlong.huang@starfivetech.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: starfive: Serialize adding groups and functions
Date:   Mon, 27 Jun 2022 10:53:33 +0200
Message-Id: <20220627085333.1774396-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianlong Huang <jianlong.huang@starfivetech.com>

The pinctrl dt_node_to_map method may be called in parallel which leads
us to call pinconf_generic_add_group and pinconf_generic_add_function
in parallel. This is not supported though and leads to errors, so add a
mutex to serialize these calls.

Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/pinctrl/pinctrl-starfive.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-starfive.c b/drivers/pinctrl/pinctrl-starfive.c
index 2a86c1035cc8..3eb40e230d98 100644
--- a/drivers/pinctrl/pinctrl-starfive.c
+++ b/drivers/pinctrl/pinctrl-starfive.c
@@ -207,6 +207,7 @@ struct starfive_pinctrl {
 	void __iomem *base;
 	void __iomem *padctl;
 	struct pinctrl_dev *pctl;
+	struct mutex mutex; /* serialize adding groups and functions */
 };
 
 static inline unsigned int starfive_pin_to_gpio(const struct starfive_pinctrl *sfp,
@@ -522,6 +523,7 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	nmaps = 0;
 	ngroups = 0;
+	mutex_lock(&sfp->mutex);
 	for_each_child_of_node(np, child) {
 		int npins;
 		int i;
@@ -615,12 +617,14 @@ static int starfive_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	*maps = map;
 	*num_maps = nmaps;
+	mutex_unlock(&sfp->mutex);
 	return 0;
 
 put_child:
 	of_node_put(child);
 free_map:
 	pinctrl_utils_free_map(pctldev, map, nmaps);
+	mutex_unlock(&sfp->mutex);
 	return ret;
 }
 
@@ -1267,6 +1271,7 @@ static int starfive_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sfp);
 	sfp->gc.parent = dev;
 	raw_spin_lock_init(&sfp->lock);
+	mutex_init(&sfp->mutex);
 
 	ret = devm_pinctrl_register_and_init(dev, &starfive_desc, sfp, &sfp->pctl);
 	if (ret)
-- 
2.36.1

