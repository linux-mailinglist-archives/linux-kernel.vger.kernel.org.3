Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C8D4CDF90
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiCDVEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiCDVEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:04:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98FB05FCA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 13:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646427820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uepxqKa49U9DtP7vSiJANEqZkhKjNPO/WhiEn3CDpEI=;
        b=c9SARkopQvR8OYzUd3HDg+PKDe0boQieerR2HH0p23XJ+boq4O4KlaOks+UJop2Bet6qIk
        WoNIvfpJwkbQq25jMVz/B3sics131TkoHCTMciJlTYFljdJ7PSYg4+gBBM34XyBuodYbDw
        NxDk3+vgSGebfk8At7yBo0Yr2qSUX1A=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-cUKWVrUkO5uIuW5q_OJTKQ-1; Fri, 04 Mar 2022 16:03:39 -0500
X-MC-Unique: cUKWVrUkO5uIuW5q_OJTKQ-1
Received: by mail-oi1-f197.google.com with SMTP id u62-20020acaab41000000b002d48ee5b710so6346175oie.20
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 13:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uepxqKa49U9DtP7vSiJANEqZkhKjNPO/WhiEn3CDpEI=;
        b=2q6+xGfeBVPms7gble1fcq8myGbtXCR+f7bmKcku7sYxlWYwH5TUNLMTMhzc2W0DZ7
         9R9h2MXSAqaFarbA1IZI0Ce/u5cR7JlKL8g6yfj+tupSXy3DcS6U2m+Uy9nwi947iZZK
         8Q6nEliiBwzUjdcQATa5OULwGO2DcRn55yqvnyfnEYl4RZgurvHo4Lk99Zfku7FcHLD8
         aN10btMEgJSewwK5d5Dr1W2PBPpsJHr56/sDOP3RZ9PxOHA+KmeW5kU6QTeeCDl1h8HR
         jyBSxW2bDC0044kNYBOoBtFISMmQF+SnBDOjxAryP6WCVJAIcBj9jAimpw4bwHMrmevr
         22Sw==
X-Gm-Message-State: AOAM531ZyFfZC6rXVyDrTFmfdKNF24iIUBdvZQLzXFguw9fgzZ1wnfxG
        G1aFTsQeVWADFSMdNwiUMxGnzC3db4/wndXkf440vAJkazCtXiME0V4ZVEoP8UbwqdjUEuLGzdM
        raVLL4EzBJM9jZUZilUfom83i
X-Received: by 2002:a05:6870:eca1:b0:da:b3f:3270 with SMTP id eo33-20020a056870eca100b000da0b3f3270mr170958oab.288.1646427818156;
        Fri, 04 Mar 2022 13:03:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6g+eOIOg7fgneT/boB7H4KCbDYRxhlnAPcPQX84IglqBZfp5G03NoG3xEF2zXBU3BXhQc5Q==
X-Received: by 2002:a05:6870:eca1:b0:da:b3f:3270 with SMTP id eo33-20020a056870eca100b000da0b3f3270mr170950oab.288.1646427817923;
        Fri, 04 Mar 2022 13:03:37 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id y8-20020a544d88000000b002d525da014bsm2932485oix.42.2022.03.04.13.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 13:03:37 -0800 (PST)
Date:   Fri, 4 Mar 2022 13:03:34 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 18/39] x86/ibt,ftrace: Make function-graph play nice
Message-ID: <20220304210334.pmrhhcm5okzcr5cd@treble>
References: <20220303112321.422525803@infradead.org>
 <20220303112826.044301664@infradead.org>
 <20220304175154.l2otvmqd4r7ozsuy@treble>
 <20220304194853.GN11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220304194853.GN11184@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 08:48:53PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 04, 2022 at 09:51:54AM -0800, Josh Poimboeuf wrote:
> > On Thu, Mar 03, 2022 at 12:23:39PM +0100, Peter Zijlstra wrote:
> > > +
> > > +	addq $16, %rsp
> > > +	ANNOTATE_INTRA_FUNCTION_CALL
> > > +	call .Ldo_rop
> > > +	int3
> > > +.Ldo_rop:
> > > +	mov %rdi, (%rsp)
> > > +	UNWIND_HINT_FUNC
> > > +	RET
> > 
> > Why the int3?
> 
> Speculation trap :-) Either I'm too paranoid or not paranoid enough; but
> without it it's just too close to a retpoline and it doesn't feel right.

Um, it *is* a retpoline :-)

Can you just use the RETPOLINE macro?  Along with a comment stating why
it can't just do a JMP_NOSPEC?

-- 
Josh

