Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964334967AB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiAUV7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiAUV7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:59:35 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BFBC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 13:59:35 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 192so6600589pfz.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 13:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SiF8IN8PI2SpOhltyDuyXyX1icsw8zFtbfQW5dLEeIU=;
        b=bQLtven7ZpIOTGbqDDlpV0R8fx++Zh/uDyeixVXjLWLQbECONlYdFuIC7JV++9VGfq
         L7oIwYoibLXUdY+lkGynvZaYUWXHddV1R5DPK3AAhoUVsV/be7wk5zLGWl8PdW069sZ4
         ufOTYHXzMz/Twt6l0dmTfyB+ejL4fVqJZIGdPlVdWWQfKEiYfRPSbig4WUQJ9xWDxS3z
         c+BmC+a8rHYy5O4+r1YPk62rUHeYwnPN3NUQ20FZ8W38eEuxbhaULQAHjt0NNiD1oCOX
         asmRkTXx0CfHx1nbbVQNW3Ay459W5oZ0Ur2CQxsS/wlCyiAvJh+Sef9Jb6D6Z65RS9xt
         8cTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SiF8IN8PI2SpOhltyDuyXyX1icsw8zFtbfQW5dLEeIU=;
        b=ROsp5Rrwr0bQXlQz8BM0SxQxbGtPCOvGSo7ZSTTVbVRUFSPXsC1axrkWeiMDgPbcoU
         gO1PnjxU1f/+FREAjPmHtTKrviSaALFvGZtjXBfhgMDoVDyYE6uBMHVvD9u6z9ftErs6
         qm5OtugrkkycSSK22y5YStLfbJD5eAT0M5K6aEbTOelbPbq0/Egou7X9bZ4QLhFpfg0x
         kLMHe+Q/RAMXc9TtV5VzXLnNOOKRlal7RtqPUApXJMDboojC81vLqMk8sbL4LM0PZU3X
         gScnwcnsCxgZWSb3KDOgPhpchftlbvVm7zob7YaZtFN4ary9sj6136q8WFNjgvtnQoFG
         LP7g==
X-Gm-Message-State: AOAM533p9/f2fso9BZx1B9XmnVR1VuMT1GKzobDDeO8rD8HgJ37P+J5D
        AMT6eFlWRJ6zWzaq+SjLAro=
X-Google-Smtp-Source: ABdhPJxa4iGkdzZELLkg3VVFmGIENpXhmp6sYfBK8j0mtfYdRtI9SxOwZjPwx4RFe43hETjrR5YW4Q==
X-Received: by 2002:a63:370b:: with SMTP id e11mr4329422pga.558.1642802374609;
        Fri, 21 Jan 2022 13:59:34 -0800 (PST)
Received: from google.com ([2620:15c:211:201:8ee4:9dbe:c4bd:f5f8])
        by smtp.gmail.com with ESMTPSA id u35sm8088563pfg.195.2022.01.21.13.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:59:34 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 21 Jan 2022 13:59:32 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, huww98@outlook.com,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC v2] mm: introduce page pin owner
Message-ID: <YessxO7ZS5ouUouW@google.com>
References: <20211228175904.3739751-1-minchan@kernel.org>
 <cf596fdc-6599-7c53-26e8-1524c5f214f7@redhat.com>
 <Yd8AYViR6vuBVU2L@google.com>
 <c9c97e6a-5bb6-475e-2d0e-d791f11d2cf9@redhat.com>
 <Yd884YERYI+UvXbj@google.com>
 <35d7f27c-44e3-3921-c8d3-b6dee3b01238@redhat.com>
 <YeGnSG3BS5np9mUa@google.com>
 <8f02e71b-5de7-4342-7371-a7fe19b114b5@redhat.com>
 <51fc9dfe-1cac-69f6-0c68-46a83fd7783d@redhat.com>
 <YeHHgGD9osY95y4v@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeHHgGD9osY95y4v@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 10:57:04AM -0800, Minchan Kim wrote:
> On Fri, Jan 14, 2022 at 07:47:49PM +0100, David Hildenbrand wrote:
> > 
> > >>>>>> Otherwise, I'd like to have feature naming more higher level>>>>>> to represent page migration failure and then tracking unref of
> > >>>>>> the page. In the sense, PagePinOwner John suggested was good
> > >>>>>> candidate(Even, my original naming PagePinner was worse) since
> > >>>>>
> > >>>>> Personally, I dislike both variants.
> > >>>>>
> > >>>>>> I was trouble to abstract the feature with short word.
> > >>>>>> If we approach "what feature is doing" rather than "what's
> > >>>>>> the feature's goal"(I feel the your suggestion would be close
> > >>>>>> to what feature is doing), I'd like to express "unreference on
> > >>>>>> migraiton failed page" so PAGE_EXT_UNMIGRATED_UNREF
> > >>>>>> (However, I prefer the feature naming more "what we want to achieve")
> > >>>>>>
> > >>>>> E.g., PAGE_EXT_TRACE_UNREF will trace unref to the page once the bit is
> > >>>>> set. The functionality itself is completely independent of migration
> > >>>>> failures. That's just the code that sets it to enable the underlying
> > >>>>> tracing for that specific page.
> > >>>>
> > >>>> I agree that make something general is great but I also want to avoid
> > >>>> create something too big from the beginning with just imagination.
> > >>>> So, I'd like to hear more concrete and appealing usecases and then
> > >>>> we could think over this trace approach is really the best one to
> > >>>> achieve the goal. Once it's agreed, the naming you suggested would
> > >>>> make sense. 
> > >>>
> > >>> At least for me it's a lot cleaner if a feature clearly expresses what
> > >>> it actually does. Staring at PAGE_EXT_PIN_OWNER I initially had no clue.
> > >>> I was assuming we would actually track (not trace!) all active FOLL_PIN
> > >>> (not unref callers!). Maybe that makes it clearer why I'd prefer a
> > >>> clearer name.
> > >>
> > >> I totally agree PagePinOwner is not 100% straightforward. I'm open for
> > >> other better name. Currently we are discussing how we could generalize
> > >> and whether it's useful or not. Depending on the discussion, the design/
> > >> interface as well as naming could be changed. No problem.
> > > 
> > > PagePinOwner is just highly misleading. Because that's not what the
> > > feature does. Having that said, i hope we'll get other opinions as well.
> > 
> > FWIW, I think "page reference holder" would be clearer. PageRefHolder or
> > PageReferenceHolder
> > 
> > "Trace page reference holders on unref after migration of a page failed."
> 
> Ah, crossed email. PageRefHolder. Yeah, sounds like better!

David,

I will change the naming to PageRefHolder and update the other
code/comments to follow it.

Do you have any objection?

Otherwise, I'd like to post next version to make the work proceeding.

Thanks.
