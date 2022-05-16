Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4835528D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345051AbiEPSmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344840AbiEPSmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:42:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D553E0FE;
        Mon, 16 May 2022 11:42:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g6so30402587ejw.1;
        Mon, 16 May 2022 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zD2cmGDI0QDaqSfgSS+PWLZ7wv6vJ0pT7+KKvGrmgP0=;
        b=Dk2VcD6Ob6Wxl0s29Saxdiyu0Qu3p694+/N78XobvJrelMJB8BXXDiRmVSmBmwvDYE
         IojUp80BBI6A97IKXY7uqG30Ny5AtPNdQF1/QdLOmgf/9o4KMS+5DP0JRxsiOz2t+3XY
         rw7wIFgLQdwKnPt5X6jU6mniNq27Rb0h9SwQ6heZC+Ovsf1xjpaiNbIE3F1TfDV2GghW
         Ktu8ECff5J6EiGGPUH90iZ1zASj2F7W7SHOaWyQB7t/MWVmQdV7mRTMe8qIYFjtUbkzU
         XLyKnjsYG4401GkbW9txkTQh5+RD3LUsfnJxJMLEo31MEfWDcpWtiHQnA+Ga2E+Y5vPQ
         b/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zD2cmGDI0QDaqSfgSS+PWLZ7wv6vJ0pT7+KKvGrmgP0=;
        b=msjOucJFbi1sbI4o+QpJTHE6T1x+lVHkDIUg/UcceB280edBT03gAjQ4rkJ77mKVop
         ETGh0iHAKz9nuEE5wU1be79XbItW99MiCnrGo6BTI+f0aLhb1AT3zjU8AZGetqkd/oaT
         RUDdGIqZsTirczGb2if5cUTRZQ9YA7elqc0bjGIsz0gUHjztGWgT4kCiJ23OzkZKU2fn
         PWKu8W8I2BA5wSaG1cIYGGnWHMEgXUGgOXMQS2kpDj5+WqmDslzGdRsa9IqT/q33aaDi
         IbzkVWiX2F2dZMDCT4MtJF2abSbEcg6AnRye+DXfFY5FPK93uJ6m3WF7pfF0mBVtMm4X
         RsXw==
X-Gm-Message-State: AOAM53072B3J1MoWRT7uMs9Zh8XcCCsa6eXzwgHf8wEqfr1ei+Hb88Zp
        SZNEOubTR2FPPZUUw6+5vyw=
X-Google-Smtp-Source: ABdhPJzb1nqIQPTNpO3v0ie6TXYdW89dGFEy1HflmPgEo6VRypohARbg8nRbkKkYvK0t2yIAENCBHg==
X-Received: by 2002:a17:907:3da3:b0:6f4:4292:6d6 with SMTP id he35-20020a1709073da300b006f4429206d6mr16584110ejc.162.1652726536490;
        Mon, 16 May 2022 11:42:16 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id eo10-20020a1709069b0a00b006f3ef214e36sm45823ejc.156.2022.05.16.11.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:42:15 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH] x86/sev: remove duplicated assignment to variable info
Date:   Mon, 16 May 2022 19:42:15 +0100
Message-Id: <20220516184215.51841-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable info is being assigned the same value twice, remove the
redundant duplicate. Also assign variable v in the declaration.

Cleans up clang scan warning:
warning: Value stored to 'info' during its initialization is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/x86/kernel/sev-shared.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 2b4270d5559e..b478edf43bec 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -201,10 +201,7 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
 
 	if (ret == 1) {
 		u64 info = ghcb->save.sw_exit_info_2;
-		unsigned long v;
-
-		info = ghcb->save.sw_exit_info_2;
-		v = info & SVM_EVTINJ_VEC_MASK;
+		unsigned long v = info & SVM_EVTINJ_VEC_MASK;
 
 		/* Check if exception information from hypervisor is sane. */
 		if ((info & SVM_EVTINJ_VALID) &&
-- 
2.35.1

