Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A975750183C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbiDNQGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349704AbiDNP5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D56D25EA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649950739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t3cZ/yakMUfrN5XmUvj9bTbScCTr9kRRHTB7H1tbd/s=;
        b=WWuDMi3UL5jTTVJS0MdT8nnlQK2ptmtPb/n99RW5j9jq5ELEEWJeVoyIi3ZwK3+3c6cOs7
        cFHh2mmUSQOTF3ps9W1B6Nca6xxAF3Z0GwPFwpsoezLYEV0jHCQuyAc4igfMM6ZLd3ha8z
        jWUJz+UsJnlu5m/5WxKVd+NKPllO21Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-ePcWycZjNDCIoKapxmrgQg-1; Thu, 14 Apr 2022 11:38:58 -0400
X-MC-Unique: ePcWycZjNDCIoKapxmrgQg-1
Received: by mail-qv1-f70.google.com with SMTP id j7-20020a05621419c700b004461f75de48so2603045qvc.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t3cZ/yakMUfrN5XmUvj9bTbScCTr9kRRHTB7H1tbd/s=;
        b=27nlpNnImtNbmyhRHdAUHnE84e1i/OQBLMdRMksx20BgBPoT/AXbANvtUu9s8RnxKZ
         Q4NgcQzW/igR3iYylSy+we75Z4dJlcsLBfcvMRADQB/Yn9rLwrRGflMOWsGKEQEA4BHM
         CleN8zo/L7OmCKJ86wCTpRuVIFgnAuPQg1l+G/7hdK0tNyWhAKhK3iNUslVPIj1jv2em
         0MKaXxz+/AsnLuStzDFiA5LmnRwNeX+3UJRtluUpiKMbxBbCG+7KchJkC+xbMBxopngF
         /1bFrt85fzP2xEKkqWztOKFw1pFvQwqvDESHkT1T47OwTQuECFoMyVK3p1jMZ/Uil+LG
         sD3Q==
X-Gm-Message-State: AOAM533FTpLW2JFC1es1dhFkX39/R6uqezXtaell2l1WC+qc1xjhJBpK
        okoLLtCYnWLiET6BbmkYMhVPGY55Nf664hwOySoWg3KTBZTSWjP9p99QydKjzp2tmwt/JswOoNw
        gLVS9MaAZP746EnI59LqdWUX9
X-Received: by 2002:a0c:a68a:0:b0:443:d22b:cdff with SMTP id t10-20020a0ca68a000000b00443d22bcdffmr3789363qva.47.1649950737892;
        Thu, 14 Apr 2022 08:38:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze8W46NbV6/9Tp9r6j9MjY3E2Hv+NCeywBGGSwJGOsm+zY4ZuLFFBm5i+ghYIJgBO5EZamqQ==
X-Received: by 2002:a0c:a68a:0:b0:443:d22b:cdff with SMTP id t10-20020a0ca68a000000b00443d22bcdffmr3789344qva.47.1649950737666;
        Thu, 14 Apr 2022 08:38:57 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id a4-20020a37b104000000b0069c2ba88bdasm1130550qkf.85.2022.04.14.08.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:38:57 -0700 (PDT)
Date:   Thu, 14 Apr 2022 08:38:54 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 02/18] objtool: Support data symbol printing
Message-ID: <20220414153854.rqkt465xn4vzndr7@treble>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <097057f88605aa67b0e3ec573fcf394ae7ac4d6f.1649891421.git.jpoimboe@redhat.com>
 <YlfHy011VP2oPFjV@hirez.programming.kicks-ass.net>
 <20220414152148.cwdefx744kymqcut@treble>
 <Ylg+bewBpaqqYgeB@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ylg+bewBpaqqYgeB@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 05:31:57PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 14, 2022 at 08:21:48AM -0700, Josh Poimboeuf wrote:
> > On Thu, Apr 14, 2022 at 09:05:47AM +0200, Peter Zijlstra wrote:
> > > On Wed, Apr 13, 2022 at 04:19:37PM -0700, Josh Poimboeuf wrote:
> > > 
> > > > @@ -34,8 +37,8 @@ static inline char *offstr(struct section *sec, unsigned long offset)
> > > >  
> > > >  	str = malloc(strlen(name) + 20);
> > > >  
> > > > -	if (func)
> > > > -		sprintf(str, "%s()+0x%lx", name, name_off);
> > > > +	if (sym)
> > > > +		sprintf(str, "%s%s+0x%lx", name, is_text ? "()" : "", name_off);
> > > >  	else
> > > >  		sprintf(str, "%s+0x%lx", name, name_off);
> > > 
> > > So I like the patch, except that "()" thing is something where we differ
> > > from the kernel's %ps format and I've cursed it a number of times
> > > because I then have to manually edit (iow remove) things when pasting it
> > > in various scripts etc..
> > 
> > Oh, hm, that's true.  I can remove them if you prefer.
> 
> Yeah, I think taking it out is best, easier if we're consistent with %ps
> for everybody.

Will do.

> > > That said, it totally makes sense to differentiate between a text and
> > > data symbol this way :/
> > 
> > Yes, but if we're keeping the "Add sec+offset to warnings" patch then
> > that distinction is already (kind of) being made by showing the data
> > section name.  And the data symbol warnings should be rare.
> 
> Yes, I'd not seen that yet, what's that for? The Changelog alludes to
> something, but I don't think it actually does get used later.

Nick had asked for something like that, it's just a way to avoid doing
math every time we look at a warning, i.e. to convert func+offset to
sec+offset.

But it's kind of ugly and I'm not 100% happy with it.

Maybe it should be behind an option (--sec-offsets)?

-- 
Josh

