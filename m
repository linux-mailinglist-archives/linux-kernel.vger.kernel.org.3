Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD6D52CD1C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiESHdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiESHdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:33:09 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE82F9346C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:33:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id l13so943779lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ALKgqLX03rO1JXR9FQHpQsvlscWjKCc3EL2LxNPWDa4=;
        b=jJ8J4mqV9cqzWX/FHDUWZ9ZfihApeYo0kNor+zZTTfLaNjiAdT+yiXoVU4gMgyXE7I
         J+wPnINsxiGrac62g0wYS1dDSUSvsPLxQdpx/tIrQGcHWOYOL1Y+/vLm4M0afCpH3YWz
         LjRh/QWLyvUc0cIk49613szHNas734U8wIsuOE1zPlKrGAP75OU1dWEp8Wfw0G/siPWW
         Pds3mCP5llT/3bnrARBdpAxx0qpBJrZ90rk02fj+YxTxSyyx7iIur1QmQC9PyLIpMb6n
         0V/wspNLxjJuwnHNmhLqUIbXvCmNVuNDdFCYlyUJ8AMR2G7OHQpd9oE/n3MqOv1V18aY
         ArNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ALKgqLX03rO1JXR9FQHpQsvlscWjKCc3EL2LxNPWDa4=;
        b=wJe8oFJUKeSRSxgK1KLhm2lxjFXqU/VUuoAKKcVyqeeTeahoInpM9wQ6mqka1vkYxy
         KMQQsRWp/pTfWFGWGL4y68QLmddOgtxPaUMTLVESetxLb3+dg2u3QGjKcaO698QQZRuq
         Iw1PvgvfZDPVbpPJExxa5kN5/6wQiUNe5K6vzXoPMFTIfVz7ZfcbfAwUTEdjLro4YJq7
         tihoXpiUGiubPSPKzENMVBRSKu4ACibOnphVfOnyvq6nXG5pmYFQxHJ9eJhJeAZxEL6q
         ViFcH+bvav9uNPmhioDnu+isF4rMnC284CRv891/F2HNWEP8x/xEURm3IeP/JrFQWYIv
         3Ztw==
X-Gm-Message-State: AOAM533ocUUOdgsJJuLe2vqQxFzOJWjVFFhgM0CuRFWuHSmfq2hbAoPU
        XxViiojDDU/w6sAU6GCWL66o/w==
X-Google-Smtp-Source: ABdhPJwJLswrPA/dEHn9WngV+DPfXX92bZvOd6QeRYtc5iny1je55P/WAJmGscSzDwdDSkLUfTlsug==
X-Received: by 2002:a05:6512:3092:b0:473:e56f:2906 with SMTP id z18-20020a056512309200b00473e56f2906mr2314368lfd.327.1652945586162;
        Thu, 19 May 2022 00:33:06 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w10-20020ac254aa000000b0047255d21117sm187406lfk.70.2022.05.19.00.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 00:33:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] soc: qcom: cmd-db: replace strncpy() with strscpy_pad()
Date:   Thu, 19 May 2022 09:33:00 +0200
Message-Id: <20220519073301.7072-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of strncpy() is considered deprecated for NUL-terminated
strings[1].  Replace strncpy() with strscpy_pad(), to keep existing
pad-behavior of strncpy.  This fixes W=1 warning:

  drivers/soc/qcom/cmd-db.c: In function ‘cmd_db_get_header.part.0’:
  drivers/soc/qcom/cmd-db.c:151:9: warning: ‘strncpy’ specified bound 8 equals destination size [-Wstringop-truncation]
    151 |         strncpy(query, id, sizeof(query));

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>

---

Changes since v1:
1. Split series per subsystem.
2. Add tag.
---
 drivers/soc/qcom/cmd-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index dd872017f345..c5137c25d819 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -148,7 +148,7 @@ static int cmd_db_get_header(const char *id, const struct entry_header **eh,
 		return ret;
 
 	/* Pad out query string to same length as in DB */
-	strncpy(query, id, sizeof(query));
+	strscpy_pad(query, id, sizeof(query));
 
 	for (i = 0; i < MAX_SLV_ID; i++) {
 		rsc_hdr = &cmd_db_header->header[i];
-- 
2.32.0

