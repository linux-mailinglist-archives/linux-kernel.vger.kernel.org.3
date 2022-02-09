Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537EF4AE937
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiBIFYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243220AbiBIFJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:09:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC660C03F91E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644383345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TGF4Zn/lmJlaMT7UwgKtEW9zKBC5kk/h265Rl1WE1zM=;
        b=bnQgNuMGZiPdg53YCOVNg/QoJhyRCoDLJKQ+kLzXLl+GhX6bEnyFd8s9TrXYkxI/3/n8vP
        4oy5k6/BbKmWXDo/sUSXkgjj78b2/ZzR9qAIaobknlU9hwH03uB80ZhB0670cSfrsqWQ3J
        rrTmMUzdsll102NBriSvhgyFGeg2WsE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-zzTazHpoPsmwvVbkt9-CCw-1; Wed, 09 Feb 2022 00:09:04 -0500
X-MC-Unique: zzTazHpoPsmwvVbkt9-CCw-1
Received: by mail-qk1-f198.google.com with SMTP id z1-20020ae9f441000000b00507a22b2d00so706124qkl.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 21:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TGF4Zn/lmJlaMT7UwgKtEW9zKBC5kk/h265Rl1WE1zM=;
        b=l5xWyVHvU+q9g8x6h/tAbxsypV9PWZI6XqeIobjSD4pBS5SbcgJC2zL9VrHtjFT7Db
         /3sn0uRe6kbqvZSQOxeF+u9Uf41ZaqDAiOTY9avNTH5KUxS2Fq/I53l9Frpto0NhDR52
         ZnkWo6RzUrZbfN31yItOd0vPXn8P/LJN248Ksghi6JEDn8xj4JiIQWWm+nNfzOOEe/sc
         v3Fh62vbJiv0OLoX4vR76xpC/OAA1hsBbl1UbUWp2AwMHTjhc7Vh4i5yAf4sNw+aGH9/
         AT6iF5yjPj2O2IhKlkq576kA3wo4N6gMrG3s5KQhtrSJT6ilXgCVm28yM1D4ZQysDquv
         NYfg==
X-Gm-Message-State: AOAM530VxOTrB6sD44+n1ESXGp9QTJvbSb31UqooT3mAxGO1PZS9vmJl
        cusC8bXa/aOh2/RRf+QQgxlUq77xBnt804uIq62bucr7mMBYs8OGwbL7T/gLHD9NgyK0yL4iLNp
        YmlAkiA5NFwb5STLtnj/qwaHI
X-Received: by 2002:a05:620a:454c:: with SMTP id u12mr233640qkp.515.1644383343673;
        Tue, 08 Feb 2022 21:09:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEKYSvdI443BGvHYbaLRm7f+Dlmoc57zeAXbSJSAxEyM1+HZGep4jMh8KCeP0Tvni/Phn0OQ==
X-Received: by 2002:a05:620a:454c:: with SMTP id u12mr233629qkp.515.1644383343413;
        Tue, 08 Feb 2022 21:09:03 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id i20sm8608161qtx.44.2022.02.08.21.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 21:09:02 -0800 (PST)
Date:   Tue, 8 Feb 2022 21:09:00 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Message-ID: <20220209050900.vb676ocdrt6gsomf@treble>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
 <20211124193037.nu7q4pa3sianzqtc@treble>
 <202202081542.F685EC23@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202202081542.F685EC23@keescook>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 03:43:27PM -0800, Kees Cook wrote:
> On Wed, Nov 24, 2021 at 11:30:37AM -0800, Josh Poimboeuf wrote:
> > On Mon, Nov 22, 2021 at 06:03:07PM +0100, Peter Zijlstra wrote:
> > > +static int validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc, char **name)
> > > +{
> > > +	struct instruction *dest;
> > > +	struct section *sec;
> > > +	unsigned long off;
> > > +
> > > +	sec = reloc->sym->sec;
> > > +	off = reloc->sym->offset + reloc->addend;
> > > +
> > > +	dest = find_insn(file, sec, off);
> > > +	if (!dest)
> > > +		return 0;
> > > +
> > > +	if (name && dest->func)
> > > +		*name = dest->func->name;
> > 
> > I think these checks can be further narrowed down by only looking for
> > X86_64_64 relocs.
> > 
> > > +	list_for_each_entry(insn, &file->endbr_list, call_node) {
> > > +		if (ibt_seal) {
> > > +			elf_write_insn(file->elf, insn->sec,
> > > +				       insn->offset, insn->len,
> > > +				       arch_nop_insn(insn->len));
> > > +		}
> > 
> > Like the retpoline rewriting, I'd much rather have objtool create
> > annotations which the kernel can then read and patch itself.
> > 
> > e.g. have '.ibt.direct_call_sites' and '.ibt.unused_endbr_insns'
> > sections.
> 
> Why have the kernel do that work at every boot when it can be known at
> link time?

True, but:

- The kernel is already doing several other flavors of boot-time
  self-patching.  IMO it's better to consolidate such craziness in one
  place (or a limited number of places) if we can.  It seems more
  robust, and limits confusion about who's patching what and when.

- Patching text at link time has pitfalls and I'd like to avoid (as much
  as reasonably possible) objtool having the ability to brick the
  kernel.

-- 
Josh

