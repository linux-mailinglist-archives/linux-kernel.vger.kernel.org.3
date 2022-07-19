Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A7B57A1F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239461AbiGSOki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbiGSOj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:39:59 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E1F54ADA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:36:00 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id n7so11925630ioo.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zRHK405baFW2UdcNvF1Ri8j6v7h1hezBx9diOW60tXw=;
        b=EcNyCwlgGsDJIOtNW/Ss1NOraStXKkldrA+XkALRjahcB3N8Pn4slgW8OT1YUICsNb
         zAMUE0EQhGd08tsdqZWKWCG5Zl7dR322RIbUsHxVfRkGHA1qQ+eiJh91uusj59tOgQ9h
         0sX/5MECKAwoyBmb0xUCwETEbwnEfnaUgSEgVPUcagNEQ3zKaUANvS4C3CGlPBvEVTUf
         opQ8DjxVkGm4lZTxQLoDqRdpqX8d131HraMlGKKf0V4oxwLbKoFm8N3l9iXCaz3N57xd
         tHlQ8SW8jrIT9d6zL6a5Ix58mAUu8T7W5D619gjQxL1N67CYV59zMWNSRQ4Zjjq/sgqw
         LpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zRHK405baFW2UdcNvF1Ri8j6v7h1hezBx9diOW60tXw=;
        b=xSahEW2aoAoOgUZcTuzB3bhMzvfE9mdr7F9iaw2fgDUMfbdtYeud9w5nUKAOAQ17k/
         Dv/TRB5P1DLUgnXTLzpxNZhQ90fjuH495M2Sku/UnKKe+Y+xbjP5WQfiGDqyuGb/Wnl/
         lt35jf/tSB/0loO24OxjqWJ/TTLlcBZMvTFe+merS7XC6Hunj/COWSXu63PBUgXSITXe
         keRvhRMQIMWEFwyg4Er9N3VIuP/zDLAoW/0A70jTzRgCcmL30L/aNGAvFrPY7vcxchvA
         ayVMi2v8yFxAvg9GFU69gyb2I/G/Ccu7KT7QnBSnNULfOS8NacWMzraNtIqZXWqwdYlS
         MfJw==
X-Gm-Message-State: AJIora8vb3jU3klhxFDiXcsZlkvi+1ofyeMyFT9y8H5dD/2iHCgYFzdW
        4RJOl7ibOnIwYqm3HtOcuOszhw==
X-Google-Smtp-Source: AGRyM1vxDr8gJG9uMO8WLs45XDR00G3/awtshi9ngzhp9qVf7XyXJaFk6+Au25UO+/mHtTIWSkp8YQ==
X-Received: by 2002:a6b:3fd6:0:b0:67b:d97f:47d3 with SMTP id m205-20020a6b3fd6000000b0067bd97f47d3mr11241017ioa.46.1658241360312;
        Tue, 19 Jul 2022 07:36:00 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id t16-20020a056602141000b00675a83bc1e3sm7286559iov.13.2022.07.19.07.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:35:59 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
        quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
        elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/5] net: ipa: skip some cleanup for unused transactions
Date:   Tue, 19 Jul 2022 09:35:51 -0500
Message-Id: <20220719143553.280908-4-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719143553.280908-1-elder@linaro.org>
References: <20220719143553.280908-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gsi_trans_free(), there's no point in ipa_gsi_trans_release() if
a transaction is unused.  No used TREs means no IPA layer resources
to clean up.  So only call ipa_gsi_trans_release() if at least one
TRE was used.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi_trans.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index b17f7b5a498be..b298ca7968907 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -404,7 +404,8 @@ void gsi_trans_free(struct gsi_trans *trans)
 	if (!last)
 		return;
 
-	ipa_gsi_trans_release(trans);
+	if (trans->used_count)
+		ipa_gsi_trans_release(trans);
 
 	/* Releasing the reserved TREs implicitly frees the sgl[] and
 	 * (if present) info[] arrays, plus the transaction itself.
-- 
2.34.1

