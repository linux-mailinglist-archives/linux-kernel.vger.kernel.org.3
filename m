Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842E352A963
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351477AbiEQRfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiEQRfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:35:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7ABF72
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:35:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso2889309pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sjTMC22wSJ47xdwSvqZCnDiGp9aPojAuMgBLE3Ru6Ns=;
        b=glbJj5X4FvEyfTXgOl7rRrg5gxtB02qGsHzTepdXpPxdD+2EOa2Gd3eR+cGDpYSzpZ
         79iaET+rnGfoymf5ex9uVGJjxTgNteZwuM/XWfbSqIrF+vTMPu5tIWJ3oAcEe5S/xh79
         6BCVObEo2xeexg0OiEd+nYK3Nfn7PexZn1WBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sjTMC22wSJ47xdwSvqZCnDiGp9aPojAuMgBLE3Ru6Ns=;
        b=Edzh+/IXjO443yYvElH/G7fr1GAfSjsBXq2rRrZ4pIYoladgBHCKtWdsF7/s2n8W0p
         laLxop3LQRrZW5Ef/4UJog0csVnF7+bEmVMnCn6n0BN6bItNgOIcQ27JHUx+yJEgkG9A
         7ub+dq5FDst7YFKbzWc5KI3i2S6TMuO439+mQ98hagoojAZr7oidS3sAxksMBDr0Gepu
         15P2xduD5gGpahBxPG6rZiOXz0lLmhQDac7tuekPv19oGaGApoeMau36FOD8t9wCeLxM
         NYSvWV8Sb/unMcc5Us1rGfe75rE5MxM+0OIHUhNvW0cJ+jD7JsVAt4mmtTpxoDZEPOby
         b4qA==
X-Gm-Message-State: AOAM532+eqakLqEtu1qlItc/5NXWHacdhdgzdOZj+dPya2Gy7+S3BPll
        HJhTsNvv6z4QXLuZcUtp4gUuAA==
X-Google-Smtp-Source: ABdhPJyklgL9P7KQ8KleeVzd4Z0HdMD3Tyeg8TCp4qbuh8EG/GLEpomy43Lre0Y6YoLoviPMTxtK/Q==
X-Received: by 2002:a17:903:41c9:b0:15e:b449:ce9a with SMTP id u9-20020a17090341c900b0015eb449ce9amr23097999ple.136.1652808945761;
        Tue, 17 May 2022 10:35:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p10-20020a62b80a000000b0050dc76281a7sm67978pfe.129.2022.05.17.10.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 10:35:45 -0700 (PDT)
Date:   Tue, 17 May 2022 10:35:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] sched/core: Address classes via __begin_sched_classes
Message-ID: <202205170952.A5251F141@keescook>
References: <20220517030024.3388355-1-keescook@chromium.org>
 <202205162032.5161269A45@keescook>
 <YoOLLmLG7HRTXeEm@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoOLLmLG7HRTXeEm@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 01:46:54PM +0200, Peter Zijlstra wrote:
> On Mon, May 16, 2022 at 08:33:25PM -0700, Kees Cook wrote:
> 
> > I just need to start today over.
> 
> :-)
> 
> Also, even with this sorted, there's a ton array bound things left.
> Please don't just mangle the code until it stops complaining like in the
> previous postings of these patches.

Yeah, other code is much simpler. The sched code has been a bit tricky
to figure out.

> As such, I'm only barely ok with the below patch. Ideally I'd shoot GCC
> in the head. Its *really* tedious you cannot just tell it to shut up
> already.

What you've got below is almost exactly what I had in my first attempt
at this (that I never posted). What I was missing and couldn't track
down were the places you used sched_class_above(). I should have sent
_that_ patch and asked where the comparisons were that I couldn't find.
I think what you've got is much cleaner, as it makes the for loop use
the normal iterator idiom.

Thank you!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
