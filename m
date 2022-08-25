Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78365A1268
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbiHYNfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiHYNfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:35:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA3B70E61
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:35:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w19so39606938ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=maHy+RdG1bfZFcMYc9WoBOBgcyZgJzrvT/br9of5/VU=;
        b=ki59yMmI7FCk8x3aODpep64NKP8t1/4KYxMTUMMmwXZzS7FTFF7NyXtV3OQEzwBO8i
         ixy2Ie3yBDN6MY9J6oh5ohKreOhyo4exnqAFtyDKyGIlmMEoYYKv5UvuVW3BpzpK3A8u
         A+7XL429LMEIxpIIwyJTOz0NA8se0/inNDugUuas2ut7vqjWuB5zrL1DUwzw8tv87ahu
         2nJ5bjWNidheTYWOAkK5DgmkK9F9z7cyBalUhH9epPhy73xf2ROJwaJA5xylPX1yvZrl
         l+q1P0cdFMUVBHTnZXGgW0s8vq3N5rLVszPhTP+7mm1iaK128FV3V6UVbyj1gmG9ENDu
         JRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=maHy+RdG1bfZFcMYc9WoBOBgcyZgJzrvT/br9of5/VU=;
        b=7NxmdSNY5cA5dV61g7sR3qToGcXfsSsvYGurrL9d47S/z9y7pSzTIjMrySZKG9wlha
         vWC71Ef5fSAOA0iC9cvDJS9v1tSqT85nOz7Gsbk4YkSJLBpXqFBykuNLtJDi5sJ1J7Kt
         sIsr386QOBFezUx7uPnV5i4AsR/+kWbTYTwSzyQcT99RT10iX9ZFvbrSIkTl2ViGnIFx
         LWxoBUNSC6W5rkupjN60d2FQzKRmV1qTTg4Q3WfOg6kxOe1mUKLUGWhgPQtnAXx3K+H4
         MHmsZ8LQZdqvmwn/+DuFNg+YxTXShXXi8NqNNdslZWURD2w9b6ZfVoM5aihlkgCk/oKc
         9bSw==
X-Gm-Message-State: ACgBeo0rMIv0vY5hfCa5AcrcvNi+DSB0bhYnc8mEer1BL3HqI6jKkoNN
        t2d7ACpLAWXC1aAve9JCDwxTsA==
X-Google-Smtp-Source: AA6agR68Mc5Uo00qzU7ZBlI2Td38wWc8YYe05Y9uKw9yUI6KGPOGWg8b0eKy6paLME3n78tCMGxBlQ==
X-Received: by 2002:a17:907:75d9:b0:73d:dda8:b6c with SMTP id jl25-20020a17090775d900b0073ddda80b6cmr397885ejc.319.1661434502051;
        Thu, 25 Aug 2022 06:35:02 -0700 (PDT)
Received: from localhost (ip-109-192-149-028.um38.pools.vodafone-ip.de. [109.192.149.28])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709060cca00b0073bf84be798sm2501321ejh.142.2022.08.25.06.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 06:35:01 -0700 (PDT)
Date:   Thu, 25 Aug 2022 09:35:00 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [RFC PATCH] memcg: use root_mem_cgroup when css is inherited
Message-ID: <Ywd6hN1Q9MtQWZCp@cmpxchg.org>
References: <YwS/S9Sd1OWnT81Q@dhcp22.suse.cz>
 <CAGWkznGYLyF+njUB0gFF3JVdThnK9JaNsqxXYFhbdSwEQpCxvA@mail.gmail.com>
 <YwXYVjRpXQjQMsxr@dhcp22.suse.cz>
 <CAGWkznEqX3DwHW_owiK+HuuQ-HsUYK4vKmLhSxgzGn20Vzid2A@mail.gmail.com>
 <YwX89JCQCKMMYdG9@dhcp22.suse.cz>
 <CAGWkznF+dBjLzAxMMXWYSZ_5q3KA-ou0P7XM7jSYN7JSRp8N0w@mail.gmail.com>
 <YwcZctA2S3Sd0LBN@dhcp22.suse.cz>
 <CAGWkznH5gQXigdLx=fwdL0uqdGx4WE9QP8b8cbWFxr=Rdg-CZQ@mail.gmail.com>
 <Ywc34ci5XUMXOSYA@dhcp22.suse.cz>
 <CAGWkznHL_G3OoAc5gJ+iwxqxonr21-fU+F4T2gkpXH68keLpuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznHL_G3OoAc5gJ+iwxqxonr21-fU+F4T2gkpXH68keLpuQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 06:11:09PM +0800, Zhaoyang Huang wrote:
> Sorry for any misunderstanding among the discussion. My purpose is
> real and simple as I have stated from the very beginning that I would
> like to have per-app cgroup hierarchy to charge memory to root if it
> is not enabled explicitly for memory. The reason has also been stated
> like reclaim and workingset regression in suren's report. I don't
> think my proposal will do any harm to current v2's mechanism besides
> asking for the admin echo "+memory" to their desire group.

It would permit children to escape parental control, completely
breaking the hierarchy and delegation guarantees currently in
place. That just isn't going to happen.

Nacked-by: Johannes Weiner <hannes@cmpxchg.org>

I would suggest focusing on finding the root cause for the reclaim
problem you are describing. It's possible all we need is a fix to
reclaim or the workingset code.
