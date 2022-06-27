Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263C455D1CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241936AbiF0XTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241627AbiF0XRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:17:22 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E173523BC4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:17:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso11135521pjz.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UfpGy5tAS73+sWM9gF7ZBJ3p3zHT7pkTPz/eUsHxpcI=;
        b=dcaUdCPejyAkT3avAyglqGr7MqNZ5eKZYM5/Uz4+a8chd/ag+waBxUPMVRuW0zcxE6
         PaSo/TML+OWIcqh36qorQYlV18WpR127C39WYyy8GgAii1jUJHgWZaiQIPu+mk0ms0y3
         Ef68PLPXfEsVzi/tV/u9eH69F6vTBJEMl3PXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UfpGy5tAS73+sWM9gF7ZBJ3p3zHT7pkTPz/eUsHxpcI=;
        b=hYbYzdUevdFs4QrqYBEpexpmqbMngNk7MGZtJsFJjb3ZaSsszjEe1KjbDyfl+uffKx
         ICQQdZC4IxMEZW24Pt7ysN3ySFknnd8TIT/koMIGToRU3lDepnAMZc7S/rXeFNoEqsM2
         +BP/5AGBPQp3vAHpqWuxV0S7Alif4FlsYlJTOoiPIGADarh0Wujf5jRGCDQn8crAXUpH
         4jvJav2UVjJgTSjCDFO08DOf4R2LMpAIY/W/10qHh+Ff5ArZByDQQaEs6yCK/1YIgkfr
         CDTr4t+lMaVBdw8IBdRHRBtUu/dqzyM4ZGBg8YGR7bRN422APrzZPpKsvVUIYJlRCQiy
         WQrw==
X-Gm-Message-State: AJIora9Rmuiu7tQRNMqO2UKK7yse2dYAfX62mNjQsfVbVU1tAfnPLXah
        F7cbGcam5V5ZD9xFokJ69OVfJg==
X-Google-Smtp-Source: AGRyM1vBDIoIwFowDxA/kWckz2krNOLSTScAcLHwIuD1+7PfwAx8sEEsuEgsxZqoZBoqq14Fos0Y2A==
X-Received: by 2002:a17:90b:1a81:b0:1ed:3c0:3abb with SMTP id ng1-20020a17090b1a8100b001ed03c03abbmr18859689pjb.5.1656371838412;
        Mon, 27 Jun 2022 16:17:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:18c2:6594:17be:c241])
        by smtp.gmail.com with ESMTPSA id g207-20020a6252d8000000b0050dc762817esm7929148pfb.88.2022.06.27.16.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:17:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: cmd-db: replace strscpy_pad() with strncpy()
Date:   Mon, 27 Jun 2022 16:17:00 -0700
Message-Id: <20220627161642.1.Ie7b480cd99e2c13319220cbc108caf2bcd41286b@changeid>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ac0126a01735 ("soc: qcom: cmd-db: replace strncpy() with
strscpy_pad()") breaks booting on my sc7280-herobrine-herobrine
device. From printouts I see that at bootup the function is called
with an id of "lnbclka2" which is 8 bytes big.

Previously all 8 bytes of this string were copied to the
destination. Now only 7 bytes will be copied since strscpy_pad() saves
a byte for '\0' termination.

We don't need the '\0' termination in the destination. Let's go back
to strncpy(). According to the warning:
  If a caller is using non-NUL-terminated strings, strncpy() can still
  be used, but destinations should be marked with the __nonstring
  attribute to avoid future compiler warnings.
...so we'll do that.

Fixes: ac0126a01735 ("soc: qcom: cmd-db: replace strncpy() with strscpy_pad()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/soc/qcom/cmd-db.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index c5137c25d819..0aafe90277bc 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -141,14 +141,14 @@ static int cmd_db_get_header(const char *id, const struct entry_header **eh,
 	const struct rsc_hdr *rsc_hdr;
 	const struct entry_header *ent;
 	int ret, i, j;
-	u8 query[8];
+	u8 query[8] __nonstring;
 
 	ret = cmd_db_ready();
 	if (ret)
 		return ret;
 
 	/* Pad out query string to same length as in DB */
-	strscpy_pad(query, id, sizeof(query));
+	strncpy(query, id, sizeof(query));
 
 	for (i = 0; i < MAX_SLV_ID; i++) {
 		rsc_hdr = &cmd_db_header->header[i];
-- 
2.37.0.rc0.161.g10f37bed90-goog

