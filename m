Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7EB4F9132
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiDHIyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiDHIyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12FCB38D8B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649407957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G7/YImBklsA+ohVD5C9vqSQwoQu6qVBBXj3k65Td9/M=;
        b=a1KYxseHkelx9ZEAxDv4y8TOXV2Ri81qDvbQ4tsaV8OFNtgD0FWSKXS8sQc1g3/o4ibJJY
        kRi7BWgJWO4CCRvm4XHNQpwZ8ghSlD4xrgS5XbSAd7dX0uMfG1kL9E6QyXfGUTZwdst4vX
        fawn/Pl2BMYl34BwqNbdLyBaD73TRdw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-rf5nLTMtMGGYNrGBHEy47g-1; Fri, 08 Apr 2022 04:52:36 -0400
X-MC-Unique: rf5nLTMtMGGYNrGBHEy47g-1
Received: by mail-qv1-f71.google.com with SMTP id o6-20020ad45c86000000b00443e7ec6026so8829334qvh.19
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 01:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G7/YImBklsA+ohVD5C9vqSQwoQu6qVBBXj3k65Td9/M=;
        b=FWjRnu51wZhdy3CCYf4hF/Cq93Sy8V3XnfFmMOh6ZfXdyfMPtO4HOFTXHeksVcKmi2
         vVkJMHV8EMt1An/1qQSTKM6eHVgsWO/pMT/Zwat3n1M+XfAxq3K3EpiQVM6EMytBcJDm
         CjSWTBNcaM8ir/lNqElTx26i0e5wlMku8L5Hu42ZmzL7lxVL03pTGPpe/ID3mVypPyfd
         Cam7sPouXwfi4zC3d9oboPqYAWxyP2sXCC2xqAhRstywJSm/dZqVcxeIq44c7bq7q1W6
         bfGpR6p+s7Iq4z78u29mZqEktyBXD2ZVTzFDF6rdRk0Ot4KymlgKjyTj1Z2k4kaLAUmh
         JiYg==
X-Gm-Message-State: AOAM530b4/PTR0BM4QJnF/ZSGmk7NzVK6sUTLbG7DbSsH1biW6nAD0ru
        sT+MN0ivmcw1CLPEZrb0ZtcVtvwquNMFQ2w0fDoTDY/vNqOkeMw497UL1EEpB3qOg7I1XeXGdGC
        tDNTKjOdXKYBoBUUEvuGVDL6+
X-Received: by 2002:a05:620a:448c:b0:67d:4fe3:2b96 with SMTP id x12-20020a05620a448c00b0067d4fe32b96mr11708029qkp.663.1649407955546;
        Fri, 08 Apr 2022 01:52:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8e28K12WSI03L5GoUoGhDpAl4ilNcJhqTbHLHggp321X66c1rTEnZqPBv7L5AjbrIhSphvw==
X-Received: by 2002:a05:620a:448c:b0:67d:4fe3:2b96 with SMTP id x12-20020a05620a448c00b0067d4fe32b96mr11708019qkp.663.1649407955305;
        Fri, 08 Apr 2022 01:52:35 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id az17-20020a05620a171100b00680af0db559sm14053367qkb.127.2022.04.08.01.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 01:52:34 -0700 (PDT)
Message-ID: <ddf1755e-fe69-b60e-ee07-e78d663b11b2@redhat.com>
Date:   Fri, 8 Apr 2022 04:52:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <87tub4j7hg.ffs@tglx>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <87tub4j7hg.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/22 04:37, Thomas Gleixner wrote:
> On Fri, Apr 08 2022 at 10:15, Peter Zijlstra wrote:
>> On Thu, Apr 07, 2022 at 11:28:09PM -0400, Nico Pache wrote:
>>> Theoretically a failure can still occur if there are locks mapped as
>>> PRIVATE|ANON; however, the robust futexes are a best-effort approach.
>>> This patch only strengthens that best-effort.
>>>
>>> The following case can still fail:
>>> robust head (skipped) -> private lock (reaped) -> shared lock
>>> (skipped)
>>
>> This is still all sorts of confused.. it's a list head, the entries can
>> be in any random other VMA. You must not remove *any* user memory before
>> doing the robust thing. Not removing the VMA that contains the head is
>> pointless in the extreme.
>>
>> Did you not read the previous discussion?
> 
> Aside of that we all agreed that giving a oom-killed task time to
> cleanup itself instead of brute force cleaning it up immediately, which
> is the real problem here. Can we fix that first before adding broken
> heuristics?
We've tried multiple approaches to reproduce the case you are talking about with
no success...

Why make a change for something that we cant reproduce when we are sure this
works for all the cases we've attempted.

I also dont see how this a broken heuristic... If anything adding a delay is
broken. How do we assure the delay is long enough for the exit to clean up the
futexes? In a heavily contended CPU with high memory pressure the delay may also
lead to other processes unnecessarily OOMing.

Cheers,
-- Nico

> 
> Thanks,
> 
>         tglx
> 
> 

