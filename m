Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69040508E74
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381106AbiDTRdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381101AbiDTRde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D24D611C39
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650475831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y4JE6wyb2ShqsvdPaXiLjq0dX7u4l1z3usOK9my2jvM=;
        b=EMNptYOz2d51MKOMt3uJCD5vTW/gH9KiiN5vZaFNhcAjXCPT75qZWEBC1Hg2jre1cw/0FL
        eKd4Ft2/EHAD5cosiQQVQ3/0JoIFxUiLoFjtarr+yqGU7tdfkL2M4Sr9royS8BETjDxx1y
        ImqvSWdyUqtuLcgGglm42qMxWrLagiY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-UA2GTVn1MvyNgzkYI6qONA-1; Wed, 20 Apr 2022 13:30:30 -0400
X-MC-Unique: UA2GTVn1MvyNgzkYI6qONA-1
Received: by mail-qv1-f69.google.com with SMTP id cs5-20020ad44c45000000b004463a27fb3fso2046119qvb.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y4JE6wyb2ShqsvdPaXiLjq0dX7u4l1z3usOK9my2jvM=;
        b=0rSIx1yJoxG35hTe6gTHKTwkbuSkWTAd5ZNDDZMasxyaMmXr8poHS8QmIkgJBY3N7v
         ECwzfIKKlbIng+WR3T0DSUfZF0EZaxQ8pCyfAK9aRbrmGRIfqu73wotXjI8baVVf/r5N
         s48ntwWCR+WZiZsuhW3ZALNQ0cdyvyakjBL+JcvYzu5a6YNET2YlZZp78iRabGAuxN5p
         yuvr5BTb/HaOtS4vBFnpx92lm9kWkRg7hs18loSk8SfSeJW7BVkEz+IDfH7oEDBtcwhg
         Fuu51nDxRi48hyPck30OYp7/wmBnCdoZF4Ol1XqNAucpew/DasWG4MjRXKCr74wkhn12
         neQg==
X-Gm-Message-State: AOAM530H+mi+i4pm6dN58qstpeF1IUtg/zULvWCLjAyLRSJxdEq8lSEX
        sAu1tjJMpH+k/Q4OjIqxPOOA63U8sk6uBb2AggGz0eYDisT7Jnba6mHyVDZHLJBjW6bQWjzD3MR
        4xmfiIwOt6N4GiGcdTYWaeCFv
X-Received: by 2002:a05:622a:1884:b0:2f2:133e:6434 with SMTP id v4-20020a05622a188400b002f2133e6434mr8235685qtc.666.1650475829377;
        Wed, 20 Apr 2022 10:30:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2hSzycUsIxnhGF/NblJkH+AnPymvZq3uEBPPPKuboOxo4jydyvImoPtsc0gsTF9wSq32z1w==
X-Received: by 2002:a05:622a:1884:b0:2f2:133e:6434 with SMTP id v4-20020a05622a188400b002f2133e6434mr8235671qtc.666.1650475829141;
        Wed, 20 Apr 2022 10:30:29 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id c4-20020a37b304000000b0069ec13803adsm1796157qkf.7.2022.04.20.10.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 10:30:28 -0700 (PDT)
Date:   Wed, 20 Apr 2022 10:30:25 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] kbuild: Remove CONFIG_DEBUG_SECTION_MISMATCH
Message-ID: <20220420173025.iobbcym4ff6nfapg@treble>
References: <7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com>
 <CAK7LNARvFcQgEB1b0L6giwx0vD7wU9L-OZ5jvm1c5+StLjeOYQ@mail.gmail.com>
 <20220409004821.tcztejr2cgsieqaq@treble>
 <CAKwvOdmfUDZPyhtF5fvdKy7i-qRKB7Bmq80DhP0F=yarG+rnpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmfUDZPyhtF5fvdKy7i-qRKB7Bmq80DhP0F=yarG+rnpw@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:03:18AM -0700, Nick Desaulniers wrote:
> > > If the issues are all about objtool,
> > > "depends on !STACK_VALIDATION" might be
> > > an alternative approach?
> > >
> > > config DEBUG_SECTION_MISMATCH
> > >            bool "Enable full Section mismatch analysis"
> > >            depends on CC_IS_GCC
> > >            depends on !STACK_VALIDATION        # do not confuse objtool
> >
> > Yes, that would be another way to handle it.  Though that means the
> > option would effectively be dead on x86-64.
> 
> Does this series help (or is it related to this thread)?
> https://lore.kernel.org/lkml/cover.1650300597.git.jpoimboe@redhat.com/
> Patch 17/25 seems to make STACK_VALIDATION unwinder-dependent (on
> CONFIG_UNWINDER_FRAME_POINTER)?

Not really, that series just splits objtool into more granular features,
so objtool is no longer just equivalent to CONFIG_STACK_VALIDATION.  So
the above suggestion would probably need to be changed to something like

  depends on !HAVE_UACCESS_VALIDATION

Or maybe

  depends on !(HAVE_UACCESS_VALIDATION || NOINSTR_VALIDATION)

But uaccess validation is still mandatory for x86-64, so that would
still unconditionally disable CONFIG_DEBUG_SECTION_MISMATCH for x86-64.

-- 
Josh

