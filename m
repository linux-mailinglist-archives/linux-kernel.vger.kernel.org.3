Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60ADD50C85A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 10:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiDWI5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 04:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiDWI45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 04:56:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28767203F67;
        Sat, 23 Apr 2022 01:54:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h11so12237183ljb.2;
        Sat, 23 Apr 2022 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KL+1rLs6IeZIDUEirIkSF1eye+etiWXqoXEgr8jLdh4=;
        b=nU2jsDFjt0G4SgxxUcRbkQLR3psE2wMl2sh2AOByKRH5XuigWBxbAUFCT+CW7mFH54
         ES115CsxEAHz6kYPnX2ObYrLa9gBSWXTqn9/Km9gzL/kltvG0PsxL8j91gVzmV3Yh2na
         MgiuNEYeca/B22PjkMu7+gL2na6qqU9H2sf7Im6cIJuFDbyw/S/GgFwv/1WJ3HvAne6r
         kzaUa4Om1y0xsRoeEhJ3Xr3nlG2F8dDNEWnqMQEmVPt17EeNpVNiH2XiKcAsLAzawEhU
         sgVJhp+cJmpZUd+oq/+u2hxbl1LLxwp7Z2VfwLl2onZiG2761VRlj/oPGq42wS3IAaYl
         /cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KL+1rLs6IeZIDUEirIkSF1eye+etiWXqoXEgr8jLdh4=;
        b=AXhflYfpNYwlpTm8S2GeQ6IWwhQvphtKCaQhT9Y18QQDCaVYZwLV/NCaw7ksTweqpn
         z8ruTJ5w6vpVVmFgfvXX44pvMEoPcVu7IzgNR7yr8thb2ICGri9uBhmSBRAou2HoA+dR
         +xlnAWbc1nslAo8m0MJmN/wGk0uMLVDHFidcBp45cZ43BAdq/rWB90WyPvMQYoqcLIGc
         /Jyi+sgJNAOGP2VGn3ZAMI4T40a6cAZ9bOwF0ISXNB6fIWtfFFag1j6/Z6s68K9KvEgb
         WFWlQHHenesAWEzZg6dbuSHsSOB8Pq23DV2fMi2eAZkSFLrxVOHq0SNXvmdIUFo2pK6b
         AX5Q==
X-Gm-Message-State: AOAM530cA+RAcQV1rDVQP+FHV7hH+sBzhCwvs1yQ0ynVWX+eS2A4rn+W
        p7dcVO9ukBqSOlxMbjFXfEZtAwEhlwk=
X-Google-Smtp-Source: ABdhPJwBjfH9QrWr+q+iXFYWN2I8Bv5K282QJnG2IE3D5WwijVQ5HlRXoqj7yErDrNzUEF1Ihh6tMg==
X-Received: by 2002:a2e:9583:0:b0:24f:482:e1cd with SMTP id w3-20020a2e9583000000b0024f0482e1cdmr1389648ljh.22.1650704039247;
        Sat, 23 Apr 2022 01:53:59 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id p25-20020a2e9a99000000b0024dc3ccff47sm493677lji.32.2022.04.23.01.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 01:53:58 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v5 1/5] extcon: sm5502: Clarify SM5703's i2c device ID
Date:   Sat, 23 Apr 2022 11:53:14 +0300
Message-Id: <20220423085319.483524-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220423085319.483524-1-markuss.broks@gmail.com>
References: <20220423085319.483524-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While SM5502 and SM5504 are purely micro USB switching
circuits, SM5703 is a multi-function device which has multiple
modules in it. Change the i2c_device_id of it to avoid conflict
with MFD driver.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/extcon/extcon-sm5502.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index 17a40c3782ee..f706f5288257 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -831,7 +831,7 @@ static SIMPLE_DEV_PM_OPS(sm5502_muic_pm_ops,
 static const struct i2c_device_id sm5502_i2c_id[] = {
 	{ "sm5502", (kernel_ulong_t)&sm5502_data },
 	{ "sm5504", (kernel_ulong_t)&sm5504_data },
-	{ "sm5703", (kernel_ulong_t)&sm5502_data },
+	{ "sm5703-muic", (kernel_ulong_t)&sm5502_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sm5502_i2c_id);
-- 
2.35.1

