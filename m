Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677D64EFBFF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352689AbiDAVJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349415AbiDAVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:09:25 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EB81FF225
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 14:07:34 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b189so3100296qkf.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 14:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xpR1DVaP7IDSimYCmW7Cs0QbhOf/zsDSmwDGGMtRXiE=;
        b=zjuB4EbQMLgWLd1xXiDq0DRbbEAMjzYTkvWV9FTeHjjdzxMzsgLz9cOT8LX0HL865X
         LHW2BCUJqmYEEKsG5XwbnSGOutsGN/YQ8gmiu4xTRrIth38kOixfHQZQp2D+gQEy+wAp
         5eir0XmdbMQD1DcCDnZSs2bABE+JK2WFkzuk8nyxnHCs0K+BO+55i+IvC4lNtDkq/8Xc
         /JtKNdUi3TT3IKCk5/e+FXfRTo0pkQIePvF+lwPnyDerrmezPkOlDwgKHH0Jqd1QjqH+
         b0Ya2VO3D31C+Q+ZLRx1Nd2EdE4udUMCOl40Onplk0lAqsORuAt13L2dbxATWATht7fU
         ojpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xpR1DVaP7IDSimYCmW7Cs0QbhOf/zsDSmwDGGMtRXiE=;
        b=UTLMj4GkRcOPeVqSJ9l1NNfJOXz1QDe7wGbbtvnsT4v8FpsN0sncL5XP9TAcUtU/2D
         O/mJv8xJjjEXYSfzHFKZWzPtEWSOBfn0bmyUzDogYtYBf49Fin71oq6ZolBEfVe3L0bf
         ibuKkuuzOJKMIQL4Sur03GXWtsivD63fOKhyJbb6jh2dW0KxA69tpEXTb4VYyQuy1XaP
         2E4zr+HZXBjQaQO9kUdNT++Yv4kCtVn7YaC+mYr5MM85H2Njr3DdU6h1aKyg3GONW2Tz
         qJMqqyJ4d/cG01fQ9utiBEcDqCWOVI8aw+ylV1rGY8Q+WRNiNxftDrY2XDNlCkiNVk3w
         vYnQ==
X-Gm-Message-State: AOAM5337hMoEylxilCyfYK+pZkVl7IMpCU27s/HfjYw75RDImhD5qILe
        XQ9fvTETKoz7AnPk5HPCtoFtFA==
X-Google-Smtp-Source: ABdhPJyycpf+e5FVb3aWtVmQD7bkM0h2MY5J9KLEotdLnlXB7JnQrhs9Y2zK6E5P8AW1jXU+nDIGQA==
X-Received: by 2002:a05:620a:20c2:b0:67d:2fb1:d358 with SMTP id f2-20020a05620a20c200b0067d2fb1d358mr7929343qka.55.1648847253922;
        Fri, 01 Apr 2022 14:07:33 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a0e8400b0067b1bcd081csm1820620qkm.66.2022.04.01.14.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 14:07:33 -0700 (PDT)
Date:   Fri, 1 Apr 2022 17:07:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Wei Xu <weixugc@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
Message-ID: <YkdplNIhtz3iyLKv@cmpxchg.org>
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <CAAPL-u8g2qkhdTQtFtBS3GNYz0WnyahWEXvR4g_OSaKv+7EozA@mail.gmail.com>
 <YkcYq8F6MYlMi+yS@cmpxchg.org>
 <CAAPL-u-za-TTyyC5uMVev9eQyhxZS7q3pVqaUxCFjqk+Sv9+ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAPL-u-za-TTyyC5uMVev9eQyhxZS7q3pVqaUxCFjqk+Sv9+ig@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 01:14:35PM -0700, Wei Xu wrote:
> On Fri, Apr 1, 2022 at 8:22 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > On Thu, Mar 31, 2022 at 09:05:15PM -0700, Wei Xu wrote:
> > > It is better to return an error code (e.g. -EBUSY) when
> > > memory_reclaim() fails to reclaim nr_to_reclaim bytes of memory,
> > > except if the cgroup memory usage is already 0.  We can also return
> > > -EINVAL if nr_to_reclaim is too large (e.g. > limit).
> >
> > For -EBUSY, are you thinking of a specific usecase where that would
> > come in handy? I'm not really opposed to it, but couldn't convince
> > myself of the practical benefits of it, either.
> >
> > Keep in mind that MAX_RECLAIM_RETRIES failed reclaim attempts usually
> > constitute an OOM situation: memory.max will issue kills and
> > memory.high will begin crippling throttling. In what scenario would
> > you want to keep reclaiming a workload that is considered OOM?
> >
> > Certainly, proactive reclaim that wants to purge only the cold tail of
> > the workload wouldn't retry. Meta's version of this patch actually
> > does return -EAGAIN on reclaim failure, but the userspace daemon
> > doesn't do anything with it, so I didn't bring it up.
> 
> -EAGAIN sounds good, too.  Given that the userspace requests to
> reclaim a specified number of bytes, I think it is generally better to
> tell the userspace whether the request has been successfully
> fulfilled. Ideally, it would be even better to return how many bytes
> that have been reclaimed, though that is not easy to do through the
> cgroup interface. The userspace can choose to ignore the return value
> or log a message/update some stats (which Google does) for the
> monitoring purpose.

Fair enough, thanks for your thoughts. No objection from me!
