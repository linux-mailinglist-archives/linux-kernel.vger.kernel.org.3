Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7174FBA21
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344862AbiDKKy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiDKKyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:54:25 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2176340A1D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:52:12 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id r25so2575927qtp.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U9MFldUlI8YuKEyEgOU8kDAs+pi0T7vKsyhKnKGTjrs=;
        b=Ff34ICPcuZ39MIm1wSdAnTHfHMg3nEABTIupQv3gGUrKqr2aDB1qvNQlAsc4rawUvZ
         lbxtEmuxHeu+X9fwghaQ1VIa+rHafS+7i5hvdUHAP9omifH456HyIAyVRs+H4OZ78dyO
         4VWdIdyAvMEcRK6CBtbE1dtqVaHNUg9ednhDrTRBDjqpBV4VxzaquLcP5KwhpcCz2l3M
         klMb2grPVD0Z5PLyBbX0PP9Gw1Xuhw+sOOAYCs9pDmq8gyLhB8ZAYvS2jZ20Fi+vg5ve
         uhCXNayj8WRiT0rrGWhWz796XuMSIeuwOlmYn0XUkChy87wdRwEdFQxvetImUslidHFx
         Zc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U9MFldUlI8YuKEyEgOU8kDAs+pi0T7vKsyhKnKGTjrs=;
        b=GTFx4jmAEqY7HZLJ2hk/pWxzHcy/KBU1ny6cDDx5hWEdU68kSgkTml5z3Nr4R6tCmh
         VxXUbqLPxGLA2Vp24pYn7JcRQEjLprUoClV9wMcUOqvxhFK3IGFRbMrtyALqs7aDF0Sc
         LwYby/dWB8s6hInWNBcau2Z6ssn71IsyYDHBQ4D40TXMVI+b33G2w9nfOlxCfKtf8c4y
         MkUK+3/5SsD9zetF/75LsJ+j6gn+WHpTbTRUZSNpKmChEY7NJuXNShAz0xlIvrlvrQZq
         cC0PDuhEUWdi/DNuJ+/w2cXw3mmNqaNKy4hSd7hhgH8iEr1czvxQHcRDL934yyadme26
         IEhg==
X-Gm-Message-State: AOAM5331iZuSZFJVQwDdibkI3C/vq+xQkW9ktFwf06q7zoVPX4rF1H4N
        6CZaSzpvpRdWFeAsv595zRv+rouK4Ms=
X-Google-Smtp-Source: ABdhPJw1RmDDrMWyFJKQ7n3xXxsChAg6SrV6I8TtssAKsFyGaB2msx9dJxTFQKSEtcp//ITLpexEpw==
X-Received: by 2002:ac8:7498:0:b0:2ed:c85:c9e1 with SMTP id v24-20020ac87498000000b002ed0c85c9e1mr10360705qtq.258.1649674331346;
        Mon, 11 Apr 2022 03:52:11 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y18-20020ac85f52000000b002ed08a7dc8dsm8436561qta.13.2022.04.11.03.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:52:10 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] firewire: Fix using uninitialized value
Date:   Mon, 11 Apr 2022 10:52:05 +0000
Message-Id: <20220411105205.2520784-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

If data is null, request->data wouldn't be assigned value. It is random
value, but we use it in handle_exclusive_region_request() and
handle_fcp_region_request() later. Fix the bug by initializing it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/firewire/core-transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index e12a0a4c33f7..16ecfa7da177 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -778,7 +778,7 @@ static struct fw_request *allocate_request(struct fw_card *card,
 		return NULL;
 	}
 
-	request = kmalloc(sizeof(*request) + length, GFP_ATOMIC);
+	request = kzalloc(sizeof(*request) + length, GFP_ATOMIC);
 	if (request == NULL)
 		return NULL;
 
-- 
2.25.1

