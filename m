Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B32B49CB9F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbiAZNz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:55:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241826AbiAZNzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643205314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CEOtowb71/wW18nMRaLR4DhB2JeMdoSeUkA2PCB2rX0=;
        b=Inktj+hNivx4tC6cRfeP4Tu/3eXf16+Qxn6pu+jg5q/bKtUO0naGswRbdlwLdn5qGP6JPA
        iAvXjJL8tEy3nfrfDIfKTwEezAGQYyQrf7q9Jb6eJvVWYdxdJtAZ7H81Jp2GNREsMKbjBb
        FBqyYZCQpsXzEIY7MVIsTAuTSF27vUQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-wc6-xaLKP7-hu9KIBAwU5A-1; Wed, 26 Jan 2022 08:55:13 -0500
X-MC-Unique: wc6-xaLKP7-hu9KIBAwU5A-1
Received: by mail-wr1-f71.google.com with SMTP id v28-20020adfa1dc000000b001dd1cb24081so1903121wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 05:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=CEOtowb71/wW18nMRaLR4DhB2JeMdoSeUkA2PCB2rX0=;
        b=x13maNHGFOvU7w9MYqjic3q4zWS4QNOMUqLWRvwvoJHClj8ntDx3R+qeB1VwFbiyb2
         q5+mk74PKH4THZl6vM2QSo1oWYkBuaKqL68e9PbnHXOddOSSNrxLhctUCPaZCJ6Ly/Jr
         2pQLqRJ+M5CIz88vo/FnPBT9+ixQOiBgQGNulwUvDhit6H18x7+Fka3+xANVkWaN+NSB
         8Bs388zL44fMbIFVHg3mBUQnZoPpaavJ8CdFagry3xHDTRdDFWVO62rDBbfzzOtibmms
         oKZ+cbwg7cVf97oRuq8HpFtWs+p4uIR431IqwVw7VIHWAFbrMwCjYV6rnxcgUvQ4ELAF
         LCjg==
X-Gm-Message-State: AOAM5313RVYDaEimKz9JT9KAmLxStEhNFhyBYo9BrFasRcObfnt8KT0q
        kztsA3qBgGQf5Oq6KN3lbjFMLylTGdi6uP4Ars0+Td8YT3zumivxy4mMqvbz2E3UfpUw50KGVcs
        +40UjpvdSIt7NP8Qa0bO1MpDR
X-Received: by 2002:a5d:4a07:: with SMTP id m7mr22391321wrq.535.1643205311888;
        Wed, 26 Jan 2022 05:55:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRzW2PVEeSrabafFjjCUdlMm9xvAZuThHjt+FAiFVYNPbOd6/wn65zNkmJd9+Sj9WLoHbMqw==
X-Received: by 2002:a5d:4a07:: with SMTP id m7mr22391298wrq.535.1643205311613;
        Wed, 26 Jan 2022 05:55:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:2700:cdd8:dcb0:2a69:8783? (p200300cbc7092700cdd8dcb02a698783.dip0.t-ipconnect.de. [2003:cb:c709:2700:cdd8:dcb0:2a69:8783])
        by smtp.gmail.com with ESMTPSA id n13sm15598929wrv.94.2022.01.26.05.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 05:55:11 -0800 (PST)
Message-ID: <2190b8e2-74f2-0e31-0a40-0401fbd9966e@redhat.com>
Date:   Wed, 26 Jan 2022 14:55:10 +0100
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
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220125114212.ks2qtncaahi6foan@box.shutemov.name>
 <Ye/5yUyEqO0ws0G5@casper.infradead.org>
 <20220125135917.ezi6itozrchsdcxg@box.shutemov.name>
 <YfAEqzTeBJSIOKcA@casper.infradead.org>
 <20220125185705.wf7p2l77vggipfry@box.shutemov.name>
 <YfBIpmxvc0+mFByf@casper.infradead.org>
 <YfDIYKygRHX4RIri@casper.infradead.org>
 <e164d7f4-406e-eed8-37d7-753f790b7560@redhat.com>
 <YfFO6VyMTrW1bWuu@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YfFO6VyMTrW1bWuu@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.01.22 14:38, Matthew Wilcox wrote:
> On Wed, Jan 26, 2022 at 11:16:42AM +0100, David Hildenbrand wrote:
>> A while ago I talked with Peter about an extended uffd (here: WP)
>> mechanism that would work on fds instead of the process address space.
> 
> As far as I can tell, uffd is a grotesque hack that exists to work around
> the poor choice to use anonymous memory instead of file-backed memory
> in kvm.  Every time I see somebody mention it, I feel pain.
> 

I might be missing something important, because KVM can deal with
file-back memory just fine and uffd is used heavily outside of hypervisors.

I'd love to learn how to handle what ordinary uffd (handle
missing/unpopulated pages) and uffd-wp (handle write access to pages)
can do with files instead. Because if something like that already
exists, it would be precisely what I am talking about.

Maybe mentioning uffd was a bad choice ;)

-- 
Thanks,

David / dhildenb

