Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CBC4BD382
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245428AbiBUCDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:03:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbiBUCDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 21:03:53 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F6E3616C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 18:03:31 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id f19so28203331qvb.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 18:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IfnVO7g/7CxNyjGwJs8ebOgPHTkowomqY0vYzJnQWEU=;
        b=YxyzZV7Ag9r/75/hPkMlxBZKN1rdYRDbkqra+lJ+le34W3Q5rwmQTGZyIf77lM1l8d
         8AQ1GX/RDHXZbWhA07H7FCi4zq3ez3izY2z10YpcR5KVZRR/Yb3ZCA3hcwHXTNQh5qMV
         jIcTYUuTc1LEcxW+RWsOmP3UDVf+KVBSSGiVvpVHFX4h9uNlrJHTXnGQEVibPrFB4wWI
         iFDOYrdYt3/2CY6FJo+WEG6YtYOFkIgh+F4VqXYdrzojflPJyqir2iMpLE6Y+gYvKaql
         gljZJLM/f5UyV93jUlmjSOerjuFh9F9FvicFYzRqZmDQKSbkJ0z/0gly9AE1I/E2V0YP
         weWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IfnVO7g/7CxNyjGwJs8ebOgPHTkowomqY0vYzJnQWEU=;
        b=c/ZJwBtrNOoFg9qQZ8ebPZBRGLuMcQJaZKonyVum4X5cTA8dzq1DAxrsHQdBDVInvQ
         2bkVHtUso18yfYX8ORk8+37GiVwRuXyhJQRSBaGmm6UPKcrgo8u1J0jHg6ae5tEO6H67
         kPpajsdWiUi++HNOi+6WEHlldEyGkk+J4CCR+H4PNaeIdkqrbOAskOYjks2ojKbTCfNK
         ZnApb7fx1/4h8Jhg5p/+RfeLD7qmjPopo+bXhlEqBtFOWXiEyWQwFHP5XMqk3Qw+N4Qo
         NVZVTazKg4APhyW1yB3fu+eva2LSsDqT+RxE26wtTasLzLGHTn2GkLcWtUSqNc81wvo3
         QBVQ==
X-Gm-Message-State: AOAM5333SKvnXiexlnWQjeLYuSAJperE1lFM7xy+991Ewltd230UflKa
        Tq1lsLXJkS6TwXlF90fuTfw=
X-Google-Smtp-Source: ABdhPJxKoVUYoG24d5EjClZyQdLEGq9z9gFN3oVKJvpQFPtE4bTKdHpZUX9MNAf19i9XBrjLu3hkPQ==
X-Received: by 2002:a05:622a:1041:b0:2de:332:fe28 with SMTP id f1-20020a05622a104100b002de0332fe28mr5793243qte.141.1645409010597;
        Sun, 20 Feb 2022 18:03:30 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v19sm26617207qkp.131.2022.02.20.18.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 18:03:30 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     oss@buserror.net
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] platforms/83xx: Use of_device_get_match_data()
Date:   Mon, 21 Feb 2022 02:03:23 +0000
Message-Id: <20220221020323.1925215-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 arch/powerpc/platforms/83xx/suspend.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/suspend.c b/arch/powerpc/platforms/83xx/suspend.c
index bb147d34d4a6..9ae9268b683c 100644
--- a/arch/powerpc/platforms/83xx/suspend.c
+++ b/arch/powerpc/platforms/83xx/suspend.c
@@ -322,17 +322,12 @@ static const struct platform_suspend_ops mpc83xx_suspend_ops = {
 static const struct of_device_id pmc_match[];
 static int pmc_probe(struct platform_device *ofdev)
 {
-	const struct of_device_id *match;
 	struct device_node *np = ofdev->dev.of_node;
 	struct resource res;
 	const struct pmc_type *type;
 	int ret = 0;
 
-	match = of_match_device(pmc_match, &ofdev->dev);
-	if (!match)
-		return -EINVAL;
-
-	type = match->data;
+	type = of_device_get_match_data(&ofdev->dev);
 
 	if (!of_device_is_available(np))
 		return -ENODEV;
-- 
2.25.1

