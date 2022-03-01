Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C0B4C98F9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 00:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbiCAXN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 18:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiCAXN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 18:13:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9D4830F47
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 15:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646176395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EI1OJ7NrqE5ww993zWd5Fjo+b/WPPmuwGAJ8gPpNTiQ=;
        b=SidePGSOgTrr3QE/8jdO5JH6d2Z3/ehdb57A8MchkPmwAXwdAqsrUhBDzQWvpXsrfTdjXS
        SB74oyYiqf9OX0hlLJgfysSN1k1APua/O0tIYYswzxvN6K95oGs1j+in+3EkLp+rdGjAkY
        GnIEXj2Arb4rg01cTQDnvowDXm2haeM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-kyAFqlhXOfOhp8SVpRbItA-1; Tue, 01 Mar 2022 18:13:08 -0500
X-MC-Unique: kyAFqlhXOfOhp8SVpRbItA-1
Received: by mail-oo1-f71.google.com with SMTP id r4-20020a4abf04000000b0032030c12b39so267oop.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 15:13:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EI1OJ7NrqE5ww993zWd5Fjo+b/WPPmuwGAJ8gPpNTiQ=;
        b=Ex6fTg91buOi60of2IIGd7bF7gnLPBxWY16YruqIGAh3dgUkQSaWoD932di3XeosGv
         8boenFpay+kOX7wKbcJj8/jHbE70GJJwUHFufIxZWLdw1oIiC07eEKoMeC894k6PuBWi
         lNFoj5CKQNBSFzGCtDxeSuzZIqgLXOyLsPADM3tgVC0r2lNpbAtLp6gPAKRX+mnkfVSQ
         ru8Mv/0YCeEz6zeCRAGcAok8/57yTVv0RSdAwp6i/VFU+o26lVCClV7XuyWFuCmAiPQl
         mcUfeVRRZU12QR71ur9gHolgxxgbXZ0QmZekYLGHAed+eOk+GgP42sDtf4IMCyYZBL6K
         hHqQ==
X-Gm-Message-State: AOAM533OkXHFlthMtVe24JO3FnFxts5OeQMgdO47uFDbb1CDAQDuKrW4
        psf/DtDzrtyFc7o4i0pL2cz3fcMPf2WJvZYmWV5q+5HeI6QsOphKuk0tq75+AVzyWQpMCMzq8Jc
        tkKxhc+Vfalh/jAYwk/aLRmVd
X-Received: by 2002:a05:6830:5:b0:5af:7ed5:8f64 with SMTP id c5-20020a056830000500b005af7ed58f64mr13893513otp.257.1646176387855;
        Tue, 01 Mar 2022 15:13:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7WgNpCnfAKQJw/5d9DHBb7uCw62oFY8ol6LBiS9ImCO/LRIQBeOANIhkIA4MRmdJH6jwqIQ==
X-Received: by 2002:a05:6830:5:b0:5af:7ed5:8f64 with SMTP id c5-20020a056830000500b005af7ed58f64mr13893482otp.257.1646176387629;
        Tue, 01 Mar 2022 15:13:07 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::b])
        by smtp.gmail.com with ESMTPSA id 7-20020a4a1e07000000b002fcc8003c36sm6873711ooq.14.2022.03.01.15.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 15:13:07 -0800 (PST)
Date:   Tue, 1 Mar 2022 15:13:03 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v2 18/39] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <20220301231303.pqexbxkpte6yjiww@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.069205370@infradead.org>
 <eed8902f21ba9e5f93562432f6b5920137860a98.camel@intel.com>
 <Yh44YsW8viBscBD0@hirez.programming.kicks-ass.net>
 <20220301210245.GM11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220301210245.GM11184@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 10:02:45PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 01, 2022 at 04:14:42PM +0100, Peter Zijlstra wrote:
> 
> > Something like so?
> > 
> > diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> > index 399f075ccdc4..5b65f6ec5ee6 100644
> > --- a/arch/x86/kernel/relocate_kernel_64.S
> > +++ b/arch/x86/kernel/relocate_kernel_64.S
> > @@ -114,6 +114,14 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> >  	/* store the start address on the stack */
> >  	pushq   %rdx
> >  
> > +	/*
> > +	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
> > +	 * below.
> > +	 */
> > +	movq	%cr4, %rax
> > +	andq	$~(X86_CR4_CET), %rax
> > +	movq	%rax, %cr4
> > +
> >  	/*
> >  	 * Set cr0 to a known state:
> >  	 *  - Paging enabled
> 
> I *think* it worked, I 'apt install kexec-tools' and copied the magic
> commands Josh gave over IRC and the machine went and came back real
> quick.
> 
> Lacking useful console I can't say much more.
> 
> I pushed out a version with these things on.

I just used your latest git tree, kexec into a non-IBT kernel worked for
me as well.

-- 
Josh

