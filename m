Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E689D4AE592
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiBHXne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237941AbiBHXn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:43:28 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0EFC061577
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:43:28 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u12so674306plq.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 15:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8FPluJVF9aWtwUGTKCjS+70K6/fX0iOecJ5yZR2L3ZM=;
        b=cc19Hm7rBDBS0UO1Frz4kzMSOLES8Rk8QqiBpJ5+csh29OGXjc6joQpcObRXlE/MV+
         CtRuLnmC8Sld1pUaM/J/Rjs31SEGT/iIaJb441EXQqPJK+opOx8QhC8SR+RVj9YYuBTh
         kxCLTi6jUC1hYj2+qOhFxY/7upb8MbndFk1yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8FPluJVF9aWtwUGTKCjS+70K6/fX0iOecJ5yZR2L3ZM=;
        b=M9pGQRgYtHxW2Ihm5xOjEI8z0sbdKyEFRx7z0VSySTKJisyOfr3fDt0ujy9XvmLM2r
         9ixGg9XMimQWOP4tebnSNaYxxNNyTmyXCv1+Gq3yOdR1TPSPRjA0RBbTohaGffN/I6Mw
         00AdFH42oFtx1kVJfoRgEPEe7xpfhGzM27LvMfv992Fk45q13BSMBM2Ri00obkkwExXY
         ZXsUpiMMhuKfX2Hk5pIq+nc/T7JDn9X3B5utcV5rwHvxvrya+9Z8IhR26PcKet9g0Ut8
         hh4dlMOCytO6sswDGLQJb4MTBvOOuwvlL0r2n/Kpbskhdo8HjzOnINy3+4gJIutvZCdb
         MABw==
X-Gm-Message-State: AOAM530OCVGjBSqTM03DF5OLeUMaOW37CRBNBHsUj032wNvL+T+vqcVu
        N6RjAADXiWt2zOrw7qQRCzPqpw==
X-Google-Smtp-Source: ABdhPJxGKq1WWoclNV713rjMPcVyISdO7VCN40olovVOyaHDBgUyKxKnxfkAX2uow9BOj0Ee6+7Q3g==
X-Received: by 2002:a17:90a:e7c6:: with SMTP id kb6mr392818pjb.139.1644363807995;
        Tue, 08 Feb 2022 15:43:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t15sm12481061pgc.49.2022.02.08.15.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 15:43:27 -0800 (PST)
Date:   Tue, 8 Feb 2022 15:43:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Message-ID: <202202081542.F685EC23@keescook>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
 <20211124193037.nu7q4pa3sianzqtc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124193037.nu7q4pa3sianzqtc@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 11:30:37AM -0800, Josh Poimboeuf wrote:
> On Mon, Nov 22, 2021 at 06:03:07PM +0100, Peter Zijlstra wrote:
> > +static int validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc, char **name)
> > +{
> > +	struct instruction *dest;
> > +	struct section *sec;
> > +	unsigned long off;
> > +
> > +	sec = reloc->sym->sec;
> > +	off = reloc->sym->offset + reloc->addend;
> > +
> > +	dest = find_insn(file, sec, off);
> > +	if (!dest)
> > +		return 0;
> > +
> > +	if (name && dest->func)
> > +		*name = dest->func->name;
> 
> I think these checks can be further narrowed down by only looking for
> X86_64_64 relocs.
> 
> > +	list_for_each_entry(insn, &file->endbr_list, call_node) {
> > +		if (ibt_seal) {
> > +			elf_write_insn(file->elf, insn->sec,
> > +				       insn->offset, insn->len,
> > +				       arch_nop_insn(insn->len));
> > +		}
> 
> Like the retpoline rewriting, I'd much rather have objtool create
> annotations which the kernel can then read and patch itself.
> 
> e.g. have '.ibt.direct_call_sites' and '.ibt.unused_endbr_insns'
> sections.

Why have the kernel do that work at every boot when it can be known at
link time?

-- 
Kees Cook
