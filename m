Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73A159C7A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbiHVSyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbiHVSyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:54:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34B82601
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:53:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u22so10728426plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GA3c/GZjUQaaitae2gW9tKtCQv1+a7TEeayxV3K4Hgw=;
        b=nohrL7qgMauyN3H6qU/Pcb9Zj1rjUJ5KPJQDupWnvb5otZfv18t9cnG5SlPjIOzgyz
         jXSeYoyn48NLHmSHqWAC3+mvaC5vuEB5pp37DTBXtnfhaTAsa3JOhzNaKd0OP53npl9P
         4CBgE6nr9Rxbq7XHZ/Vf77HEDBIaCpRhCYoqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GA3c/GZjUQaaitae2gW9tKtCQv1+a7TEeayxV3K4Hgw=;
        b=pGEaZRa+sXs1VCLv953VjR21d7q8Hq9nYZqalEsJ8fO3ri0r6cT2HOTsssRprX59NB
         wRfP6PSObqUFaQGgj+JcEuNcYJ4LYBmfDfCrTkVPw7iZf+nrVxraiAy4gxUe+viVwZz7
         M0eHVGuAW0b16hxRpo6AkBl8ey0nOUc0rWJiN2Nh0KrZL99lhX09im2Kawwqa7ixBkm+
         qh4sXZkfwC9WuyKWfwe328lWItczUd0ym7w5BOZTvPF70VWjbX7IDo8R/ZSix9qdNn9S
         BTKIcDUGTxLhYsLyNf85gKQdKFKYh91BLlGi28NIJu7E11NzXerKsPm04J4JJ6DNyJLP
         djCw==
X-Gm-Message-State: ACgBeo24oEhWCbssw0Gj/72DDSn181k8iK5KnhA430/R7XJ5eEknysas
        x6owcMsqfdbkjc9fxuCbEUuA1Q==
X-Google-Smtp-Source: AA6agR6IgcQdruU28Yk2u5gkyWvHVyZ/g3OywX3bEvdNobN795P5crDloxA6vR8K5z1yVfd5tjxC1Q==
X-Received: by 2002:a17:903:24e:b0:172:6c9d:14e0 with SMTP id j14-20020a170903024e00b001726c9d14e0mr21534899plh.84.1661194398373;
        Mon, 22 Aug 2022 11:53:18 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:1969:d650:d765:53ef])
        by smtp.gmail.com with UTF8SMTPSA id f184-20020a6238c1000000b00536b3fe1300sm2244190pfa.13.2022.08.22.11.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 11:53:18 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 2/2] clk: qcom: gcc-sc7280: Keep USB GDSC power domains on when USB wakeup is enabled
Date:   Mon, 22 Aug 2022 11:53:11 -0700
Message-Id: <20220822115246.2.If09027f73daa6e1ed95f5eab02326b543c67132e@changeid>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220822115246.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
References: <20220822115246.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set GENPD_FLAG_ACTIVE_WAKEUP for the USB GDSC power domains of SC7280.

Suggested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/clk/qcom/gcc-sc7280.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 7ff64d4d5920..4ff855269467 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -3125,6 +3125,7 @@ static struct gdsc gcc_usb30_prim_gdsc = {
 	.gdscr = 0xf004,
 	.pd = {
 		.name = "gcc_usb30_prim_gdsc",
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = VOTABLE,
@@ -3134,6 +3135,7 @@ static struct gdsc gcc_usb30_sec_gdsc = {
 	.gdscr = 0x9e004,
 	.pd = {
 		.name = "gcc_usb30_sec_gdsc",
+		.flags = GENPD_FLAG_ACTIVE_WAKEUP,
 	},
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = VOTABLE,
-- 
2.37.1.595.g718a3a8f04-goog

