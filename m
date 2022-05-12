Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91475241F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349879AbiELBUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349868AbiELBUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:20:16 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD10287A24
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:20:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p8so3428070pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TrL32Nt81/NQSNF8rFsX4dzPpMYEmEyoU2tdFctinr4=;
        b=p5W3iSAAD3DwAarCXV14GiMOE8396VxmuWGBCC+xBcGLRTuEqMlpBQfVKva3ueDvWT
         suWJIUZdtVoZspuRBIIN2bln0EIkuXe012K8U4Y/JaMq6eMO5UfuT3N+3JOnAsgkcXen
         gOhWf5bxWbzseK2JAMJio558696uP62Yx+wGvQkydZj8XnJQJ2uuD7exdHLmXcYto1sx
         3EWH81ZE3M4ykhLLqJIYN3YQ9MZ9lS7i2ImGPZ3tCm3U8aCjD46VeNuCLEaCVKkb/BXp
         yy9FgwlGuCvF3wFQo3Nuyk2TsLC1OAxeUePrgahcNmK+BwgAcFN8hKCLARhaFRyoJvIl
         +cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TrL32Nt81/NQSNF8rFsX4dzPpMYEmEyoU2tdFctinr4=;
        b=qmgOPomGLyCKOR43r56P03kHQTpQ1qH5EjdTZb/qopIdh17ElAxjgF72WAZ6W5q3+X
         KIS/wQ/S/ZbSnUfzgrQ2c2D0hQcH32VjLzZyNJ+aMm3cUcHGrsvuGKSAZ9w5rb7NyQF3
         TwSjV7je9inxBxar4ufkKx1q9xV+peIFWtWFF+5C3y0rvqmb8vhR0i+e1VyS9fZ35J4b
         RhFgeExVrgpkFV5hFhPu1/KAqJcOkwV4iGmT0mFSZF1rrksp26TX3m21Lmzut+R/TQNc
         vifyVz43+PuNF67kR/e22lxlSA/aGiiEcYpSSZukiu7EoriWhyt/w0AzWaz7rUxPx671
         3cqQ==
X-Gm-Message-State: AOAM530wPhZU3sbFp6Zv4y9dQLvRSF6dXqoH6KkNxadjBpZYeK8yyFI8
        eMp2GNdYA60MQ1tJ5YH+EbI=
X-Google-Smtp-Source: ABdhPJxRTun1qVUqHUyyz1PVhV+O3qL8/7in+R8xB5f2DcN/ETKRNWSBuH7fEp7PGnxG5CqugWyp5A==
X-Received: by 2002:a63:88c8:0:b0:3ab:1871:13b4 with SMTP id l191-20020a6388c8000000b003ab187113b4mr23246137pgd.85.1652318414220;
        Wed, 11 May 2022 18:20:14 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ea8500b0015e8d4eb24bsm2545978plb.149.2022.05.11.18.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 18:20:13 -0700 (PDT)
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
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 0/2] x86/asm/bitops: optimize ff{s,z} functions for constant expressions
Date:   Thu, 12 May 2022 10:18:53 +0900
Message-Id: <20220512011855.1189653-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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

