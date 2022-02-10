Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03DA4B190C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345441AbiBJXIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:08:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbiBJXIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:08:38 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A790E31;
        Thu, 10 Feb 2022 15:08:39 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id o10so6606250qkg.0;
        Thu, 10 Feb 2022 15:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8tBSzebx6IZWphnQDmZzi0rvUYtCYRK6nGrmurw7iTk=;
        b=VctWFimLh3AYddEGqTeZwYpvH+2egElHggiZG6HROcMPM6t4PbuJRA3P7nel5acxHJ
         iVQtSJ6P8j/vL38rwP+vwLlkPVwnPVBh36AXVths9rFLU8Jf8Nu9MwqwdTO9ndYp1Az+
         UCDnDGwr/s+vCOfO28O5MqFNsyI7IC+EaInU7kKbFdyTOtNEdWRafeisQBf3eQCBuzqG
         EJ5T2OOsfp//rGAWOIp72EkCNobq2Jps8jA6DTJ9H14V9rPuEOnbxvlRLfKiLs88A5a+
         pzF7Lcqq0h8cN3QlFSo/+ZyNgTD0S1drwmCJrCJfDhbCVLKHva/gnz45ss/dsQ2fWwpT
         nH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8tBSzebx6IZWphnQDmZzi0rvUYtCYRK6nGrmurw7iTk=;
        b=A+TBVbkzhSghPUPrxsdtHdPoUx+9S++VKhubygpEw5yKgfmn8fTKOT4nHWyC1eqArU
         TjNzaZJnCGIx4gyRrxcOjRy311bIagIJBlMEY3IjxTRfWR1QYevJpsxxZ3onSE/QQ5Wj
         GwEY8KZCYmccOa/VcQqwHNe7WFewrb+Ib0ko9jl+ySq3oMC+8Um13A/6ARVq1wE+HVw4
         tpgZigACNrC2KTku44YK2tK0zIvuHNOjO9joiQLfTKXKWdDGEUtLKSQGAT+MbCbIW0Lm
         edQEERdYIKHBMClnNJ2Dr8NwarMKWQ7tVI1VwQv61ev2ugQ6i1GZEmfJuPHAwMkrdJSE
         yiSA==
X-Gm-Message-State: AOAM5321Q9vT/H6HxlcVLeozWWOFDhBvMEp+AY1upm1YGM0SFh46e5/s
        LxMzRIFwsyoI9ldKbP8rQUA=
X-Google-Smtp-Source: ABdhPJxz8mHol+ysN0OuloI7MrK637q0cIngQIMXKsaQuDg4uwCNVT0JgimFXOAi9PcGNTEyNSlXLA==
X-Received: by 2002:a05:620a:c4e:: with SMTP id u14mr4883247qki.710.1644534518498;
        Thu, 10 Feb 2022 15:08:38 -0800 (PST)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id s6sm10549153qko.93.2022.02.10.15.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:08:38 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] of: unittest: print pass messages at PR_INFO level
Date:   Thu, 10 Feb 2022 17:08:19 -0600
Message-Id: <20220210230819.3303212-1-frowand.list@gmail.com>
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

From: Frank Rowand <frank.rowand@sony.com>

Printing the devicetree unittest pass message for each passed test
creates much console verbosity.  The existing pass messages are
printed at loglevel KERN_DEBUG so they will not print by default.

Change default to print the pass messages at loglevel PR_INFO so
they will print with the default console loglevel.

The test community expects either a pass or a fail message for each
test in a test suite.  The messages are typically post-processed to
report pass/fail results.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

One review comment to similar previous patch "of: unittest: print
pass message as same lovlevel as fail" suggested to also change
the text of the pass message to include "PASS" instead of "pass".
I would rather leave the text unchanged to minimize churn for any
existing users of the message.  It is my intention to change the
pass and fail messages to KTAP version 2 format as soon as that
version of the specification is completed.

 drivers/of/unittest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 70992103c07d..9012e6900965 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -44,7 +44,7 @@ static struct unittest_results {
 		pr_err("FAIL %s():%i " fmt, __func__, __LINE__, ##__VA_ARGS__); \
 	} else { \
 		unittest_results.passed++; \
-		pr_debug("pass %s():%i\n", __func__, __LINE__); \
+		pr_info("pass %s():%i\n", __func__, __LINE__); \
 	} \
 	failed; \
 })
-- 
Frank Rowand <frank.rowand@sony.com>

