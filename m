Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E1F52FCAA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354797AbiEUNOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354370AbiEUNOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:14:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A60C38D86
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:14:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y41so9852922pfw.12
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/YxdBnzui3ni5Jh3oFs5foUUYY4daAUO1PEkpPdCqlo=;
        b=cK2xhVsGyV8VicAIx7RO1hnU738yQyl0C95qeHyJMhTXaHhYmXRvaUDq7GkJrXHDDU
         VaD71U3BRjiWyy7w5zQcGOdAVS10yh3fiGzlSCLHdGkGLCdTJjbzcEJKqZ3Jv7eAh1qZ
         PP6C/YIf5kG4pjSPFWMoCWcD0OwN2/+s1R3DH8DYBuQt5nr44+ElZ80GyCfKmgZ5V6mq
         /STJXr1jbJcSGOe95mHhXItNuhNKIuNltjLHBv9T/pw90dPdgx5pk/wM3FdEv4C4V0EO
         in9Q1ZrWW/+JccujTvceUy39LYWT6fb3Tw0l/xcl/q9l7zvWdC84ENEPpcr0kzWfMpPT
         K+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/YxdBnzui3ni5Jh3oFs5foUUYY4daAUO1PEkpPdCqlo=;
        b=f2RGzWIysP8dsOJr9L8LXtKDzLg04lAB1kPFiOS9o4rOiSu/aLS5HaoDRoS3oh0lIl
         j+9TeM0KKDbG1jQIWN8Q8KpLWqSY/3MhfE8cL1OZwKdYKrKgtCzKtWmGwrGoOQTA2+9H
         wmFkHuXh+qKPWqxCpN2jf2/dmQ58qaFqCODOeL2cIhc1WBCb2lUNvEKZC/dhkFxptpm2
         nOBVp8t8XhzWjd8SAe2P8zziIDQ4mQIytgdn8i5SaXUi3xTqP/zNEHD7LAOyDO177/VG
         9AnE1T187abZOCWLdVQSOR4wqQs3IziVOW0sDEIaalsCmdLrvUU1sQdmCjf+/0UgyXmD
         QdRQ==
X-Gm-Message-State: AOAM5322k5XKrvuo31wfp1b+MgNhgoLxRhYcbwkm5FCeswCGESmzL/C/
        s6UhRE2gWXTDzCp36XMBUfy6VtHFrMmvOA==
X-Google-Smtp-Source: ABdhPJyLWt4gX8XuEVkhq42WgdF3C0m9EL1l6FbEi/bqSXoDHDApDfOlBx9NvZ64lxpBhABsJYf9BQ==
X-Received: by 2002:a05:6a00:e8e:b0:518:287c:ce82 with SMTP id bo14-20020a056a000e8e00b00518287cce82mr14806077pfb.4.1653138844368;
        Sat, 21 May 2022 06:14:04 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902748300b00161929fb1adsm1573706pll.54.2022.05.21.06.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:14:03 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 08/13] openrisc/traps: Remove die_if_kernel function
Date:   Sat, 21 May 2022 22:13:18 +0900
Message-Id: <20220521131323.631209-9-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521131323.631209-1-shorne@gmail.com>
References: <20220521131323.631209-1-shorne@gmail.com>
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

