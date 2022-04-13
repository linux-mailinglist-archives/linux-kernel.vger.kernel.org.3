Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098F84FF5D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbiDMLkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiDMLkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:40:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0921C58822
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:38:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z99so2009245ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b9JbZM1/gAbcuCSgzitqQgGnzkrB8hE/3F5FE4npMMY=;
        b=WtCYKflLYJfCcEGbpC48ZVJIJgkOmzZvvZwcomVJTa/7NuLM469DYokRYCO3orRSYK
         9nnALsXGmBByS9DwmWy6ttYB3uHE6tRzC9zByQNUgky7ohAU+geTcIdjCUvVBAvnE1zT
         KYrMolwL7uwPN1YLeMJqLf+eX2IgTL2v2oTjYh80FqzhymAH5dTAmhojC4pqxzcVFJk9
         D3Ptc9p4n93QkwBNvx1RQt0JF2KVfWDSb3861Z+NwGX5xpHRYReFu6ur5mhoR7ZyLiBw
         7XDl1UoLaiAA3wTK3ii+dldirtGhwiHmFOyct1nw5Mo1LVd5u16n8jWfAS3TcdLTOzWX
         9vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b9JbZM1/gAbcuCSgzitqQgGnzkrB8hE/3F5FE4npMMY=;
        b=tCU2G/Tzp5kX3XibEllQYytb9oYYfnO2ICJw93ywQCtjlXEyFRoEyU5sSIv1DdpDVd
         JxvHrXD2H182dgQNDfWjHFApRayYJN/MZxES0YInKsQCr9MEzwpl+cpy2+2tlpovpT4N
         KJM9RhdzVqviF0gVwzHIYoLsCjwZPoNoyVjvxF7gY+AltJGYUOBCC9fplCQtL3IPNYB5
         i8aOeYsEzezRKRK5gSq30YtEinYwzLTeJsybtZ1DOCh46oVbre/G4Zhr2zRh5xA4O2OR
         3bOVPIU8DHq69Zag0jblp3K+oO84M2RZeW8/2TQXnfZmrIlORZCkLh+T2SQxE/kwbxqq
         EbYg==
X-Gm-Message-State: AOAM532w77z89GzDaILzcA+l5hdRH/WgPQBZw09/Y/XAcKH7IGg0mP0t
        CwW+cxbYacx9ZVk5AvB+QC/ZYA==
X-Google-Smtp-Source: ABdhPJzcFhKHFSAPtp2yAjnsOtivadRH69IbPhFXrHhUJCyVkldZzwgNyUL1CPHvDsMwMqKnW0cDuw==
X-Received: by 2002:a05:6402:1d55:b0:419:992b:9286 with SMTP id dz21-20020a0564021d5500b00419992b9286mr43241654edb.235.1649849893495;
        Wed, 13 Apr 2022 04:38:13 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id cb25-20020a170906a45900b006e87e5f9c4asm4452783ejb.140.2022.04.13.04.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 04:38:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [RESEND PATCH 2/3] nvmem: sunplus-ocotp: staticize sp_otp_v0
Date:   Wed, 13 Apr 2022 13:38:08 +0200
Message-Id: <20220413113809.243288-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220413113809.243288-1-krzysztof.kozlowski@linaro.org>
References: <20220413113809.243288-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
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

From: Krzysztof Kozlowski <krzk@kernel.org>

The "sp_otp_v0" file scope variable is not used outside, so make it
static to fix warning:

  drivers/nvmem/sunplus-ocotp.c:74:29: sparse:
    sparse: symbol 'sp_otp_v0' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/nvmem/sunplus-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
index 2dc59c22eb55..c94134649714 100644
--- a/drivers/nvmem/sunplus-ocotp.c
+++ b/drivers/nvmem/sunplus-ocotp.c
@@ -71,7 +71,7 @@ struct sp_ocotp_data {
 	int size;
 };
 
-const struct sp_ocotp_data  sp_otp_v0 = {
+static const struct sp_ocotp_data sp_otp_v0 = {
 	.size = QAC628_OTP_SIZE,
 };
 
-- 
2.32.0

