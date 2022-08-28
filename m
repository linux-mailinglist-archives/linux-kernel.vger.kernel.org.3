Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF655A3FB0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 22:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiH1Uvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 16:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1Uv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 16:51:29 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9125521A;
        Sun, 28 Aug 2022 13:51:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 142so6406589pfu.10;
        Sun, 28 Aug 2022 13:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=CZ1UYy559cJCnBfDARk3iy3GbnYwC4JJkHYcAm3KtAk=;
        b=qlkmgsnPFrDWXw7R17q9Xam4a/9+loTfNOvjbxoALnGSrdxbs+b+2LNpFCPCn56cMk
         A5G2YaRlnj6hmNucVKac4qNmUHQ/sY5583oATT0gU5SMjjAQa/1GolH2efOyg7R4E30m
         vr4JOz16u+IKNHjBGsOVNs60/zgEhjgtVS7G0azJ4W5QjrQBJW0f0GeDX8PsLslaXJmW
         2nnjr9yIZ0NLuW6KikN1MmVW7A45ylV0ut+NuJVroB8nffLrPhoP/nycGh9bE8HyCaQB
         sNIHPOxvb++wke7MMu8rcx41eLGgV5Mr6JLFSTdXgi4eql8c0RE/Wypfsh9YIMgeSoRA
         kmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=CZ1UYy559cJCnBfDARk3iy3GbnYwC4JJkHYcAm3KtAk=;
        b=69k+8glelkaAstV99mbVspZirYJT6PMwVtoUbRZllflrRkx1ff3Lw5AM1lKHi53QJw
         d7Hra5XcOpYuqrXKXOOgsJRHe+fe3uoio3uFHaID26SlsHGlKVRQiaiNIBqT9QmuO0G3
         Y6IJD6z3zk2Kb69YaFscpqtBUs4yn0pnCqvz6u+GUqmFPHm0kKNpzVD5yLpx15V1tYnP
         qLPzXkj6mqKx5i1K+xOMHY2QsByUNoJkX/IWLdWcy0+Ndbw8kDiUHe7cZFs4LPIwyc9k
         rn/l3iU16nejZFvjDBRAjnfy8QU4WvxJ+HIxs3RBEVPr9OL8Ea3p7aIwvckEGWbiEshJ
         C57Q==
X-Gm-Message-State: ACgBeo19wyTnkCCSYY++ALc+4NRulJ/XekUZApvOCnQ7auPfblPPt3Eq
        1xmkxPkKDGQh1kmBbyDXwhKanBEWpbJrmg==
X-Google-Smtp-Source: AA6agR5TSUA12VygsTLXxLORGx6tufeN4gnBGLGB3bg4qebvu1iP0FQFoCGmX40kO/Rn3PhFfVNK5w==
X-Received: by 2002:a63:1e61:0:b0:41c:45d:7d50 with SMTP id p33-20020a631e61000000b0041c045d7d50mr10987636pgm.507.1661719886873;
        Sun, 28 Aug 2022 13:51:26 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id l23-20020a639857000000b0041a615381d5sm4982312pgo.4.2022.08.28.13.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 13:51:26 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mario.limonciello@amd.com,
        hdegoede@redhat.com, Shyam-sundar.S-k@amd.com,
        mika.westerberg@linux.intel.com, nakato@nakato.io,
        lily <floridsleeves@gmail.com>
Subject: [PATCH v1] drivers/acpi/x86: check return null pointer from acpi_evaluate_dsm()
Date:   Sun, 28 Aug 2022 13:51:20 -0700
Message-Id: <20220828205120.1956222-1-floridsleeves@gmail.com>
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

From: lily <floridsleeves@gmail.com>

Check return value from acpi_evaluate_dsm(). Only do ACPI_FREE() when
out_obj is not NULL pointers.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/acpi/x86/s2idle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index f9ac12b778e6..1b449d3cfbf7 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -328,7 +328,8 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func, unsigned int func_mask, g
 
 	out_obj = acpi_evaluate_dsm(lps0_device_handle, &dsm_guid,
 					rev_id, func, NULL);
-	ACPI_FREE(out_obj);
+	if (!out_obj)
+		ACPI_FREE(out_obj);
 
 	acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
 			  func, out_obj ? "successful" : "failed");
-- 
2.25.1

