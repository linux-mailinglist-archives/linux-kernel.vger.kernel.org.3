Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E837F4FFACA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbiDMQBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiDMQBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:01:04 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A195863513
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:58:40 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id l10-20020a17090a72ca00b001cd46918af5so1502818pjk.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=esOVAp2irCJ3Vjv6n3zKptfZxPr7nea31riVyn8IwzA=;
        b=mugdlaJfqV6BzoMRpaiK5wVOC89SQxXWIv/7SA2IWoQeqGxtkOVO5e99zdgZO6ByHl
         waiSJsfhCL8jqtYwCQ+fct8ZE+R7hsIX7mDJG3xCepYJfGzVjAF17sRtKceMz1Ke6++B
         jjzcxRMODxHIXlk+civmhu5EkMlEGgmhhDBQ39UBF8bdxHZTihLRAEhZ+kFHYq7ZqRFj
         BGZxnU/CjHVMuSNUZ+YeDA5zl9m/A0BEuNgfjkFNb5KPtaZ10l4OfZXEfO2hotQy1l2A
         LmoeViJzWmwIYiPEioHmqUIQ/ZkrOXZayOBr74hv0PSB3twNNCLdMtbml7MOTKkjjJjB
         KcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=esOVAp2irCJ3Vjv6n3zKptfZxPr7nea31riVyn8IwzA=;
        b=aS0zJvsJrF1UcQ6hbr/yFIcw2uA8hQtt0ZzTkYonI8hnHNnGGUOQHUDGqeCN6cLPpL
         VUFJd8SCAYx3PB/9YzIRt6HyR17eAO0Kdv9uVaEZq3ld1EoU1PIzja+2uXOMpLDVs/VR
         t9J63dFGqPGGVaDfrse3Yz22obiiJ5uDjGYxV1fCgiDXykcPPvqDBj2YWjzG6jqUAjZ/
         30ug+xMhIcqxF46wPPQ9PG1Fdfq014lNa8uKPDMdMiXj9Fi7/UT4GTBb58yJH5qtyjR2
         01At7Nu+fHPM7u5XJ/fd8Ekxt+jyHCMNDuf1ubYo+OY0imRe4fxC9pTkwodWFi4RnW7y
         QAPw==
X-Gm-Message-State: AOAM53399LSZlWp6KA/dLX3RnP4m/BMMcO3g7DxVw1RVS7mr0TT0s7GO
        hNgDyO2ZiRmwsyUPWJm8p4rOsq5K7q0=
X-Google-Smtp-Source: ABdhPJxIsFvYT4ZGMIA9rMTLc6Euk99wC0DXG4Y79LtsWB+wAou+COvDqA1Unv9b4P15r7HklQzyIXoFiTI=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:9bb6:f53:456a:fd2d])
 (user=pgonda job=sendgmr) by 2002:a17:90b:2384:b0:1cb:5223:9dc4 with SMTP id
 mr4-20020a17090b238400b001cb52239dc4mr58307pjb.1.1649865519822; Wed, 13 Apr
 2022 08:58:39 -0700 (PDT)
Date:   Wed, 13 Apr 2022 08:58:35 -0700
Message-Id: <20220413155835.439785-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH] crypto: ccp - Log when resetting PSP SEV state
From:   Peter Gonda <pgonda@google.com>
To:     linux-crypto@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        David Rientjes <rientjes@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when the PSP returns a SECURE_DATA_INVALID error on INIT or
INIT_EX the driver retries the command once which should reset the PSP's
state SEV related state, meaning the PSP will regenerate its keying
material. This is logged with a dbg log but given this will change
system state this should be logged at a higher priority and with more
information.

Signed-off-by: Peter Gonda <pgonda@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: John Allen <john.allen@amd.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/ccp/sev-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 6ab93dfd478a..fd928199bf1e 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -435,7 +435,7 @@ static int __sev_platform_init_locked(int *error)
 		 * initialization function should succeed by replacing the state
 		 * with a reset state.
 		 */
-		dev_dbg(sev->dev, "SEV: retrying INIT command");
+		dev_err(sev->dev, "SEV: retrying INIT command because of SECURE_DATA_INVALID error. Retrying once to reset PSP SEV state.");
 		rc = init_function(&psp_ret);
 	}
 	if (error)
-- 
2.35.1.1178.g4f1659d476-goog

