Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED5A58A03E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbiHDSIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238488AbiHDSIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:08:36 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF036BD76
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 11:08:32 -0700 (PDT)
Received: from linux.gnuweeb.org (linux.gnuweeb.org [172.17.0.3])
        by gnuweeb.org (Postfix) with ESMTPSA id A77767E295;
        Thu,  4 Aug 2022 18:08:31 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1659636511;
        bh=YbhOBwc9/fp+EJUtdTULgx+1f0UukDq/9CZZosXIem4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L1K+rKOx0REOkMQ1ct49BhB4CWXEZ87ETTTY0zL9cJGGLIpDqxUKiJ0Lp+b1t5ggJ
         2ugK2izB0QZ3wTeYCt2vNTtOBFv3Jj9KDHmW3ftnoj5rSHC5WVpvFqrHACoOrGkNO3
         5skAyHsOXfsSsFBEU7cCbuS3jYDgwFQVIxczQHrppiYWT74cYxSQUBJHBCiv2P9U+5
         yzZus2Vt7pTv/Vzhazz/y2oOZnfGivis4rFsn7npbOxRBPZJAAw+IXTN99+DD7hcpl
         ih49IV+jf3ycjkz9sHevaLYAyzVFm9QzS952r5qL7K85/8+JJVOxOrGGI04pmq8+9V
         wq5E9Lw9aoUOA==
From:   Kanna Scarlet <knscarlet@gnuweeb.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kanna Scarlet <knscarlet@gnuweeb.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Bill Metzenthen <billm@melbpc.org.au>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Roth <michael.roth@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] x86: Change mov $0, %reg with xor %reg, %reg
Date:   Thu,  4 Aug 2022 18:08:05 +0000
Message-Id: <20220804180805.9077-1-knscarlet@gnuweeb.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Yuvrd2yWLnyxOVLU@zn.tnic>
References: <20220804152656.8840-1-knscarlet@gnuweeb.org> <20220804152656.8840-2-knscarlet@gnuweeb.org> <Yuvrd2yWLnyxOVLU@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 10:53 PM, Borislav Petkov wrote:
> Bonus points if you find out what other advantage
>
> XOR reg,reg
>
> has when it comes to clearing integer registers.

Hello sir Borislav,

Thank you for your response. I tried to find out other advantages of
xor reg,reg on Google and found this:
https://stackoverflow.com/a/33668295/7275114

  "xor (being a recognized zeroing idiom, unlike mov reg, 0) has some
  obvious and some subtle advantages:

  1. smaller code-size than mov reg,0. (All CPUs)
  2. avoids partial-register penalties for later code.
     (Intel P6-family and SnB-family).
  3. doesn't use an execution unit, saving power and freeing up
     execution resources. (Intel SnB-family)
  4. smaller uop (no immediate data) leaves room in the uop cache-line
     for nearby instructions to borrow if needed. (Intel SnB-family).
  5. doesn't use up entries in the physical register file. (Intel
     SnB-family (and P4) at least, possibly AMD as well since they use
     a similar PRF design instead of keeping register state in the ROB
     like Intel P6-family microarchitectures.)"

Should I add all in the explanation sir? I will send v2 revision
tomorrow.

We also find more files to patch with this command:

   grep -rE "mov.?\s+\\$\\0\s*," arch/x86

it shows many immediate zero moves to 64-bit register in file
arch/x86/crypto/curve25519-x86_64.c, but the next instruction may depend
on the previous %rflags value, we are afraid to change this because
xor touches %rflags. We will try to change it to movl $0, %r32 to
reduce the code size.

Example cmovc needs %rflags

    "  adcx %1, %%r11;"
    "  movq %%r11, 24(%2);"

    /* Step 3: Fold the carry bit back in; guaranteed not to carry at this point */
    "  mov $0, %%rax;"
    "  cmovc %%rdx, %%rax;"

Thanks.

Regards,
-- 
Kanna Scarlet

