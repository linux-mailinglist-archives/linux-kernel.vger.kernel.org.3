Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F03E55D15A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiF0P5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiF0P5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:57:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E124D79;
        Mon, 27 Jun 2022 08:57:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p14so9417390pfh.6;
        Mon, 27 Jun 2022 08:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7ZSEV4LTD7LAEM2Qop9QWeKPyT8Eo98shgP/WcfAJM=;
        b=TD25yDZjhKN9TW36xDeM7TC/WXolSNS4MNswQEtngcUO1oXtqBPpHKRVemyWExAlFW
         TqyvvXlQnhbGsHE73jVzf9Y9myNUkq+LmwxSgmvbIrAkTKRE8ajBfNydza4Fe1PWDCGo
         XN9lsNhRoOlrS3Twls6Nfrj9RBXQIGwY5DmVwoSfnp2Ara+fYn8fsBgPHgdzCdEMq0mO
         UMFJ0JsZO9r/GyZxyRU76iYGgF/7rl0zwXLixDbWPgyWOQ63wjrZwwnOr3K1Jnv7a9PF
         QKEiklV9Wc5SFJuofCme726CpZgab0fToWe4ZqGpSUmTSEqY0DkQgIKX3LCCrRr03tgp
         bLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7ZSEV4LTD7LAEM2Qop9QWeKPyT8Eo98shgP/WcfAJM=;
        b=aM5eFQd+hGMVAWRlr5jUU/6dHIi/lKYY2f1TbZCQ9FgwVpEnbEzCVASW1CbbN2oHcb
         tzkvgeywhHPPgWBCdHQr4PxLPmDoS7f5vFZZUQ7w1gIEekeqfe1VaLtlU2B2nU+Om/hf
         37oy2FZu2tTV9R/J0fxJHXjY3YjohGveXmFoYJoLkbrf1zMT9wjA79Z7cKiJ+WQnTbCL
         gltOnsOevi1aOM85ANDSTQTh1ZTy6FWaCAsGju2Eun5G+3zCP0HUKdZvT+1cU4t7lly3
         MEMyQyz5FZtDqOVmxWQwVzqZh6bF77EcjGIHU7DPIziNqyzBVhE8Gk44OelcCHdpxZpM
         k1fA==
X-Gm-Message-State: AJIora+NVseYGC0rXIHiYew8l/iGA56gXJaJC3X4JT2GKelcnTsBG+vv
        a3uYz7ZW1E/OTyd7gt8g69Wle+sxRXxqDg==
X-Google-Smtp-Source: AGRyM1v0/J58YZ3w/3MSk7WzTC+fbEwFJrbTeOxEdqpHzith/X6cEbp8QvXyQ3UyKtR/zcQ/eIEfuw==
X-Received: by 2002:a05:6a00:1a0c:b0:523:1a23:957f with SMTP id g12-20020a056a001a0c00b005231a23957fmr15619816pfv.45.1656345436401;
        Mon, 27 Jun 2022 08:57:16 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:26dc:1818:7133:85db])
        by smtp.gmail.com with ESMTPSA id h4-20020a056a001a4400b005252e524d1csm7499932pfv.211.2022.06.27.08.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:57:15 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-next@vger.kernel.org, ntb@lists.linux.dev,
        Alexander Fomichev <a.fomichev@yadro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jon Mason <jdmason@kudzu.us>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] drivers/ntb/test: avoid 64-bit modulus operation
Date:   Mon, 27 Jun 2022 08:57:10 -0700
Message-Id: <20220627155710.2067032-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Redefine RESCHEDULE_RATIO to a closest power of 2 so that the following
code in the perf_run_latency

	/* Avoid processor soft lock-ups */
	if (!(pthr->tries % RESCHEDULE_RATIO))
		schedule();

doesn't do 64-bit modulus operation.
This fixes the following build failures on 32-bit architectures visible
in linux-next:

  ERROR: modpost: "__umoddi3" [drivers/ntb/test/ntb_perf.ko] undefined!

Fixes: dc150dfb081f ("ntb_perf: extend with burst latency measurement")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 23e154bd41b9..536fab0030f3 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -126,7 +126,7 @@ MODULE_DESCRIPTION("PCIe NTB Performance Measurement Tool");
 #define PERF_BUF_LEN 1024
 
 #define LAT_MIN_TRIES	20
-#define RESCHEDULE_RATIO	10000
+#define RESCHEDULE_RATIO	8192 /* power of 2, to avoid actual division */
 
 static unsigned long max_mw_size;
 module_param(max_mw_size, ulong, 0644);
-- 
2.30.2

