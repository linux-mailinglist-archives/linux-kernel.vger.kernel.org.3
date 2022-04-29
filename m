Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57DC5150D8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379164AbiD2Qbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379113AbiD2QbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4965AD95E1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v12so11433458wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CnkgP4xzcb/4FGK+Q79OqtGtPLwxsYGrJi4DRc/jOmY=;
        b=zSFJ+kJY4sCK8V3o9Qaw51kkfaagRztZST+bHJLgimLTammtS0mM+IuUyHfOOlcqRG
         HFXntqqooUj9aSE5+j7ZuidpqPdAZMx+p3iffi+hFaNc8Oy1x43HMb7ymbcDDCAePDmZ
         R4X41tL+ptD+iI3VRW8oF/zLTmDLgIhtjoELghOccP9qkE3alH+bqclQ0wwQTpRe5sJ7
         m8xSGAzwZyP7VFsQRvFZVM9QqbKmcEzURDvoTd4pUQ2Uyh18wuOBp5qrWcUa5qhW2WaV
         2V7mLpvENCjG8JlBSaZlZnLJtOFEH3UxwQJAkyS+fbm25ZekWwP5WOXcte+rbCSQbd+z
         CLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CnkgP4xzcb/4FGK+Q79OqtGtPLwxsYGrJi4DRc/jOmY=;
        b=hvhQHregzu4RnqiRyLSmzAaOQia1MsuCxnjm4lUjNbddumRieUz64OJtiFLEJ7tPlI
         9gyMfmWOVHO5TBHLiq2q5tQHF62C4kJrGNoI4mED2a4QwGjNMi4F6mMdgv6KNsJf0rOr
         L9xK64PqQIMZLmTyKCAZ+4rmULmorjMv+EfTN+/U/iZ1gJ7FXus4d/LjBdH+di7DnEOo
         CDiDNtcmvqRSsv9OmEsO2/EVenJbfKazIY8ql0CEuPv6IOJBrC2hxKW2BcBQt/mw1/Bo
         9e+Q3pH30QkOeafhQl8Z9Rd/D/ZMF0LF64P9MaEOOA1py08X9TaDJLy26SOGNHFj67Sw
         VYtQ==
X-Gm-Message-State: AOAM532xO8EUnVBMEJMs7/Zh19iAMz3oTa3LNbHv2BMlv/OFI7G1RbC+
        hTFPymZHuvdw5czU35xAHsuBMQ==
X-Google-Smtp-Source: ABdhPJxFrajJOJVqLlgX2mFevBg9QJSCXbtmQwyGjtJJoYIes56GeffsQDwP+cK6jOmkicKiUGAC4g==
X-Received: by 2002:a5d:58e5:0:b0:20a:e022:3f8c with SMTP id f5-20020a5d58e5000000b0020ae0223f8cmr18088298wrd.667.1651249679827;
        Fri, 29 Apr 2022 09:27:59 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:27:59 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/16] nvmem: bcm-ocotp: mark ACPI device ID table as maybe unused
Date:   Fri, 29 Apr 2022 17:26:51 +0100
Message-Id: <20220429162701.2222-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
References: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

"bcm_otpc_acpi_ids" is used with ACPI_PTR, so a build with !CONFIG_ACPI
has a warning:

  drivers/nvmem/bcm-ocotp.c:247:36: error:
    ‘bcm_otpc_acpi_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/bcm-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index a8097511582a..dfea96c52463 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -244,7 +244,7 @@ static const struct of_device_id bcm_otpc_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, bcm_otpc_dt_ids);
 
-static const struct acpi_device_id bcm_otpc_acpi_ids[] = {
+static const struct acpi_device_id bcm_otpc_acpi_ids[] __maybe_unused = {
 	{ .id = "BRCM0700", .driver_data = (kernel_ulong_t)&otp_map },
 	{ .id = "BRCM0701", .driver_data = (kernel_ulong_t)&otp_map_v2 },
 	{ /* sentinel */ }
-- 
2.21.0

