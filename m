Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBF255D942
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiF0Qfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiF0Qfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C950FDEC0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656347740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VXkvf9Dz/3Rc1tZTIiOEIYW6xJ4bF2M7kN20MmYwhCw=;
        b=h7N5dsE3RRNoiAHhU5qHX2LpBWhww4q1FTDPQEeG+5G292ktLnV/6IE3lujI3nJCxuaJfr
        8DaEYT32X3gauvMSEheeQe47m79a3zzTsAmPFkBWM9YnpzdAgYtNryMQujveBXy2kVw2Qw
        CG3UNs5p67XMLD777kn1wHsohwbgZX8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-8q6G59CYPKi2RTIzlc0YdA-1; Mon, 27 Jun 2022 12:35:38 -0400
X-MC-Unique: 8q6G59CYPKi2RTIzlc0YdA-1
Received: by mail-wm1-f70.google.com with SMTP id v184-20020a1cacc1000000b0039c7efa3e95so3781396wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=VXkvf9Dz/3Rc1tZTIiOEIYW6xJ4bF2M7kN20MmYwhCw=;
        b=faKLtuwW6VMj1tygbiE6m0AR5UlgvJTw3B4yfxTDgk7NcVQvBnXgi7OZ5woaVs4AQj
         ofklH+YTODqv2XJLHFpxdygscZn4peneoItayBTXNpmy7r1P8MgS+0ycUDCi2pq6h5NH
         F5hLvRlhzJDCcl5s624RYBGr7Cb3pK7LmBpLMzpnsPVN3gto5m95svFbZsxqruUc+LAk
         LzOQ4o94v9Sj0oUT++gOynSBQWf9LuIHOrQAX9qw7lwKTHD1QnctWx/ak2X7hFG/QFV4
         66uzP/JmFBvaTO8UG0pCeolWldhT1wJrFP1wiByOxhRRLb4vYOSxr4kFsPXUr4U2WBn6
         XbBg==
X-Gm-Message-State: AJIora9pbPiPy1Wn9rh+RGtoWo+q/jf/HRgFMhsccxHAeKhuEUHWlrwQ
        RffQGIebYYRslyeJDTtj+/siEcE/1LlQ5LizL040TnkxIOCyKaJ1pQT1cImmkJy1/3cq8rb4KkG
        MBuICydqQDc1oBpQKDWSCfX7b
X-Received: by 2002:a05:600c:3845:b0:39c:6ea9:ed34 with SMTP id s5-20020a05600c384500b0039c6ea9ed34mr15813982wmr.175.1656347737546;
        Mon, 27 Jun 2022 09:35:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tQi9g3utC8EzXjKD8m93yuKrwANYFg//2CpsGdAnGzYjiEv6/vdPPRcD412Ha4VSvENvZqJQ==
X-Received: by 2002:a05:600c:3845:b0:39c:6ea9:ed34 with SMTP id s5-20020a05600c384500b0039c6ea9ed34mr15813955wmr.175.1656347737217;
        Mon, 27 Jun 2022 09:35:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:d100:dd9:b2f7:f126:11c2? (p200300cbc708d1000dd9b2f7f12611c2.dip0.t-ipconnect.de. [2003:cb:c708:d100:dd9:b2f7:f126:11c2])
        by smtp.gmail.com with ESMTPSA id ib3-20020a05600ca14300b003a04e6410e0sm1554270wmb.33.2022.06.27.09.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 09:35:36 -0700 (PDT)
Message-ID: <8fefe59d-c893-39f4-3225-65343086c867@redhat.com>
Date:   Mon, 27 Jun 2022 18:35:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <59edde13-4167-8550-86f0-11fc67882107@quicinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Discussion on race between freed page_ext access and memory
 offline operation
In-Reply-To: <59edde13-4167-8550-86f0-11fc67882107@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.06.22 18:09, Charan Teja Kalla wrote:
> The below race between page_ext and online/offline of the respective
> memory blocks will cause use-after-free on the access of page_ext structure.
> 
> process1			    process2
> ---------			    ---------
> a)doing /proc/page_owner            doing memory offline	
> 			            through offline_pages
> 
> b)PageBuddy check is failed
> thus proceed to get the
> page_owner information
> through page_ext access.
> page_ext = lookup_page_ext(page);
> 				
> 				  migrate_pages();
> 				 ................
> 				Since all pages are successfully
> 				migrated as part of the offline
> 				operation,send MEM_OFFLINE notification
> 				where for page_ext it calls:
> 				offline_page_ext()-->
> 				  __free_page_ext()-->
> 				    free_page_ext()-->
> 				      vfree(ms->page_ext)
> 				mem_section->page_ext = NULL
> 
> c) Check for the PAGE_EXT flags
> in the page_ext->flags access
> results into the use-after-free(leading
> to the translation faults).
> 
> As mentioned above, there is really no synchronization between page_ext
> access and its freeing in the memory_offline.  The above is just one
> example but the problem persists in the other paths too involving
> page_ext->flags access(eg: page_is_idle()).
> 
> The memory offline steps(roughly) on a memory block is as below:
> 1) Isolate all the pages
> 2) while(1)
>   try free the pages to buddy.(->free_list[MIGRATE_ISOLATE])
> 3) delete the pages from this buddy list.
> 4) Then free page_ext.(Note: The struct page is still alive as it is
> freed only during hot remove of the memory which frees the memmap, which
> steps the user might not perform).
> 
> This design leads to the state where struct page is alive but the struct
> page_ext is freed, where the later is ideally part of the former which
> just representing the page_flags. This seems to be a wrong design where
> 'struct page' as a whole is not accessible(Thanks to Minchan for
> pointing this out).

Accessing the struct page -- including any extensions -- is invalid if
the memory section is marked offline.

Usual PFN walkers use pfn_to_online_page() to make sure we have PFN with
an actual meaning in it.

There is no real synchronization between pfn_to_online_page() and memory
offline code. For now it wasn't required because it was never relevant
in practice.

After pfn_to_online_page() it takes quite a long time until memory is
actually offlined and then, the memmap is removed. Maybe it's different
for page_ext.


It smells like page_ext should use some mechanism during  MEM_OFFLINE to
synchronize against any users of its metadata. Generic memory offlining
code might be the wrong place for that.

> 
> Some solutions we think are:
> ----------------------------
> 1) Take the mem_hotplug_lock read_lock every time page_ext access.

That would be the big hammer. But it feels wrong, because page_ext is
another subsystem that's synchronized from generic memory offlining code
via the notifier.

> 
> 2) Take the extra refcount on the page every time page_ext access is
> made, so that parallel offline operation can't free the page to buddy.

No, that's no good. Just racy.

> 
> 3) Change the design where the page_ext is valid as long as the struct
> page is alive.

:/ Doesn't spark joy.

> 
> Any other inputs here?


page_ext needs a mechanism to synchronize against any users of the data
it manages. Maybe RCU can help?


-- 
Thanks,

David / dhildenb

