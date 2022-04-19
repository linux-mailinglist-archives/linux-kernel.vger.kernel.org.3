Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3435B50778F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356365AbiDSSPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356304AbiDSSO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79A1B3D4BB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650391917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LwUaVyvkJpv+b43R2pNDTJa0Sg8BzHKo5UTqR77pruc=;
        b=KLQmXZzNeaF6nFQu3m2ZDxficAZhX4lHb6SdCflzifkqBJgf2yjTWDDrqG0AksySUDftFr
        8DQPKoP+MHKaNdEVETsY14dcDEca59sM1bc8+/k96bz7eNxzqLecuExkvhAf+3g34jAOiZ
        Q19Xv3P8ntaOt20w/g/Hds6iIr6WSYo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-EKDFvnEaMO6a4kza1yE__Q-1; Tue, 19 Apr 2022 14:11:55 -0400
X-MC-Unique: EKDFvnEaMO6a4kza1yE__Q-1
Received: by mail-qv1-f71.google.com with SMTP id 30-20020a0c80a1000000b00446218e1bcbso12551304qvb.23
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LwUaVyvkJpv+b43R2pNDTJa0Sg8BzHKo5UTqR77pruc=;
        b=yu+TtPuBfnX1oTrnzXK0QWI0qh1mEuxTsQUkWzm/LcsyJ5y0ayDqCSN6Bjp87zIsFP
         A+o2354rxPndXiO6TrT5fY+O+QoUZiXvXVa54phrFgmqFeq10B1n3fQOCtxLKf9+5kDR
         F0emCnqLMQYU/S4+dK8adcXJlqSnGKeNVe6Lr/aITkipkwfepR9uPo6NykG4k6L5Ex1c
         V2H9ipIyFVlAPl+H+8juQ3HWig+aSiCQ8htUSgKBJdDzeoPLdb6a/b/hCGVXVPQq7pcj
         SgSknNyC9Md5i31nQoL96qtYyRQ228aPKPr137BF6JGMacizauZ2MYKYxy5g+L+Wj9Gb
         pPBA==
X-Gm-Message-State: AOAM533wEFogzrqEenkLJxu0o4yKkP3MvzVwKi1cM5CGbDOij5ZaHYWf
        6U+kt/twETE2HbqER+zZ59vOhZV6p9NGQR9UYv77N3Vfr/SmDktIEh+bCgjpZ9M6OH3nNxMO32e
        zX+p+fZldxkRjH/or6cUfWfjw
X-Received: by 2002:ac8:57c3:0:b0:2f2:2a4:fd15 with SMTP id w3-20020ac857c3000000b002f202a4fd15mr5998025qta.339.1650391915367;
        Tue, 19 Apr 2022 11:11:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHzZnfiEoTE9rq8ROzmmv2/PC1BvV4lSL4t+0tPZRfEQwxsSBiOPjTXcSOMF6iNYRfANzpIw==
X-Received: by 2002:ac8:57c3:0:b0:2f2:2a4:fd15 with SMTP id w3-20020ac857c3000000b002f202a4fd15mr5998008qta.339.1650391915104;
        Tue, 19 Apr 2022 11:11:55 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id s18-20020a05622a1a9200b002f335693f4bsm390102qtc.38.2022.04.19.11.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 11:11:54 -0700 (PDT)
Message-ID: <b5575449-08a2-2901-e7e1-a97150e4878c@redhat.com>
Date:   Tue, 19 Apr 2022 14:11:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] vm_swappiness=0 should still try to avoid swapping
 anon memory
Content-Language: en-US
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org, aquini@redhat.com, shakeelb@google.com,
        llong@redhat.com, mhocko@suse.com, hakavlad@inbox.lv
References: <20210809223740.59009-1-npache@redhat.com>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <20210809223740.59009-1-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think its is important to note the issue we are seeing has greatly improved
since the initial posting. However we have noticed that the issue is still
present (and significantly worse) when cgroupV1 is set.

We were initially testing with CgroupV1 and later found that the issue was not
as bad in CgroupV2 (but was still an noticeable issue). This is also resulting
in the splitting of THPs in the host kernel.

-- Nico

On 8/9/21 18:37, Nico Pache wrote:
> Since commit 170b04b7ae49 ("mm/workingset: prepare the workingset detection
> infrastructure for anon LRU") and commit b91ac374346b ("mm: vmscan: enforce
> inactive:active ratio at the reclaim root") swappiness can start prematurely
> swapping anon memory. This is due to the assumption that refaulting anon should
> always allow the shrinker to target anon memory. Add a check for swappiness
> being >0 before indiscriminately targeting Anon. Before these commits
> when a user had swappiness=0 anon memory would rarely get swapped; this
> behavior has remained constant sense RHEL5. This commit keeps that behavior
> intact and prevents the new workingset refaulting from challenging the anon
> memory when swappiness=0.
> 
> Anon can still be swapped to prevent OOM. This does not completely disable
> swapping, but rather tames the refaulting aspect of the code that allows for
> the deactivating of anon memory.
> 
> We have two customer workloads that discovered this issue:
> 1) A VM claiming 95% of the hosts memory followed by file reads (never dirty)
>    which begins to challenge the anon. Refaulting the anon working set will then
>    cause the indiscriminant swapping of the anon.
> 
> 2) A VM running a in-memory DB is being populated from file reads.
>    Swappiness is set to 0 or 1 to defer write I/O as much as possible. Once
>    the customer experienced low memory, swapping anon starts, with
>    little-to-no PageCache being swapped.
> 
> Previously the file cache would account for almost all of the memory
> reclaimed and reads would throttle. Although the two LRU changes mentioned
> allow for less thrashing of file cache, customers would like to be able to keep
> the swappiness=0 behavior that has been present in the kernel for a long
> time.
> 
> A similar solution may be possible in get_scan_count(), which determines the
> reclaim pressure for each LRU; however I believe that kind of solution may be
> too aggressive, and will not allow other parts of the code (like direct reclaim)
> from targeting the active_anon list. This way we stop the problem at the heart
> of what is causing the issue, with the least amount of interference in other
> code paths. Furthermore, shrink_lruvec can modify the reclaim pressure of each
> LRU, which may make the get_scan_count solution even trickier.
> 
> Changelog:
>  -V3:
>     * Blame the right commit and be more descriptive in my log message.
>     * inactive_is_low should remain independent from the new swappiness check.
>     * Change how we get the swappiness value. Shrink_node can be called with a
>       null target_mem_cgroup so we should depend on the target_lruvec to do the
>       null check on memcg.
> 
>  -V2:
>      * made this mem_cgroup specific so now it will work with v1, v2, and
>        no cgroups.
>      * I've also touched up my commit log.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/vmscan.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4620df62f0ff..9f2420da4037 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2883,8 +2883,12 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	struct lruvec *target_lruvec;
>  	bool reclaimable = false;
>  	unsigned long file;
> +	struct mem_cgroup *memcg;
> +	int swappiness;
>  
>  	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
> +	memcg = lruvec_memcg(target_lruvec);
> +	swappiness = mem_cgroup_swappiness(memcg);
>  
>  again:
>  	memset(&sc->nr, 0, sizeof(sc->nr));
> @@ -2909,7 +2913,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  
>  		refaults = lruvec_page_state(target_lruvec,
>  				WORKINGSET_ACTIVATE_ANON);
> -		if (refaults != target_lruvec->refaults[0] ||
> +		if ((swappiness && refaults != target_lruvec->refaults[0]) ||
>  			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
>  			sc->may_deactivate |= DEACTIVATE_ANON;
>  		else

