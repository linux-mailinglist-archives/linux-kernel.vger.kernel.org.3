Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8B751BE27
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357843AbiEELjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355487AbiEELjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:39:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE9C31DC4;
        Thu,  5 May 2022 04:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 596ECCE2CCE;
        Thu,  5 May 2022 11:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43443C385A4;
        Thu,  5 May 2022 11:36:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jEqdmP2N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651750562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qy7eBqzc4l9OXb3zD5/KizGPeJugg6QmlUARzHOUfHc=;
        b=jEqdmP2NEkkIb9QOzvXJaXomMbAmdv+SmSdByiAWKcwIpItMyJb0IfT0nVGDIbpp9LfAro
        0Jzl7TzNB2vwAUdNYE6PBDDmncc/uCTPV2vSuTHmf/w0qgG/NWBpUbnvFCSdIL6qIhon0l
        54+mhAm0S70JmKI6SF4HPKjm1nYlICw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 21d83868 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 5 May 2022 11:36:02 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id j2so7166369ybu.0;
        Thu, 05 May 2022 04:36:02 -0700 (PDT)
X-Gm-Message-State: AOAM5334uszr3svWBDvegUD8Afkz7Y8KMdVN+gtReyPRebBb4SCOLBE5
        LFFedfHsrN2SqOHeHwjHAMJYlZKbOnvwx+EdVpY=
X-Google-Smtp-Source: ABdhPJz2xUxE5hzybsoy9m61A19jOU2zW4POfZkCToRonl7dVsx83Cpd5pj4GjPu+Elo/arZ+ShgDM1SXrPulH8ebH4=
X-Received: by 2002:a25:bf85:0:b0:64a:422c:24e7 with SMTP id
 l5-20020a25bf85000000b0064a422c24e7mr2301675ybk.637.1651750560684; Thu, 05
 May 2022 04:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <YnDwjjdiSQ5Yml6E@hirez.programming.kicks-ass.net>
 <87fslpjomx.ffs@tglx> <YnKh96isoB7jiFrv@zx2c4.com> <87czgtjlfq.ffs@tglx>
 <YnLOXZp6WgH7ULVU@zx2c4.com> <87wnf1huwj.ffs@tglx> <YnMRwPFfvB0RlBow@zx2c4.com>
 <87mtfwiyqp.ffs@tglx> <YnMkRLcxczMxdE5z@zx2c4.com> <87h764ixjs.ffs@tglx>
 <YnOuqh4YZT8ww96W@zx2c4.com> <1f4918f734d14e3896071d3c7de1441d@AcuMS.aculab.com>
In-Reply-To: <1f4918f734d14e3896071d3c7de1441d@AcuMS.aculab.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 5 May 2022 13:35:49 +0200
X-Gmail-Original-Message-ID: <CAHmME9q+1dAg=H2RLDHd=CSCwO4PpL+YYMeDXO6uQ_wD+GNPhg@mail.gmail.com>
Message-ID: <CAHmME9q+1dAg=H2RLDHd=CSCwO4PpL+YYMeDXO6uQ_wD+GNPhg@mail.gmail.com>
Subject: Re: [patch 3/3] x86/fpu: Make FPU protection more robust
To:     David Laight <David.Laight@aculab.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 1:34 PM David Laight <David.Laight@aculab.com> wrote:
>
> ...
> > +     cycles_t end, start = get_cycles();
> >       blake2s_update(&input_pool.hash, in, nbytes);
> > +     end = get_cycles();
>
> If get_cycles() is rdtsc then that gives meaningless numbers.
> The cpu clock frequency will change on you.
>
> You can use one of the performance counters to get an actual

Indeed. In the process of wiring up rdpmc now.

Jason
