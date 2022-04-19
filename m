Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2A1506CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344520AbiDSM7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242767AbiDSM7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B1FA2B192
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650372981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7CRMFwBAwSytoT7QhMHKmZ9oEqeZXJfZLO3BeitbNk=;
        b=Ag9wQi3tkWp6uhEatutEtw/H5llf2MK+COvow8cRRrF6cFCg4V1OQeHpCp/G7Y8yFfIZyq
        0Mclxts/XKnFGVVjigmYYBMBhHEn66sBwIRohbfpw7SchGSP7+rsXGWj/Ika6XrVU5OUaB
        2m1R8Q1GRsAitiVxg9xwfigIwKRVH3Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-11jULcglOF2YZ-WQSWJQ4Q-1; Tue, 19 Apr 2022 08:56:20 -0400
X-MC-Unique: 11jULcglOF2YZ-WQSWJQ4Q-1
Received: by mail-wm1-f69.google.com with SMTP id y11-20020a7bc18b000000b0038eac019fc0so1183411wmi.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=w7CRMFwBAwSytoT7QhMHKmZ9oEqeZXJfZLO3BeitbNk=;
        b=qV5TMctCEORNJC/5XCVRkXgJKmVuZbTOWEXQvbzNGa9ZAPiVyp48nx5VJY6zgex1ya
         TYp1tLf1/bdgGy5wKMxwX5elqdxeO4j8hmSd/dEO/SCX475aYRmcq+1g4AeZ4RRMwY3Q
         vllvrkgoCbX4IvMo7UfBD9bTAm5JSTI/JFZlTZZWDKeNMeaZZV8a3Ftxmnfhz0cbEsYp
         iUMO0+yHjgox2NYSfEios6uwXWZGwy8/E5JIcyzKvJgtt8IyuCri6k/jci0zFLET0cX0
         iWQWdpYXK8Bdrs/hkJ90zb7+Iky4soBzPb6jM9JbH2FqUdoTH12PJjATL9TnlPUT7QSl
         to0A==
X-Gm-Message-State: AOAM533jizkz+VtmJhgJ2e0zJEkaKc4kwrPoJ42KnVAweGxj8+rZue7N
        Z+kol0wRTJ6COnqEeA5MAPcKUJrHQ0ZK2/BUdOih2lLYNSxufR0lk1y5Tnf7UXpgkXXPGlOESbI
        q+cVYfWQuHmfZcXmbL/Fc0DU+
X-Received: by 2002:a5d:6e0d:0:b0:207:a4d9:7950 with SMTP id h13-20020a5d6e0d000000b00207a4d97950mr11552650wrz.477.1650372978817;
        Tue, 19 Apr 2022 05:56:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYKkTpNyM9dnV8PInAa0R3bc+otnnkjPQ1loj/u9sqAIWt80zuVCGbG64ifL6Knin9j3CtIA==
X-Received: by 2002:a5d:6e0d:0:b0:207:a4d9:7950 with SMTP id h13-20020a5d6e0d000000b00207a4d97950mr11552629wrz.477.1650372978524;
        Tue, 19 Apr 2022 05:56:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id g5-20020adfd1e5000000b0020a97e7ba9fsm5533899wrd.92.2022.04.19.05.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 05:56:17 -0700 (PDT)
Message-ID: <59404249-de0c-c569-d04a-9da38ed14b0a@redhat.com>
Date:   Tue, 19 Apr 2022 14:56:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm: do not call add_nr_deferred() with zero deferred
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
References: <20220416004104.4089743-1-roman.gushchin@linux.dev>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220416004104.4089743-1-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.22 02:41, Roman Gushchin wrote:
> add_nr_deferred() is often called with next_deferred equal to 0.
> For instance, it's happening under low memory pressure for any
> shrinkers with a low number of cached objects. A corresponding trace
> looks like:
>   <...>-619914 [005] .... 467456.345160: mm_shrink_slab_end: \
>   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1	     \
>   unused scan count 0 new scan count 0 total_scan 0	     \
>   last shrinker return val 0
> 
>   <...>-619914 [005] .... 467456.345371: mm_shrink_slab_end: \
>   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1	     \
>   unused scan count 0 new scan count 0 total_scan 0	     \
>   last shrinker return val 0
> 
>   <...>-619914 [005] .... 467456.345380: mm_shrink_slab_end: \
>   super_cache_scan+0x0/0x1a0 0000000087027f06: nid: 1 unused \
>   scan count 0 new scan count 0 total_scan 0	             \
>   last shrinker return val 0
> 
> This lead to unnecessary checks and atomic operations, which can be
> avoided by checking next_deferred for not being zero before calling
> add_nr_deferred(). In this case the mm_shrink_slab_end trace point
> will get a potentially slightly outdated "new scan count" value, but
> it's totally fine.

Sufficient improvement to justify added complexity for anybody reading
that code?

> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  mm/vmscan.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d4a7d2bd276d..19d3d4fa1aad 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -808,7 +808,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	 * move the unused scan count back into the shrinker in a
>  	 * manner that handles concurrent updates.
>  	 */
> -	new_nr = add_nr_deferred(next_deferred, shrinker, shrinkctl);
> +	if (next_deferred)
> +		new_nr = add_nr_deferred(next_deferred, shrinker, shrinkctl);
> +	else
> +		new_nr = nr;
>  
>  	trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
>  	return freed;

And if we still want to do this optimization, why not put it into
add_nr_deferred()?

-- 
Thanks,

David / dhildenb

