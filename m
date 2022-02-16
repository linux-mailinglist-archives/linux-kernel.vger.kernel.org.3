Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A884B8893
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiBPNMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:12:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiBPNMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:12:49 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB501A343B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:12:36 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y17so3812078edd.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m421YRZGEJntA1XH4znYoSO6mB7oCx7u3N2gxq1kXl8=;
        b=aOXX1rJua9aTg8AxXa9i5j/RrNeJ8pxuXHF6ZRAFhiRvpVqHcKu6sdF8v3yuqEvhZz
         dfuCOtY2syT4cnOPJ03kMrqcmIXW+VpNH5kcwGYC0m0PKGxdCthSHpXwTqbzkxAGfREd
         Ox9zBsQGMJZdE/5KrTAyqzsm2d6gLjY19hn2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m421YRZGEJntA1XH4znYoSO6mB7oCx7u3N2gxq1kXl8=;
        b=q11zLL+yRNnAGyIgpPjm99q0A5pKXmBVa2KflhNDkevE2MxkDthVL+/1Tkls2XNmgS
         4ihM4qnitN0oB8PFwtSL1Jr9YUmn2T7npurEhd+nGuO5VxX+WKlomyJd2t8BxciqHIjc
         Sh9SsLPSqLBC/1o4W4eHOT88xS9CkKuySaQqeCJ8zX+2nmRTkE/2lydB/dUgBx6CEve/
         eu7Mf5OIOmMHN88E/qEP31ZrPKQqYE8nq/4rhYnEPbJALo11gJ0xzPiRreTtTOISZbUL
         GqCa2EAC/aF2dgdkcExaNTuNRATI58+Yy4T3vYF33YQ4xyc42/KzA8/9RZy0HLU7B5p8
         qczQ==
X-Gm-Message-State: AOAM533flsnWFu644sNPtFkN3TplmeMc/gfsUlj+FNxCBgiEX5eBAnN9
        2V9CRtrnJ8uUi/eWOvgj/usvamMK/PRh3AXp
X-Google-Smtp-Source: ABdhPJy4+BOqL1A5ydec/gIJxjR2gGyCphXlGTfzjc+DNWQTHybHfqoIr+VeBuTkK4KODG+Bv1ICWA==
X-Received: by 2002:a05:6402:268c:b0:411:e086:b7d1 with SMTP id w12-20020a056402268c00b00411e086b7d1mr2797303edd.111.1645017154635;
        Wed, 16 Feb 2022 05:12:34 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:279b])
        by smtp.gmail.com with ESMTPSA id t26sm745556edv.50.2022.02.16.05.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:12:34 -0800 (PST)
Date:   Wed, 16 Feb 2022 13:12:33 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] memcg: synchronously enforce memory.high for
 large overcharges
Message-ID: <Ygz4QQmtrhXwCpG4@chrisdown.name>
References: <20220211064917.2028469-1-shakeelb@google.com>
 <20220211064917.2028469-5-shakeelb@google.com>
 <YgZS+YijLo0/WmEd@chrisdown.name>
 <CALvZod6FwcSyi3B-3fkw4e+7BGrjFF2iRLEZVeurLp2+v-k-dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CALvZod6FwcSyi3B-3fkw4e+7BGrjFF2iRLEZVeurLp2+v-k-dg@mail.gmail.com>
User-Agent: Mutt/2.2 (7160e05a) (2022-02-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shakeel Butt writes:
>> Thanks, I was going to comment on v1 that I prefer to keep the implementation
>> of mem_cgroup_handle_over_high if possible since we know that the mechanism has
>> been safe in production over the past few years.
>>
>> One question I have is about throttling. It looks like this new
>> mem_cgroup_handle_over_high callsite may mean that throttling is invoked more
>> than once on a misbehaving workload that's failing to reclaim since the
>> throttling could be invoked both here and in return to userspace, right? That
>> might not be a problem, but we should think about the implications of that,
>> especially in relation to MEMCG_MAX_HIGH_DELAY_JIFFIES.
>>
>
>Please note that mem_cgroup_handle_over_high() clears
>memcg_nr_pages_over_high and if on the return-to-userspace path
>mem_cgroup_handle_over_high() finds that memcg_nr_pages_over_high is
>non-zero, then it means the task has further accumulated the charges
>over high limit after a possibly synchronous
>memcg_nr_pages_over_high() call.

Oh sure, my point was only that MEMCG_MAX_HIGH_DELAY_JIFFIES was to more 
reliably ensure we are returning to userspace at some point in the near future 
to allow the task to have another chance at good behaviour instead of being 
immediately whacked with whatever is monitoring PSI -- for example, in the case 
where we have a daemon which is monitoring its own PSI contributions and will 
make a proactive attempt to free structures in userspace.

That said, the throttling here still isn't unbounded, and it's not likely that 
anyone doing such large allocations after already exceeding memory.high is 
being a good citizen, so I think the patch makes sense as long as the change is 
understood and documented internally.

Thanks!

Acked-by: Chris Down <chris@chrisdown.name>
