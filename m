Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239A753FE9D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbiFGMVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243831AbiFGMUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:20:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE024C5E41
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:19:48 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s13so18978942ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HFNl4deQqY2CVWCJqnRvkKKqDLhRyFvEhkD6zhbS1io=;
        b=JYTSE+FQSj3LpqRsscj3Ljj0WQdmKkXCC/5x0wki7CIoE7ia2PcV2KUJNeCl1KS+Nv
         fCI9RUTTFFXWbp2zY5i+KWMlj7jz5irPevyqWm8d5gZwidNRXAKSoFfWcR2JaZR81dz0
         D6yi4hSrBrxvASQCafI9Wdno9St/pZQ9GHLLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HFNl4deQqY2CVWCJqnRvkKKqDLhRyFvEhkD6zhbS1io=;
        b=WqUb+qhTQt59hEN/0yGN6nl+L2sHc6Ur2/JkxwW+GhcFdiJvqn7kWIWFYjSGhfqISf
         U2bLoT3hhzPobBsuKJnIhr8tFp8KByie2M3/ENy2fiNj4abXt5lG+k9kGDZWzq30+X6J
         67QYWIPNfH34a+z8Bigke/U+PFF40guiXDgK0b2mE9JcxZ4fpJLTGc9n9jDuZwoSvLSk
         kAtOoT4kTvjnOCpvL/K1hrDDUbhiZ/kYdpC/8TVlk8qrvgfXY20+x//61o+V3VPtiQKp
         FKyWCBuSagVI8X+gVcSWiYbJLwa/nvdBWllOswBSr4gGdQYtTAQOk+G9iFMnhwFvXFkO
         rlqA==
X-Gm-Message-State: AOAM533l0jrpML2fUZAbb6Dl87SP+qkF6kPn/YneJ6z6C05P29Ae7PWw
        BZYIZQFqvjVCbltgprVfLLq+7JXGysVf5z0nR0WT3dv6u3k=
X-Google-Smtp-Source: ABdhPJwc6B8osrc3RlQBKNzSqQgX+GAmy2OiHGnBK9NNDbojQKeyzL1+XWJ6r/8G0SIaL9Qni0QATp5zSIL0fycCzko=
X-Received: by 2002:a2e:b0d6:0:b0:255:7d62:d75c with SMTP id
 g22-20020a2eb0d6000000b002557d62d75cmr12516223ljl.118.1654604387151; Tue, 07
 Jun 2022 05:19:47 -0700 (PDT)
MIME-Version: 1.0
From:   Joe Damato <jdamato@fastly.com>
Date:   Tue, 7 Jun 2022 15:19:36 +0300
Message-ID: <CALALjgwSm07Cnbm6WaK74ZSs4wJ7hs4B3wLOe7h4Y-7sJ5cUWg@mail.gmail.com>
Subject: 5.19-rc1 x86 build failure
To:     x86@kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, jiangshanlai@gmail.com, bp@suse.de,
        brgerst@gmail.com, Andrew.Cooper3@citrix.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings:

My apologies if this is the incorrect place to report this, but I got a
build error when trying to compile the net-next 5.19-rc1 tree.

git bisect says that commit a1e2c031ec394 ("x86/mm: Simplify
RESERVE_BRK()") is responsible for the build issue I am hitting.

I am performing this build on an x86_64 system with GNU C11 (Ubuntu
5.4.0-6ubuntu1~16.04.12) version 5.4.0 20160609 (x86_64-linux-gnu).

The assembler outputs a cryptic error message:

/tmp/ccnGOKZ5.s: Assembler messages:
/tmp/ccnGOKZ5.s:98: Error: missing ')'
/tmp/ccnGOKZ5.s:98: Error: missing ')'
/tmp/ccnGOKZ5.s:98: Error: missing ')'
/tmp/ccnGOKZ5.s:98: Error: junk at end of line, first unrecognized
character is `U'
/tmp/ccnGOKZ5.s:99: Error: missing ')'
/tmp/ccnGOKZ5.s:99: Error: missing ')'
/tmp/ccnGOKZ5.s:99: Error: missing ')'
/tmp/ccnGOKZ5.s:99: Error: junk at end of line, first unrecognized
character is `U'

I've asked GCC to generate the assembly and output so I can see more
specifically where this issue is (via "-fverbose-asm -Wa,-adhln=output"):

  96                            .pushsection .brk_reservation,"aw",@nobits
  97                            .brk.early_pgt_alloc:
  98 ???? 00000000              .skip ((2 * 3) * ((1UL) << 12))
****  Error: missing ')'
****  Error: missing ')'
****  Error: missing ')'
****  Error: junk at end of line, first unrecognized character is `U'
  98      0000
 100                            .popsection

This comes from arch/x86/mm/init.c, which has the following code:

RESERVE_BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE);

wherein INIT_PGT_BUF_SIZE (via PAGE_SIZE) has a "1UL" which makes the
assembler unhappy.

I don't really know what the correct way to fix this is; it seems that the
macro _AC should handle this if ASSEMBLY is defined, IIUC, but that does
not seem to be the case at this point in init.c.

Perhaps I am doing something incorrect during the build process causing
this to happen?

Thanks,
Joe
