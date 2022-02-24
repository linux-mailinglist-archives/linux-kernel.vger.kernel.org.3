Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476214C38FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiBXWrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiBXWrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:47:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F298E2198
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645742797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WTczrDjAa2NO+fw5U0Wu+pn7i9yPzc6kDHZ9NOpMh8I=;
        b=CE0yJ4XjlkY1kmSLkyj7/+C+pV7Fw93JXPSvgBz6rI6AeSHiUUY6wDHQMPP7t+6BhwbJZR
        6UyVxGxWdmegVxPrQ9fJ9vOIV5gmBVQhgsXQpH8HcY3MPcDfD8hvhzkVPeC4nxaQYBIcnX
        MaTlVAB0fjckQbzpO3zHrEqSPiLUWac=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-WN5cz22xPdGIRh9VBz_Q1g-1; Thu, 24 Feb 2022 17:46:35 -0500
X-MC-Unique: WN5cz22xPdGIRh9VBz_Q1g-1
Received: by mail-qt1-f198.google.com with SMTP id j7-20020ac84407000000b002de72c633b2so788959qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WTczrDjAa2NO+fw5U0Wu+pn7i9yPzc6kDHZ9NOpMh8I=;
        b=JH7/tSVC2XBHqvUKwrJE8bkmyhwd0JaRm8WF7pfEhfApBroH7xnHswZl3lUI6CYMkY
         tQUF/4TUUxs5ttcS5PlPDJYjVB19peu77lnDa9bgcL1zYxbxqOFTzLzG8+4xhznTmWzk
         WLthLBlY/jFmiiKkpWQ4PUZWlzjXIU7ASBU9OMKHUFdbcWeTTjcWTgEUafWJC8xZbM3z
         U37fb3YRG5sQUj5JjCBHQxXOLkoPNMGUrQudxJIGG2PnDCNToLU3SNDD6dtIzZdq0AWj
         HHvgZ2ecH9DvlSvE4uRH2wEZOzkkK3R8xzbcnaMIUD7Q6IxE6jSBhoRK8mNcJFnp18Sg
         1D+A==
X-Gm-Message-State: AOAM532Iqzmmgl5FSu1wx+K41Ebaqt1sDvjWQPKiYGFQp10zPTZ2NkLn
        0X+AfTlCl8oOoF+hcsQe4IkRAEZ0fxlaF3Pj/WJA9tq3G6utuoSSLnLu2IQTjcDxnBH1taM2sTe
        1cbHKNHZwL4um1/W9QjSph12n
X-Received: by 2002:a37:a307:0:b0:508:b101:6d7a with SMTP id m7-20020a37a307000000b00508b1016d7amr3180117qke.311.1645742795428;
        Thu, 24 Feb 2022 14:46:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3lxMLs6NpxmzWzBWQI1gwxChvh+Mh0f2hr3U7wycNGqRB+/Ta87W2tnSmFmUSmbGgo6l7BA==
X-Received: by 2002:a37:a307:0:b0:508:b101:6d7a with SMTP id m7-20020a37a307000000b00508b1016d7amr3180093qke.311.1645742795167;
        Thu, 24 Feb 2022 14:46:35 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id y16-20020a37e310000000b00648c706dda1sm454942qki.6.2022.02.24.14.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:46:34 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:46:31 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
Message-ID: <20220224224631.tr3odcwacpoejftn@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.714815604@infradead.org>
 <20220225005520.c69be2fbdbd28028361792d9@kernel.org>
 <20220224105847.5c899324@gandalf.local.home>
 <20220224110130.4f4ae4ac@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224110130.4f4ae4ac@gandalf.local.home>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 11:01:30AM -0500, Steven Rostedt wrote:
> On Thu, 24 Feb 2022 10:58:47 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 25 Feb 2022 00:55:20 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > >  unsigned long ftrace_location(unsigned long ip)
> > > >  {
> > > > -	return ftrace_location_range(ip, ip);
> > > > +	struct dyn_ftrace *rec;
> > > > +	unsigned long offset;
> > > > +	unsigned long size;
> > > > +
> > > > +	rec = lookup_rec(ip, ip);
> > > > +	if (!rec) {
> > > > +		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
> > > > +			goto out;
> > > > +
> > > > +		if (!offset)    
> > > 
> > > Isn't this 'if (offset)' ?  
> > 
> > No, the point to only look for the fentry location if the ip passed in
> > points to the start of the function. IOW, +0 offset.
> > 
> 
> I do agree with Masami that it is confusing. Please add a comment:
> 
> 		/* Search the entire function if ip is the start of the function */
> 		if (!offset)
> 			[..]
> 
> -- Steve
> 
> > 
> > 
> > >   
> > > > +			rec = lookup_rec(ip - offset, (ip - offset) + size);

If 'offset' is zero then why the math here?      ^^^^^^^^^^^   ^^^^^^^^^^^
-- 
Josh

