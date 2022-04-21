Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D750A74E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390875AbiDURoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiDURof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:44:35 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638A34A3CE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:41:45 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h12so1861474plf.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7JRw6mNztMXZ06DOT43AeVGnBVZ54ZjCu5voH5Wt+y4=;
        b=DkcqPXe34K3PAhGnkPTX+ibi5dB0a2z7iquzGv/EAQKFz2t1gbypfJCkAfbaR50QG4
         IsNm8YHG2VZIf/ZdRMJs2j/3wx/JobsKD94qawhcAqi6i3MReh1n5BtKRHlzGm3NA+bj
         zu2iC+BtGtQKoLhBDZQaC8EwyYyQkVmsJdNII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7JRw6mNztMXZ06DOT43AeVGnBVZ54ZjCu5voH5Wt+y4=;
        b=kpr5z3gigeWTZ+1DQfmuxXX+I+MSPN1Q9UY6ry47mo2I6IGw5q6O5uz/ocLdiDuxmy
         hojt7+QFt77aTkOOAek2Om2SMSz3qLvzlI4tTolvnUbbBvANah7q2L06gEVeofUOLlYk
         vmW1OpsOL7pX/dhtYvavsRlG5mmd9x94N+qoxVzbHPF3yTJ6rfNqtKoL1DhGXE9YwKe/
         5O2KC78RTcuOduAp9WLvF41xOVaODTOs3/fytMqE9XVIroCdPF30cFwgurF/qrYnvkYu
         DXmRyT1xnxVr5PNnAsHoDQHUTbVKRMTmN5DZ6F7Dez9v0LcRL1CW1DFallHes3eTi14z
         CWeA==
X-Gm-Message-State: AOAM530ACcg++xWMv5A8LwxwGTeprj3b0Bqes2hZC0P7as3NVd108586
        OhTC9dq3xPdbcaNnpnxSp4wd8Q==
X-Google-Smtp-Source: ABdhPJzvJsBMz4TF2Ld0nZq3b3BGx5UhBL6r5l9SjnBtlfqWPBALbFZyZbFepVsc1TYIRd/JPiI0pw==
X-Received: by 2002:a17:90a:c20a:b0:1d7:4cd5:ac82 with SMTP id e10-20020a17090ac20a00b001d74cd5ac82mr2242262pjt.212.1650562904943;
        Thu, 21 Apr 2022 10:41:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n64-20020a622743000000b0050acf41bde9sm5885926pfn.117.2022.04.21.10.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:41:44 -0700 (PDT)
Date:   Thu, 21 Apr 2022 10:41:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net,
        linux-hardening@vger.kernel.org, Jann Horn <jannh@google.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Igor Zhbanov <izh1979@gmail.com>
Subject: Re: [PATCH RFC 0/4] mm, arm64: In-kernel support for
 memory-deny-write-execute (MDWE)
Message-ID: <202204211030.B0093CC14@keescook>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <202204141028.0482B08@keescook>
 <YmAEDsGtxhim46UI@arm.com>
 <c62170c6-5993-2417-4143-5a37a98b227c@gmail.com>
 <202204201610.093C9D5FE8@keescook>
 <YmF5s4KqT5WL4O0G@arm.com>
 <202204210941.4318DE6E8@keescook>
 <YmGTRQA74n/ZF7Vl@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmGTRQA74n/ZF7Vl@arm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 06:24:21PM +0100, Catalin Marinas wrote:
> On Thu, Apr 21, 2022 at 09:42:23AM -0700, Kees Cook wrote:
> > On Thu, Apr 21, 2022 at 04:35:15PM +0100, Catalin Marinas wrote:
> > > Do we want the "was PROT_WRITE" or we just reject mprotect(PROT_EXEC) if
> > > the vma is not already PROT_EXEC? The latter is closer to the current
> > > systemd approach. The former allows an mprotect(PROT_EXEC) if the
> > > mapping was PROT_READ only for example.
> > > 
> > > I'd drop the "was PROT_WRITE" for now if the aim is a drop-in
> > > replacement for BPF MDWE.
> > 
> > I think "was PROT_WRITE" is an important part of the defense that
> > couldn't be done with a simple seccomp filter (which is why the filter
> > ended up being a problem in the first place).
> 
> I would say "was PROT_WRITE" is slightly more relaxed than "is not
> already PROT_EXEC". The seccomp filter can't do "is not already
> PROT_EXEC" either since it only checks the mprotect() arguments, not the
> current vma flags.
> 
> So we have (with sub-cases):
> 
> 1. Current BPF filter:
> 
>    a)	mmap(PROT_READ|PROT_WRITE|PROT_EXEC);	// fails
> 
>    b)	mmap(PROT_READ|PROT_EXEC);
> 	mprotect(PROT_READ|PROT_EXEC|PROT_BTI);	// fails
>
>    c)	mmap(PROT_READ);
> 	mprotect(PROT_READ|PROT_EXEC);		// fails
>
>    d)	mmap(PROT_READ|PROT_WRITE);
> 	mprotect(PROT_READ);
> 	mprotect(PROT_READ|PROT_EXEC);		// fails
> 
> 2. "is not already PROT_EXEC":
> 
>    a)	mmap(PROT_READ|PROT_WRITE|PROT_EXEC);	// fails
> 
>    b)	mmap(PROT_READ|PROT_EXEC);
> 	mprotect(PROT_READ|PROT_EXEC|PROT_BTI);	// passes
> 
>    c)	mmap(PROT_READ);
> 	mprotect(PROT_READ|PROT_EXEC);		// fails
>
>    d)	mmap(PROT_READ|PROT_WRITE);
> 	mprotect(PROT_READ);
> 	mprotect(PROT_READ|PROT_EXEC);		// fails
> 
> 3. "is or was not PROT_WRITE":
> 
>    a)	mmap(PROT_READ|PROT_WRITE|PROT_EXEC);	// fails
> 
>    b)	mmap(PROT_READ|PROT_EXEC);
> 	mprotect(PROT_READ|PROT_EXEC|PROT_BTI);	// passes
> 
>    c)	mmap(PROT_READ);
> 	mprotect(PROT_READ|PROT_EXEC);		// passes
> 
>    d)	mmap(PROT_READ|PROT_WRITE);
> 	mprotect(PROT_READ);
> 	mprotect(PROT_READ|PROT_EXEC);		// fails

[edited above to show each case]

restated what was already summarized:
Problem is 1.b. 2 and 3 solve it. 3 is more relaxed (c passes).

> If we don't care about 3.c, we might as well go for (2). I don't mind,
> already went for (3) in this series. I think either of them would not be
> a regression on MDWE, unless there is some test that attempts 3.c and
> expects it to fail.

I should stop arguing for a less restrictive mode. ;) It just feels weird
that the combinations are API-mediated, rather than logically defined:
I can do PROT_READ|PROT_EXEC with mmap but not mprotect under 2. As
opposed to saying "the vma cannot be executable if it is or ever was
writable". I find the latter much easier to reason about as far as the
expectations of system state.

So, I'd still prefer 3, as that was the _goal_ of the systemd MDWE
seccomp filter, but yes, 2 does provide the same protection while
allowing BTI.

-- 
Kees Cook
