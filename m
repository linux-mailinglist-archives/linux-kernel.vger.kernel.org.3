Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B5D57EFFB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 17:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbiGWPPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 11:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbiGWPPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 11:15:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D6EEE1C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 08:15:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b10so6694662pjq.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 08:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aK0OouJ7vj79B3CKhHBNrE1LgvDzY0FwEUqvzc5U2io=;
        b=Me+qv1JnC+Uu5R2+FCTXCgSCsM0E/YDI8NLaPA0F2H9OTWqbaTC5nEXN9qMc9Aqxdv
         ugwkb0fc1MVfC6MvZk6xag1YyBNhFQ1E6zUPrglkqiePnFVir3krK342EHxEeIFy1ek6
         L6tgnj+wrThudBkYiv4EUwN+YD45nNbu4M3sqN0vZ5J547poqmeUka60lUy2RkXUEJri
         ZvA7XcChji0DrWhqdurdC3lviXeXfdlFuDlrH3CU3Fc/JTyhFMa3bsjUXmwOtPWHKuHy
         prbaMOimDfQdHS8qA43uvAD9widLwoABheuRd/UB1Okl7FLxXyRLV/gxfcR0n5RkVa1+
         9BWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aK0OouJ7vj79B3CKhHBNrE1LgvDzY0FwEUqvzc5U2io=;
        b=zIWayWgeO/jw7MU2qLV8UCCkdrg60g0kVc6mEBwn/Vpss9whvVA+gXIIdmU+qNFDnK
         Mhkb51Hb37My8YFgkob1qtaGq72HupGOzrm262mTMTEp7N/fjwirJThKAiRO5Iq0I4oI
         qcg0xP4kMmX8GESqAu9PKZouNwQp/wYCfv71YmNnWO3YqCWQ5BFJ8Ve4Cy3Lj/dv1YSt
         GliZntNghjZlDfcCsjqWof6rinfW2Fo185eUISGSR1hDicYUwIoZjJuYNHiewqML3DuK
         rBgvn2v32fUTNz7NaQ4/rGQ6xc3bV6p1QR4dgcBWuwmdMs9VfuAaw0lDeTljYqnhGBJ9
         7+MA==
X-Gm-Message-State: AJIora+Yx2G3SBtc1n5UWf40dL8c714GGDNoRZpgQEfw3fGp42gxgQcc
        LK2h8vpftYDQv9PgB4a0mbk=
X-Google-Smtp-Source: AGRyM1t3kZHIwiwfGy1nQBE14Z/D3Z1d5e2j78FpRwfman4hragA5vIF8Y5vI619e+yI8OXGGPHqoQ==
X-Received: by 2002:a17:903:32c6:b0:16d:328f:898d with SMTP id i6-20020a17090332c600b0016d328f898dmr4743715plr.143.1658589336430;
        Sat, 23 Jul 2022 08:15:36 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id a5-20020aa794a5000000b0052ac1af926fsm6071350pfl.20.2022.07.23.08.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 08:15:35 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RESEND PATCH v4 0/2] x86/asm/bitops: optimize ff{s,z} functions for constant expressions
Date:   Sun, 24 Jul 2022 00:15:19 +0900
Message-Id: <20220723151521.51451-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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


** Statistics **

Patch 1/2 optimizes 26.7% of ffs() calls and patch 2/2 optimizes 27.9%
of __ffs() and ffz() calls (details of the calculation in each patch).


** Changelog **

v3 -> v4:

  * (no changes on code, only commit comment was modified)

  * Remove note and link to Nick's message in patch 1/2, c.f.:
  https://lore.kernel.org/all/CAKwvOdnnDaiJcV1gr9vV+ya-jWxx7+2KJNTDThyFctVDOgt9zQ@mail.gmail.com/

  * Add Reviewed-by: Nick Desaulniers <ndesaulniers@google.com> in tag in patch 2/2.


v2 -> v3:

  * Redacted out the instructions after ret and before next function
    in the assembly output.

  * Added a note and a link to Nick's message on the constant
    propagation missed-optimization in clang:
    https://lore.kernel.org/all/CAKwvOdnH_gYv4qRN9pKY7jNTQK95xNeH1w1KZJJmvCkh8xJLBg@mail.gmail.com/

  * Fix copy/paste typo in statistics of patch 1/2. Number of
    occurences before patches are 1081 and not 3607 (percentage
    reduction of 26.7% remains correct)

  * Rename the functions as follow:
    - __varible_ffs() -> variable___ffs()
    - __variable_ffz() -> variable_ffz()

  * Add Reviewed-by: Nick Desaulniers <ndesaulniers@google.com> in tag in patch 1/2.

Vincent Mailhol (2):
  x86/asm/bitops: ffs: use __builtin_ffs to evaluate constant
    expressions
  x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to evaluate constant
    expressions

 arch/x86/include/asm/bitops.h | 64 +++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 26 deletions(-)

-- 
2.35.1

