Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55B75A636E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiH3Mdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiH3Mdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044ED58B71
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661862826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yHf1R0yRa5PLkeHO3mixZ0igrrsKa53gGZnPGXCHmJs=;
        b=BFM2lJNG3+LDGh87uEfZgCi3/++4XDuZ8zsCRjoMsHEN11MjfElI15xh6/hL2K/pEIvdy3
        k+I+/MaykJtY8VvAZ8sXJFX9o5PoJfXpHPCk0tZvedgKXMzkfXaWJv+bmani6YcTX+R2q6
        Dnt9ZQAI3C9RVjooy1jfxPCQ3ux+nlY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-hvLkGwitNmifizLHGyM18Q-1; Tue, 30 Aug 2022 08:33:45 -0400
X-MC-Unique: hvLkGwitNmifizLHGyM18Q-1
Received: by mail-wm1-f72.google.com with SMTP id i132-20020a1c3b8a000000b003a537064611so6574515wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=yHf1R0yRa5PLkeHO3mixZ0igrrsKa53gGZnPGXCHmJs=;
        b=dWWBmI+oZL22WYiup4arOajz/+BJRCFIy5SX+ZUg2danNJWe2JeiCPdcwWz+V1E56x
         e/7joxhBQAGmzSsnhVvMSJHD99aXiNxa/akcTA7fm8sJsoE5fkFLKxJ1MCknblhAj6LE
         6yPSXjiIxEyzKgnY4vLxaIkTSsc90KUh1amSBnNwZETeJrc4/v4JU7WUU+uqXNzt+K65
         G5kPgM8MtgQBOxUt9Xn7cOtetGty2iH1MaVvIY4NoEsAUlrMGwy2XGp+qwOgRVCW2HuN
         bji2nesrmhfyFOmew5Z/VSbRrFY3V1lUYDS7DveEYoSZepG45y/SeJnyuAUayT6flOUq
         lkjg==
X-Gm-Message-State: ACgBeo3w0ocOtAREk42Hnq0LI9MANtKavj7/Su09kmr70acI1Yh6sRwX
        4gXq+3nXS1kDuwxlysI3yKU5bj4IwETZMYEazPScaX/eHNRq1mwv9Eu/jKFa9lQhZCvXhsqKUjD
        /vilyTWraL8eoogoyPvIfD5Yo
X-Received: by 2002:a05:600c:22c8:b0:3a5:c134:1f50 with SMTP id 8-20020a05600c22c800b003a5c1341f50mr9791111wmg.55.1661862823822;
        Tue, 30 Aug 2022 05:33:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7fV7UlnayoRTU1wY6uREoAOzHee3qXuVMo38aaSfaVyAWlUh4403AykH+xcIKYhpoChaFmAg==
X-Received: by 2002:a05:600c:22c8:b0:3a5:c134:1f50 with SMTP id 8-20020a05600c22c800b003a5c1341f50mr9791098wmg.55.1661862823512;
        Tue, 30 Aug 2022 05:33:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:1000:ecb4:919b:e3d3:e20b? (p200300cbc70a1000ecb4919be3d3e20b.dip0.t-ipconnect.de. [2003:cb:c70a:1000:ecb4:919b:e3d3:e20b])
        by smtp.gmail.com with ESMTPSA id i2-20020a5d55c2000000b00226dd738b9dsm4519579wrw.46.2022.08.30.05.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 05:33:43 -0700 (PDT)
Message-ID: <00f2dee2-ebc1-e732-f230-bc5b17da9f80@redhat.com>
Date:   Tue, 30 Aug 2022 14:33:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Rik van Riel <riel@surriel.com>, alexlzhu@fb.com,
        linux-mm@kvack.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, akpm@linux-foundation.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <cover.1661461643.git.alexlzhu@fb.com>
 <490fcdd204ae129a2e43614a569a1cf4bdde9196.1661461643.git.alexlzhu@fb.com>
 <ead1bc0e-c9df-d590-3423-9cfa449167e7@redhat.com>
 <6448b9a8dba8ef39e42e56a3c0ce0633fff7c6a6.camel@surriel.com>
 <42c164c6-8c69-7b4b-d965-ac62d1607061@redhat.com>
 <37db29410990991555362154a371b58f47d3cb0c.camel@surriel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC 2/3] mm: changes to split_huge_page() to free zero filled
 tail pages
In-Reply-To: <37db29410990991555362154a371b58f47d3cb0c.camel@surriel.com>
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

On 29.08.22 15:17, Rik van Riel wrote:
> On Mon, 2022-08-29 at 12:02 +0200, David Hildenbrand wrote:
>> On 26.08.22 23:18, Rik van Riel wrote:
>>> On Fri, 2022-08-26 at 12:18 +0200, David Hildenbrand wrote:
>>>> On 25.08.22 23:30, alexlzhu@fb.com wrote:
>>>>> From: Alexander Zhu <alexlzhu@fb.com>
>>>
>>> I could see wanting to maybe consolidate the scanning between
>>> KSM and this thing at some point, if it could be done without
>>> too much complexity, but keeping this change to split_huge_page
>>> looks like it might make sense even when KSM is enabled, since
>>> it will get rid of the unnecessary memory much faster than KSM
>>> could.
>>>
>>> Keeping a hundred MB of unnecessary memory around for longer
>>> would simply result in more THPs getting split up, and more
>>> memory pressure for a longer time than we need.
>>
>> Right. I was wondering if we want to map the shared zeropage instead
>> of
>> the "detected to be zero" page, similar to how KSM would do it. For
>> example, with userfaultfd there would be an observable difference.
>>
>> (maybe that's already done in this patch set)
>>
> The patch does not currently do that, but I suppose it could?
> 

It would be interesting to know why KSM decided to replace the mapped
page with the shared zeropage instead of dropping the page and letting
the next read fault populate the shared zeropage. That code predates
userfaultfd IIRC.

> What exactly are the userfaultfd differences here, and how does
> dropping 4kB pages break things vs. using the shared zeropage?

Once userfaultfd (missing mode) is enabled on a VMA:

1) khugepaged will no longer collapse pte_none(pteval), independent of
khugepaged_max_ptes_none setting -- see __collapse_huge_page_isolate.
[it will also not collapse zeropages, but I recall that that's not
actually required]

So it will not close holes, because the user space fault handler is in
charge of making a decision when something will get mapped there and
with which content.


2) Page faults will no longer populate a THP -- the user space handler
is notified instead and has to decide how the fault will be resolved
(place pages).


If you unmap something (resulting in pte_none()) where previously
something used to be mapped in a page table, you might suddenly inform
the user space fault handler about a page fault that it doesn't expect,
because it previously placed a page and did not zap that page itself
(MADV_DONTNEED).

So at least with userfaultfd I think we have to be careful. Not sure if
there are other corner cases (again, KSM behavior is interesting)

-- 
Thanks,

David / dhildenb

