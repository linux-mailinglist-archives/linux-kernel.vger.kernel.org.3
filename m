Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69474EFC60
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350219AbiDAVxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353033AbiDAVxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:53:35 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA2221BC51
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 14:51:43 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id d142so3216533qkc.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 14:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=M11X+y56T/1F4fHNq5auQu00TlcNFHXDYbY/RsKteOE=;
        b=c99U3qkEZHhIEc7ajhsZpxJqU4l3cAi/NL5cixEEbUy7C6XoKYSnxPRQBhDUZTmgW3
         CdaWd0g1Bby07fp/jIyG1J3+95Fzgp/LQjARdfXbFBUkPZqyz7od9HefPpO8KeihaS2q
         AlvwqXjClIn82Ow/qtMIqMEuy5CmEAoKGT4g+DwYdedW4fXEssdeJNdj65X6UuIG3Gye
         uo1vCgIZbKpkm4ga/owAOGsj/OUuejccn7DdhxMou/c44twsSE4v7r5tzRnQ3jKJpheT
         vGlmiuBEeWfJ6E0nzDdCP0Neo+0FVxArhDDUs374m/wmtChQS97scg1pGgtlfoHSbhwi
         XX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=M11X+y56T/1F4fHNq5auQu00TlcNFHXDYbY/RsKteOE=;
        b=iyBr42WnmFaDuTjXoqNLeF1bMpHgOn0dfabF+5tWaPUC2NP84P48537cJYbcEzDeAm
         Ff5xjtYPNGhBl7dy3OMd5qgzkDdZwY42M9RixSTWjxmHvNx/Ibknck0N4pDFhf9GZRsV
         +MWVbIMUkBqNKzg8llDX4/uTvfoRC5ydtixGLec+CXusMllDo3psTa72U87wTQit7IPV
         pj5CfBOWQkV8ALrXq7j3oDfHcO8NRGQnfuGy6YHgmq2e9e2wGIK6qQpSKYS0HnDDkXdH
         iin7gOTIVhWQN1nqCBVd/XiMZxK7z+4uNdML2qmjF6Y9ITY+A4nxaPjY/fnvll1Q+dDY
         YuKA==
X-Gm-Message-State: AOAM532ToOXuklRQXzSgLqICrvnX+34Ey7ryIhWkPYR7+9dufgRQKQ3W
        YbEXerYqHw8l3TyxwbF3pLDUjw==
X-Google-Smtp-Source: ABdhPJz5e+/qhWGXkOB2Pdg+sYmL/Wm7bmIqKPSDgyhO5CcEvxS029Di2b+ofW5VEbb4r0PJYsKguA==
X-Received: by 2002:a05:620a:25a:b0:67d:43a6:8892 with SMTP id q26-20020a05620a025a00b0067d43a68892mr7881250qkn.659.1648849902837;
        Fri, 01 Apr 2022 14:51:42 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id 188-20020a3709c5000000b0067b147584c2sm1897184qkj.102.2022.04.01.14.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 14:51:42 -0700 (PDT)
Date:   Fri, 1 Apr 2022 17:51:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
Message-ID: <Ykdz7fiMFZeFltYy@cmpxchg.org>
References: <YkdrEG5FlL7Gq2Vi@cmpxchg.org>
 <243A0156-D26A-47C9-982A-C8B0CDD69DA2@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <243A0156-D26A-47C9-982A-C8B0CDD69DA2@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 02:21:52PM -0700, Roman Gushchin wrote:
> > On Apr 1, 2022, at 2:13 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > 
> > ﻿On Fri, Apr 01, 2022 at 11:39:30AM -0700, Roman Gushchin wrote:
> >> The interface you're proposing is not really extensible, so we'll likely need to
> >> introduce a new interface like memory.reclaim_ext very soon. Why not create
> >> an extensible API from scratch?
> >> 
> >> I'm looking at cgroup v2 documentation which describes various interface files
> >> formats and it seems like given the number of potential optional arguments
> >> the best option is nested keyed (please, refer to the Interface Files section).
> >> 
> >> E.g. the format can be:
> >> echo "1G type=file nodemask=1-2 timeout=30s" > memory.reclaim
> > 
> > Yeah, that syntax looks perfect.
> > 
> > But why do you think it's not extensible from the current patch? We
> > can add those arguments one by one as we agree on them, and return
> > -EINVAL if somebody passes an unknown parameter.
> > 
> > It seems to me the current proposal is forward-compatible that way
> > (with the current set of keyword pararms being the empty set :-))
> 
> It wasn’t obvious to me. We spoke about positional arguments and then it wasn’t clear how to add them in a backward-compatible way. The last thing we want is a bunch of memory.reclaim* interfaces :)
> 
> So yeah, let’s just describe it properly in the documentation, no code changes are needed.

Sounds good to me!
