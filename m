Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB7D4CADB9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241828AbiCBSjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiCBSjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:39:00 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E000D206D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:38:16 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id e15so1099509pfv.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 10:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PazTu+4EeuEZqrZzm/cCwxArqmtpbNlhi9Rif2g8+Fs=;
        b=Bz92Gv6XjfQtgcK6SlPf1XnIfF2bOiToiCBP5I8hc/+6d1NEVAo5XSbgmBmrp2enPQ
         Cko3J/H2qpCFckSAyh0T+IZRkKszIvx4WeZXj2gqWO25drz8mZxtJSOMtk4bw0EhGX5h
         vK/2IbY46jSvEfUa4dgg+50ypz7iNYnUaDvtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PazTu+4EeuEZqrZzm/cCwxArqmtpbNlhi9Rif2g8+Fs=;
        b=yIDeeR3l/V+aAaGj9VpDhCNytudPhYlQnmk8AZWN3WdWQn/1Ncf2aKeA74DuAWFdFp
         cEkNNiPC4g8HBRDTCNWHwsTxo9c6GnBu0fi2ONO3Tiql0n1cqRhUdKvrDusA/u7TxJx0
         rMlzKwOZHiLx9iaa4LccFXSNVgr3qYbHTNz8/glu6vQrUdXUsiyca/JYSIfPudHqewk8
         luNxI08t0jn8aeVCU4SEq1wxmQs6Qj9n3x3MKjqiMJUWzpF5WsSfP5FNXn1vy1d1MFwD
         9NzXIJdK3aKxy+JzlG6ZlsDrdf4rZoI2rGLw1++OSWNGGlPFTv+pFvC6kxFdD8tqWtg/
         Ne7w==
X-Gm-Message-State: AOAM532/pbRZXRnurjC7+FxkVXuKjJit/kErveLqxU+qbcVlR0rZ0I2m
        99ucKS0CFD3B2gbjdXnUX0hgqg==
X-Google-Smtp-Source: ABdhPJxhxSSHSJlDECVeWXv3M0FfsOx6C0RLroz//5Cm4YILIeeaJc8hMWwUnH7rBjulfgPQdz3Z8w==
X-Received: by 2002:a63:4e14:0:b0:374:4a37:4966 with SMTP id c20-20020a634e14000000b003744a374966mr27207516pgb.118.1646246296102;
        Wed, 02 Mar 2022 10:38:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h13-20020a056a00230d00b004f427ffd485sm8013405pfh.143.2022.03.02.10.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 10:38:15 -0800 (PST)
Date:   Wed, 2 Mar 2022 10:38:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v2 18/39] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <202203021033.56CE82B@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.069205370@infradead.org>
 <eed8902f21ba9e5f93562432f6b5920137860a98.camel@intel.com>
 <Yh44YsW8viBscBD0@hirez.programming.kicks-ass.net>
 <20220301210245.GM11184@worktop.programming.kicks-ass.net>
 <20220301231303.pqexbxkpte6yjiww@treble>
 <c5e53502274a29e39c996627a35a7aa8e0795ca9.camel@intel.com>
 <Yh911I6Oh9RbCQz1@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh911I6Oh9RbCQz1@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 02:49:08PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 02, 2022 at 01:59:46AM +0000, Edgecombe, Rick P wrote:
> > As for pinning strength, I'm not understanding this kexec asm enough to
> > say for sure how much better it is than just removing the bit from the
> > pinning mask. I think some future hardening around preventing turning
> > off IBT might still be worthwhile.
> > 
> > Kees, I think you brought up the pinning, what do you think of this?
> 
> IIRC the whole purpose of that was to ensure that the
> cr4_update_irqsoff() function itself isn't a useful gadget to manipulate
> CR4 with.

Right -- as long as the paths that touch cr4 are either respecting
pinning or are inlined at a point of no return (i.e. performing kexec),
they shouldn't end up being very helpful gadgets.

e.g. imagine the scenario of a controlled write to a function pointer
than just aims at a valid endbr function that manipulates cr: an
attacker will just call into that first to disable IBT, and then carry
on doing things as normal.

There is an argument to be made that if an attacker has that kind of
control, they could call any set of functions to do what they want,
but the point is to create an unfriendly environment to attackers so
that future defenses compose well together -- e.g. FGKASLR.

-- 
Kees Cook
