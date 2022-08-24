Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E1759FFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbiHXQpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239594AbiHXQpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:45:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FF325FA
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:45:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo2213931pjd.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=tU1yBnqhlu3GqyKX52PVBbY7hfY440wN3o9LUS939qw=;
        b=dMwaDYcQTBZEUAz6w9NArwGUlxFWdZ3Pss5DJq8kQ35DIDbNM2J2BoG/fLJUW7rAsk
         0QkvfhDnsJ4GpqK+iwL2pNU8/iNzBW0S4Vz8aXQDoTWy5C9oPqxuTmJv7ilJjJwJHmXc
         Kev/YZH83qJsfs9xjvwGtRFhUI4Bn2u9JNj2hZfiZhr8jSp1vQlhxBzwpdAzhlIPp+ak
         VdN83DtNcVMzLg9ICJmdmqkTLFRdO/ClUvv+FlSKobXzKj/BQ7yWjJaL7hLXxQelxtQj
         1Fmqnu76cf5fKgdgEA7VgO+8MnkMbKLlJsxV3HeCVq8ipj8XaQFvLBn7h+plvbH4rhDk
         TO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=tU1yBnqhlu3GqyKX52PVBbY7hfY440wN3o9LUS939qw=;
        b=4gW0J5a8Tz456zU7Rjf7SYy8ZsQIGcx102KIw9SgIAnjCvAAXCiYoP18RJ9zIj5v36
         Bqx0gTPKUx9kCyLU71f97tJjPaEt23esf2oHpbbhW7fHwDvxSd6Rlq4dI8UsHTRHimAU
         Ol0BQuIGSwZEgGqk12C5rzs+O8RDOjJ3SzZGXqXfOJ9wmC01wUZZsNDnD9PUP8F5/aGI
         t6H1h9pNMxpXKGc8rCx3uU5pT/JFSTrFp5wqSwN/e8TvBZtyHmple78ypGAN2SPQXvHR
         RhSZXaaIumlCHDqzJatO9BGw1RgayfMTerrZTJo/cm4s54o0RFUji9E92WQYE6k5xjOw
         uOjQ==
X-Gm-Message-State: ACgBeo2clb79Js49WkUbUln3eplTTAsF1r5gTbcMS0PRMmHWIDRTB4tN
        QxBg+oh+Gb0vzaGQMPGAme+idA==
X-Google-Smtp-Source: AA6agR6mRl2fzdjX6KtKC9JWf9pNY+kiiRoR9PXpwCPuruebJXijTYHgPAAsuT/LODAzP52270zQ/w==
X-Received: by 2002:a17:90b:3684:b0:1fa:f48e:abd0 with SMTP id mj4-20020a17090b368400b001faf48eabd0mr28499pjb.180.1661359507905;
        Wed, 24 Aug 2022 09:45:07 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id o19-20020aa79793000000b005364944e538sm9721693pfp.99.2022.08.24.09.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 09:45:07 -0700 (PDT)
Date:   Wed, 24 Aug 2022 16:45:03 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 09/17] perf/core: Use static_call to optimize
 perf_guest_info_callbacks
Message-ID: <YwZVj+8H4rGjEHyH@google.com>
References: <20211111020738.2512932-1-seanjc@google.com>
 <20211111020738.2512932-10-seanjc@google.com>
 <YfrQzoIWyv9lNljh@google.com>
 <CABCJKufg=ONNOvF8+BRXfLoTUfeiZZsdd8TnpV-GaNK_o-HuaA@mail.gmail.com>
 <202202061011.A255DE55B@keescook>
 <YgAvhG4wvnslbTqP@hirez.programming.kicks-ass.net>
 <202202061854.B5B11282@keescook>
 <CABYd82ZmDbgmEGhdWOJ5Um8tiFd4TeQ-QZ2+xwxwqqQs6oi0xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABYd82ZmDbgmEGhdWOJ5Um8tiFd4TeQ-QZ2+xwxwqqQs6oi0xg@mail.gmail.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022, Will McVicker wrote:
> On Sun, Feb 6, 2022 at 6:56 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Sun, Feb 06, 2022 at 09:28:52PM +0100, Peter Zijlstra wrote:
> > > On Sun, Feb 06, 2022 at 10:45:15AM -0800, Kees Cook wrote:
> > >
> > > > I'm digging through the macros to sort this out, but IIUC, an example of
> > > > the problem is:
> > > >
> > >
> > > > so the caller is expecting "unsigned int (*)(void)" but the prototype
> > > > of __static_call_return0 is "long (*)(void)":
> > > >
> > > > long __static_call_return0(void);
> > > >
> > > > Could we simply declare a type-matched ret0 trampoline too?
> > >
> > > That'll work for this case, but the next case the function will have
> > > arguments we'll need even more nonsense...
> >
> > Shouldn't the typeof() work there too, though? I.e. as long as the
> > return value can hold a "0", it'd work.
> >
> > > And as stated in that other email, there's tb_stub_func() having the
> > > exact same problem as well.
> >
> > Yeah, I'd need to go look at that again.
> >
> > > The x86_64 CFI patches had a work-around for this, that could trivially
> > > be lifted I suppose.
> >
> > Yeah, I think it'd be similar. I haven't had a chance to go look at that
> > again...

Peter and/or Kees, can you provide a pointer to the patches that could potentially
be used as a basis for fixing ARM CFI?  Or even better, send a patch to actually
fix this?  :-)
