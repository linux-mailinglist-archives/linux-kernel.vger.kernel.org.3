Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEA348F038
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243680AbiANS5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 13:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243640AbiANS5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:57:07 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DAEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 10:57:07 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id hv15so14191504pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 10:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YabguVGMf1wsrLonybEy7GRmC4KIXzc8d3V33tngp/k=;
        b=BNkdw/wh6LH8w0iEL7y9mRnL7JUYIA3P/U0BRZLrJbpTwamsTrd3mzbMjtnNHRN7v4
         +S5gXh4ccZUXYy2SFitNDcBX5gV8xkC4vxhRBD4Te4n0ny3LT2EOnhGtU+5o4srLrWhk
         mnayMbiByRLiYmIrmWcKo3Q2MsAVhAgbA2JAgaTHeomjOsEPTRHGttdoapY1obh9mVvn
         LBMJH8XRiWkoD9q5UJaB6C520GJ27hYAiT84F56S1l8i8ZuwNDtOniXuKB51kVN0s593
         b0o+ehUSWxYNdQQNpvW2KxJYY/eNLucMSbeJrNOkebNjKyOkaOT4QQycRu3CQmDTcg+f
         e3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YabguVGMf1wsrLonybEy7GRmC4KIXzc8d3V33tngp/k=;
        b=LM1Ch3f+fHLxg0eZ2tKQvkRBeV8u1H5i69oehMRJIafHEnNf4d+ksh6AUIOARoDD0L
         Da5ZkLoE7olIIgVKBaSBh55XFS3pCzAu+5x29lPAW1Cyja1Big6zXuR8bqh5daNXD49l
         lYUQzKO5nsRzlG1lPZxOL1UUgZInzp4+FYiDqCkly/StyqCMOofY2y4vaLuKAe3IHviF
         WD28UYMH+4tPVCt7IgarLZGEBU2fe9ox9CIe6C5yrqyS80ghvZP5t908KtzpQ9UWYc1N
         BeyaGrWRZFn0NiOTTsmo74kk2MimfF9munmhY9kr4GcbOIg3J5eAFZezxflcOVGbduLp
         2L1A==
X-Gm-Message-State: AOAM532msUhqMYQgn7eC2kbkFKJ2jZyiYLlwrmmzARdXonJ4UG3gQmdA
        PZRPNua69Yzg7SLbFRDJ5yA=
X-Google-Smtp-Source: ABdhPJxglYK9nWP4cyYX2JxAIwtXPJz4Ogbq2I60+DHXHnuDTEfjzEyC8nX9XFjNT13GmDdPuNncGg==
X-Received: by 2002:a17:90b:1a88:: with SMTP id ng8mr21769882pjb.180.1642186626607;
        Fri, 14 Jan 2022 10:57:06 -0800 (PST)
Received: from google.com ([2620:15c:211:201:a5b:82ad:7990:3ae0])
        by smtp.gmail.com with ESMTPSA id h189sm1470896pfg.141.2022.01.14.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 10:57:06 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 14 Jan 2022 10:57:04 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, huww98@outlook.com,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC v2] mm: introduce page pin owner
Message-ID: <YeHHgGD9osY95y4v@google.com>
References: <20211228175904.3739751-1-minchan@kernel.org>
 <cf596fdc-6599-7c53-26e8-1524c5f214f7@redhat.com>
 <Yd8AYViR6vuBVU2L@google.com>
 <c9c97e6a-5bb6-475e-2d0e-d791f11d2cf9@redhat.com>
 <Yd884YERYI+UvXbj@google.com>
 <35d7f27c-44e3-3921-c8d3-b6dee3b01238@redhat.com>
 <YeGnSG3BS5np9mUa@google.com>
 <8f02e71b-5de7-4342-7371-a7fe19b114b5@redhat.com>
 <51fc9dfe-1cac-69f6-0c68-46a83fd7783d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51fc9dfe-1cac-69f6-0c68-46a83fd7783d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 07:47:49PM +0100, David Hildenbrand wrote:
> 
> >>>>>> Otherwise, I'd like to have feature naming more higher level>>>>>> to represent page migration failure and then tracking unref of
> >>>>>> the page. In the sense, PagePinOwner John suggested was good
> >>>>>> candidate(Even, my original naming PagePinner was worse) since
> >>>>>
> >>>>> Personally, I dislike both variants.
> >>>>>
> >>>>>> I was trouble to abstract the feature with short word.
> >>>>>> If we approach "what feature is doing" rather than "what's
> >>>>>> the feature's goal"(I feel the your suggestion would be close
> >>>>>> to what feature is doing), I'd like to express "unreference on
> >>>>>> migraiton failed page" so PAGE_EXT_UNMIGRATED_UNREF
> >>>>>> (However, I prefer the feature naming more "what we want to achieve")
> >>>>>>
> >>>>> E.g., PAGE_EXT_TRACE_UNREF will trace unref to the page once the bit is
> >>>>> set. The functionality itself is completely independent of migration
> >>>>> failures. That's just the code that sets it to enable the underlying
> >>>>> tracing for that specific page.
> >>>>
> >>>> I agree that make something general is great but I also want to avoid
> >>>> create something too big from the beginning with just imagination.
> >>>> So, I'd like to hear more concrete and appealing usecases and then
> >>>> we could think over this trace approach is really the best one to
> >>>> achieve the goal. Once it's agreed, the naming you suggested would
> >>>> make sense. 
> >>>
> >>> At least for me it's a lot cleaner if a feature clearly expresses what
> >>> it actually does. Staring at PAGE_EXT_PIN_OWNER I initially had no clue.
> >>> I was assuming we would actually track (not trace!) all active FOLL_PIN
> >>> (not unref callers!). Maybe that makes it clearer why I'd prefer a
> >>> clearer name.
> >>
> >> I totally agree PagePinOwner is not 100% straightforward. I'm open for
> >> other better name. Currently we are discussing how we could generalize
> >> and whether it's useful or not. Depending on the discussion, the design/
> >> interface as well as naming could be changed. No problem.
> > 
> > PagePinOwner is just highly misleading. Because that's not what the
> > feature does. Having that said, i hope we'll get other opinions as well.
> 
> FWIW, I think "page reference holder" would be clearer. PageRefHolder or
> PageReferenceHolder
> 
> "Trace page reference holders on unref after migration of a page failed."

Ah, crossed email. PageRefHolder. Yeah, sounds like better!
