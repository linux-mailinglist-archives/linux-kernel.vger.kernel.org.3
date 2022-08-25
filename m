Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855A85A18AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241032AbiHYSSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240817AbiHYSSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:18:18 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703AA275F0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:17:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y4so19213489plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xV16KsLT5qgflE4jARzcSKyio15O/YsfD8KZKN9MRtk=;
        b=HIUfo9L+Sa8FNGdbpOuj5Gi99YMMu+SmRzFFdFtej9PHTK6fvgOwr99bk+nm97/oA9
         0rHODqPqMpPF8eKZ0M/t2esUer1tlNPJfkFv/+hiRVVtlCtH/RvjBm6nto91Dmmlstog
         S2+GJMPH3ZMNKZPpYMN0IQDDzliMZxPLz4zbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xV16KsLT5qgflE4jARzcSKyio15O/YsfD8KZKN9MRtk=;
        b=VPdO054cJdO8HLtCIpAx4BdPagXxD06GdbR7jVUIaGjIAKeI0CKTS8KTgr6t0i3gOk
         VuQFKVsKXkVD+up3pIWrFnXo5gXeohBfyMNTCPGOHxT/XxpF5RBa409mMO0BBuDUCH9Y
         qP3tGpkAmdnaIB6W2sjeULkr8WqTHCy0MOnJw7TaQyhkY6tuh8nQLQ8O6NIVjXDotWoZ
         K97H1XlbQ3lEwiBnrDhog1G4W+4SgoDiELqNS+c6KLxJHdtZrHwWbfYK+ILn7od45o0T
         oA4OvqvHLEGHUBwresh8F+Wsak5RfthKhDQL4b6v021OWkN1Pq/2n/qnKSjCiGbg8oJl
         P7jg==
X-Gm-Message-State: ACgBeo1Trwwv8cBxRkwJPJDLEzEkvUeCTmH85lgKRn8PE6j1rmIyn1MS
        aiNH6VU5I6jvN6Spl4ee+//CPQ==
X-Google-Smtp-Source: AA6agR4BddArG3aKjI8bEBOKERG9yR+PbwD7PckgTB2K0OEYB4c5jwN+VaRFd5tPZ8s96os5m1snyQ==
X-Received: by 2002:a17:903:110e:b0:171:3114:7112 with SMTP id n14-20020a170903110e00b0017131147112mr343254plh.114.1661451470795;
        Thu, 25 Aug 2022 11:17:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y9-20020a634b09000000b004114cc062f0sm13024818pga.65.2022.08.25.11.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:17:49 -0700 (PDT)
Date:   Thu, 25 Aug 2022 11:17:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
Message-ID: <202208251117.F93103A00@keescook>
References: <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk>
 <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
 <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
 <b79c83af-e9fc-9fa0-dff7-f3a8a39887ff@acm.org>
 <CAHk-=wgV1F7_ErXkXT2wd+07LJd_3Vp-yVUKLROPiEgijeoTrQ@mail.gmail.com>
 <353e5bbd-cdd1-f818-6a2f-9a7c800f9879@acm.org>
 <CAHk-=whSZ20Hv4EyLDtUZGX4MsYmCLQ4+OOTbv1WEXfXDcxnWw@mail.gmail.com>
 <CAHk-=wjQGnVfb4jehFR0XyZikdQvCZouE96xR_nnf5kqaM5qqQ@mail.gmail.com>
 <7bc72b9d-79b0-5b8c-18c4-4a5c914efdc5@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bc72b9d-79b0-5b8c-18c4-4a5c914efdc5@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 10:39:02AM -0700, Bart Van Assche wrote:
> On 8/24/22 17:40, Linus Torvalds wrote:
> > Actually, thinking about it, that was simple enough.
> > 
> >    -#define is_signed_type(type)   (((type)(-1)) < (type)1)
> >    +#define is_signed_type(type)   (((type)(-1)) < (__force type)1)
> > 
> > should work.
> > 
> > It looks a bit odd, because we only force one side.
> > 
> > But we only need to force one side, because the '-1' doesn't have any
> > issues with bitwise types, the same way 0 doesn't.
> > 
> > So only '1' needs to be force-cast to avoid a warning about casting an
> > integer to a bitwise type.
> > 
> > And since that -1 counts as an unrestricted value after a cast, now
> > the ordered comparison doesn't warn either.
> > 
> > Now, admittedly I think sparse should also allow a forced cast of an
> > unrestricted value to be unrestricted, so I think I should do this
> > 
> >   static int restricted_value(struct expression *v, struct symbol *type)
> >   {
> > -       if (v->type == EXPR_CAST)
> > +       if (v->type == EXPR_CAST || v->type = EXPR_FORCE_CAST)
> >                  v = v->cast_expression;
> > 
> > in sparse, but even without that the above "is_signed_type()" macro
> > should make sparse happy (with that current tree of mine).
> > 
> > And since we don't now need to cast 0, gcc won't complain about that
> > NULL pointer comparison.
> > 
> > Does that solve things for you?
> 
> Yes, thank you! No sparse warnings are triggered by the is_signed_type()
> macro and the gcc warning about ordered comparison of a pointer with the
> null pointer is gone.
> 
> The patch I came up with is available below. If nobody picks it up from
> this email I will try to find an appropriate kernel maintainer to send
> this kernel patch to.
> 
> Thanks,
> 
> Bart.
> 
> 
> From: Bart Van Assche <bvanassche@acm.org>
> Date: Tue, 23 Aug 2022 12:59:25 -0700
> Subject: [PATCH] tracing: Define the is_signed_type() macro once
> 
> There are two definitions of the is_signed_type() macro: one in
> <linux/overflow.h> and a second definition in <linux/trace_events.h>.
> 
> As suggested by Linus Torvalds, move the definition of the
> is_signed_type() macro into the <linux/compiler.h> header file. Change
> the definition of the is_signed_type() macro to make sure that it does
> not trigger any sparse warnings with future versions of sparse for
> bitwise types. See also:
> https://lore.kernel.org/all/CAHk-=whjH6p+qzwUdx5SOVVHjS3WvzJQr6mDUwhEyTf6pJWzaQ@mail.gmail.com/
> https://lore.kernel.org/all/CAHk-=wjQGnVfb4jehFR0XyZikdQvCZouE96xR_nnf5kqaM5qqQ@mail.gmail.com/
> 
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good to me; thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
