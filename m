Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052844C750A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbiB1RuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239333AbiB1Rn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:43:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 498639680D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646069772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZjMF25uYjLREHp+O7hSIrQRDAZsG0wANT5peCox0nVI=;
        b=LFWIS18XW4zDfCPAJ2EeOZ5ccFiKBQ+nq8k+P5c3YRz2qIMCdUgrRgAB15/FxaKiaDHFnp
        8eLxkeTP1S7KbDuv7L5M+o9sBUDeDNCNoM2YwJnNKVb0Zo3FnTESIcyA+IunpmIBi6xDNq
        sX1LpxoXAa1SPGu45JzSoiAHcwNJ0oo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-U1YXVGmONM6teGaV4Fdj3g-1; Mon, 28 Feb 2022 12:36:10 -0500
X-MC-Unique: U1YXVGmONM6teGaV4Fdj3g-1
Received: by mail-qv1-f69.google.com with SMTP id d15-20020a0cb2cf000000b00432e2ddeefaso7322426qvf.23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZjMF25uYjLREHp+O7hSIrQRDAZsG0wANT5peCox0nVI=;
        b=GAPlAA9MUihPAcG/A/GHcAHlaryN5brG7qMN2aAjC8lrbtpp8e6/Rdfh2kb2pRHSDa
         9bRLan3yWdESFtgvmiRwCchzXSCW8I5PvXIym+YS9ryST7HCgbA3kF6WH9qYQpYBQuXY
         SkzFIYBo59wa3Y++h1RtF4b0Luni5UJnBr3wM+O4LgdoB0DmhYYIZevIgNQDaldMGQZO
         Is+GmUNPmGXc71oE12xUb5AVaxb5zoslyzcvm8A7C5zyb5hQ0Rrf4eV5vdMrEFwnLVqK
         EReaPMAajXJC1XFITaPp2eS/3XO1jh0jyVq2DYByHfJotTrfJRcstLesYY9bwz+1YSB7
         81Yw==
X-Gm-Message-State: AOAM533kBnccklRhJeHl3HlBg/ZAPQ5nFLLpyqW8yW81pBRxX97lQi53
        TaKDGNI1xktIihQYMiM6NeQEz9bg60q5QJ3GXoCwfKGYgtnNX5DsGLDjJsyOl3JrBp53cIhgAaC
        UXM8K/ghWewkgEouXam2uK4ob
X-Received: by 2002:a05:620a:2108:b0:648:ee02:4601 with SMTP id l8-20020a05620a210800b00648ee024601mr11172612qkl.405.1646069770423;
        Mon, 28 Feb 2022 09:36:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrX+DEjhdqkNd1pMhAVM2Jj1iDLRMhoDRwTjYtNT6tbi8TuqQl5g0wq16VvkZYqx/2B/4FJw==
X-Received: by 2002:a05:620a:2108:b0:648:ee02:4601 with SMTP id l8-20020a05620a210800b00648ee024601mr11172597qkl.405.1646069770154;
        Mon, 28 Feb 2022 09:36:10 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id p12-20020a05622a048c00b002de8f67b60dsm7488545qtx.58.2022.02.28.09.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 09:36:09 -0800 (PST)
Date:   Mon, 28 Feb 2022 09:36:06 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 36/39] objtool: Find unused ENDBR instructions
Message-ID: <20220228173606.nqyq2knzenwrnfup@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151324.137868984@infradead.org>
 <20220227034613.a5ejjey5agxlympd@treble>
 <YhzC6RmRZs6U4wvG@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhzC6RmRZs6U4wvG@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 01:41:13PM +0100, Peter Zijlstra wrote:
> On Sat, Feb 26, 2022 at 07:46:13PM -0800, Josh Poimboeuf wrote:
> > On Thu, Feb 24, 2022 at 03:52:14PM +0100, Peter Zijlstra wrote:
> > > +#ifdef CONFIG_X86_KERNEL_IBT
> > > +	. = ALIGN(8);
> > > +	.ibt_endbr_sites : AT(ADDR(.ibt_endbr_sites) - LOAD_OFFSET) {
> > > +		__ibt_endbr_sites = .;
> > > +		*(.ibt_endbr_sites)
> > > +		__ibt_endbr_sites_end = .;
> > > +	}
> > > +#endif
> > 
> > ".ibt_endbr_superfluous" maybe?  It's not *all* the endbr sites.
> 
> Since I like seals, I'll make it .ibt_endbr_seal :-) Also goes well with
> the option at hand.

Sounds good.

> 
> > > +
> > >  	/*
> > >  	 * struct alt_inst entries. From the header (alternative.h):
> > >  	 * "Alternative instructions for different CPU types or capabilities"
> > > --- a/tools/objtool/builtin-check.c
> > > +++ b/tools/objtool/builtin-check.c
> > > @@ -21,7 +21,7 @@
> > >  
> > >  bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
> > >       lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
> > > -     ibt, ibt_fix_direct;
> > > +     ibt, ibt_fix_direct, ibt_seal;
> > >  
> > >  static const char * const check_usage[] = {
> > >  	"objtool check [<options>] file.o",
> > > @@ -50,6 +50,7 @@ const struct option check_options[] = {
> > >  	OPT_BOOLEAN(0, "dry-run", &dryrun, "don't write the modifications"),
> > >  	OPT_BOOLEAN(0, "ibt", &ibt, "validate ENDBR placement"),
> > >  	OPT_BOOLEAN(0, "ibt-fix-direct", &ibt_fix_direct, "fixup direct jmp/call to ENDBR"),
> > > +	OPT_BOOLEAN(0, "ibt-seal", &ibt_seal, "list superfluous ENDBR instructions"),
> > 
> > s/list/annotate/ ?
> 
> Done :-)
> 
> > Not sure "ibt-seal" is the appropriate name since the "seal" is done at
> > boot time.
> 
> It allows sealing; it finds the locations to seal, whatever :-)

Fair enough :-)

> > Do we really need a separate option anyway?  To get the full benefits of
> > IBT you might as well enable it...  And always enabling it helps flush
> > out bugs quicker.
> 
> Are you asking about --ibt and --ibt-seal or about the existence of
> X86_KERNEL_IBT_SEAL here?

Both.

> The Makefiles will only ever use --ibt and --ibt-seal together for the
> reason you state. The reason they're two separate objtool arguments is
> because it's stictly speaking two different things being done. Also
> --ibt as such is invariant, while --ibt-seal causes modifications to the
> object file (which can be discarded using the new --dry-run I suppose).

Ok, but I wanted to avoid option sprawl.  I don't see a reason to
separate them.

> The reason X86_KERNEL_IBT_SEAL exists is because that requires objtool
> while X86_KERNEL_IBT does not -- you seemed to favour not hard relying
> on having objtool present.

Hm, either you misunderstood, I misspoke, or I have short term memory
loss.  Objtool is already hopelessly intertwined with x86.  I'd rather
not have the extra option.

-- 
Josh

