Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA9B5A46B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiH2KCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiH2KCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475E05F138
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661767346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EHQWTqx1hJ/KNsFe7kL4o8M725RFp/teHXSfvZJ6uuM=;
        b=Q+BFzAd1ADtLvKr0A2TzEx37RVQd9038QK8iBJPO8in/bDNGFMWvqVlZlFgC6inNJhjle5
        aHRKlmamXnV2Tn/GTG+5FZKpGCohG6cvedtLE8sbLYLzIup7kAQctwSVcic2x3Hi6JVrrh
        vfmo3Lh6p4i8IS/IkzcKKVMSxvBSMeA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-369-3nKKG3vGMAKe3YT8fR4WYg-1; Mon, 29 Aug 2022 06:02:25 -0400
X-MC-Unique: 3nKKG3vGMAKe3YT8fR4WYg-1
Received: by mail-wm1-f72.google.com with SMTP id c5-20020a7bc005000000b003a63a3570f2so1190630wmb.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=EHQWTqx1hJ/KNsFe7kL4o8M725RFp/teHXSfvZJ6uuM=;
        b=WSzA+iPnf6xKhGGRvEBCdX7RUCEP4FIONCp4pDLG5TDqWCGBO0nrMBLVhZN/ijHb1J
         2Aii9pzYWiAz0Y8n81NiOKKGmXobVWCD2v83680KCDb6qmP7/mAqi/ikzWDsILEk8fTi
         n7eVYCKPMeU8p7Qk/DEH/yZ1lhZXENHJ+msAI76s8hlUAE4buGw2A2/vvw4vwGW/YVAW
         Z1Cr3T2rpHEen3e9maqbgnLNWgpG7gyDO5dIUmDW0NP9JlqyEd7QKK+eVK/WAjKDYBul
         Dz3wBCxo3hC6LegF/9cC4m1V/pzP4DzL42vvpYqM4mufSq7047XsUoVRPqCpj4SvG986
         vhUg==
X-Gm-Message-State: ACgBeo2Ry/TexD8IW2piqHA6BW9IJk3ICayPhPQomiCLPDtzyIGtGuA7
        EtMBJ+CHU0zi4EHoe2J6PoXdkWg6S23hqzZ/+YxWACoVC2m4jLLSmK5N/o962KrHdE4SMGV7uCW
        HXPK0DWWByRYFwqv/3H72HVUx
X-Received: by 2002:a5d:498c:0:b0:226:d522:ae4 with SMTP id r12-20020a5d498c000000b00226d5220ae4mr4042662wrq.84.1661767343859;
        Mon, 29 Aug 2022 03:02:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6NVshlmvckCXyQ/ibbvM+hwHWz+l6Mr1r8C40Y1pvr4x0hOtw751gci5QcYA7r2t95lVIuwA==
X-Received: by 2002:a5d:498c:0:b0:226:d522:ae4 with SMTP id r12-20020a5d498c000000b00226d5220ae4mr4042638wrq.84.1661767343537;
        Mon, 29 Aug 2022 03:02:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3900:658b:bed0:4260:4c25? (p200300cbc7073900658bbed042604c25.dip0.t-ipconnect.de. [2003:cb:c707:3900:658b:bed0:4260:4c25])
        by smtp.gmail.com with ESMTPSA id q13-20020adff78d000000b0022533c4fa48sm6548900wrp.55.2022.08.29.03.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 03:02:22 -0700 (PDT)
Message-ID: <42c164c6-8c69-7b4b-d965-ac62d1607061@redhat.com>
Date:   Mon, 29 Aug 2022 12:02:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC 2/3] mm: changes to split_huge_page() to free zero filled
 tail pages
Content-Language: en-US
To:     Rik van Riel <riel@surriel.com>, alexlzhu@fb.com,
        linux-mm@kvack.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, akpm@linux-foundation.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <cover.1661461643.git.alexlzhu@fb.com>
 <490fcdd204ae129a2e43614a569a1cf4bdde9196.1661461643.git.alexlzhu@fb.com>
 <ead1bc0e-c9df-d590-3423-9cfa449167e7@redhat.com>
 <6448b9a8dba8ef39e42e56a3c0ce0633fff7c6a6.camel@surriel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6448b9a8dba8ef39e42e56a3c0ce0633fff7c6a6.camel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.08.22 23:18, Rik van Riel wrote:
> On Fri, 2022-08-26 at 12:18 +0200, David Hildenbrand wrote:
>> On 25.08.22 23:30, alexlzhu@fb.com wrote:
>>> From: Alexander Zhu <alexlzhu@fb.com>
>>>
>>> Currently, split_huge_page() does not have a way to identify zero
>>> filled
>>> pages within the THP. Thus these zero pages get remapped and
>>> continue to
>>> create memory waste. In this patch, we identify and free tail pages
>>> that
>>> are zero filled in split_huge_page(). In this way, we avoid mapping
>>> these
>>> pages back into page table entries and can free up unused memory
>>> within
>>> THPs. 
>>>
>>
>> Isn't this to some degree splitting the THP (PMDs->PTEs + dissolve
>> compound page) and then letting KSM replace the zero-filled page by
>> the
>> shared zeropage?
>>
> Many systems do not run KSM, though, and even on the systems
> where it does, KSM only covers a subset of the memory in the
> system.

Right, however there seems to be a push from some folks to enable it
more widely.

> 
> I could see wanting to maybe consolidate the scanning between
> KSM and this thing at some point, if it could be done without
> too much complexity, but keeping this change to split_huge_page
> looks like it might make sense even when KSM is enabled, since
> it will get rid of the unnecessary memory much faster than KSM could.
> 
> Keeping a hundred MB of unnecessary memory around for longer
> would simply result in more THPs getting split up, and more
> memory pressure for a longer time than we need.

Right. I was wondering if we want to map the shared zeropage instead of
the "detected to be zero" page, similar to how KSM would do it. For
example, with userfaultfd there would be an observable difference.

(maybe that's already done in this patch set)

-- 
Thanks,

David / dhildenb

