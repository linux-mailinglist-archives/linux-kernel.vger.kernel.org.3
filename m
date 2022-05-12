Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787E5525316
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356746AbiELQ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356747AbiELQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:56:56 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD954A3DF
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:56:48 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r71so4799918pgr.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C9OapljaiZ/OiA13d4g/3jGQ7Gr1SYoZDM7IohOZJMw=;
        b=WZHk4r4OdUURkV+uv/i+IHW79scgXxJNk6w0bmDQkegUWDRjxTbgQVx113wplBoJM1
         y5jFwCRqa1gjhe4GuODsCQCVb7gSoPXdT4QCo976FlDsbb/AivuuzAVIGFEPi61SzpzO
         nljfmMTEyNQHN3D3mZpGJpgh6StbNqO5noiQyFyPVJ+QMvXft1fQZamwCcIeD8f5LWxd
         SZ0fHCXEjezwVBmdLC2EEJZF8QZFSXTo3IVxsH3/d9U1J4NqBbuvPSxhTMX4KHqvgPja
         SRKWeEi2FqmDjcfDBBA3X8y3ZZGbwszxGKv5qWTds9A6yCrajfaj8AyQWRfagYlcoqlG
         svsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=C9OapljaiZ/OiA13d4g/3jGQ7Gr1SYoZDM7IohOZJMw=;
        b=Qz5fpEjpRTJwRK/BrMWaebpz0bWwzl4cLa8EqGYF6UkzFZW1sczIesIZIcJcklhS9t
         I1hY3qnz3ouqNA63g4j41cT5n1KijZSXVGQVgWG2Mje+j7eulyZn9uKudMgU6DEaaVeE
         1ZmSLksx4K2lBGQcX9PEr4ChbJnu0tvoMYnGGcFkiagegQm+pmI0rmb/pbzIlqu5XaHe
         klZD7fgESk4Yb+M9NPOjYyszHlaGSFaYQwQCWUo8M2YYEKwa9OrfbyptGUhilhAmz+Uj
         dNtsMYetximGwSW9oD7+QVkj3CLBmGPwwB3weTP7IMGMT6+jTDWAvXMjifWKjRt8oA4G
         Ds0Q==
X-Gm-Message-State: AOAM5320gNJnhGt6dHK/vLMA0EvB8k/vdqYlS9PpiwqDdisdJBpHZSh9
        iWGDcvVrXiq+yBNawudqRP8=
X-Google-Smtp-Source: ABdhPJwYRz8NfONMA8aHt4KsoL4b3aqUVkTDSkVKWpClzGdbbD4dNG9CZX74biI2lpbFKpk5hxGZig==
X-Received: by 2002:a63:6c01:0:b0:3db:5a80:16b8 with SMTP id h1-20020a636c01000000b003db5a8016b8mr477327pgc.394.1652374607962;
        Thu, 12 May 2022 09:56:47 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:6c64])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902650900b0015e8d4eb263sm130399plk.173.2022.05.12.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:56:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 May 2022 06:56:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 (repost)] workqueue: Warn flushing of kernel-global
 workqueues
Message-ID: <Yn08TdfdsFjKx+qw@slm.duckdns.org>
References: <2efd5461-fccd-f1d9-7138-0a6767cbf5fe@I-love.SAKURA.ne.jp>
 <CAHk-=wgiCVcF4vJCOcg1hDw9PMT6zNSgt-pPuZL8ihWEcVv3eg@mail.gmail.com>
 <e4203c4f-9c3d-6e33-06e8-052676cc5af1@I-love.SAKURA.ne.jp>
 <YjivtdkpY+reW0Gt@slm.duckdns.org>
 <YnzjrnnP622mad1y@google.com>
 <33772dcb-c5dd-c5e7-30c8-d2397d21b26c@I-love.SAKURA.ne.jp>
 <Yn0H/68tagxaj/ke@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn0H/68tagxaj/ke@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dmitry.

On Thu, May 12, 2022 at 06:13:35AM -0700, Dmitry Torokhov wrote:
> > > This means that now the code has to keep track of all work items that it
> > > allocated, instead of being able "fire and forget" works (when dealing
> > > with extremely infrequent events) and rely on flush_workqueue() to
> > > cleanup.
> > 
> > Yes. Moreover, a patch to catch and refuse at compile time was proposed at
> > https://lkml.kernel.org/r/738afe71-2983-05d5-f0fc-d94efbdf7634@I-love.SAKURA.ne.jp .
> 
> My comment was not a wholesale endorsement of Tejun's statement, but
> rather a note of the fact that it again adds complexity (at least as far
> as driver writers are concerned) to the kernel code.

I was more thinking about cases where there are a small number of static
work items. If there are multiple dynamic work items, creating a workqueue
as a flush domain is the way to go. It does add a bit of complexity but
shouldn't be too bad - e.g. it just adds the alloc_workqueue() during init
and the exit path can simply use destroy_workqueue() instead of flush.

> > >          That flush typically happens in module unload path, and I
> > > wonder if the restriction on flush_workqueue() could be relaxed to allow
> > > calling it on unload.
> > 
> > A patch for drivers/input/mouse/psmouse-smbus.c is waiting for your response at
> > https://lkml.kernel.org/r/25e2b787-cb2c-fb0d-d62c-6577ad1cd9df@I-love.SAKURA.ne.jp .
> > Like many modules, flush_workqueue() happens on only module unload in your case.
> 
> Yes, I saw that patch, and that is what prompted my response. I find it
> adding complexity and I was wondering if it could be avoided. It also
> unclear to me if there is an additional cost coming from allocating a
> dedicated workqueue.

A workqueue without WQ_RECLAIM is really cheap. All it does is tracking
what's in flight for that particular frontend while interfacing with the
shared worker pool.

> I understand that for some of them the change makes sense, but it would
> be nice to continue using simple API under limited circumstances.

Hmmm... unfortunately, I can't think of a way to guarantee that a module
unloading path can't get involved in a deadlock scenario through system_wq.
Given that the added complexity should be something like half a dozen lines
of code, switching to separte workqueues feels like the right direction to
me.

Thanks.

-- 
tejun
