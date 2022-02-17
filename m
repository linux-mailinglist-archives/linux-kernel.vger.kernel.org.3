Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3F44BA739
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243768AbiBQRfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:35:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiBQRf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:35:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6536273771
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645119313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DZsl4nXyfSH8LqSPjL0oKykjopTH/CSytqMZi4biHO0=;
        b=EOypnlIn0e/r/qW7apL/J0q/CmEM98tyWuf8jnpLVONhNiXGYFrD/avxsJ6nS+8R+Z7pfi
        Hp1Do1lSUMPgyXP40Y9MYpb/ZHBkRzQOABOqoEqn95cXVZ370v+DP4tGUYqw/+FlBBLMn/
        vkbHYjt1Ez8RcNNXvPSqsSa8fABuI0c=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-2CvIBJFHM_OP2WbvlfSAqA-1; Thu, 17 Feb 2022 12:35:12 -0500
X-MC-Unique: 2CvIBJFHM_OP2WbvlfSAqA-1
Received: by mail-oo1-f69.google.com with SMTP id h13-20020a4aa74d000000b002e99030d358so159451oom.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZsl4nXyfSH8LqSPjL0oKykjopTH/CSytqMZi4biHO0=;
        b=cCIHYEtvq3lSFhT4peCUUglXxWIoKSfGLcBnU5pU4qxdudDkkUvdgE/YJMl42+P8f5
         G9EtjThVkGsjhfJaLMu/IoyhcG/juOSWs2YjXyU77iBhbxdshF8mdjY3R6QroX5penue
         jvRKAUFUikHRVUqoLBHrnHQzRM1qDH9ABWUj4a3zgrCJlveNoPDhQViHSHE4q/14kyEF
         lBi08+OP+r3voB867c53nbYbZ0lJK+8eM/u7M9RZBKsMKGI1R+cXtlvpeMu/zx/Moo3O
         +jAOkZZ0TP5+08eHGxbhaBV7GTq8UMLcicl+9LS19FyaFQ2gc/Emx9hmof1puAdqx1yl
         KKPA==
X-Gm-Message-State: AOAM532bYgcQAKSH7qnwdQnVM3oXL1bDQCP7PNp8B/qQDdferkpS4+pS
        esYe8tuSWU23vyCdCltSc6p+fDozyNR4aMM/Vw6GXAmV6u2qYI1Y9GMkw4Lf0pL2cFMtOJscUAe
        ayAOCBUfzZFxFIyIVZMyixCfr
X-Received: by 2002:a4a:4346:0:b0:316:7659:3fd0 with SMTP id l6-20020a4a4346000000b0031676593fd0mr1114488ooj.42.1645119311462;
        Thu, 17 Feb 2022 09:35:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwl2V9nqsG9LlpbFpV7Btyn+CUYFrNOE/K7Kquyb4vznOqw25KLJa10rY6evLvTaSfrNjz1tA==
X-Received: by 2002:a4a:4346:0:b0:316:7659:3fd0 with SMTP id l6-20020a4a4346000000b0031676593fd0mr1114483ooj.42.1645119311275;
        Thu, 17 Feb 2022 09:35:11 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id 2sm16957210oaz.24.2022.02.17.09.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 09:35:10 -0800 (PST)
From:   trix@redhat.com
To:     dinguyen@kernel.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] clk: socfpga: cleanup spdx tags
Date:   Thu, 17 Feb 2022 09:34:53 -0800
Message-Id: <20220217173453.3262672-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Replace tabs with spaces in SPDX tag

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/clk/socfpga/clk-periph-s10.c | 2 +-
 drivers/clk/socfpga/clk-pll-s10.c    | 2 +-
 drivers/clk/socfpga/clk-s10.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/socfpga/clk-periph-s10.c b/drivers/clk/socfpga/clk-periph-s10.c
index cbabde2b476b..f5c1ca42b668 100644
--- a/drivers/clk/socfpga/clk-periph-s10.c
+++ b/drivers/clk/socfpga/clk-periph-s10.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier:	GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017, Intel Corporation
  */
diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
index e444e4a0ee53..1d82737befd3 100644
--- a/drivers/clk/socfpga/clk-pll-s10.c
+++ b/drivers/clk/socfpga/clk-pll-s10.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier:	GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017, Intel Corporation
  */
diff --git a/drivers/clk/socfpga/clk-s10.c b/drivers/clk/socfpga/clk-s10.c
index 4e508a844b3d..9b2e0275fbf7 100644
--- a/drivers/clk/socfpga/clk-s10.c
+++ b/drivers/clk/socfpga/clk-s10.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier:	GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017, Intel Corporation
  */
-- 
2.26.3

