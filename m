Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A92B5150D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379171AbiD2Qbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379117AbiD2QbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA7CD95D4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e24so11442678wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Db7SM18qWKB7TpzEEpOJB6Dd7eXYda2poIceJD5qIQ0=;
        b=v2L6OPPvTDVMluFqfBinnzYEeZg+TQAooLhtKnj5z23NnEMB5AlQ1S9h4hP3kigsvY
         lVlJ2qwapd/5lx2gTdAMTEYWQEyxuKS9J/VsrV/N9nCo4vE0QlpY99oawxR72rPEmOwF
         FWuUKQjM6Es+kzEAbUNcA7zECo3pG3myP1pcXdtXuS++awIJCP9mNsXdRovICbkbKKPR
         8XEsMNPfI1B/tQ+DyGkH7hp5rCdA+aC0Ko3aiIev/Hsl9cC+9GYymZCGadMdTg5guh7S
         BNcfhFpl5tGRBIxKZAn62/8Mp8DO5W5UbuArer0wdX6Qev0KS4chWOjySC8mS5dkW8yk
         OqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Db7SM18qWKB7TpzEEpOJB6Dd7eXYda2poIceJD5qIQ0=;
        b=QyswbZTlfFEAVPoIGDg4j4IaK50S2MDPoEZMk4bJLDX+H1FrJ7jwDy6WktGnBsc6w2
         K31F6nrxlhBOxy7RE7g1d8/DUs6+YLyWBYWjDugQkLZJ2o8GMRjbj659pwCnoOD6qk1k
         tBgQtMJjCuiSojvMap+5g7uZFoV8w9o+7VwvB4UGQx4F7mgywzj3WcM6pSfvTwAlS2xV
         2iSzDa7Z/ZGQ3uVrgDZXDHrMTanqjxtM+vGiBLwx+9xh9IUwjAjFEc9lMFBUDCcfnvp1
         9jiip01mxn1mi4dqG949ypxLObzPwMBKTkgFPaVcpnc2l1K6TLroo0FGtXqMypplRqDi
         Fs7Q==
X-Gm-Message-State: AOAM533fRnWJmY+wfbFiqWB0mp14eU3Bjl4gdFKCeBKnyQsyQ+lMvKHi
        agBUtyCr8WYufgxvPhKVMlW0+w==
X-Google-Smtp-Source: ABdhPJzlekKsgzxAOmGiaG5OXe5jkSMuAIx4f5Hxbdgyew+Rc6NZKqyYRMG6Evt0CwIPGmh7pGpwdQ==
X-Received: by 2002:a05:6000:1e08:b0:20a:873f:13b3 with SMTP id bj8-20020a0560001e0800b0020a873f13b3mr29949716wrb.52.1651249682586;
        Fri, 29 Apr 2022 09:28:02 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:28:02 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/16] nvmem: sunplus-ocotp: staticize sp_otp_v0
Date:   Fri, 29 Apr 2022 17:26:53 +0100
Message-Id: <20220429162701.2222-9-srinivas.kandagatla@linaro.org>
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

From: Krzysztof Kozlowski <krzk@kernel.org>

The "sp_otp_v0" file scope variable is not used outside, so make it
static to fix warning:

  drivers/nvmem/sunplus-ocotp.c:74:29: sparse:
    sparse: symbol 'sp_otp_v0' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunplus-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
index 81aba80bdd10..52b928a7a6d5 100644
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
2.21.0

