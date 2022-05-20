Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD5C52E400
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345392AbiETEte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiETEta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:49:30 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED62113C0A8;
        Thu, 19 May 2022 21:49:27 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 14so70524qkl.6;
        Thu, 19 May 2022 21:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XG5WWsQRA6vH99HPmitBVSvlWBRqY1ZTW1CIEPjKXTs=;
        b=SagrVVrPZTFyCQzofnfq4NzGwy4myqaUTHnB0hvEUlEKgRpfoIy+NMGNIUTBRtjhWp
         l8QPoHdcrF3YgVG58RmtzP2/fP5HUII5plEgcqDlyrMnwecuXGt4Sr7GBCd9amuL/+j4
         8wkjBdTOnswuBcGncFJTIs2GDAxxqxb+Ue+Q1PQH7u1Yr9p68hnHQOluMK1Cl8nbfc3S
         q3ao4Qm9lDtWg+FioDQPh9FdwMGGrw8bmvxIkRjboGlwSGiM1fca4ehi5nK3H5nRjAfK
         OCOSLprl3DRd3u1ZjDNIz3kMR+dbiRVyhejpHGPpKPmVVo3M9KYMTGS0eMahDHdpvtve
         QEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XG5WWsQRA6vH99HPmitBVSvlWBRqY1ZTW1CIEPjKXTs=;
        b=RwnXUAFK82IPPQ3vz/Dji65+eFiB4JzQb3rPUIKqCMno8uSXpy0eunwH/Cj6WfZG8a
         40laGqLqbMPrNSmY+8ZKZ5aBRmtsNfYSLBe28sbzFWZm16ttnoJkAuioS05JhV043I4F
         mMmEUgsledF5eB5mbWhPvqn59uY4jNVEjggPVphL4FtMel5eNnTdVgqNqPEyTb4jRT1N
         xNbakRA5LbMTBeyrBc7a2X7NEvNqpxhB+Wcc13dpHx+buqj4WhUND9ufpZB47VQCSfOe
         0nJypjD5aoSxmavFCrIE4IWxxXCK27gtW9kWN3gfetKsjZVX3bDlr5mCNKEtmJ9TufBN
         DtFg==
X-Gm-Message-State: AOAM532Wv6tWHV4t15kYbOVcNe0peuziD0/KaMc/OT8o0VmhhV5YJ8Dx
        BB4FRO/DnPg10QYiNiKXKQ==
X-Google-Smtp-Source: ABdhPJwQyXHPMVhf7jGpcs0ZlqmocbdVBNDHLA7CeeBf72FR/x5g9nGqmaJ8i3w/10r0mME+rHCchw==
X-Received: by 2002:a05:620a:240b:b0:6a0:5187:656d with SMTP id d11-20020a05620a240b00b006a05187656dmr5260631qkn.273.1653022167111;
        Thu, 19 May 2022 21:49:27 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id b12-20020ac87fcc000000b002f9094e8a5csm2601201qtk.53.2022.05.19.21.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 21:49:26 -0700 (PDT)
Date:   Fri, 20 May 2022 00:49:24 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v2 03/28] vsprintf: %pf(%p)
Message-ID: <20220520044924.dr2rnnbhvilxznek@moria.home.lan>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-4-kent.overstreet@gmail.com>
 <141b17a257274fc38291cdb07e0e23b6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <141b17a257274fc38291cdb07e0e23b6@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 09:06:24PM +0000, David Laight wrote:
> From: Kent Overstreet
> > Sent: 19 May 2022 18:24
> > 
> > This implements two new format strings: both do the same thing, one more
> > compatible with current gcc format string checking, the other that we'd
> > like to standardize:
> > 
> >  %p(%p) - more compatible
> >  %(%p)  - more prettier
> > 
> > Both can take variable numbers of arguments, i.e. %(%p,%p,%p).
> > 
> > They're used to indicate that snprintf or pr_buf should interpret the
> > next argument as a pretty-printer function to call, and subsequent
> > arguments within the parentheses should be passed to the pretty-printer.
> 
> I suspect this a very good way to blow the kernel stack.
> The highest stack use is already very likely to be inside
> the printf code in an error path somewhere.

By getting rid of stack allocated buffers, I've been _reducing_ stack usage.
Also, the new printbuf calling convention reduces stack usage as well.

It's true that we'll want to keep the stack usage of pr_buf -> pretty printer ->
pr_buf again minimal, but I don't see any difficulties there the way the code is
structured now. 

> 
> ...
> > The goal is to replace most of our %p format extensions with this
> > interface, and to move pretty-printers out of the core vsprintf.c code -
> 
> One advantage of the current scheme is that is reasonably safe
> and easy to use.
> Perhaps too many extra formats have been added recently.
> This all seems like a recipe for disaster with functions being
> called with the wrong number of parameters
> (I can't think how you can compile-time check it).

We can't check it at compile time yet, it's true - printf format checking will
need to be extended. But we're already talking about doing that.

> Double copying using a temporary buffer isn't the end of the world.
> It is only a problem because pr_cont() is basically impossible.
> But since kernel printf ought to be formatted to reasonable
> line length that isn't really an issue.
> printf() is expensive an extra memory copy is probably noise.
> 
> ...
> > Currently, we can only call pretty printers with pointer arguments. This
> > could be changed to also allow at least integer arguments in the future
> > by using libffi.
> 
> I'm sure I remember something else trying to use that.
> IIRC it is basically broken by design.

Hmm? libffi is the standard for calling C from a lot of languages. If it's
broken by design, that's some real news. And it does constructed function calls,
which is exactly what we need here.
