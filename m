Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C933C523800
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344225AbiEKQDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiEKQDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:03:52 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4511912CA
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:03:51 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y41so2351977pfw.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCk9G2cMF/SICHI8ao9nOv/XHwNyqHuD3L/gqBqavrY=;
        b=Jb+K99Cb+7nxhYnfUAhHLzW7+vUWuxV6Kf0/rR3ZSUpywfQa2f0Qv6HS3km/PVCdqu
         pAh/XkEMKdnieUol2I2IMdLbThGsSHTRt9L7srPIEiSdgADymqSFzoTpYDBvJuo5q7Qd
         Wko3GGDAaMtPyShp5qgaAz38Jc/J4oetIsbcEcMcAhXncDeKgjjH4StDv2F4s/wB7Kdl
         7Cnd76NrobAFKklidqp/jtkZszqNfUujZx5T6Dnmxx7+Dkxj1gBUBujZpQCOvAvL9wj8
         RdjTvsnIXn8MUGZpPFmrppdzwdQJwQ86aAWXXB0RCQFclcNbKg28Pqs/LVVnLCnSHPHO
         0vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qCk9G2cMF/SICHI8ao9nOv/XHwNyqHuD3L/gqBqavrY=;
        b=4BUE99wzvmssGUdKIwpZZ1YSqvAonlIn/Qnu/xvMaq6F/XkVV7dY7r/5wBHtN99tfb
         dkmJ7cmy8+tnG76fGyI7FAlrnXFEWsg3r5tFRxoYSBVC8QJacmaIK6uMnP+Py5CNHczM
         4D2+6oXIsfT/KWzz1XsA8+KldEjleGymv6i/J5K51zv1TbZADtRN1if0ieEW0U+HgFTL
         Iubei+THTjcA9LTVd9hbsq6aXfPJ+npxnElsnl3HwksECEZfLxkdyoa2Dy1XwXtZAcQn
         8Gm7JeUBdo15rQQMz2DAt000dfxbOiUGgozEqz8uT2ANtBjb+BWMF5wIzJUhfDY1pOBz
         EYkQ==
X-Gm-Message-State: AOAM533dQsXpVqOW6TBkbmOLV8ZeLwNS21RIak9jAX8vtJFBeQIEjKRY
        EDocEJ9kwL/5GCpuBvVeV2E=
X-Google-Smtp-Source: ABdhPJwDwa3EeRhPSh3wZNtTpQRSsX/wuSkDCgVa1eB8kFVLzoEbYADPoQgefeD/7eS30ImXym4+FQ==
X-Received: by 2002:a63:751d:0:b0:3db:2e7b:f93 with SMTP id q29-20020a63751d000000b003db2e7b0f93mr2560049pgc.496.1652285030554;
        Wed, 11 May 2022 09:03:50 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w11-20020a63c10b000000b003c14af50624sm42825pgf.60.2022.05.11.09.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:03:49 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 0/2] x86/asm/bitops: optimize ff{s,z} functions for constant expressions
Date:   Thu, 12 May 2022 01:03:17 +0900
Message-Id: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compilers provide some builtin expression equivalent to the ffs(),
__ffs() and ffz() function of the kernel. The kernel uses optimized
assembly which produces better code than the builtin
functions. However, such assembly code can not be optimized when used
on constant expression.

This series relies on __builtin_constant_p to select the optimal solution:

  * use kernel assembly for non constant expressions

  * use compiler's __builtin function for constant expressions.

I also think that the fls() and fls64() can be optimized in a similar
way, using __builtin_ctz() and __builtin_ctzll() but it is a bit less
trivial so I want to focus on this series first. If it get accepted, I
will then work on those two additionnal function.


** Statistics **

Patch 1/2 optimizes 26.7% of ffs() calls and patch 2/2 optimizes 27.9%
of __ffs() and ffz() calls (details of the calculation in each patch).


** Changelog **

v1 -> v2:

  * Use the ORC unwinder for the produced assembly code in patch 1.

  * Rename the functions as follow:
     - __ffs_asm() -> variable_ffs()
     - __ffs_asm_not_zero() -> __variable_ffs()
     - ffz_asm() -> variable_ffs()

  * fit #define ffs(x) in a single line.

  * Correct the statistics for ffs() in patch 1 and add the statistics
    for __ffs() and ffz() in patch 2.


Vincent Mailhol (2):
  x86/asm/bitops: ffs: use __builtin_ffs to evaluate constant
    expressions
  x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to evaluate constant
    expressions

 arch/x86/include/asm/bitops.h | 64 +++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 26 deletions(-)

-- 
2.35.1

