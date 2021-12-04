Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2A84684AC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 13:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384897AbhLDMPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 07:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354819AbhLDMO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 07:14:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE03BC061751;
        Sat,  4 Dec 2021 04:11:32 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u1so11519805wru.13;
        Sat, 04 Dec 2021 04:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SA05gaA86ga0WnsWblVWGRk46vKTY7ejtnjWmzpvNMc=;
        b=joDVMtGbkNsXydRbF2YXC0zcNZWbgqis5ocf0FfBBrcR/pUP51sB6rKuN9Xxm0cNoD
         L8MCWyuQxQuBQocDKqS1BVcJhDKueN58XVn3F06eC9TjIoAItGomCRvgPMe+cba8i9FM
         hF2XXbrdbeEP+nkgdKBjiKVcnh7GT4vDvN37Li1ELryFdRvpfc0eQpCwPK16KnBkQnHc
         y0UxUp6alMXsCgkQDKtU4h08F8qoSbr1SR8eYJmAjPYuZK9ijCfRaNqofS26ruLCpYi0
         3GJ0GJ/4o8exuqpZMUWD7Ky3umnh2pgmrjUxajBbcjKbd1QICE8PzH4aF3KaAStkvacE
         6fSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SA05gaA86ga0WnsWblVWGRk46vKTY7ejtnjWmzpvNMc=;
        b=RxepsC2sy7SLOzrBaX8fA+sQF5tqQSOiFNcKQ5COQgT7PJLIIC4JEpQn9X/LDed4CS
         aOrR8CF7eiqSNZFJr7x/rlJiZ5nheU7fk0z+EnEXY4vsTcMcjKgdUC3pZh0xGWilVYRB
         1E2YPfISOj99D8p83/H0tYdamyi6xYaQzu+vGmveIcqgV9vBnzEn5PPa7tsMe/IOBQEu
         GbV11OFZ46guRasmjUv2SACmAWN+ArND6heOnP2xK+ScopqOo37hgVEQjmG/54F40YFI
         zz1HgrUAw6DXxteOT3VyJ+2tVNvmxAIeOgoTmeSccyt/ZZpJ8urLtDmcdnlnoH5jugHZ
         ezzA==
X-Gm-Message-State: AOAM533JVJed5i/E7a/+JRPTJtfVRmOsYxRkh4pTkcPTEDP7rYJiyyv7
        QXEd7jv5RUq+lPUPO+8qyW8=
X-Google-Smtp-Source: ABdhPJw6I8weYg2ZSkP9PwcmLOJls7gRm5yFYrdnUjJ5EtQp4X+o1tRLoJcIuts5o4xNonHGM52LAA==
X-Received: by 2002:adf:edc1:: with SMTP id v1mr29420024wro.170.1638619891417;
        Sat, 04 Dec 2021 04:11:31 -0800 (PST)
Received: from localhost.localdomain ([39.48.153.81])
        by smtp.gmail.com with ESMTPSA id u23sm5444935wmc.7.2021.12.04.04.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 04:11:31 -0800 (PST)
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     stanimir.varbanov@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amhamza.mgc@gmail.com
Subject: [PATCH] media: venus: vdec: fixed possible memory leak issue
Date:   Sat,  4 Dec 2021 17:11:23 +0500
Message-Id: <20211204121123.22180-1-amhamza.mgc@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed coverity warning by freeing the allocated memory before return

Addresses-Coverity: 1494120 ("Resource leak")

Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
---
 drivers/media/platform/qcom/venus/helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 84c3a511ec31..344a42853898 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -197,6 +197,7 @@ int venus_helper_alloc_dpb_bufs(struct venus_inst *inst)
 
 		id = ida_alloc_min(&inst->dpb_ids, VB2_MAX_FRAME, GFP_KERNEL);
 		if (id < 0) {
+			kfree(buf);
 			ret = id;
 			goto fail;
 		}
-- 
2.25.1

