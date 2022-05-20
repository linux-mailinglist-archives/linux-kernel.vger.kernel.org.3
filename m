Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BF952E9AD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347922AbiETKLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiETKLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:11:33 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B333C562F3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:11:31 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id o22so9111174ljp.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Skx2zpy1PMa6tudbnRm9c7Rx7FIXVp820jTpRzRNRw8=;
        b=e4D6OdD8003gzrpVoyJkLBaJsd0EkGLIJy6lfX3etZ/4/IrNHLrDesYBize4K6EoPO
         RJHDB6l7kgXmKxGZ5g+/SEGWsAt21Sc9ERRvEitjK6gv49xgkA/f1xGo7JjBABlWx7yK
         Nf+dhRvfRiD6QYRFE57Wj32Bl08Wbnb9fTPrZjCxEiWnXnjWQ3UJ5df3syQNMRtvcNLA
         pwzz1htDaY7wXvSQohGKlSx8K06m4ktDQYwz/0VntEMKp5JO1TO4D+NmkmM7Hfb0cUkh
         xDlSGeE8Q3FRluFoy7RNbo2dVgQeyndRUUVf/xT/hGmpm1meJbPasx8zk6b2lu9H5It+
         cNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Skx2zpy1PMa6tudbnRm9c7Rx7FIXVp820jTpRzRNRw8=;
        b=HZA7F7m1oNBMC5pwyl2orbHOr6psva4rqBZqqxkw4CmbDKCFtl7bCTA28Q4PHuNsAI
         LvzsN22YyQGZjjz7KwZNl1XpPx+3BOC6/uZjvlijjrbG9L1Hy+IHckH+myq+RjqnM17N
         yDhTn2ZMedkuDxmbqXfVuSEuAdRcb+1WHZPjh/egOPUb36QmSj9a9iGJObdiixKTrvxU
         5QFiYl1UEzzjxYdRNrX1DxZWPpiHKqtUMMYn8Hux66c5ZP4vj5n1PRrtWI3y5/i0kMt+
         feZJcgKRHzSzhaCFddJ4cw0kFy6FyFZFVFNIFGe9xN8wy5OVd7m8ACGyDEZZphbksI2f
         hV7A==
X-Gm-Message-State: AOAM531suALXOP+TY2+yA77BS4DeD6KdWMkBM89dBEGcZLsS1IV42+fI
        TrVRzcvkdfT+kBvbFcS3e1p9x/HZppZf0jYE
X-Google-Smtp-Source: ABdhPJyswmUJqh69golRIqXrT9f5/znx8axuL1Slw8+SENXD70jJZidGPaEAaR3QF334RRjkW2o1Ag==
X-Received: by 2002:a2e:968d:0:b0:253:d66a:ffd9 with SMTP id q13-20020a2e968d000000b00253d66affd9mr4022896lji.184.1653041489946;
        Fri, 20 May 2022 03:11:29 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o25-20020ac24359000000b00473cb4f7cf6sm598114lfl.309.2022.05.20.03.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 03:11:29 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 52951104AAB; Fri, 20 May 2022 13:13:22 +0300 (+03)
Date:   Fri, 20 May 2022 13:13:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>,
        Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        frederic@kernel.org, paulmck@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC][PATCH 9/9] arch/idle: Change arch_cpu_idle() IRQ behaviour
Message-ID: <20220520101322.flxf52mg6vkkbc7r@box.shutemov.name>
References: <20220519212750.656413111@infradead.org>
 <20220519213422.119695559@infradead.org>
 <20220519220349.GM2578@worktop.programming.kicks-ass.net>
 <20220520022052.mkrc4v4evtp74bxe@black.fi.intel.com>
 <20220520070614.GP2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520070614.GP2578@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 09:06:14AM +0200, Peter Zijlstra wrote:
> On Fri, May 20, 2022 at 05:20:52AM +0300, Kirill A. Shutemov wrote:
> > On Fri, May 20, 2022 at 12:03:49AM +0200, Peter Zijlstra wrote:
> > > 
> > > On Thu, May 19, 2022 at 11:27:59PM +0200, Peter Zijlstra wrote:
> > > > --- a/arch/x86/coco/tdx/tdx.c
> > > > +++ b/arch/x86/coco/tdx/tdx.c
> > > > @@ -178,6 +178,9 @@ void __cpuidle tdx_safe_halt(void)
> > > >  	 */
> > > >  	if (__halt(irq_disabled, do_sti))
> > > >  		WARN_ONCE(1, "HLT instruction emulation failed\n");
> > > > +
> > > > +	/* XXX I can't make sense of what @do_sti actually does */
> > > > +	raw_local_irq_disable();
> > > >  }
> > > >  
> > > 
> > > Kirill, Dave says I should prod you :-)
> > 
> > It calls STI just before doing TDCALL that requests HLT.
> > See comment above $TDX_HCALL_ISSUE_STI usage in __tdx_hypercall()[1].
> 
> Yes, it says that, but it's useless information since it doesn't
> actually tell me the behaviour.
> 
> What I'm interested in is the behavour of the hypercall when:
> .irq_disabled=false, .do_sti=false
> 
> From what I can tell, irq_disabled=false should have the hypercall wake
> on interrupt, do_sti=false should have it not enable interrupts.
> 
> But what does it actually do ? Because HLT without STI is a dead
> machine, but this hypercall looks more like mwait with the irq_disabled
> argument...

+Isaku.

So you want to call call the HLT hypercall with .irq_disabled=false and
.do_sti=false, but actual RFLAGS.IF in the guest is 0 and avoid CLI on
wake up expecting it to be cleared already, right?

My reading of the spec is "don't do that". But actual behaviour is up to
VMM and TDX module implementation. VMM doens't have access to the guest
register file, so it *may* work, I donno.

Sorry for not being helpful :/

Isaku, maybe you can clarify this?

-- 
 Kirill A. Shutemov
