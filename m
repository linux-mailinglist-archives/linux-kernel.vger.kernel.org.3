Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E650B48EAEA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241390AbiANNig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:38:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230472AbiANNie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642167513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbLWpbs04Fbr52VNRcUjKYlBXFjrwmcMdjglRxFIjmA=;
        b=IIvHHkH4DDbSJYx3DZcZxj+vKTflV1xhkV/lcVuxZhQIbBKqb4pZKtxdzA4OJCtQLPJqR7
        sJ+YHELayk4+J1jZ4XmNrW6jpZHmcDHpNdcmRQ208V7MA411nqk3smDNCxst+Tw1bGItg7
        a0gm30Z76kJo09L1Tva3WkwXx+VL/f4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-7vjjeoUKMhOC11O146_8wA-1; Fri, 14 Jan 2022 08:38:32 -0500
X-MC-Unique: 7vjjeoUKMhOC11O146_8wA-1
Received: by mail-ed1-f69.google.com with SMTP id z8-20020a056402274800b003f8580bfb99so8386338edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=NbLWpbs04Fbr52VNRcUjKYlBXFjrwmcMdjglRxFIjmA=;
        b=o5p8xTbfP35eHuS/FjMLrx3Hlkp09PQSSDvsv7LeJP3p2CBfmXUB/EicArAmEM3sDp
         5bc8e27OVPPz0JRplduRGt1GTi7uh9HnVJGS6QsReRPvzwqPFF0AzuqGrq5r/K9yz3tP
         3TwBiq1YIGUJAP1pbP0ab1D+RjMKJ5GES5ZF9Q5uiDkHNaToSpUXj8+GWyHAtO9BRBqM
         rs07v0CYLAj5Ikq4r6d9tkaWO5B/fRye8ohVLVy41KW1Zo63LaQC+DT1nHK0eqSF5bu9
         7+wntcxM1bfhNF7mfaoFxKa3ypgpQwu7V1b3BB+0CfOccZl5veLYzQ24XcOOvRFUT5Vw
         jJsw==
X-Gm-Message-State: AOAM532W/pzZgKFwTkef+/yuMu99HNrE/3KonWYBrrjJYvmo+YBXW7iU
        x+ApxEerAlD/Le+w5O+E71CpgsW7cfSiqS5RbKdlM6wo3ogDW2A2CzOfCCOcN4CYgu3wMqXCxeC
        8ys39Aj4hhRflU0QSMze7H83k
X-Received: by 2002:a05:6402:22f5:: with SMTP id dn21mr8277776edb.195.1642167511645;
        Fri, 14 Jan 2022 05:38:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHvYz3VQ9C1aagG3+wcF6jvkOYHX0vhK+bpyMkPVNgdDNTqGPKVyjbaru5jr4nQAEJhmT6JQ==
X-Received: by 2002:a05:6402:22f5:: with SMTP id dn21mr8277761edb.195.1642167511469;
        Fri, 14 Jan 2022 05:38:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c701:9d00:ff87:1c9b:108a:9702? (p200300cbc7019d00ff871c9b108a9702.dip0.t-ipconnect.de. [2003:cb:c701:9d00:ff87:1c9b:108a:9702])
        by smtp.gmail.com with ESMTPSA id c13sm1900839ejj.144.2022.01.14.05.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 05:38:31 -0800 (PST)
Message-ID: <ead90b32-da2b-4d66-f103-6fbec0937e93@redhat.com>
Date:   Fri, 14 Jan 2022 14:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v3 5/8] mm: page_isolation: check specified range for
 unmovable pages during isolation.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-6-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220105214756.91065-6-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.22 22:47, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Enable set_migratetype_isolate() to check specified sub-range for
> unmovable pages during isolation. Page isolation is done
> at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not all
> pages within that granularity are intended to be isolated. For example,
> alloc_contig_range(), which uses page isolation, allows ranges without
> alignment. This commit makes unmovable page check only look for
> interesting pages, so that page isolation can succeed for any
> non-overlapping ranges.

Are you handling if we start checking in the middle of a compound page
and actually have to lookup the head to figure out if movable or not?

> 
> has_unmovable_pages() is moved to mm/page_isolation.c since it is only
> used by page isolation.

Please move that into a separate patch upfront, makes this patch much
easier to review.

-- 
Thanks,

David / dhildenb

