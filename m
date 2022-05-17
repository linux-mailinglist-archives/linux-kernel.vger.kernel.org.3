Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445E7529647
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbiEQA4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbiEQAzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:55:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2080B1FCCE
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ev18so5357878pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/YxdBnzui3ni5Jh3oFs5foUUYY4daAUO1PEkpPdCqlo=;
        b=WHGy/FigKtpjnR0C/zvZzZKw82dDIx9z+0NO4/b1iqKaQ/L6icwl70tjS+vHAAlnKj
         TVt4JbXCTMQUOyaPvfYy4bIrT86YM0bKZT+chnoq6SJX7+2OhqLV/YUXuXJVuvVDxzJA
         h14DGve6uUkDhDNUXn8tD7mOT4nCvcP4EKHCdrp8yyhFQGYRTS/sKYQtN66O4GzzyQHx
         kGFltFCl5MTjCJjEd2YCa8rZTffpg9XoX2bdzfCXAM+MysAZH+jgmnUzJVPXyGxeC25K
         PN11R+jIzWdIZLs64/9MshIAogvSw8aVUiH0E0quNX/Eqewn5/qXV+4+0QqgJwc9bPwe
         YdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/YxdBnzui3ni5Jh3oFs5foUUYY4daAUO1PEkpPdCqlo=;
        b=7W2Fq0qk1wTFzColS1ad0QDNZP4fWamjCKjRFc6xCw72B5gGg3WZGoZES/lgzCEj9D
         1lpj+cWLjj1iI5gawN1BEfbplqwwp6RLydKJvoNpXdNULHS9H8FhwFKFiEs6da88RBFa
         Q0idsKxSpow00/1hgwdo2iF6cBre/eydn2bRKCh6B3l5hHL4vDQNSpqtds0K4qEqrfU6
         ruQvr19ApiesKv+dryCbzfGl7fPvpEo2itCfAzERavFY/3mXcaNyIIxwSGHHSdRpHECX
         j3ELdFjU2vOF/kkZDhfZRhvtwa+MRxXYJUpL/0iME9NywdJaDAgCJlAqx+cuED/TCXyd
         RkDA==
X-Gm-Message-State: AOAM530EqNZYjeXgyWD1Robe9swc1nPm6RGuoQRp+Cgo5ATslI1izNBf
        v97+QugRhfxIdIzGTT/la4O8o4Qchxc7nA==
X-Google-Smtp-Source: ABdhPJy5VHtPWLlYSrYw1gcfTPLMW48qsnQGgyFXX1YLRyLH78izI4koIEmJWPPcAq4bBJMclmC/6w==
X-Received: by 2002:a17:902:cec9:b0:15e:cbf4:c246 with SMTP id d9-20020a170902cec900b0015ecbf4c246mr19899475plg.1.1652748952205;
        Mon, 16 May 2022 17:55:52 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id n16-20020a6563d0000000b003c14af50607sm7243875pgv.31.2022.05.16.17.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:55:51 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 08/13] openrisc/traps: Remove die_if_kernel function
Date:   Tue, 17 May 2022 09:55:05 +0900
Message-Id: <20220517005510.3500105-9-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220517005510.3500105-1-shorne@gmail.com>
References: <20220517005510.3500105-1-shorne@gmail.com>
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

