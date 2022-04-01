Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD2B4EE967
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344064AbiDAH5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344061AbiDAH5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:57:38 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC02B1A8C02
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:55:48 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id w141so1493714qkb.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 00:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EvMYudPMRlW+QI6mRpk+TBKOIo2CGyH38rNyym6D1Tg=;
        b=k3c7PAaIDx5QN1SJ8NeWDznRSidczb38R2PWr3sPpbGPzb0duAsVQ4Lrn3NArdfjNE
         2QZLRwD0nW2tbjk5QMKASyaPlq5FXdv+Dr9AYLjoYq6UXI4k6eF8Yhys15344c8vgAmN
         SzORYxE3oQhBrOJSGuxAf5TBxsmDrFUQkzDu1WArf0lBQj0K1YaDa4ajtBq3VH8CMHAy
         oPXA489ytyos3hR5awk9Ays8Qr0H21qd6Jm3yZ2qPRjir4nqv79piOv5Fu8P5n1BuyoK
         AyrOpIIvuTDT0QDzrlnCv578OWoduGNqka4cddB/NI9SKUwxL5EdJImooxrb+/aeSLRA
         K+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EvMYudPMRlW+QI6mRpk+TBKOIo2CGyH38rNyym6D1Tg=;
        b=Zz7vDYzNMSmPnO4xbGslSazf2wh61OIBIdpadQL2MGDxWfF0Bn0JTpnCJgtqqdBgZ8
         pnY8wnACryh+NxZ3cdrx/meVx6748ed+NH/m95rZTukqk6oxXAsXRhQSryAlirjn0I/e
         TfK4n3ZkohNZlrtu3JE7xCGVD/c8Ggg1P7njfwSigHe3IdUBSHbPkjiffGCrmjYNpeyb
         tU8zIDBkdrrxf1K+KWVRrqfAZdEXwFkBg91qspJg3WxOA7KRBdKMeiwWrlfoREnixgzv
         954UwhuIsvDsQBqQ+P+g41N9rR/9h1ZINcOokDJe6t9sqQ7gJVVbb7yYzMioV9RJ54qC
         ruJA==
X-Gm-Message-State: AOAM533ekE27AdlrE5ldOVvnYpXHSe59K5YEdaCDzv4m+EF6ao+TcUx2
        cRx/g50Bmq+SKmTGRdQeXGs=
X-Google-Smtp-Source: ABdhPJyGg0jtsxFhZt29VXKRpRVMbcVM9RS+EqR48wxTQoCmF1+xoN0RETvR8EU0AXxeBdhuhf2RIQ==
X-Received: by 2002:a05:620a:c08:b0:67d:3b4e:229f with SMTP id l8-20020a05620a0c0800b0067d3b4e229fmr5930412qki.550.1648799747772;
        Fri, 01 Apr 2022 00:55:47 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 78-20020a370551000000b0067e3a58c090sm905190qkf.82.2022.04.01.00.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 00:55:47 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     sudeep.holla@arm.com
Cc:     cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] firmware: arm_scmi: Replace zero-length array with flexible-array member
Date:   Fri,  1 Apr 2022 07:55:37 +0000
Message-Id: <20220401075537.2407376-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

There is a regular need in the kernel to provide a way to declare
having a dynamically sized set of trailing elements in a structure.
Kernel code should always use “flexible array members”[1] for these
cases. The older style of one-element or zero-length arrays should
no longer be used[2].

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/firmware/arm_scmi/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index cf6fed6dec77..d753c040b6e8 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -49,7 +49,7 @@ struct scmi_msg_resp_clock_describe_rates {
 	struct {
 		__le32 value_low;
 		__le32 value_high;
-	} rate[0];
+	} rate[];
 #define RATE_TO_U64(X)		\
 ({				\
 	typeof(X) x = (X);	\
-- 
2.25.1

