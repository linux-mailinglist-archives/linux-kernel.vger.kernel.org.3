Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4883508BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376391AbiDTPUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354475AbiDTPUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EACB44A2A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650467840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tawPnIWWjQdoIazhl+r2801d/l1EXFGE8jMsnLNAlno=;
        b=ibuGkRFN41AkdHtPkwsHzz5jnywAQqpmBAhCHcZBoPLi7N0pQFXUQkMvmk0SXTX7VeSypy
        NhB+H4CckSRhJlQMRVSyyhLiGfecc1Mddd2EgKUsFti7f3iAvFVmhXPEIRAf3zp6ZCVohz
        cqls5qOy9hv5jjkkBUsDussAYkX05kI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-IH7d5f_ZMCC_Sr4d6P9WQw-1; Wed, 20 Apr 2022 11:17:19 -0400
X-MC-Unique: IH7d5f_ZMCC_Sr4d6P9WQw-1
Received: by mail-qk1-f200.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so1404186qkb.23
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tawPnIWWjQdoIazhl+r2801d/l1EXFGE8jMsnLNAlno=;
        b=KE/WtnoHDqrML9lSeiZYGH0okcQQhoLkj8qvTVzwj8MMpXt7T6JQ7YRD6bn5VOtxJ4
         xmB0zY8wcpwrnt9K9Mygx4PFMRpsvHtow+QQs6U0b5v2D1j+GRTV/lv48puNqjaPq+gJ
         nzTssXL8BJMToHiZoat3qCioa7snvJKc9Nqus9IbttaJQRrxKA6OER+dk/+FKbi2nJo8
         GK57oItGqDFx39vmbdcuWQ0V7uWlb/mVJMC1laNlsEZdZaxpaDJKyKOrGygdVuYny3IT
         WIrz1yXbNRIEaxxHW6Kzxhy99lkyL0uyYF99v+onWaPAG594yW1TsPxOOrSYC069TDF0
         gOUQ==
X-Gm-Message-State: AOAM531fRcTsHs7fzEJ8yEUG1sbLjMBV/+dgRijnsPrvAPSGOM50w27j
        J7yqmG0KkqlNYAtVCR5WxiWTu0Euy8wz9DR0a2djXKobW1f28/i8rlwpTZO6fCITXmEy58EZDpf
        B4m0mLt7o2RNXDl0hK5r6IQJS
X-Received: by 2002:a37:b484:0:b0:69b:db47:69a8 with SMTP id d126-20020a37b484000000b0069bdb4769a8mr13172014qkf.460.1650467838560;
        Wed, 20 Apr 2022 08:17:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9Jr9LQASoZCUHBuMXCR9K/qCqPf0fDTpqGvGKtTblfg7LphaYZ397Zrar7j6Rf9EQRb7i+g==
X-Received: by 2002:a37:b484:0:b0:69b:db47:69a8 with SMTP id d126-20020a37b484000000b0069bdb4769a8mr13172004qkf.460.1650467838326;
        Wed, 20 Apr 2022 08:17:18 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id bm1-20020a05620a198100b0047bf910892bsm1767274qkb.65.2022.04.20.08.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 08:17:17 -0700 (PDT)
Date:   Wed, 20 Apr 2022 08:17:14 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     joao@overdrivepizza.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, andrew.cooper3@citrix.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 00/11] Kernel FineIBT Support
Message-ID: <20220420151714.fderdz4dzea75rvg@treble>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420074044.GC2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220420074044.GC2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 09:40:44AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 19, 2022 at 05:42:30PM -0700, joao@overdrivepizza.com wrote:
> > @PeterZ @JoshP
> > 
> > I'm a bit unaware of the details on why the objtool approach to bypass ENDBRs
> > was removed from the IBT series. Is this approach now sensible considering that
> > it is a requirement for a new/enhanced feature? If not, how extending the Linker
> > to emit already fixed offsets sounds like?
> 
> Josh hates objtool modifying actualy code. He much prefers objtool only
> emits out of band data.
> 
> Now, I did sneak in that jump_label nop'ing, and necessity (broken
> compilers) had us do the KCOV nop'ing in noinstr, but if you look at the
> recent objtool series here:
> 
>   https://lkml.kernel.org/r/cover.1650300597.git.jpoimboe@redhat.com
> 
> you'll see his thoughs on that :-)
> 
> Now, I obviously don't mind, it's easy enough to figure out what objtool
> actually does with something like:
> 
>   $ OBJTOOL_ARGS="--backup" make O=ibt-build/ -j$lots vmlinux
>   $ objdiff.sh ibt-build/vmlinux.o
> 
> Where objdiff.sh is the below crummy script.
> 
> Now, one compromise that I did get out of Josh was that he objected less
> to rewriting relocations than to rewriting the immediates. From my
> testing the relocations got us the vast majority of direct call sites,
> very few are immediates.
> 
> Josh, any way you might reconsider all that? :-)

If I remember correctly, the goal of --ibt-fix-direct was to avoid
hitting unnecessary ENDBRs, which basically decode to NOPs, so the
ghastly hack wasn't worth it.

If FineIBT needs it, I could reconsider.  But I think there's a strong
case to be made that the linker should be doing that instead.

-- 
Josh

