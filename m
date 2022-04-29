Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770155150D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379159AbiD2Qbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379118AbiD2QbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A536D95ED
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:02 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t6so11478492wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9L3uMLDD1NekAOzWxjVzgekMM2ZB8pgbD0zH/lCgA3Y=;
        b=eU7WKCkMMDPe/RDCGg8/9raNfZ+VbHtr0YEhI4Dw7ohPsWwZH7TtV8CjANqVFfoB+I
         8pD3Q8cWU+SYm/FeKnHTJu1ziCF88SIo04o90hUtuhkEIG+8ui6Ie30oyTT27V+FAMUh
         5u16NAdaT7k934Yc7XSNz8SEVnkxuieVqMQUXrb38NVIAXI9wnmAUeUfhtYqjww7H++o
         YSzU+aTT24ozVIiODKXCXD/Nm2ubmhjy/QpkgIsg71qgbb19biQFtldm6fidDefsVSXL
         NIk7+dmS0xs/eMx7sGKzhskAaSFHFFE6Rcg4RV9sfNtAEiCq2VZWLCepFjq2mXl+UX9F
         SCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9L3uMLDD1NekAOzWxjVzgekMM2ZB8pgbD0zH/lCgA3Y=;
        b=DNv6IwnUU15hJTVQFx44om+TqkDzjfrpMp5tiuF4q/W3ukOs4uFPpOQ5+C8Pim2A8d
         7C3Ytve7Liavt4mQFrD53MZw4EdFCzcr2PXX5vGRpbPJ3xlk9P+TjobQpHEDzol5p2T3
         X3PPF8U8kYYfwWrD9zWZhnYj+yOYRTH25004HSC854pgTS1fzTBDhATUXbk3llq/55sg
         Rbq8oQu8RzYCj1dVIqd/TohYlcpmqZIIjw9v4QQpfqpTvugjVgekadnNw43ETHvd9keP
         dwROQR3pQIC2f5eY/1Ly00oAIY/cRD3JAAY+HCYbviWD0zhAkpp/X25LiZzOXRQyyJ0+
         bPig==
X-Gm-Message-State: AOAM53148XVO5tOq5v/1ll60jIToqo2E/nJoY56BfgAJTju+6slRE1hl
        gTGWBMdD7klZrmspneebluyEgw==
X-Google-Smtp-Source: ABdhPJz8C4bE25s4Hbbz1S65VBmc1+8ge9DJRkv2dMQ3T97TAbqxeZwnrlUF57Aot9ueSu4/c1pr9g==
X-Received: by 2002:a05:6000:12c7:b0:20a:e00f:da73 with SMTP id l7-20020a05600012c700b0020ae00fda73mr18655912wrx.613.1651249681070;
        Fri, 29 Apr 2022 09:28:01 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:28:00 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/16] nvmem: sunplus-ocotp: drop useless probe confirmation
Date:   Fri, 29 Apr 2022 17:26:52 +0100
Message-Id: <20220429162701.2222-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
References: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunplus-ocotp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
index 2dc59c22eb55..81aba80bdd10 100644
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
2.21.0

