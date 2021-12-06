Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03C94695E1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbhLFMrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:47:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234371AbhLFMrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638794620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D0rDYXzE0SPZ+C/eIfPCQMaxBhSZ8MnPKElCP2zX1KY=;
        b=JDvwXbWiaXR97URvIoB0gde6dGm8DzoPd1i5xdwGcUy6Kbhyy7RwKVN6aJvMZaOCvICybv
        FsJYaBFNW7s1g/aAT/ZTU8NjdTB23Zfn4WQEq3EBCRVORyHU3nIUi3S4FEYosejJcx7V0K
        w65Lrv632yLjg0e294Z/4tshYNZMZy0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-5jP1MsV5Pg-w6ACTfTPTWg-1; Mon, 06 Dec 2021 07:43:31 -0500
X-MC-Unique: 5jP1MsV5Pg-w6ACTfTPTWg-1
Received: by mail-wm1-f70.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so6066144wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 04:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=D0rDYXzE0SPZ+C/eIfPCQMaxBhSZ8MnPKElCP2zX1KY=;
        b=0rzuLpDNzMt9xCbTQYezedgqMtHqUIaCZdf4Vfu3iKgwuqQQqxMeT7WKGxZWM1dJPj
         bObnX1iRZnJmHPAsrSXEfpIRcfsqL4eh0BGAzOqVFruEvRJPxCMS9+avPwt4VOMhA0JC
         YF7fujxBaq8UVs0CpavJv/p58kn4CA2q7vrjKuOSwFBvkAjyK90LcfHdsjyedStfh3x+
         CqEIvfpT0lnNdQ9lwsIkezzgFNecZgaGc9zy+juFopKV6NgezQdOrEemO5a/1c/zFuip
         lluDI5nd2jCz8c0rxIbFPV4zZW+3YVaQyIRHl3tteryCYx7OlMXJrDgy9xZW3sjKlpmT
         3Uzg==
X-Gm-Message-State: AOAM530yu89Ekvd11iNULL9HTUJFnh/4AsOJGAZ4HMp6AjmC+Pm7DyfN
        1l+AJ/km/sWn16WQlE7PFyk8OHBJ1ktYUsyl22WDMHxN4KqVvoGrbea0fgH/Ak5WtSRPTNAH7e/
        EZZSG7pYoNaIQ4WJ/Zo6vHwdb
X-Received: by 2002:a05:600c:378b:: with SMTP id o11mr39083438wmr.157.1638794609551;
        Mon, 06 Dec 2021 04:43:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6i6PiyHl0fU3Hvlx3y7gJZLF38DdGHyzeKmUhKFboTJBwesZG6aNnluoOCJjZ+HH6FCFeKw==
X-Received: by 2002:a05:600c:378b:: with SMTP id o11mr39083406wmr.157.1638794609363;
        Mon, 06 Dec 2021 04:43:29 -0800 (PST)
Received: from [192.168.3.132] (p5b0c62c6.dip0.t-ipconnect.de. [91.12.98.198])
        by smtp.gmail.com with ESMTPSA id r17sm12356493wmq.11.2021.12.06.04.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 04:43:28 -0800 (PST)
Message-ID: <51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com>
Date:   Mon, 6 Dec 2021 13:43:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com> <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <Ya3r3C/OpnK7OBPt@dhcp22.suse.cz>
 <840cb3d0-61fe-b6cb-9918-69146ba06cf7@redhat.com>
 <Ya3yZWkj2wGRWDMz@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
In-Reply-To: <Ya3yZWkj2wGRWDMz@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm not sure if it's rally whack-a-mole really applies. It's just the
>> for_each_node_* calls that need love. In other cases, we shouldn't
>> really stumble over an offline node.
>>
>> Someone deliberately decided to use "for_each_node()" instead of
>> for_each_online_node() without taking care of online vs. offline
>> semantics. That's just a BUG and needs fixing IMHO.
> 
> Well, I would argue this is too much to ask for the API users. It is
> also a trap that is just too easy to fall into. Turning for_each_node
> into for_each_online_node will not solve the problem just by itself.
> As you have pointed out an offline node can become online and without a
> hotplug notifier there is no way for_each_online_node would be a proper
> fit for anything that allocates memory only for online nodes. See the
> trap? People think they are doing the right thing but they are not in
> fact.

I agree that it requires care in the caller. And some callers don't seem
to know that the nid they hold in their hand is garbage and should be
used with care. And this is pretty much undocumented.

> 
> Now practically speaking !node_online should not apear node_online (note
> I am attentionally avoiding to say offline and online as that has a
> completely different semantic) shouldn't really happen for some
> architectures. x86 should allocate pgdat for each possible node. I do
> not know what was the architecture in this case but we already have
> another report for x86 that remains unexplained.

So we'd allocate the pgdat although all we want is just a zonelist. The
obvious alternative is to implement the fallback where reasonable -- for
example, in the page allocator. It knows the fallback order:
build_zonelists(). That's pretty much all we need the preferred_nid for.

So just making prepare_alloc_pages()/node_zonelist() deal with a missing
pgdat could make sense as well. Something like:


diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b976c4177299..2d2649e78766 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -508,9 +508,14 @@ static inline int gfp_zonelist(gfp_t flags)
  *
  * For the case of non-NUMA systems the NODE_DATA() gets optimized to
  * &contig_page_data at compile-time.
+ *
+ * If the node does not have a pgdat yet, returns the zonelist of the
+ * first online node.
  */
 static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
 {
+       if (unlikely(!NODE_DATA(nid)))
+               nid = first_online_node;
        return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
 }


But of course, there might be value in a proper node-aware fallback list
as we have in build_zonelists() -- but it remains questionable if the
difference for these corner cases would be relevant in practice.

Further, if we could have thousands of nodes, we'd have to update each
and every one when building zone lists ...

Removing the hotadd_new_pgdat() stuff does sound appealing, though.

-- 
Thanks,

David / dhildenb

