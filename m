Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC47751B5C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbiEECXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiEECXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:23:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E13483BF;
        Wed,  4 May 2022 19:19:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i24so2538062pfa.7;
        Wed, 04 May 2022 19:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IGv/QuhBfQMEN1mITB6WR1nioX3n8yw8Uyn/MllDKZo=;
        b=O1bvPD2pfqGO5YcVlBia0bgyU6sSXfeggPG92iUilwzKRv2JssKoDRVEd1eyW9BIJn
         fzcfzo52m4fIjgLfrRfZeXW0ZWT4yiCruYJnEqNcqfkE3X8YNUdd4nojV291GiaToISk
         uoF7M1gzS2//K24N/EscNY61kYERovP5NCEM1TtJYAo4jjwPNRFqSue1HP4jrjE1BMZN
         +/0YSATZMyiZjXsGj+VEhrB6PJgprB8ul3XfX7JhDHQJ7fRijZ8P7tLF3MDBxplj0b2p
         e/uAs3Y0pWSD/KjIdOrSDzsH9U53zhOY3hvg8BmdSX9Y7niXr1pIJYNPKKCoP0w2+D6l
         ka7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IGv/QuhBfQMEN1mITB6WR1nioX3n8yw8Uyn/MllDKZo=;
        b=xBlXMaQ/mttUpoBGtSaLN3ot+T5+R3G4dzT5y8gom9pKNwPdYzZQdSZSVBQO0OjBO/
         aDelh4Oi3gO24YvsocCUZJijDwcKDFRZ37KPWM15pvfkf5fNn+66wZ4rWwJqv3uhKvIE
         vouLFO+36LQ59O4IH6wQ2IpwRGmKa86zzxX82KFx8y+nxr4E3VItUH+yuinmbqtJEA9v
         E9gMYCOeJtUDEHqiqQUlCzjUAbZxaVTN+FInldvEJTqFFl5JmI/K+UI0GieWW0EpQYSi
         qQEE7N+X14hxIqt1CdUTTk9ZeZrI9kcG7xcw5eboIDNbwVes4KMzJCvFSBQ2KL7bW/hI
         s7Wg==
X-Gm-Message-State: AOAM531baf7gsUIJl+gPHfufCVU+27GdBeRtpwO0qdnyzK3dsXR8d/lc
        PSX0RYt6acGg7WfPkG8opkg=
X-Google-Smtp-Source: ABdhPJyrL+ek4+CgF2rPUMkUnMVKUAUJnXy5lHQGfZ8YPp657PFqSjEntMedpfFCKQKyjqjbKzWHQw==
X-Received: by 2002:a05:6a00:4385:b0:510:4422:aa3a with SMTP id bt5-20020a056a00438500b005104422aa3amr5084784pfb.16.1651717166440;
        Wed, 04 May 2022 19:19:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b28-20020aa78edc000000b0050dc7628138sm105962pfr.18.2022.05.04.19.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:19:26 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] platform/x86: hp-wmi: simplify the return expression of platform_profile_omen_set()
Date:   Thu,  5 May 2022 02:19:19 +0000
Message-Id: <20220505021919.54462-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/platform/x86/hp-wmi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 667f94bba905..9edb1f877189 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -1119,7 +1119,7 @@ static int platform_profile_omen_get(struct platform_profile_handler *pprof,
 static int platform_profile_omen_set(struct platform_profile_handler *pprof,
 				     enum platform_profile_option profile)
 {
-	int err, tp, tp_version;
+	int tp, tp_version;
 
 	tp_version = omen_get_thermal_policy_version();
 
@@ -1149,11 +1149,7 @@ static int platform_profile_omen_set(struct platform_profile_handler *pprof,
 		return -EOPNOTSUPP;
 	}
 
-	err = omen_thermal_profile_set(tp);
-	if (err < 0)
-		return err;
-
-	return 0;
+	return omen_thermal_profile_set(tp);
 }
 
 static int thermal_profile_get(void)
-- 
2.25.1


