Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB652778A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 14:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbiEOMnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 08:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbiEOMmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 08:42:36 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234D211C0C
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:36 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so11231993pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 05:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/YxdBnzui3ni5Jh3oFs5foUUYY4daAUO1PEkpPdCqlo=;
        b=CUCIL+9IqRDN2tJAKVtzSzg97nX5O/JVAGHwOTY5DEpkHUytrXA/oXzlwAwXb2WBb8
         8N2nRud02vIqlwXUP4YZnnsD9AxZu8iQtGS0pp5/8XppjqZnmaE07Wz82rf+a+DSfpBt
         ekv1ybRFgnpr6UTANmIfRECHA1i/xQ91h9vPuP/t/pCZxhtGF74ECwz0v0/Jb4den/pl
         B2ymDTQk0nfTvlwnAMloyqPyY3m/ADG/xu5L98Zldy5/WwcpmZd6SsdGC2mICJOlk7rc
         tHvBznNJt1polk4ODdmghCrvTMXZVeA5uN4J9yIr5meyA9JA1Yk88zBWmxmOxcmEmSBH
         nVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/YxdBnzui3ni5Jh3oFs5foUUYY4daAUO1PEkpPdCqlo=;
        b=M4vMQDulvNAxcSieL1zKyWKhJRnp6ZI9szLio2DCrIF/tZ4/j2LRH265XeVmyGCbW2
         X1Qqo5pCdGWt6IT8a+ITAVqFLSFFQMeZiWPNo11p+nd+XoahDrk4q0xfqcHMbHvqTXGu
         MFhTU3jH1S/MwalQjkYVyvqmpWp74xZv5Sbr3zm7xW3JpTEsQ7pBNQzZggG6OrLWkLfG
         FRdYQnhWqxF6Vm3Hd7S18/R/wxVvXzvdwlRhamKwx3O54XkquR0NUEb4LeDocBD5cgpj
         GRDOYSe6QZrIRmcaYTllz8f92jBlzJ8UiyknMG816vOUiuTiIKB+YqBEvz+OTbLKpSX+
         ayFw==
X-Gm-Message-State: AOAM530zrFgP4ckzEu/FN7DxZdRey5jXXTi6QKsdtWkCVMiApx4WjiCw
        hzSPCMtY54z+z9OsUNAJCeVWetF8SyP0og==
X-Google-Smtp-Source: ABdhPJwll4DIMNy2JuWm6ejdna8WNoX3+eiQHDVN4fLW8HnaNS1u+hk/bQv2o6r610cu+5jGCXD9vQ==
X-Received: by 2002:a17:903:240f:b0:156:8e81:a0a3 with SMTP id e15-20020a170903240f00b001568e81a0a3mr13027370plo.13.1652618555086;
        Sun, 15 May 2022 05:42:35 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id c9-20020aa78e09000000b0050dc76281ebsm4945390pfr.197.2022.05.15.05.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 05:42:34 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 08/13] openrisc/traps: Remove die_if_kernel function
Date:   Sun, 15 May 2022 21:41:53 +0900
Message-Id: <20220515124158.3167452-9-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220515124158.3167452-1-shorne@gmail.com>
References: <20220515124158.3167452-1-shorne@gmail.com>
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

This was noticed when I saw this warning:

    arch/openrisc/kernel/traps.c:234:6: warning: no previous prototype for 'die_if_kernel' [-Wmissing-prototypes]
      234 | void die_if_kernel(const char *str, struct pt_regs *regs, long err)
	  |      ^~~~~~~~~~~~~

The die_if_kernel function is not used in the OpenRISC port so remove
it.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 9e0937eb31ca..99cd2e6f8873 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -235,15 +235,6 @@ void __noreturn die(const char *str, struct pt_regs *regs, long err)
 	make_task_dead(SIGSEGV);
 }
 
-/* This is normally the 'Oops' routine */
-void die_if_kernel(const char *str, struct pt_regs *regs, long err)
-{
-	if (user_mode(regs))
-		return;
-
-	die(str, regs, err);
-}
-
 void unhandled_exception(struct pt_regs *regs, int ea, int vector)
 {
 	printk("Unable to handle exception at EA =0x%x, vector 0x%x",
-- 
2.31.1

