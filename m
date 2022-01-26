Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52A649CC55
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242147AbiAZOaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:30:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235227AbiAZOaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643207413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=150fjVbAwE7w6KLDZgSC6nZJBEmTmA9CuvCHqdto7BQ=;
        b=fPyS68kW/cKKvFCC5Uj0XxW+A27aSQXFcEuV2GB3LvExNHhXpgEFmI7YoZ/jhbTcdEGZ/u
        A3xT9nvpuuJhr4u8qtVpeck1bN/DWtj6XyGpaMTvKSBCmdK8UYaSHRZYtyTn2YF35ZLCpb
        gSjB0fOq9gkz+ybcZzFKY9Af3qQfCoA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-ypBMWtaHNvqdm4hUD5ZMMw-1; Wed, 26 Jan 2022 09:30:11 -0500
X-MC-Unique: ypBMWtaHNvqdm4hUD5ZMMw-1
Received: by mail-wm1-f69.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so2613540wmb.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:30:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=150fjVbAwE7w6KLDZgSC6nZJBEmTmA9CuvCHqdto7BQ=;
        b=2OdMPcmOHP+IMv1q8g2jLJjjP/U8GygnqoH7IBxCLKJvcctx+2XNDJI6YDoa6Qapr5
         TojeygLIDn1m1cx4Coc6azjR57hCWrBtWOo4aZQ/oGhn9NS+x5s3BXXZ+j4J0hTxWhzV
         JBtkufowTQ/xhzJfhNLEHzb26ITlGmjnGu1FAbyLJfAIzBCiFNc5qXFHrISuc7nvRjj3
         mIvyki8f9MxBRQMYmnQP71wAsIm/lhWzdQvcbPBg2aSQ4kK6Hkh0lIoQCc4du4cVGPO7
         J5pNM4j1Zmxuv+Hgb+WKd2cAjamQNAp1fkiNKMC1GelbdTavUphj6y/bhwGI2QwdYet1
         GQ3A==
X-Gm-Message-State: AOAM5310ZcteEt6a4gPCx0bUm0ewyZewzEofKZnk+ejBL6vfRIrXyEIe
        UvLeko1EbKITUDgF7+pPDgs5/WL+mL4L/d30ERMV3jY/L+bt811EmrXNxiQwwhkwroWdaT8LmYk
        G8YFlwEQFwK4cYWvq7hgtC1Dz
X-Received: by 2002:a05:6000:50b:: with SMTP id a11mr21795286wrf.387.1643207410674;
        Wed, 26 Jan 2022 06:30:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwc7scJK8kzvq+kw8xhyBTNOK9A0YqpOZbYNVnvSQ4zvC3C9EcQz4YQaKEfIScHQ6NWRTikNw==
X-Received: by 2002:a05:6000:50b:: with SMTP id a11mr21795278wrf.387.1643207410449;
        Wed, 26 Jan 2022 06:30:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:2700:cdd8:dcb0:2a69:8783? (p200300cbc7092700cdd8dcb02a698783.dip0.t-ipconnect.de. [2003:cb:c709:2700:cdd8:dcb0:2a69:8783])
        by smtp.gmail.com with ESMTPSA id m187sm3201648wme.25.2022.01.26.06.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 06:30:09 -0800 (PST)
Message-ID: <b493ba2a-6bf8-89d5-f6a2-4d96efc7256c@redhat.com>
Date:   Wed, 26 Jan 2022 15:30:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        akpm@linux-foundation.org, longpeng2@huawei.com, arnd@arndb.de,
        dave.hansen@linux.intel.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>
References: <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <Ye/5yUyEqO0ws0G5@casper.infradead.org>
 <20220125135917.ezi6itozrchsdcxg@box.shutemov.name>
 <YfAEqzTeBJSIOKcA@casper.infradead.org>
 <20220125185705.wf7p2l77vggipfry@box.shutemov.name>
 <YfBIpmxvc0+mFByf@casper.infradead.org>
 <YfDIYKygRHX4RIri@casper.infradead.org>
 <e164d7f4-406e-eed8-37d7-753f790b7560@redhat.com>
 <YfFO6VyMTrW1bWuu@casper.infradead.org>
 <2190b8e2-74f2-0e31-0a40-0401fbd9966e@redhat.com>
 <YfFW43PT5hwPHnOz@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YfFW43PT5hwPHnOz@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.01.22 15:12, Matthew Wilcox wrote:
> On Wed, Jan 26, 2022 at 02:55:10PM +0100, David Hildenbrand wrote:
>> On 26.01.22 14:38, Matthew Wilcox wrote:
>>> On Wed, Jan 26, 2022 at 11:16:42AM +0100, David Hildenbrand wrote:
>>>> A while ago I talked with Peter about an extended uffd (here: WP)
>>>> mechanism that would work on fds instead of the process address space.
>>>
>>> As far as I can tell, uffd is a grotesque hack that exists to work around
>>> the poor choice to use anonymous memory instead of file-backed memory
>>> in kvm.  Every time I see somebody mention it, I feel pain.
>>>
>>
>> I might be missing something important, because KVM can deal with
>> file-back memory just fine and uffd is used heavily outside of hypervisors.
>>
>> I'd love to learn how to handle what ordinary uffd (handle
>> missing/unpopulated pages) and uffd-wp (handle write access to pages)
>> can do with files instead. Because if something like that already
>> exists, it would be precisely what I am talking about.
> 
> Every notification that uffd wants already exists as a notification to
> the underlying filesystem.  Something like a uffdfs [1] would be able
> to do everything that uffd does without adding extra crap all over the MM.

I don't speak "filesystem" fluently, but I assume that could be an
overlay over other fs?

Peter is currently upstreaming uffd-wp for shmem. How could that look
like when doing it the fs-way?

-- 
Thanks,

David / dhildenb

