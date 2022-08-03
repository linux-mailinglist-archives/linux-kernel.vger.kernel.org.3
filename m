Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB152588530
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiHCAyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiHCAyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:54:21 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14BA4C611;
        Tue,  2 Aug 2022 17:54:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 12so13799441pga.1;
        Tue, 02 Aug 2022 17:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zE3Wm1yzV7Ang77xNzXX9+GA41v2UvMCOejZS/f/X2A=;
        b=L9iMaKB+nFcO8485ZEG5NWE/P8Tc6x1p+jSyrU2ckQVFLIUvCT7vA/dGyrSWHVq0EA
         E1plZMEpUOK4IuXUOqpHTpCCmlDnmJashOVixbpPZ/QOFUD540nBYwgAmm/zX/3Svg5a
         cxOuOPWQOIXKMXM69jjzRkx1ujFXIkn1Ms2C4h7kTXl18LhMc+MUKhjYWX657x6ePqLN
         lf1MOfGRpIrhjlhgDLwZqMdVPjwQ3ydPpdDroIepsDZ0IfvU1XoUDIdsMMiPvWoiK2PE
         uAynOXS11mQg35PwGCt4DtiuvlcSKy5dZTkV4Emwj3ipeI5DFr7DLX9oDkLV/PbR0L4+
         WEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zE3Wm1yzV7Ang77xNzXX9+GA41v2UvMCOejZS/f/X2A=;
        b=GrdZEgurOvZBlmXKIsTWtNgyfpyT+kRrc+/5EB6tt2PNi5wGPLzjzY+Z8ebXZ4loXP
         ZCHCRi50H/N7G3Iv9iwXASnGWSZSf1JI4awc2+uftYasEymEsQAASW9280ET21IJ/Omx
         rm5P90j1/3l5O8wFcpWPQrWxbjILtvIbWPAKEFplEhNZGKIi7OSeRGohFUyavDYpy+Nh
         wuFCOnTxvX/w9cONDT8xFviQk8Rdns+hthnM4eNvac6l5IF22sBYU8YHe2vuXVJ87QyK
         vC3GYZHhJ9nXNhN5YdYDFH8qHbf5t7WiJBPcWc69c28kynkwDVfRc5LTGmkN5t1ThHIs
         0Jyg==
X-Gm-Message-State: AJIora/DlkmYVFGLquz/lI97b4gNWllIOtu2y7Af2P9FzVHtmJxNtoml
        y5RO05E/SHr2uzP895VRxsY=
X-Google-Smtp-Source: AGRyM1v/3BZM8/LgLQaADjBGs8SZC+QRNTrENmRzfpAyAnqr8vSjFwqyXTZ16ws5ss5DKC8kY2jS3Q==
X-Received: by 2002:a63:214b:0:b0:40d:d4d2:2b5e with SMTP id s11-20020a63214b000000b0040dd4d22b5emr19281144pgm.531.1659488060189;
        Tue, 02 Aug 2022 17:54:20 -0700 (PDT)
Received: from localhost.localdomain ([170.178.188.167])
        by smtp.gmail.com with ESMTPSA id h15-20020a056a00000f00b005255f5d8f9fsm4768596pfk.112.2022.08.02.17.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 17:54:19 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH] pinctrl: qcom: sm8250: Fix PDC map
Date:   Wed,  3 Aug 2022 08:53:33 +0800
Message-Id: <20220803005333.14870-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the PDC mapping for SM8250, gpio39 is mapped to gpio73(not gpio37).

Fixes: b41efeed507a("pinctrl: qcom: sm8250: Specify PDC map.")
Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 drivers/pinctrl/qcom/pinctrl-sm8250.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250.c b/drivers/pinctrl/qcom/pinctrl-sm8250.c
index af144e724bd9..3bd7f9fedcc3 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8250.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8250.c
@@ -1316,7 +1316,7 @@ static const struct msm_pingroup sm8250_groups[] = {
 static const struct msm_gpio_wakeirq_map sm8250_pdc_map[] = {
 	{ 0, 79 }, { 1, 84 }, { 2, 80 }, { 3, 82 }, { 4, 107 }, { 7, 43 },
 	{ 11, 42 }, { 14, 44 }, { 15, 52 }, { 19, 67 }, { 23, 68 }, { 24, 105 },
-	{ 27, 92 }, { 28, 106 }, { 31, 69 }, { 35, 70 }, { 39, 37 },
+	{ 27, 92 }, { 28, 106 }, { 31, 69 }, { 35, 70 }, { 39, 73 },
 	{ 40, 108 }, { 43, 71 }, { 45, 72 }, { 47, 83 }, { 51, 74 }, { 55, 77 },
 	{ 59, 78 }, { 63, 75 }, { 64, 81 }, { 65, 87 }, { 66, 88 }, { 67, 89 },
 	{ 68, 54 }, { 70, 85 }, { 77, 46 }, { 80, 90 }, { 81, 91 }, { 83, 97 },
-- 
2.35.1

