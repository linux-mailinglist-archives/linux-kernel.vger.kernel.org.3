Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B054F8BBD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiDHAX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 20:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiDHAX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 20:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7ABB711C24
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649377313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZonmDGhG6Ei2GHwUj3ZdEVwNc8Wy/16NayqTTmMzuwc=;
        b=WQCjTQMwoThspFlKR4ENm69GC1B5umGO/ExX0FzjpYR77LmBw2Ld3U53dUAfkvOta7cxb2
        b7v4rctqZprC6Fn60ZbEzRFCNfvBB61SwaQjXanRhP25cINNkZRfYGM2tBgFbM52FDhLh1
        bLsnxSC8ZK1BnbEEQ3S6tWtRRa2mYxQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-f56-GsQ1OvWbmF_6ObhIkw-1; Thu, 07 Apr 2022 20:21:52 -0400
X-MC-Unique: f56-GsQ1OvWbmF_6ObhIkw-1
Received: by mail-qv1-f69.google.com with SMTP id a3-20020a056214062300b00443cd6175c8so8130422qvx.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 17:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZonmDGhG6Ei2GHwUj3ZdEVwNc8Wy/16NayqTTmMzuwc=;
        b=4GDWTDg/P+V7pfGcUtbgblwZaa3abOwnJB9p8VZii9ud/7maH48IbOno8Q/vY4XPvT
         K579uspFMsQ+LSOFTYglULIoPVYt7ofLc7ZOUzSrNAoyllYHPqfjQe7XwV8hNl5hutPr
         mGJ8ZBhIwGI07k+G8uClxM992W7WFuYQxyzLtaPUFlAq1Ri6IaPk42ldUD917ad36bXG
         nS5aVB3DMDwwkJ/9cHUnPct3v+eMYIrCVoeWfvhdf1Jc7hJMXSjP3U3QOTKA2nKvh4YR
         kK+z2ToGaFf2Wl65QhCIF3xqCl6vyxzUqk3oq2BZxhSo6X5uHTejJF9FmDn8uxw4RrDm
         6xDw==
X-Gm-Message-State: AOAM530FjR8OzsfMwojMrobd1y4Nb9U+xJoHs+NMPZS59dCEHgWX4xLj
        nsABfIxLg6YqDNRl5jBYAauMKF58wStnEW+NA8pYKdd6m3W54i3XL+/IigDsmzpOKhpEzv4xfX7
        asLuMRLwAJcZ7PNhuhkBgnAkE
X-Received: by 2002:a05:6214:2466:b0:441:2daa:4ab1 with SMTP id im6-20020a056214246600b004412daa4ab1mr14363352qvb.12.1649377311660;
        Thu, 07 Apr 2022 17:21:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyABym9CrcYrMyehlVw8QJv0G9OjD6XnfCJAdri20QerkAWI+6pnBBMq3wC8o95yaEireiLcA==
X-Received: by 2002:a05:6214:2466:b0:441:2daa:4ab1 with SMTP id im6-20020a056214246600b004412daa4ab1mr14363333qvb.12.1649377311423;
        Thu, 07 Apr 2022 17:21:51 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id d6-20020ac85d86000000b002e1e20444b6sm16357246qtx.57.2022.04.07.17.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 17:21:50 -0700 (PDT)
Date:   Thu, 7 Apr 2022 17:21:47 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     madvenka@linux.microsoft.com
Cc:     mark.rutland@arm.com, broonie@kernel.org, ardb@kernel.org,
        nobuta.keiya@fujitsu.com, sjitindarsingh@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, jmorris@namei.org,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] arm64: livepatch: Use DWARF Call Frame
 Information for frame pointer validation
Message-ID: <20220408002147.pk7clzruj6sawj7z@treble>
References: <95691cae4f4504f33d0fc9075541b1e7deefe96f>
 <20220407202518.19780-1-madvenka@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220407202518.19780-1-madvenka@linux.microsoft.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 03:25:09PM -0500, madvenka@linux.microsoft.com wrote:
> The solution
> ============
> 
> The goal here is to use the absolute minimum CFI needed to compute the FP at
> every instruction address. The unwinder can compute the FP in each frame,
> compare the actual FP with the computed one and validate the actual FP.
> 
> Objtool is enhanced to parse the CFI, extract just the rules required,
> encode them in compact data structures and create special sections for
> the rules. The unwinder uses the special sections to find the rules for
> a given instruction address and compute the FP.
> 
> Objtool can be invoked as follows:
> 
> 	objtool dwarf generate <object-file>

Hi Madhaven,

This is quite interesting.  And it's exactly the kind of crazy idea I
can appreciate ;-)

Some initial thoughts:


1)

I have some concerns about DWARF's reliability, especially considering
a) inline asm, b) regular asm, and c) the kernel's tendency to push
compilers to their limits.

BUT, supplementing the frame pointer unwinding with DWARF, rather than
just relying on DWARF alone, does help a LOT.

I guess the hope is that cross-checking two "mostly reliable" things
against each other (frame pointers and DWARF) will give a reliable
result ;-)

In a general sense, I've never looked at DWARF's reliability, even for
just normal C code.  It would be good to have some way of knowing that
DWARF looks mostly sane for both GCC and Clang.  For example, maybe
somehow cross-checking it with objtool's knowledge.  And then of course
we'd have to hope that it stays bug-free in future compilers.

I'd also be somewhat concerned about assembly.  Since there's nothing
ensuring the unwind hints are valid, and will stay valid over time, I
wonder how likely it would be for that to break, and what the
implications would be.  Most likely I guess it would break silently, but
then get caught by the frame pointer cross-checking.  So a broken hint
might not get noticed for a long time, but at least it (hopefully)
wouldn't break reliable unwinding.

Also, inline asm can sometimes do stack hacks like
"push;do_something;pop" which isn't visible to the toolchain.  But
again, hopefully the frame pointer checking would fail and mark it
unreliable.

So I do have some worries about DWARF, but the fact that it's getting
"fact checked" by frame pointers might be sufficient.


2)

If I understand correctly, objtool is converting parts of DWARF to a new
format which can then be read by the kernel.  In that case, please don't
call it DWARF as that will cause a lot of confusion.

There are actually several similarities between your new format and ORC,
which is also an objtool-created DWARF alternative.  It would be
interesting to see if they could be combined somehow.


3)

Objtool has become an integral part of x86-64, due to security and
performance features and toolchain workarounds.

Not *all* of its features require the full "branch validation" which
follows all code paths -- and was the hardest part to get right -- but
several features *do* need that: stack validation, ORC, uaccess
validation, noinstr validation.

Objtool has been picking up a lot of steam (and features) lately, with
more features currently in active development.  And lately there have
been renewed patches for porting it to powerpc and arm64 (and rumors of
s390).

If arm64 ever wants one of those features -- particularly a "branch
validation" based feature -- I think it would make more sense to just do
the stack validation in objtool, rather than the DWARF supplementation
approach.

Just to give an idea of what objtool already supports and how useful it
has become for x86, here's an excerpt from some documentation I've been
working on, since I'm in the middle of rewriting the interface to make
it more modular.  This is a list of all its current features:


Features
--------

Objtool has the following features:


- Stack unwinding metadata validation -- useful for helping to ensure
  stack traces are reliable for live patching

- ORC unwinder metadata generation -- a faster and more precise
  alternative to frame pointer based unwinding

- Retpoline validation -- ensures that all indirect calls go through
  retpoline thunks, for Spectre v2 mitigations

- Retpoline call site annotation -- annotates all retpoline thunk call
  sites, enabling the kernel to patch them inline, to prevent "thunk
  funneling" for both security and performance reasons

- Non-instrumentation validation -- validates non-instrumentable
  ("noinstr") code rules, preventing unexpected instrumentation in
  low-level C entry code

- Static call annotation -- annotates static call sites, enabling the
  kernel to implement inline static calls, a faster alternative to some
  indirect branches

- Uaccess validation -- validates uaccess rules for a proper safe
  implementation of Supervisor Mode Access Protection (SMAP)

- Straight Line Speculation validation -- validates certain SLS
  mitigations

- Indirect Branch Tracking validation -- validates Intel CET IBT rules
  to ensure that all functions referenced by function pointers have
  corresponding ENDBR instructions

- Indirect Branch Tracking annotation -- annotates unused ENDBR
  instruction sites, enabling the kernel to "seal" them (replace them
  with NOPs) to further harden IBT

- Function entry annotation -- annotates function entries, enabling
  kernel function tracing

- Other toolchain hacks which will go unmentioned at this time...

-- 
Josh

