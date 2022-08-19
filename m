Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC0759A8BE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242756AbiHSWoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHSWoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:44:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D706F108FAE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:44:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso6116932pjo.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Erbhv9qJxxmv8I4xE++m4WGQox9PmBPC52DMICZWm0o=;
        b=K80i5SAoEGl+TSPxBtIbWRg1n6X1cknrKpHf4OAT7rIADMjckEdb+qnQ30HK17wLfJ
         JVWeukprhVmqiJ/jRYop9BQoJbei8wq0CHd02P+Kmx/1HPBF98dUfhUWcQ6gHEdaxkU/
         FX7ug5WYMqGEhGW/PvQcSwcYX6agjFlhovm7rpVjbD+m1SjMFiyYhAVeTlRH+UOmqJ0P
         VQE3y4uL+TTAqoseZWZdKK6E/lsuWpsQuqdAUaFCCdp92EngsuiRtak+tNYIIIhQCBAZ
         4d9GXkUBDN9tMuElwJXvZ/629tdsI40ul2fWWFCfJ8Q31xP/x1LpeehXZjMIKaFJT+VH
         6Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Erbhv9qJxxmv8I4xE++m4WGQox9PmBPC52DMICZWm0o=;
        b=RxuFHoDbpQbm7bW6Eq/NtZgUm3aitSJv+VUnCmiF7uzb38c5loWRt9ytkeClOIf8I7
         DG3c1gJrzaUsnWYipj8z3cHtLPVeeCOPmUXYv+pCRvYHPDMuHaTrzlrHJBo9DP/u/VlG
         xwQOVPkMlIl77ONu1jj862ZNYnkbARJURewEGyqPv+pHKWz7l4BI0yXOB0DJtvws+I8F
         CJBFEjs5XqEehQjWcRWfOJAF10djyjTerTNGh8/J6Yo98DryYYhsNIvhd+YYYHhIuk5Z
         jmD0/IEFrO58Bx7Cu4m21Gh44oAgf1idnnTLXgl4YsU+HzxOjqhqADfYVVmKhsBA72Vj
         GTfw==
X-Gm-Message-State: ACgBeo2rFJFgLeHU+vW4QKul5et1mbU7WHXtEdgGkJmcnwO87X7nmBNO
        ejfO0TS4HmrpVQBqrUuu+l+Isw1k0Fd/6xpY
X-Google-Smtp-Source: AA6agR6VLdLgFnIX8rMIoEelT9W2gJs68CKlnXwfrx9SyFBjuXp0aNPjbPmqKdP6VDXBDRTOgyFjvQ==
X-Received: by 2002:a17:90b:4c05:b0:1fa:e826:9da9 with SMTP id na5-20020a17090b4c0500b001fae8269da9mr4808127pjb.9.1660949054704;
        Fri, 19 Aug 2022 15:44:14 -0700 (PDT)
Received: from localhost.localdomain ([47.154.96.63])
        by smtp.gmail.com with ESMTPSA id u7-20020a170903124700b001726a4ad819sm3666230plh.114.2022.08.19.15.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 15:44:13 -0700 (PDT)
From:   Russ Dill <russ.dill@gmail.com>
X-Google-Original-From: Russ Dill <Russ.Dill@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Russ Dill <Russ.Dill@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] x86/boot: Fail gracefully if SMP MP-table early_memremap fails
Date:   Fri, 19 Aug 2022 15:44:00 -0700
Message-Id: <20220819224400.2667654-1-Russ.Dill@gmail.com>
X-Mailer: git-send-email 2.36.1
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

At least one older motherboard (Micronics W6-LI Pentium Pro) has been
observed to fill in the physptr but not actually populate the mpc when
only one CPU is present. In this specific case, this leads to the size
field being zero which causes early_memremap to fail. This then
causes a NULL pointer exception in smp_read_mpc.

Add a simple return check. Returning -1 here will cause the MP-table to
be ignored and the system to boot in nosmp mode.

Signed-off-by: Russ Dill <Russ.Dill@gmail.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/mpparse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index fed721f90116..ca2af4f42cb8 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -438,6 +438,10 @@ static int __init check_physptr(struct mpf_intel *mpf, unsigned int early)
 
 	size = get_mpc_size(mpf->physptr);
 	mpc = early_memremap(mpf->physptr, size);
+	if (!mpc) {
+		pr_err("MPTABLE: mpc early_memremap() failed\n");
+		return -1;
+	}
 
 	/*
 	 * Read the physical hardware table.  Anything here will
-- 
2.36.1

