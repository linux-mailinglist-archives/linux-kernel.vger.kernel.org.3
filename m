Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878AC5150E0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379220AbiD2QcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiD2Qbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14BEDA6DB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b19so11431324wrh.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxKWDdPeJSszfEeucG2we5seobARL3GADW6N1hKVnQg=;
        b=F+m2BX1PfLfgcsjPS6StmQGPm0KVXiOgrJOM3YVrl4fnSRDbR0WvBCkFLRxA8qjx5x
         0STv1ljFF/ClJ3jXwjaCI4hzB2dcigkIqdElO9EkeSr2jCr9Xw0Pl32NPC76l3TnCDsS
         pmfIu9AMTUbQ3NEUJLvDDo/bHWDyhk5OBfybOvX/i7JwfO/J8C0cHHQqgh+fqq0L051i
         PfNQ5by2l/AulaE3y+1fDghTHvWFW5oH0ITvCrwjPCglQcSOv/HH4YAjTS9umDXdSF0m
         P3MZXptsn7y+hkEnsINg4uIuQcnr2GOL2c4yNWs3DCoWi3CcWUZkL1bATZ1DTwUm/QqA
         qWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxKWDdPeJSszfEeucG2we5seobARL3GADW6N1hKVnQg=;
        b=4Ljrf/fOMSSH4/dLsQ0jtZX+ht57YRVaUcsIlL9mgMiQJ06RQ2enS2Fe/sbIbbIBoz
         JIbJRCwUpXzDc3ZGp1RpcIW1hXxcn8FwWIMbnwYfF5XyYiNPiuCwNl16y5m68bRkSQBA
         2iNNvQN1y6Emk83KW77DuTLKp14wM2TJ6ELNzRZEh9Kb4ZCe/wwBPwMke6TnHGAe6hD6
         T/l1gkjLD9+G9EM1mc6+sHgILCemUHZn0v/vK6An86wZll/a9hWuQ7mug1blrjdvMFRX
         lsmppnETntXFntIrcIV/jH+V4zSDdRb68J9SGCgrt/NxgIe3raseZqPw4g52MeJm1sWO
         +71w==
X-Gm-Message-State: AOAM531i74jzPWc2TZM5fAe0IiwdbIMdVFDCCsp97da7aYf9dhkMaVuB
        tCiWnfSu+PnTCeWJscOlPNwQHjaGGnEOqA==
X-Google-Smtp-Source: ABdhPJz0K2x+TKnWtFaKI/nX0V6SFQGvQDj+WlELbQZOXGA99cQTLMybn0YGE58/dM+9tcHHXHvQrA==
X-Received: by 2002:a05:6000:1e08:b0:20a:873f:13b3 with SMTP id bj8-20020a0560001e0800b0020a873f13b3mr29950222wrb.52.1651249692377;
        Fri, 29 Apr 2022 09:28:12 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:28:11 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 16/16] nvmem: sfp: Add support for TA 2.1 devices
Date:   Fri, 29 Apr 2022 17:27:01 +0100
Message-Id: <20220429162701.2222-17-srinivas.kandagatla@linaro.org>
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

From: Sean Anderson <sean.anderson@seco.com>

This adds support for Trust Architecture (TA) 2.1 devices to the SFP driver.
There are few differences between TA 2.1 and TA 3.0, especially for
read-only support, so just re-use the existing data.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/layerscape-sfp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/layerscape-sfp.c b/drivers/nvmem/layerscape-sfp.c
index 59083f048921..e2b424561949 100644
--- a/drivers/nvmem/layerscape-sfp.c
+++ b/drivers/nvmem/layerscape-sfp.c
@@ -78,12 +78,18 @@ static int layerscape_sfp_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(nvmem);
 }
 
+static const struct layerscape_sfp_data ls1021a_data = {
+	.size = 0x88,
+	.endian = REGMAP_ENDIAN_BIG,
+};
+
 static const struct layerscape_sfp_data ls1028a_data = {
 	.size = 0x88,
 	.endian = REGMAP_ENDIAN_LITTLE,
 };
 
 static const struct of_device_id layerscape_sfp_dt_ids[] = {
+	{ .compatible = "fsl,ls1021a-sfp", .data = &ls1021a_data },
 	{ .compatible = "fsl,ls1028a-sfp", .data = &ls1028a_data },
 	{},
 };
-- 
2.21.0

