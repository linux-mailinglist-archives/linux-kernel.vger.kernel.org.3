Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847E3565347
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiGDLZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiGDLZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:25:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC6FFD3E;
        Mon,  4 Jul 2022 04:25:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e40so11325739eda.2;
        Mon, 04 Jul 2022 04:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z68zNcyHc4RP/qQ4YC8ImgRIcxZ+6FOFgyfdlqMIDxA=;
        b=DmfmJKAsao8sE6juVAJuI19G8ANa56KxQ55B47+1mL8bprx3k/yPt9NRMCLbClF8U4
         mvJgcjPJTaqkTuF8FzfqH2mEc3Oanjjep1/AILg9bCNmOVp/SHgDJMANw4i8aRzPYQJz
         EIFcKjt5dtQ2+CZcsYjka8GDuLPJujtwsgYS/m+v+Me9QfMDioZxnqEd2VBhohcKYfh8
         j9Z6k7nW7QET6qPGvqG40TPtGYMhbMGIozQ/+FBCk5wHJ9FAZM+15cJjc6K7KcDdH0V1
         uTeOnkYDNn7+rMMpUvK5oyxSB/CVgwQdh2vx64OBk88VMEvyEmYh60/aBYcLqRF5gBIk
         VhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z68zNcyHc4RP/qQ4YC8ImgRIcxZ+6FOFgyfdlqMIDxA=;
        b=Ay2PC9zIBZi5I29iXd+drlBgZGu3CypDv1Aw6TugYtoTAL5i+vQoBwxZAIIjWVpExJ
         EL9UpXa2gc18MEtYxKRVeNdzOUwsaC9ZDPQtSU6oExQ654S9gHm1NTS/XLvC/f9gpYxW
         8NR+u6OWOW18TFfzCr8KExZFKJslff6yutOPocB0S3JchYhwxP+SLKiVtOnjAaYOQ6AK
         AZqDuKXKzBX2X6zowHe6mYNS+FWk/ppPJ0eNTUAO5fRtA5K58BXZIKWolsTfpXbi7633
         ZdIClB0Nh12XnIENP6avtCFyIQIpVffEE0wNS0TKGdaOq6qW5ERf4pkvz8fYXku3BdIO
         OqSg==
X-Gm-Message-State: AJIora+uluPqc75vq/2maIIuxL6ZVTz4g94jVNWb4xj1rdPdQo/9BdYf
        15RGiYbM/m2gez+4JCCSxXE=
X-Google-Smtp-Source: AGRyM1tCFjRUP/eb1gC3OpKbKt1HvrUfeK0wby1qbjqHDUgQjopGsSyk6pGncpC+C+hNMQE/hfpc0Q==
X-Received: by 2002:aa7:c650:0:b0:43a:2c9a:fd1f with SMTP id z16-20020aa7c650000000b0043a2c9afd1fmr8894847edr.318.1656933932942;
        Mon, 04 Jul 2022 04:25:32 -0700 (PDT)
Received: from krava ([151.70.14.154])
        by smtp.gmail.com with ESMTPSA id c12-20020a170906d18c00b00727c6da69besm7336926ejz.38.2022.07.04.04.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 04:25:32 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 4 Jul 2022 13:25:28 +0200
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf parse: Allow names to start with digits
Message-ID: <YsLOKEqzp0Syz/Rt@krava>
References: <20220612061508.1449636-1-asmadeus@codewreck.org>
 <YsAUqwzeO8U6cIJA@codewreck.org>
 <YsA4+A7TSjzUKDWK@kernel.org>
 <YsBosxs9TVB0aLrf@krava>
 <YsDZ8mTnCQzpejOM@codewreck.org>
 <YsGduWiTvkM2/tHv@krava>
 <YsItNWBYfZ5UoUPf@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsItNWBYfZ5UoUPf@codewreck.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 08:58:45AM +0900, Dominique Martinet wrote:
> Jiri Olsa wrote on Sun, Jul 03, 2022 at 03:46:33PM +0200:
> > > not sure if there'd be any other way of testing, there's nothing else in
> > > 'perf list' that starts with a number.
> > 
> > maybe we could do it same way we did for fake pmu events like below
> 
> hmm, I'll have to defer to you on that honestly.
> 
> It looks good to me though and I've tested your diff (test succeeds even
> with 9pnet module unloaded).
> 
> Just a note though, this makes test no longer checks the sys event
> directories exist for all other tests in these arrays (test__events,
> test__events_pmu and test__hybrid_events); if we have guarantees the
> probes exist I believe at least a few should keep checking the format
> path correctly.
> It might be worth adding a check_format flag to test_event() and add a
> new list that doesn't check formats just for 9p?

format provides only id which we don't check for tracepoints

> 
> If you're ok with that I can resend this as three patches: my original
> patch, a patch with your diff and test_event() keeping current
> behaviour, and a last patch adding that last flag and testing 9p without
> format check.
> 
> (and if you don't think it's worth checking probe existence same thing
> but even simpler)

I have that patch split into 2 separated changes,
I'll try to send it later today

jirka
