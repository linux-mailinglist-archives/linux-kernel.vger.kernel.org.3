Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6605844E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiG1Rbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG1Rbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:31:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E686FA1D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:31:45 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e1so2633961pjl.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=JzWSbegIa18BHBsASV98zvRT5onUp1vk7q4OW1er06Q=;
        b=FHAd4S42PQWgOUTtJLeher3mJZNYMDm6Q8ch+tKigZv6XbAa+eoy4wNvdVxuPp5kLd
         aQKGGkjNPUj9Ud0bS7RW8Et+qvqXBTDnVDWmT/rZ/OoPxo2xB5Z7gL/Al85Jk+hR4Fta
         qB3StRXNTxByiUYpwT1+9Y9Gg3V7RArWLxsFQQ66QL9KmkB8JEuE+riAPn8BhMjYa1EL
         1YkPqDfvPLpwd9m0rmZfod8mSnfqt0U9GH2l7FJBjQQD9fWvz0cefgMm+0kdPCcHHJC/
         oJ//zLDrB3IaMU9KyF560e8my+A3ppLNyWBiK70yerGW5H4T5tQlfqzKxuFFWwigdqwy
         p2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=JzWSbegIa18BHBsASV98zvRT5onUp1vk7q4OW1er06Q=;
        b=DXfM1Bus3DnvfcXnI47b9CHx9lYp3g6oqx6FKyYeJr1QrtyZ6gIyysxfoM/c915W73
         iwjQWtVfbNokt8TrV9D3b4Orou3qrIv2RWigIWXRr2yMbXAUslKLmKuhQ5TGGZGwhJ0l
         wTZfhpx8fHw8aYqha5Xgbx/aRg29O4/rauq1i+ey+IC5X6lP8QbJb0jaqm/QQKuseX3z
         PmbZvIj6NkmXoOtSlMn8bxRMjQrRhpEDpg+f8pDmx7zt0gREGPLWuaVz2k9fWRPuPMh0
         TeKd/QDrVr2/m2vw6iRASR9mxDCpjBvq+L3Ki3TKXyJv8sQVuXMqkDwWf83fSIkWVT7z
         6UQQ==
X-Gm-Message-State: ACgBeo2Wz4G7QquYVberYfcavVZw2kYX8h/Q92Xhy3mbrXytn5I4A2S+
        oY5SQfUOrYWksN/eRdKg8cM=
X-Google-Smtp-Source: AA6agR79XgLeYtVswaHYrccTNfk8EN5TwR71V5MTFwRQuNzMgRId0lj/kNqiriOE1Xa2W7VGLxfNKw==
X-Received: by 2002:a17:90b:3141:b0:1f2:c6d9:6bc4 with SMTP id ip1-20020a17090b314100b001f2c6d96bc4mr491470pjb.30.1659029505044;
        Thu, 28 Jul 2022 10:31:45 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w187-20020a6230c4000000b0052c456eafe1sm1040312pfw.176.2022.07.28.10.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:31:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 28 Jul 2022 07:31:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH v2 1/2] workqueue: Unbind workers before sending them
 to exit()
Message-ID: <YuLH/l9YZYG6FRSW@slm.duckdns.org>
References: <20220727115327.2273547-1-vschneid@redhat.com>
 <20220727115327.2273547-2-vschneid@redhat.com>
 <CAJhGHyCeraX1jcea9kt_FBC561zBgECuw5qx8TAdCG0EHnT6kA@mail.gmail.com>
 <xhsmhedy5ecdg.mognet@vschneid.remote.csb>
 <YuK6zzmlFJ376UeD@slm.duckdns.org>
 <xhsmh8roddubi.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh8roddubi.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jul 28, 2022 at 06:24:17PM +0100, Valentin Schneider wrote:
> > I don't understand why this would need MEM_RECLAIM when it isn't sitting in
> > the memory reclaim path. Nothing in mm side can wait on this.
> 
> Vaguely reading the doc I thought that'd be for anything that would
> directly or indirectly help with reclaiming memory (not explicitly sitting
> in some *mm reclaim* path), and I assumed freeing up a worker would count as
> that - but that's the understanding of someone who doesn't know much about
> all that :-)

Oh, it's just needed for things that mm might end up waiting on. Here,
there's no way for mm to know about or trigger this at all, so it doesn't
need the flag.

> > There actually are spurious wakeups. We can't depend on there being no
> > wakeups than ours.
> 
> Myes, I suppose if a to-be-destroyed kworker spuriously wakes before having
> been unbound then there's not much point in having the unbinding (harm has
> been done and the kworker can do_exit(), though arguably we could reduce
> the harm and still move it away), but let me see what I can do here.

Yeah, it kinda sucks but is a kernel-wide thing and pretty rare, so for the
most part, we can pretend that they don't exist but under specific
conditions, there can be asynchronous wakeups coming from whereever, so we
gotta be crash proof against those.

Thanks.

-- 
tejun
