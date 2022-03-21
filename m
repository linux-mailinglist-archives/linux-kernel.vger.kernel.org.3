Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08C44E24FB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245549AbiCULFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346637AbiCULFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:05:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD749E5F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:04:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93803B8123D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6729C340ED;
        Mon, 21 Mar 2022 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647860651;
        bh=xv2aUD6HBP3isQVHSLMnT4UgBzlt+JWeo9tqC6E6FeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dljCfzNcISII2jKwQy19CAVCK1Uho9WrYekVEraCeDrbKGwgfLPlXwhR5xjEnfxJ1
         2tsInS5oQpIIhbTBYgTFi9DzhYx1O2FUJ4c4DMmXnOA4DmWe0CC7FtkoAFJG3vF7l2
         nHdEIEcRsXL2eemPOlHdpo9LzGRzW5PKJtIveK4PbmzTtAoWsY3VL/HYvSv+S4EKb6
         xspMrEMTGT6cIltflK9DSE823D9PSwX8fe+fdxmxxGWJyFBbmglZh5/n9I9GNl/7Vc
         vuylBKrGASdaK6X7DhAj/d9Hx9iG/RdomDNN2M4PYNn9IwlS+gDEVYjQXmHwBZV62f
         voi+pRnWM8Evg==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/3] nvmem: sunplus-ocotp: drop useless probe confirmation
Date:   Mon, 21 Mar 2022 12:03:26 +0100
Message-Id: <20220321110326.44652-3-krzk@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220321110326.44652-1-krzk@kernel.org>
References: <20220321110326.44652-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

