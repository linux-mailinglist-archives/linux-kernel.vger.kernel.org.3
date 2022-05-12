Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA547524151
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349527AbiELAEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349536AbiELAEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:04:11 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611FC79823
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:04:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c9so3374440plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Du8y+3TBg8I2NiIb6Nb+MDSCb6olYthJ0zX2ujarAf0=;
        b=SWpJF80SqudeT/4smk+lrQtIdS+dYPdT4M5XoiBfPN1fuiqTSctEgwZOD3qhYYv6pi
         WBx13fXeNgNuntUc9o4zJajW2+D0nibznXc28BkDyBmF4jfQHi4/MheBsVxjjSlrcrGI
         /cJcdw9BUdCEn2Qz43+1nJmN8fk7c18WXDFH0cAMIqKABJ2QAJdYS/xTmYtZBB/zC4uS
         vYrtclIKrCrXiggQ2TkHkAKy56xdda68/7A/Bi8E1NW8UbghA0MoyT+NH8yvhtohfAwc
         hfzrkykv77bdxRJG6osYdt5EuGhUNlOZnJbTLUGWI6VPZI01wUytdoOUPyG5GVQ88nH1
         cAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Du8y+3TBg8I2NiIb6Nb+MDSCb6olYthJ0zX2ujarAf0=;
        b=KFK57SgebJhDdy9xpQByhy0L6bLN+WIa5F81g0UR/tQY+Gr7zB6m5ZwVzx3d+1sJSI
         LwXpREsZ9AW7eBTjkthivHFuyHaX9aUNKBPFeRIOZUXAZbwWP+sQe2hPlNCPcMn0BsaJ
         v8fEcolPWcm9boVHQr9Mx90lFyUA+ZnSyNcsz5M5o4dAkuzFc2K+aFNTlRSY1dEjrBs2
         EW5JGxrFhSF7c2ioa+HxWipzn+8HypHZXTszfgOySO6cgJ9M2oBBQqhO7WAcP3+mqulq
         MyJmGVtbNI/BC1H0Lvkfju62ZucIMFM4vXbaBw0+6+8LWwhKTr6U+6vs/BDjnbEGoN68
         i2WA==
X-Gm-Message-State: AOAM532CgXKq9S9eHI1dAUiPBIyeOqib/6UgHHQP87AykTm/M65MdRQy
        IF2Iy69zoCkdySoLTmbzqyg=
X-Google-Smtp-Source: ABdhPJztYrd322lEcizPl8SZyJK9pwQmXTrX5c830/IReHH6IUvKVZEKaYXL8VlZxw9QR/DZK29OnQ==
X-Received: by 2002:a17:90b:1e50:b0:1dc:dc64:da90 with SMTP id pi16-20020a17090b1e5000b001dcdc64da90mr7905954pjb.58.1652313849684;
        Wed, 11 May 2022 17:04:09 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902d38200b0015f300ed0b7sm2491462pld.76.2022.05.11.17.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 17:04:09 -0700 (PDT)
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
Subject: [PATCH v3 0/2] x86/asm/bitops: optimize ff{s,z} functions for constant expressions
Date:   Thu, 12 May 2022 09:03:38 +0900
Message-Id: <20220512000340.1171988-1-mailhol.vincent@wanadoo.fr>
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

v2 -> v3:

  * Redacted out the instructions after ret and before next function
    in the assembly output.

  * Added a note and a link to Nick's message on the constant
    propagation missed-optimization in clang:
    https://lore.kernel.org/all/CAKwvOdnH_gYv4qRN9pKY7jNTQK95xNeH1w1KZJJmvCkh8xJLBg@mail.gmail.com/

  * Fix copy/paste type in statistics of patch 1. Number of occurences
    before patches are 1081 and not 3607 (percentage reduction of
    26.7% remains correct)

  * Rename the functions as follow:
    - __varible_ffs() -> variable___ffs()
    - __variable_ffz() -> variable_ffz()

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

