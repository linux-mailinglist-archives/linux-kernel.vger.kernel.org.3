Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16902588598
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiHCB5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiHCB5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:57:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C882D564CC;
        Tue,  2 Aug 2022 18:57:30 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id d7so10824617pgc.13;
        Tue, 02 Aug 2022 18:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JvSizfg9rJurRHFe1HvtMoLl3ryLwF2DPEDaLcO0/zg=;
        b=ivdtrHns+qdUJaUgXx3t2P7lZGTBdEX1hlhws6XHpUGBCfVMrXX7huC8Lv/xUAxtRp
         AD1igNZ/8vDhAPBHlOUHD+QnVHiolcFmcHc3ICtLufr7q8IflijouagXnSv8dSvjjSQG
         8UNCIOPvGJEAGq2t//QIkucSL1XTmuwyE8HZUFhvAVnDCpquuJZhl9Re47vGCY0pr1Ql
         2J9kr5flMjtWdOAqng4egtK455H590P/Phb0vRyJ73dfEJX3QSS3M3X9OTg0uHxv4GtX
         m6wypXfUKagVzdPCxt4V2zL4kQGOz/JS/RJJsCggRWWquHEFna6pi3qqpjgc0AOVsjWG
         0ltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JvSizfg9rJurRHFe1HvtMoLl3ryLwF2DPEDaLcO0/zg=;
        b=VHLoj9VqFTfTY00gD6veEP5pUOUJCA1JYMBUa2QTVI9/k1N5tfGmq/q8LQObFeAImQ
         EOMZ4HN/ila5v8Q5j3B+v4pXWkxG+SrLuHbfpn1LUHzD49VecMozTOTEjdA2v6CNU9fg
         WIzJPZR5OCzW/CpFUGO1RBGLrsxwp2HjSxhO6pNR1JkBIMNApVbu3S23OJ+ph/z/jqYJ
         9dsHdRB1K1oAlWb5Vk6cKkUC9hS9QZUg9l5XDpfiZWNS684FbsRT7qjOkSnOsf43rgP3
         t1HF4r1w4IcRXEQ4Y1TIuaDO5AJ3nbzaai5eZUjjXKJR1bqeHT1B8NaWlnD36Ftmkq46
         NU2g==
X-Gm-Message-State: AJIora9jIFdrTNMpU/UHGYso+aMkwiqL33t3Arx0WR5mxbdqb3ma5Iy9
        LanbxMm3nSZJMtNvKRdbOSs9CykjEpX6KWSwiGs=
X-Google-Smtp-Source: AGRyM1sY77TjWlF1i2ByBC3xgp/87vLfOLXiuHQrp4k9tseD3xnMSO4Z83+L/NTDtMIkfSyHppRzZg==
X-Received: by 2002:a63:4d65:0:b0:419:d6ae:27df with SMTP id n37-20020a634d65000000b00419d6ae27dfmr19545911pgl.179.1659491850275;
        Tue, 02 Aug 2022 18:57:30 -0700 (PDT)
Received: from localhost.localdomain ([170.178.188.167])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902650a00b0016a33177d3csm378157plk.160.2022.08.02.18.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 18:57:29 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v1] pinctrl: qcom: sm8250: Fix PDC map
Date:   Wed,  3 Aug 2022 09:56:45 +0800
Message-Id: <20220803015645.22388-1-lujianhua000@gmail.com>
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

Fix the PDC mapping for SM8250, gpio39 is mapped to irq73(not irq37).

Fixes: b41efeed507a("pinctrl: qcom: sm8250: Specify PDC map.")
Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---

Changes in v1:
- fixes typo error(mapped target is irq, not gpio).

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

