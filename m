Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56307523BED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345856AbiEKRxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345835AbiEKRxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:53:09 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5226D4F0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:53:07 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id hh4so2550888qtb.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+98S328gIXASjWyIOnT/blA4Tt4P6OykWVYnviKs3ME=;
        b=ZdCacF6byBtXl0QQmIVcjdBoxeabZgc7+C/W2V36nSNHaMGPgCqRtaTvGz6pJBRZow
         iblsDw9rPzOZJH00cABZEDopiWvSeJIFXA7B6daZ038Ke4gPcoy+14pjwEKB8l9WOdk2
         r22vYuPanMwnpackRyxW8GWj08pIuMQlFcJyBYnVFdw4GmG9s1dslt7Igfa9SzYVHoyn
         h4qjQE4G07yKMl0JjI3iY7EUCMUkFG1IHeT6azlmb0L53M8Y/katJirJbyC74MrmXVsY
         Sk8boCp6GYKLKRZUT1BdYQVu6Yy5uWLMBFWqw508lYzne1rA3Cewns5YAGuxR9CWY6yb
         Ol1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+98S328gIXASjWyIOnT/blA4Tt4P6OykWVYnviKs3ME=;
        b=66PZ5HRBDTFxUxAwJE6urf5NsPACZyHRG949XPo1/p7viyd3VN8gnwQZ7jtNy30LRa
         KJ7HvhhkMF6y5Q01mHr7qdRJTWVjf4fFpI5jSXPdtoAmk+orGufZwWt9skEPiGHaJkve
         WA/D6BFyu8wgaGWNqPVj+Gic+BfsgC94IRdGX2yYCvC0z7LKuYmTdl1AqSG2aBm1x8Ed
         xHYX+WhBNbP4ixFiKXnK8JCLrIrgORN460fjQ5KURvo1j44IjMRLZHki4Y6jNoymiW12
         2SmvEiVu6jWUjJNh3ZkPBaU+IKJ6EdObWtxfo+Fs1b9pEm2pX6jeMuwCnnAMH5F9w1Rj
         ZeAQ==
X-Gm-Message-State: AOAM530LitkP8nPFqZEJ8tgp9HEtgnKQRG76I2swRrPQOAFo32Hta/CK
        B+NzvtxJqx4/mH91o31mvzmPxw==
X-Google-Smtp-Source: ABdhPJxi4Nl8pTf7fTdo9YDS9qc45Ph/BFwmULDBZVmNVr9oBfAm1mwPvt6MNTWQqTtGl64tD7wXmg==
X-Received: by 2002:a05:622a:1982:b0:2f3:b7c1:4426 with SMTP id u2-20020a05622a198200b002f3b7c14426mr25436047qtc.347.1652291586832;
        Wed, 11 May 2022 10:53:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:14fe])
        by smtp.gmail.com with ESMTPSA id m185-20020a378ac2000000b0069fc13ce24dsm1577060qkd.126.2022.05.11.10.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 10:53:06 -0700 (PDT)
Date:   Wed, 11 May 2022 13:53:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Vernet <void@manifault.com>, tj@kernel.org,
        roman.gushchin@linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH v2 2/5] cgroup: Account for memory_recursiveprot in
 test_memcg_low()
Message-ID: <Ynv4AdjeVjptnjrH@cmpxchg.org>
References: <20220423155619.3669555-1-void@manifault.com>
 <20220423155619.3669555-3-void@manifault.com>
 <20220427140928.GD9823@blackbody.suse.cz>
 <20220429010333.5rt2jwpiumnbuapf@dev0025.ash9.facebook.com>
 <20220429092620.GA23621@blackbody.suse.cz>
 <20220506164015.fsdsuv226nhllos5@dev0025.ash9.facebook.com>
 <Ynkum8DeJIAtGi9y@cmpxchg.org>
 <20220509174424.e43e695ffe0f7333c187fba8@linux-foundation.org>
 <20220510174341.GC24172@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220510174341.GC24172@blackbody.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Tue, May 10, 2022 at 07:43:41PM +0200, Michal Koutný wrote:
> On Mon, May 09, 2022 at 05:44:24PM -0700, Andrew Morton <akpm@linux-foundation.org> wrote:
> > So I think we're OK with [2/5] now.  Unless there be objections, I'll
> > be looking to get this series into mm-stable later this week.
> 
> I'm sorry, I think the current form of the test reveals an unexpected
> behavior of reclaim and silencing the test is not the way to go.
> Although, I may be convinced that my understanding is wrong.

Looking through your demo results again, I agree with you. It's a tiny
error, but it compounds and systematically robs the protected group
over and over, to the point where its protection becomes worthless -
at least in idle groups, which isn't super common but does happen.

Let's keep the test as-is and fix reclaim to make it pass ;)

> The obvious fix is at the end of this message, it resolves the case I
> posted earlier (with memory_recursiveprot), however, it "breaks"
> memory.events:low accounting inside recursive children, hence I'm not
> considering it finished. (I may elaborate on the breaking case if
> interested, I also need to look more into that myself).

Can you indeed elaborate on the problem you see with low events?

> @@ -2798,13 +2798,6 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  
>  			scan = lruvec_size - lruvec_size * protection /
>  				(cgroup_size + 1);
> -
> -			/*
> -			 * Minimally target SWAP_CLUSTER_MAX pages to keep
> -			 * reclaim moving forwards, avoiding decrementing
> -			 * sc->priority further than desirable.
> -			 */
> -			scan = max(scan, SWAP_CLUSTER_MAX);

IIRC this was added due to premature OOMs in synthetic testing (Chris
may remember more details).

However, in practice it wasn't enough anyway, and was followed up by
f56ce412a59d ("mm: memcontrol: fix occasional OOMs due to proportional
memory.low reclaim"). Now, reclaim retries the whole cycle if
proportional protection was in place and it didn't manage to make
progress. The rounding for progress doesn't seem to matter anymore.

So your proposed patch looks like the right thing to do to me. And I
would ack it, but please do explain your concerns around low event
reporting after it.

Thanks!
