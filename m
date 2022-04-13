Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246734FF5D5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiDMLkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbiDMLkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:40:36 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60515B3E6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:38:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bv19so3343999ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/zaNNAJ+480JiKojnpkVOuaK1VF8i4bh+T0L8gYvyZQ=;
        b=THmxtERv0MjO9uAtwMhvtpGizFEXaf9gcgsPDWCM7Ag0p+vOjaOtFG2bOmwnmaEFlu
         lIIHnAtggdLgYL0RMZSL8FOkE8mFFw3+UgGRFzdlItlN6h+MwYIZlANfVfzFjZSwBbxE
         Z/0iVZHL2qS/yWX4w+0sgkMi4TPXatSZAW7Co+zwi7i6AzrGsjdJf+qStdcKDbCI3i6D
         8oTo+2Px66l7WfuSo5kJDqgUwvoQUFdahnboVxlRKPsWMJRGXqB57Zr57TfkKs2YR4Vl
         iqYV0twBxEz6TiFs42Sdzt2jyGQ4I/WFeTLSEwnmPYKPP/mknjib420naNglppW72ATp
         /eWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/zaNNAJ+480JiKojnpkVOuaK1VF8i4bh+T0L8gYvyZQ=;
        b=QuFS8Hm5Ucx7yYnmHP77J6G6/2RoRXJYFlNhiK/iINk8kShM7nqUh1KwNdSF03NM6M
         eHuouc2uUJU4uEnlvnmGgzP9IVfUcvsxYd6Dtkik8qigtmkyEbG+TSysHaIO15QdL4Be
         caeBkWEVnMTj/tEcK0Hn5hPKZmVsLOxKvohVZLxXugjMyRN4c0uGQMr37WHEIoJ2ZTh+
         F5YeNkHUlhb72zUDZYjxQSlSV8hgfWuxevuZuRjklXkZQ+7/a1ne5/hBig6nisncMZ7m
         EZtauIGkwCHoisQkIdtMXSZaR1U87hXJG3DgO/uCS675nGF4upGVUDfkJ6MVxTANHRt/
         pyow==
X-Gm-Message-State: AOAM531iW2Z9YEGRnJtwlZJyOjxGKBEP2B/8Bmfn+smSnTYP129SGAai
        uPOr72JhDh79Q/ytP2gcYhzhofXLiJz1uGyd
X-Google-Smtp-Source: ABdhPJxqMsV6/694dW65704kt79sdj3/9QW8CBjvpEwzSXnyFBBq4y0sPehPl8Xcsi/iDPU9tYOyAg==
X-Received: by 2002:a17:906:d54b:b0:6e7:f185:18d5 with SMTP id cr11-20020a170906d54b00b006e7f18518d5mr40984484ejc.155.1649849894489;
        Wed, 13 Apr 2022 04:38:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id cb25-20020a170906a45900b006e87e5f9c4asm4452783ejb.140.2022.04.13.04.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 04:38:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH 3/3] nvmem: sunplus-ocotp: drop useless probe confirmation
Date:   Wed, 13 Apr 2022 13:38:09 +0200
Message-Id: <20220413113809.243288-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220413113809.243288-1-krzysztof.kozlowski@linaro.org>
References: <20220413113809.243288-1-krzysztof.kozlowski@linaro.org>
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

From: Krzysztof Kozlowski <krzk@kernel.org>

Printing probe success is discouraged, because we can use tracing for
this purpose.  Remove useless print message after Sunplus OCOTP driver
probe.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/nvmem/sunplus-ocotp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
index c94134649714..52b928a7a6d5 100644
--- a/drivers/nvmem/sunplus-ocotp.c
+++ b/drivers/nvmem/sunplus-ocotp.c
@@ -202,8 +202,6 @@ static int sp_ocotp_probe(struct platform_device *pdev)
 		(int)QAC628_OTP_NUM_BANKS, (int)OTP_WORDS_PER_BANK,
 		(int)OTP_WORD_SIZE, (int)QAC628_OTP_SIZE);
 
-	dev_info(dev, "by Sunplus (C) 2020");
-
 	return 0;
 }
 
-- 
2.32.0

