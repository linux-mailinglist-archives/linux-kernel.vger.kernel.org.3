Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5552D724
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbiESPMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240491AbiESPMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:12:24 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4525D6832
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:12:23 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z18so6084588iob.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9qaIWyA9uNywpEUw7kTE6d95X5zg1e5QyGsV1unQNs=;
        b=okV+OY5euXuUWRW1si2pG28tdFBUY7vhVb7WYWnyrGBhrNVAfcSFvDfG0qlYQIEhGD
         K7nXTFzPiRehg7ZsJRAKzE1jJYVJA+5b4TAqntjRrez/WEp2OUHPdKvrzCu1LIqa0/RQ
         GBfDLdLf/Ah+UqEKu2q1WVB7NXr63FvFbWOthjXzPxFYOyeBjGfRLLXdfrJP2Y/7ETvk
         SKx6CdZnHBaHOrXKl5IZih/VnQIny+PHcYfbZM1N473MMpmbbmpBrRauCcQWCPQCyYPr
         ArOtrFR7VNavyBLKQpeslg0qNDK1Waw41/LAQcV6QY0+vJr+zrkLiPhW+iVN+qLhlH2m
         dvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9qaIWyA9uNywpEUw7kTE6d95X5zg1e5QyGsV1unQNs=;
        b=i2Knzv6ZaFvZwX3O1dUbzLMbqWEfwI3h4vNllC1yvKLs/fPu2HpWREWb4n2RZYR8LV
         zRo51CD7YFJ1XURPrlP7QL9TXeCPO8A++xsh2P8HuR5VtZy0V/sWAbzoka9CLGOe/mq9
         HurfxBbhUGHQ4AicZqhV68LC46lar55u0NqW7kXelIXQVKDeh/dGrGVEEO0c90w8V6qE
         +48XLV2ZGxCZmL+HxDR03VVrqICwZ7OoSJXLYblU68kWgROQPm6QOn+ujYI4XUcJjLjK
         IL0/jtzAD0C4y5ISvLGoVk3hni0G4hYEAjsL+W1QoBgRdPVq/2xdc2bEP5CdRNJ/buM9
         6ZXA==
X-Gm-Message-State: AOAM532OAZ5WvxtyQSlaEU4gJL3iV9bfDtR4ibxo+JppWFtCTM8htD4D
        26AI/RskrDnXvrTUCMi6KDGdnA==
X-Google-Smtp-Source: ABdhPJyl/3ypaRK71Jb3RHvfLfN5sSszW8m9VQgGjTht5UuB8uGREUs/faTrM+Qt+UxtZOZhzTCiiQ==
X-Received: by 2002:a05:6602:2c4b:b0:65a:c92a:d3eb with SMTP id x11-20020a0566022c4b00b0065ac92ad3ebmr2688164iov.138.1652973143233;
        Thu, 19 May 2022 08:12:23 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id g6-20020a025b06000000b0032e271a558csm683887jab.168.2022.05.19.08.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 08:12:22 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/7] net: ipa: rename a GSI error code
Date:   Thu, 19 May 2022 10:12:12 -0500
Message-Id: <20220519151217.654890-3-elder@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220519151217.654890-1-elder@linaro.org>
References: <20220519151217.654890-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CHANNEL_NOT_RUNNING error condition has been generalized, so
rename it to be INCORRECT_CHANNEL_STATE.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c     | 6 +++---
 drivers/net/ipa/gsi_reg.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 5eb30113974cd..d47ba16465d29 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1179,15 +1179,15 @@ static void gsi_isr_gp_int1(struct gsi *gsi)
 	 * Similarly, we could get an error back when updating flow control
 	 * on a channel because it's not in the proper state.
 	 *
-	 * In either case, we silently ignore a CHANNEL_NOT_RUNNING error
-	 * if we receive it.
+	 * In either case, we silently ignore a INCORRECT_CHANNEL_STATE
+	 * error if we receive it.
 	 */
 	val = ioread32(gsi->virt + GSI_CNTXT_SCRATCH_0_OFFSET);
 	result = u32_get_bits(val, GENERIC_EE_RESULT_FMASK);
 
 	switch (result) {
 	case GENERIC_EE_SUCCESS:
-	case GENERIC_EE_CHANNEL_NOT_RUNNING:
+	case GENERIC_EE_INCORRECT_CHANNEL_STATE:
 		gsi->result = 0;
 		break;
 
diff --git a/drivers/net/ipa/gsi_reg.h b/drivers/net/ipa/gsi_reg.h
index 8906f4381032e..5bd8b31656d30 100644
--- a/drivers/net/ipa/gsi_reg.h
+++ b/drivers/net/ipa/gsi_reg.h
@@ -515,7 +515,7 @@ enum gsi_err_type {
 /** enum gsi_generic_ee_result - GENERIC_EE_RESULT field values in SCRATCH_0 */
 enum gsi_generic_ee_result {
 	GENERIC_EE_SUCCESS			= 0x1,
-	GENERIC_EE_CHANNEL_NOT_RUNNING		= 0x2,
+	GENERIC_EE_INCORRECT_CHANNEL_STATE	= 0x2,
 	GENERIC_EE_INCORRECT_DIRECTION		= 0x3,
 	GENERIC_EE_INCORRECT_CHANNEL_TYPE	= 0x4,
 	GENERIC_EE_INCORRECT_CHANNEL		= 0x5,
-- 
2.32.0

