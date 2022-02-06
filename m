Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1800B4AAD74
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 03:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381541AbiBFCL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 21:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiBFCLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 21:11:25 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A43C043186
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 18:11:24 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id d10so31456360eje.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 18:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kom0rnZXZn47YFlPMfS28zjK6FLYKt/ZTTdoLV2yT4Q=;
        b=Tp67YNDYO4k7ScZNzTnDsX9iV0SicTghOQd6D5OO4tZ0aI0A1+ky8payE32xq/VnCe
         HFQd+9wiJ00MEOVBe9k54EHI/diQp9Tjq+V11YW8XI15zYv0xe7viWUfJlGtkNMMoVjj
         OnCn7XCHrV4t5K1nadLISMRBUXyHirD8loWAjjcoLSe5izAlbtQRbO7pamPqb9BQxF9o
         C3vLuRAlfAK71yJQXC1F19fFiuIYorig69CyNrATmF2vFXIsQYgo52WY4gkLEY6xowQ8
         SKirnPMYoa34eVjaNiZug804bQSyNbJJsARgeQ7BCR6kk9pXjF0luaukaqp51zBwB5uw
         ziVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kom0rnZXZn47YFlPMfS28zjK6FLYKt/ZTTdoLV2yT4Q=;
        b=lbb6lJWHTeZCAYjvIwIFr45etnfF6WDew/rTVPKdUU7z7DcGDWYqicIQZ8xyYz6uV0
         JnXgWzTLyCZpF6Dr1FkRd84CJIP1BPNC8+fF/7hKPxQL9OoWEV8cJfvX9mcjZvR/0mK2
         llTKMDoA46u0Qqw6uCTIbnbgYUPfAJidyd8IzrmST6YI3IFIkAardOCYrWrmQWxJgFnV
         IPNswEt3EjRoWDb0EwE6BReoAZZSiEj1cGY8F1U46DHFVKGiWJh7psuwrkd5nXjQCquS
         /RiffyvHc6CfpHtAODn/w/gnEpvj6+BRO86bSYnljwzKMFw2A9T5BZXfoCAiS3FqcUWO
         nh3Q==
X-Gm-Message-State: AOAM530xZf7oDleNNHDxiWj4NhVrFicZXHieoj91AcuH1dFheRZsrwKH
        yepjoJG3kvs50bzjkgCxSqY=
X-Google-Smtp-Source: ABdhPJzU4BjbD9JCm7i0prrIm4SV2jedxnxnvSs6CAyPDmVTsNKNyqF7xstxj9l6UCiAf8sMoYRdfA==
X-Received: by 2002:a17:907:3f87:: with SMTP id hr7mr5173101ejc.586.1644113483316;
        Sat, 05 Feb 2022 18:11:23 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id p13sm2128231ejx.191.2022.02.05.18.11.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Feb 2022 18:11:22 -0800 (PST)
Date:   Sun, 6 Feb 2022 02:11:22 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        mhocko@suse.com, mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: add zone to zonelist if populated
Message-ID: <20220206021122.luaihnjz3vhqwxax@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220203020022.3044-1-richard.weiyang@gmail.com>
 <530d1ca4-6e05-b237-e0a9-c43d61767c4d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <530d1ca4-6e05-b237-e0a9-c43d61767c4d@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 10:25:51AM +0100, David Hildenbrand wrote:
>On 03.02.22 03:00, Wei Yang wrote:
>> During memory hotplug, when online/offline a zone, we need to rebuild
>> the zonelist for all nodes. Current behavior would lose a valid zone in
>> zonelist since only pick up managed_zone.
>> 
>> There are two cases for a zone with memory but still !managed.
>> 
>>   * all pages were allocated via memblock
>>   * all pages were taken by ballooning / virtio-mem
>> 
>> This state maybe temporary, since both of them may release some memory.
>> Then it end up with a managed zone not in zonelist.
>> 
>> This is introduced in 'commit 6aa303defb74 ("mm, vmscan: only allocate
>> and reclaim from zones with pages managed by the buddy allocator")'.
>> This patch restore the behavior.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> CC: Mel Gorman <mgorman@techsingularity.net>
>> CC: David Hildenbrand <david@redhat.com>
>> Fixes: 6aa303defb74 ("mm, vmscan: only allocate and reclaim from zones with pages managed by the buddy allocator")
>
>That commit mentions that there used to be some ppc64 cases with fadump
>where it might have been a real problem. Unfortunately, that commit
>doesn't really tell what the performance implications are.
>

It mentioned a 100% CPU usage by commit 1d82de618ddd. Currently I don't find
which part introduced this and how it is fixed.

>We'd have to know how many "permanent memblock" allocations we have,
>that can never get freed.
>

For the case in that commit, the memory are reserved for crash kernel. I am
afraid this never get freed.

But for all the cases, I am not sure.

-- 
Wei Yang
Help you, Help me
