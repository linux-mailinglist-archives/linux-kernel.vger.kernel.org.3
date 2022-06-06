Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF60E53E79E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbiFFLLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiFFLLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:11:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35AF244080;
        Mon,  6 Jun 2022 04:11:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id v1so17546071ejg.13;
        Mon, 06 Jun 2022 04:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5dkAFM0Ntd+L8H4UaOt5V9mbAusEKvzKxThmfKqM4zs=;
        b=TEU7MbFsD9GboY+2C1GNl01obmtEJfCtA84n7qy9cN3aY5jN1AdyJzlAvdS7qx88RM
         ncDnjPRncz0zLsn++zoOHtIcPl+vahRXoH61BElnLKTyr7oe3cqs84wfer+8yXCMLTt9
         5JG282VRn+t0olG+N3Lz5d2jIBq69GbEE3bqmWfGIxSRm0gbCwS9n5thC3XQkIkDfWJa
         wLTiu6isNbM0c7X46eIV5x9NIYsvDfzwm8i7qWMcoossRZkMDSAYJ/vYVZWczCkfXWfn
         sjz99IdJPKWAWi/fZrExPee5uJCSICC2cA/OEkzgqLmYtLRPvJIfxURoqmeUQWcjPkQg
         PzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dkAFM0Ntd+L8H4UaOt5V9mbAusEKvzKxThmfKqM4zs=;
        b=abboXrXNqnK0mby7LfTf+pf8JTqSaXh70zldPiHEo5Vgn0pCkxRqHVjo1f57WX33Df
         GhkvBDtqKrgITpuFoe3rR5N9JIsjJG5ZiRpdEGhxRyGX8PUJfIKcEPzYr6J3OkyATVSw
         bQ3zQbcHSpx9lirHjmOBvBZ3O1SQglB+x+eq+zzxXIdyBPdHpC3q7R6VsJYRx7+Q2etR
         Ii1euaNcia8JVMsfpS7LcRfs82yV6m6brQnwg12Iu0Oc850/Nnu0a5sMcppvU+AohAqz
         OtM9l7iHEkdKqZqiRW8TkjsecS1/22MhzRB/rHGHhVHvJyo6hX02YXMOGkqkZqgmsIWq
         2CYQ==
X-Gm-Message-State: AOAM532WCOVXBMFxBDRtLEhoYntHoB6vIi4zZfBVGins5wVnevOiSg0H
        fc/bmOZLx5av1RdMDHkRdYM=
X-Google-Smtp-Source: ABdhPJxohOMH19X1rkNAgT3/VwPn0GgVou8p/7lLyJsCir6/1AaIt0yoRMKAB7+YgGERbK6nfcuMfA==
X-Received: by 2002:a17:907:6282:b0:6e0:c64a:60a7 with SMTP id nd2-20020a170907628200b006e0c64a60a7mr20791455ejc.349.1654513879169;
        Mon, 06 Jun 2022 04:11:19 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id z14-20020a170906074e00b006fecf62536asm3843506ejb.188.2022.06.06.04.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 04:11:18 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/5] PM / devfreq: Fix kernel warning with cpufreq passive register fail
Date:   Mon,  6 Jun 2022 13:11:01 +0200
Message-Id: <20220606111104.14534-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220606111104.14534-1-ansuelsmth@gmail.com>
References: <20220606111104.14534-1-ansuelsmth@gmail.com>
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

When the cpufreq passive register path from the passive governor fails,
the cpufreq_passive_unregister is called and a kernel WARNING is always
reported.
This is caused by the fact that the devfreq driver already call the
governor unregister with the GOV_STOP, for this reason the second
cpufreq_passive_unregister always return error and a WARN is printed
from the WARN_ON function.
Remove the unregister call from the error handling of the cpufreq register
notifier as it's fundamentally wrong and already handled by the devfreq
core code.

Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
---
 drivers/devfreq/governor_passive.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 09b6c852fccc..ab393c8174f4 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -325,7 +325,6 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
 err_put_policy:
 	cpufreq_cpu_put(policy);
 err:
-	WARN_ON(cpufreq_passive_unregister_notifier(devfreq));
 
 	return ret;
 }
-- 
2.36.1

