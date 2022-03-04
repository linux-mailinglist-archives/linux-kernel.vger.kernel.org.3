Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501884CE00B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 23:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiCDWGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 17:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiCDWGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:06:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E16F1AD3A0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 14:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646431525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xpbSIpXfAvBqAcPEyNw+3AokfVgrAk9V9rcfO42TjmM=;
        b=GJwVPEEXBTg7qHRqlehWnQfeH2LUKA1ymLYpIanxXBA4tjplNM1NKjOaaztRZTbqtxZbbS
        Pvqw3lbve4//gxO1abGUgRTuGAh+rZ1O6Yd5B/OAvEDoDMKEaOsMhiOWjMnX5xoudQkRnc
        lBYWOKTV0uKx+r8j9tCby5SYDLvEnKg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-VVxzNQk3NJudXZMHC-A8Wg-1; Fri, 04 Mar 2022 17:05:23 -0500
X-MC-Unique: VVxzNQk3NJudXZMHC-A8Wg-1
Received: by mail-qt1-f198.google.com with SMTP id w11-20020a05622a134b00b002dd15429effso7184470qtk.18
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 14:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xpbSIpXfAvBqAcPEyNw+3AokfVgrAk9V9rcfO42TjmM=;
        b=FqwMqYln1pZNVgrUAdwjhAfBEr1uvcdfH8aLANh8F5P0OJTWy7kO4zx8BSdOFyxn5o
         F4aPrz35WKsgemu/Mh7QABF5ODI0IW1+OZRynYpcXngtBoq9ltu2UHh95+LNUMc8dhxv
         bo/u0tyhOKgx4uFwTMrjLPNpcdbpJSnCA7Xdx2dOIKOq2nZAzp7i/PsqRXOHAxQTBMh5
         lQWTmv6MrXG2GCvDTSLKqF2Pv3bLUkt8M9zEyJYvW8vw47fgOBBDcAemgzGGyN03T2L4
         GvGor8lMBo0dk+lflC3mTkNTs+6kB+Z2d+akzuYge+CQYD2Iv8ojdkTpMYPe8dDWKzOw
         iIHQ==
X-Gm-Message-State: AOAM531k0gEv4Bq+/HWA771+M6tB143jx85JRxampZbD1lClM6j/lkCz
        826wOF+FNIqtXigv50K763NV+M74LNZJFoDIVBTcWv7hV4ywiEr6KoFeBKojQfEQPZ0GLjV3i7y
        4vdW7Mcc81VKXgxXJpF0NSqus
X-Received: by 2002:a37:9644:0:b0:4f6:c9d5:1c88 with SMTP id y65-20020a379644000000b004f6c9d51c88mr501025qkd.576.1646431523410;
        Fri, 04 Mar 2022 14:05:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKCRR94XRkA6onsvISRkrvguxddQpsMJKn+v0flZFIO8LjiR3XMO5+l0h5EzBAM8ZzI5Y43Q==
X-Received: by 2002:a37:9644:0:b0:4f6:c9d5:1c88 with SMTP id y65-20020a379644000000b004f6c9d51c88mr501000qkd.576.1646431523180;
        Fri, 04 Mar 2022 14:05:23 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id az33-20020a05620a172100b00648af7287desm2837069qkb.26.2022.03.04.14.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 14:05:22 -0800 (PST)
Date:   Fri, 4 Mar 2022 14:05:19 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 18/39] x86/ibt,ftrace: Make function-graph play nice
Message-ID: <20220304220519.o6mel7h6qx4ucesm@treble>
References: <20220303112321.422525803@infradead.org>
 <20220303112826.044301664@infradead.org>
 <20220304175154.l2otvmqd4r7ozsuy@treble>
 <20220304194853.GN11184@worktop.programming.kicks-ass.net>
 <20220304210334.pmrhhcm5okzcr5cd@treble>
 <20220304214454.GT11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220304214454.GT11184@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 10:44:54PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 04, 2022 at 01:03:34PM -0800, Josh Poimboeuf wrote:
> > On Fri, Mar 04, 2022 at 08:48:53PM +0100, Peter Zijlstra wrote:
> > > On Fri, Mar 04, 2022 at 09:51:54AM -0800, Josh Poimboeuf wrote:
> > > > On Thu, Mar 03, 2022 at 12:23:39PM +0100, Peter Zijlstra wrote:
> > > > > +
> > > > > +	addq $16, %rsp
> > > > > +	ANNOTATE_INTRA_FUNCTION_CALL
> > > > > +	call .Ldo_rop
> > > > > +	int3
> > > > > +.Ldo_rop:
> > > > > +	mov %rdi, (%rsp)
> > > > > +	UNWIND_HINT_FUNC
> > > > > +	RET
> > > > 
> > > > Why the int3?
> > > 
> > > Speculation trap :-) Either I'm too paranoid or not paranoid enough; but
> > > without it it's just too close to a retpoline and it doesn't feel right.
> > 
> > Um, it *is* a retpoline :-)
> > 
> > Can you just use the RETPOLINE macro?  Along with a comment stating why
> > it can't just do a JMP_NOSPEC?
> 
> There is no RETPOLINE macro; or rather it is completely contained in
> lib/retpoline.S and I'd sorta like to keep it that way.
> 
> That said, I can stick a comment on.

The only reason it's in retpoline.S is because nobody else needed it.

It just seems weird to reinvent the wheel, especially with a slightly
different method of stopping speculation.

And I could envision other cases where we might want an unconditional
retpoline.

Your call though...

-- 
Josh

