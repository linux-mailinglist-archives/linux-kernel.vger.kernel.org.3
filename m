Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4259848DE69
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 20:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiAMT4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 14:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiAMT4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 14:56:02 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A2AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 11:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+L8IQFbePjLmj8jogpBBewUbU3G3copTEuVS12npBWE=; b=nnWa+MjhlKpvgGGPDuB1jllm9r
        WfO/UC+xw7alFhLbQM5flj9fUbcCRgOWoRM2afTc+K3DGrZQLtD+liFIq/VqeMMzoN04CnTKoBIvX
        ykIBCWleweG2mVrtiNRi3mtElF0VC8H7ZhMPwVBq5ApsuYCxFEOg7fQoUrJUQtszqPqgHrqR5iH4L
        bjwOa2bpKekl3WDjiUY8JChQj9CAIaNFDFyxCDPpl5f+xLCqa/pxixi77PaLrbR0U4jvp864/BQJH
        QrVuGTizYNzUo9HgDrZ/ECceRGswWEptf0jfN3GLCXS4qWsASW2aAF/FuNKrX3I2YCCD1QDj6SAZX
        aaI/d8DA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n86CC-0010sv-P3; Thu, 13 Jan 2022 19:55:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C4D1F3001E1;
        Thu, 13 Jan 2022 20:55:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A52DE2C258543; Thu, 13 Jan 2022 20:55:37 +0100 (CET)
Date:   Thu, 13 Jan 2022 20:55:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        kernel test robot <oliver.sang@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [PATCH] x86/entry_32: Fix segment exceptions
Message-ID: <YeCDudla868Ipf++@hirez.programming.kicks-ass.net>
References: <20220106083523.GB32167@xsang-OptiPlex-9020>
 <Yd1l0gInc4zRcnt/@hirez.programming.kicks-ass.net>
 <Yd4u2rVVSdpEpwwM@google.com>
 <Yd6zrbFBzSn3ducx@hirez.programming.kicks-ass.net>
 <Yd724f1Uv1GTZ+46@zn.tnic>
 <73020277-d49f-7aae-22db-945e040a31a2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73020277-d49f-7aae-22db-945e040a31a2@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 10:54:39AM -0800, Andy Lutomirski wrote:
> On 1/12/22 07:42, Borislav Petkov wrote:
> > On Wed, Jan 12, 2022 at 11:55:41AM +0100, Peter Zijlstra wrote:
> > > Full and proper patch below. Boris, if you could merge in x86/core that
> > > branch should then be ready for a pull req.
> > 
> > I've got this as the final version. Scream if something's wrong.
> 
> AAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHH!!!!!!!!!!!

:-)

> > +	/*
> > +	 * There is no _ASM_EXTABLE_TYPE_REG() for ASM, however since this is
> > +	 * ASM the registers are known and we can trivially hard-code them.
> > +	 */
> > +	_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_POP_ZERO|EX_REG_DS)
> > +	_ASM_EXTABLE_TYPE(2b, 3b, EX_TYPE_POP_ZERO|EX_REG_ES)
> > +	_ASM_EXTABLE_TYPE(3b, 4b, EX_TYPE_POP_ZERO|EX_REG_FS)
> 
> Aside from POP_ZERO being a bit mystifying to a naive reader...
> 
> >   .endm
> >   .macro RESTORE_ALL_NMI cr3_reg:req pop=0
> > diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
> > index b5ab333e064a..503622627400 100644
> > --- a/arch/x86/include/asm/extable_fixup_types.h
> > +++ b/arch/x86/include/asm/extable_fixup_types.h
> > @@ -16,9 +16,16 @@
> >   #define EX_DATA_FLAG_SHIFT		12
> >   #define EX_DATA_IMM_SHIFT		16
> > +#define EX_DATA_REG(reg)		((reg) << EX_DATA_REG_SHIFT)
> >   #define EX_DATA_FLAG(flag)		((flag) << EX_DATA_FLAG_SHIFT)
> >   #define EX_DATA_IMM(imm)		((imm) << EX_DATA_IMM_SHIFT)
> > +/* segment regs */
> > +#define EX_REG_DS			EX_DATA_REG(8)
> > +#define EX_REG_ES			EX_DATA_REG(9)
> > +#define EX_REG_FS			EX_DATA_REG(10)
> 
> These three seem likely to work

On IRC Andrew also noted that these EX_REG_* things should be __i386__
only. Previosly when they lived as open-coded EX_DATA_REG() usage in
entry_32.S that was implied, but now ...
