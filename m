Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F416599064
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346156AbiHRWS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244097AbiHRWSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:18:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F482D1E1;
        Thu, 18 Aug 2022 15:18:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dc19so5681305ejb.12;
        Thu, 18 Aug 2022 15:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BBl82XfFeF2MZw0ulNToCpoAaMZwaKTEd9Lqq190fuI=;
        b=ZgwNuXCqAGel4wSe20RaaMANDjhqdi86IvOO4F1eWP+DCImxLV1IeRxnhuudUUjoac
         bk58jFtzv8c0cC9K+EENR6uI+dgUR2Gq5iiAhTeAOoMLKv+y7A9ENWcwdx+D9JaDndGt
         v4T6HmylIIn0IJm0oPCbLwC7Vd0RdTGg9e5Rfbbn9xmubOC01fU9744tdmGR0wQCtzRC
         4TSPilY6b6E/MxZaAnW6RiaTQejnxhkZ9DrmVoEXTaRBsBKfRW8bnl9Wys0Q39HVuWy1
         DhlKasvVylv/3uwkzZK6DNRg40II5f7XH6m6AMMpv3m2PO33pV93ZV5P4bDSusyQ83Bc
         zLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BBl82XfFeF2MZw0ulNToCpoAaMZwaKTEd9Lqq190fuI=;
        b=TGp46ctwQB+Yx06ZpF2vhSMlTB8fZwsjWkz4vdTTj3fGJdMdc6dqivPWtpyzRKcXTF
         m9Am4E82yuavFQeFnM5gEDeFR9WCOypEhKcfSYeRGIg5+90Zmy/v/sdwfBYwWrCD7wXb
         a+PVBbLTCgXn1Ph8b7d/BCdGCovdQ6m55zrOekysaGr1zuKkdQtTX38VfQvMBYFfZFEV
         LfyhWtw0gGozwEXmPbo8r/c6Vxq1+INB5GccjABTlAz9lZ1Zu0YB7eRzyHPNsW3qvUhK
         4rHCFMQTpaaOXI1QTQGPe/qoZcI8HO+goie2PqRmKHvxYymE0lTcI0ZYJyjvxXSh/aRM
         w2mA==
X-Gm-Message-State: ACgBeo1ugpOBivVZje21H0Uz/nYpAQN7Z/MJdp6pL8KrCTfOik5yF4jQ
        mwJGpORbAi1X9LLHRA6uqYE=
X-Google-Smtp-Source: AA6agR6fId+ZZd4Yz0jTu2Jr8sTZE7slXFkgVcgFTYu+uRiyevyqomNch3kLzgKH5Taw/626xtEUNA==
X-Received: by 2002:a17:907:6930:b0:733:8eb3:83a3 with SMTP id rb48-20020a170907693000b007338eb383a3mr3232484ejc.32.1660861099454;
        Thu, 18 Aug 2022 15:18:19 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id t19-20020a1709060c5300b00731747c3107sm1378315ejf.73.2022.08.18.15.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:18:19 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v8 2/5] mfd: qcom-spmi-pmic: add support for PMP8074
Date:   Fri, 19 Aug 2022 00:18:12 +0200
Message-Id: <20220818221815.346233-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818221815.346233-1-robimarko@gmail.com>
References: <20220818221815.346233-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for PMP8074 PMIC which is a companion PMIC for the Qualcomm
IPQ8074 SoC-s.

It shares the same subtype identifier as PM8901.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/qcom-spmi-pmic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index 00003a868d28..7e2cd79d17eb 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -60,6 +60,7 @@ static const struct of_device_id pmic_spmi_id_table[] = {
 	{ .compatible = "qcom,pmi8994", .data = N_USIDS(2) },
 	{ .compatible = "qcom,pmi8998", .data = N_USIDS(2) },
 	{ .compatible = "qcom,pmk8002", .data = N_USIDS(2) },
+	{ .compatible = "qcom,pmp8074", .data = N_USIDS(2) },
 	{ .compatible = "qcom,smb2351", .data = N_USIDS(2) },
 	{ .compatible = "qcom,spmi-pmic", .data = N_USIDS(1) },
 	{ }
-- 
2.37.2

