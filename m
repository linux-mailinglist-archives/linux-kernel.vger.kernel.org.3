Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB5A56C2FE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbiGHUtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbiGHUtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:49:08 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F567B359
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:49:04 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id f14so16709423qkm.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=FBvdmM502BDBY4F9Apm5h9KKjB4dWv/nkjvzfkcviig=;
        b=flRZHbrF5tCOzGBVGjKqEY5zxAulqJgX1lQNpbJKJ7rlC32NLjZTWh5os+OqExD77o
         tePhkMCbmpSm5y8PH1o+CVi/H0QOOnIIib85UDmRJmRI8mfGXI2AD4462/fuBN8Oplqr
         YIeivkOo05wy8W9lWlYR2RsvsSCIalOh+61NZzcJmv07XqO28tccrxPMbiFD1Z5I+MYT
         tfoy5obtspICwdmrY+OMIJdZjWBk0ZskPMw/BpJ/B4gk4Wsj5WunaOhYKPjl5o7cvOYp
         IwuEFnaplbpLT6ytkbMQKUo4dofLwz48AAlqkJK8JYfOhEujKTAMYS5V6Tpmh9jQu0qv
         QUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=FBvdmM502BDBY4F9Apm5h9KKjB4dWv/nkjvzfkcviig=;
        b=bSg9eaizyFK9yaFCQUgkm6e0opdFgfyKbOBjQSFaEjDw+SI0q2Y9kzojf8W8RjEYuS
         hNGInMCjFC55gNo4kx4eUfEjDy6OAp1FUDORh51fvlE+QiIgkVezknnI4HAfHf8VdJb6
         J5wJOZjA5MTyOCR8gaqSOjYDCI4ilE9dnUTb3FH4BkKVDfdVog3lsdUBZeoFxmkyhIJd
         FPl5sqU5fvwzEt2qgXdS0LpgmNWL1a/+MhOZ0Fv9QpmIloFyj6Afu+EMaC17Z41OUYeP
         SUUhftJElcLMgh9a9SMhKw4uI/eEECpjqV6PWbfkvIXvoycpmj739oVCwLMk/c4mIOCz
         BOCg==
X-Gm-Message-State: AJIora+GIrOTckfFoZL4h/LzHmThcR3B+rfutGJzErymZeIk2J2fCq1S
        3sQlsyKj4pSy7ijGIdemKhUKxT0IJXRGxSww
X-Google-Smtp-Source: AGRyM1ui+B2KFJvUrUAEz+K+CoBg1vZ/A2zaAyO3i/ZkIT50BY2lbH+dpweHklJVWdeb9Xa41CJJCw==
X-Received: by 2002:a05:620a:47ac:b0:6b5:4c72:3739 with SMTP id dt44-20020a05620a47ac00b006b54c723739mr3691646qkb.695.1657313343302;
        Fri, 08 Jul 2022 13:49:03 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y11-20020a05620a44cb00b006a37eb728cfsm31585444qkp.1.2022.07.08.13.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:49:03 -0700 (PDT)
Date:   Fri, 8 Jul 2022 13:48:46 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Nadav Amit <namit@vmware.com>
cc:     Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] x86/mm/tlb: ignore f->new_tlb_gen when zero
In-Reply-To: <49C173B5-CF12-44AA-BE00-689E99E65C23@vmware.com>
Message-ID: <23b7e5f8-8b38-51aa-fecd-3ed92118af72@google.com>
References: <20220708003053.158480-1-namit@vmware.com> <4eccbb3a-2b5a-039-e934-da451e469929@google.com> <49C173B5-CF12-44AA-BE00-689E99E65C23@vmware.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2142999139-1657313342=:1568"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2142999139-1657313342=:1568
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 8 Jul 2022, Nadav Amit wrote:
> On Jul 8, 2022, at 12:21 PM, Hugh Dickins <hughd@google.com> wrote:
>=20
> > =E2=9A=A0 External Email
> >=20
> > On Thu, 7 Jul 2022, Nadav Amit wrote:
> >=20
> >> From: Nadav Amit <namit@vmware.com>
> >>=20
> >> Commit aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when
> >> possible") introduced an optimization of skipping the flush if the TLB
> >> generation that is flushed (as provided in flush_tlb_info) was already
> >> flushed.
> >>=20
> >> However, arch_tlbbatch_flush() does not provide any generation in
> >> flush_tlb_info. As a result, try_to_unmap_one() would not perform any
> >> TLB flushes.
> >>=20
> >> Fix it by checking whether f->new_tlb_gen is nonzero. Zero value is
> >> anyhow is an invalid generation value.
> >>=20
> >> In addition, add the missing unlikely() and jump to get tracing right.
> >>=20
> >> Fixes: aa44284960d5 ("x86/mm/tlb: Avoid reading mm_tlb_gen when possib=
le")
> >> Reported-by: Hugh Dickins <hughd@google.com>
> >> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> Cc: Andy Lutomirski <luto@kernel.org>
> >> Signed-off-by: Nadav Amit <namit@vmware.com>
> >=20
> > Thanks a lot for your rapid response and thinking it through
> > (before I got around to any "nopcid" or "nopti" experiments).
> >=20
> > I've been testing this one for a few hours now, and no problems seen.
> > I expect you'll be sending another version, maybe next week, meeting
> > Dave's concerns; but wanted to reassure that you have correctly
> > identified the issue and fixed it with this - thanks.
>=20
> Thanks, Hugh. Sorry again for my mistake.
>=20
> Can I please have your =E2=80=9CTested-by=E2=80=9D?

Sure, let me scrabble around in my box of tags, yes, here's one:

Tested-by: Hugh Dickins <hughd@google.com>
--0-2142999139-1657313342=:1568--
