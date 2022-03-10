Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448514D4767
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbiCJM4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242165AbiCJM4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:56:06 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F4314A058;
        Thu, 10 Mar 2022 04:55:04 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id r12so4785110pla.1;
        Thu, 10 Mar 2022 04:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LqKvOOJIsEkJ2EYAXsGvj44/+JSM7E7TqxfIavhRMMk=;
        b=IJoeHYMcb2qPcw4UZGlhhBR63cLCN0i3980ZRc0ENhA6FbnlNkiwbk1XXzoiEbgpAT
         F3WInVz46eJE7IPPL6e/YAdavRBhsA0rOBT6yhJmZ4e+ZrS+VV+zBa+saY58ODM8+SES
         c5Q4lP9pSGdsXyvQWBTuETNSNF748HTQDniKtQXhu2Mxq5cwJOB8bJr/pCl4QjHU7mDB
         j0zcDyIajMbNhj6AVnYMdnWjUgPaH/Na4A3130hy8RTCcIrBcFEkLOEV08tZezfQqbkU
         ti8R1EFNFTgM3k94lG9jhfCJrtPNJhDzXH0+o/Ksgl6684+OTvq6PuzE2RcJMDbIos+C
         fcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LqKvOOJIsEkJ2EYAXsGvj44/+JSM7E7TqxfIavhRMMk=;
        b=nE0wee2qnjADfEPbG8zQvOyj83zB9H7EK+FlaJqqEoxTSRnyeqGqrRdpEAczcEuFHE
         9V8WnsFF3roP7+5uFP7Pd6Ty1N3f1kLDVTi0hh3/3x8Fqc0t557/rMh+IPpuoMPxwnU1
         Q4niORJyVJyqnbhfsLU9BoXl6gXrPnVGNvJw70BUd0SB3go9wp1l/cHRz8dyAkPBjotB
         8blvlH9oQ99F2vLMgC4CNV0w+H5xC+/MLYpdYV0umoUEPSmfZZXk1mGz3W/1QvZtDF7k
         I8E6GXWsscm+G84vzeY6LJf3BAA+HQAt04N4QsQdne3Mr0HHdnZI5sIAlTohmSwQd0ZW
         IkSA==
X-Gm-Message-State: AOAM530jWfphAgE3Dk38TvUZaeDKk5hdBYlfjRnWnmx1r4eezhLEFGkr
        U8rG2ydE+x2CXc0W4t+22kYeKVyc2R/O0Tq2dn0=
X-Google-Smtp-Source: ABdhPJyZZCuUrQ4jvZncbPFQwRSOLywswNTEIfEXGZie0hGvBEhX7D+iEbgpPfWl9k5kD287FDNsPQ==
X-Received: by 2002:a17:90a:7027:b0:1bf:6ae4:f19e with SMTP id f36-20020a17090a702700b001bf6ae4f19emr4861172pjk.39.1646916903575;
        Thu, 10 Mar 2022 04:55:03 -0800 (PST)
Received: from localhost.localdomain (hwsrv-462136.hostwindsdns.com. [2607:5501:3000:c81::2])
        by smtp.gmail.com with ESMTPSA id c14-20020a056a00248e00b004f77e0fbfc0sm2203946pfv.185.2022.03.10.04.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 04:55:03 -0800 (PST)
From:   Zizhuang Deng <sunsetdzz@gmail.com>
To:     Jonathan.Cameron@huawei.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Zizhuang Deng <sunsetdzz@gmail.com>
Subject: [PATCH] iio: dac: ad5592r: Fix the missing return value.
Date:   Thu, 10 Mar 2022 20:54:50 +0800
Message-Id: <20220310125450.4164164-1-sunsetdzz@gmail.com>
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

The third call to `fwnode_property_read_u32` did not record
the return value, resulting in `channel_offstate` possibly
being assigned the wrong value.

Signed-off-by: Zizhuang Deng <sunsetdzz@gmail.com>
---
 drivers/iio/dac/ad5592r-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index a424b7220b61..4434c1b2a322 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -522,7 +522,7 @@ static int ad5592r_alloc_channels(struct iio_dev *iio_dev)
 		if (!ret)
 			st->channel_modes[reg] = tmp;
 
-		fwnode_property_read_u32(child, "adi,off-state", &tmp);
+		ret = fwnode_property_read_u32(child, "adi,off-state", &tmp);
 		if (!ret)
 			st->channel_offstate[reg] = tmp;
 	}
-- 
2.25.1

