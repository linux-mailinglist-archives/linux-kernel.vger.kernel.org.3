Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D88498816
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241809AbiAXSRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:17:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235979AbiAXSRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643048228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXCp/3WRPdbQGrhdFuzXkJTii1DEyN3+UMPeAGL1KzA=;
        b=STGg+4NYmV8Pa8jSetbMW7HuS2oC4oIr6MyiNPoi63BrZELm8PMOXih7CTajbxZjWvQt3M
        er/oXf1w0ylc/y+Dga3AqZMrMXvzkLM8+T5URSn/kOS/vb24QVEujF1sStStvCtNmrebR2
        CNsxclbEp8SVBBKVOK2WWmuBuX/Dq6A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-KPcmZWE6PMSlbBT_52T4Sw-1; Mon, 24 Jan 2022 13:17:06 -0500
X-MC-Unique: KPcmZWE6PMSlbBT_52T4Sw-1
Received: by mail-wm1-f70.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so15380623wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=cXCp/3WRPdbQGrhdFuzXkJTii1DEyN3+UMPeAGL1KzA=;
        b=gZYCelj7SYnN+vZ3cBNgM/AEyYpxuQmGIEJJ/I3BhbC4hv9ktUx23a0D3CysQ2dkg6
         ZEdvMV1uXU0EvfbHS15LX6N0E0kRZfJK+cydLUGMTCdMoSKzeL7Iwy3VbiuPqFadTNbW
         5wLjRLDsE1mZ3v2CGwST3D5EzXGO5fCVgMmKgN72x2YjWNnI0nlQGdr6gQlI1p+un/Vr
         JjI4qpTOo7MB9GVVkWnOEmwrYPzumbdHhb8okvwghyUyd2AOalIiu+SMOh6puWWVX0Z2
         QRtDMKOaiJuOADYtQllFDyvlaMvFpQCykCWcauR23fyXEq/69h5CJyP+pR3NhGHGdgOF
         cNYQ==
X-Gm-Message-State: AOAM530Ard/DGTHHHT++VDXnUOQvEONz2Ny/rBZyz0L84dIjoyFCSDgg
        8ob2VvwzOzlzD/lgHljJEz/CvfNpdnsfsngZTPR/Cw+m17RDbRUoWK/A09RNPqkAC9Fpa2HYzVc
        g+kfNBQlkod+n74Kn+FmhYp23
X-Received: by 2002:a5d:62cb:: with SMTP id o11mr9848754wrv.62.1643048225632;
        Mon, 24 Jan 2022 10:17:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFwCMIj36ND3f3CCu8RXmMSlBJWyR1XuYwbYGBwkLytFBepvBIAjw5RJdLWqMBIr8e0Ks1kg==
X-Received: by 2002:a5d:62cb:: with SMTP id o11mr9848739wrv.62.1643048225375;
        Mon, 24 Jan 2022 10:17:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:cb00:cd6b:7964:cc7d:b0e6? (p200300cbc707cb00cd6b7964cc7db0e6.dip0.t-ipconnect.de. [2003:cb:c707:cb00:cd6b:7964:cc7d:b0e6])
        by smtp.gmail.com with ESMTPSA id i3sm36623wmd.30.2022.01.24.10.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 10:17:04 -0800 (PST)
Message-ID: <5f81c8a3-a07a-5651-b0d6-5082c5677e3d@redhat.com>
Date:   Mon, 24 Jan 2022 19:17:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm: page_alloc: avoid merging non-fallbackable pageblocks
 with others.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, Mel Gorman <mgorman@techsingularity.net>,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220124175957.1261961-1-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220124175957.1261961-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.22 18:59, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> This is done in addition to MIGRATE_ISOLATE pageblock merge avoidance.
> It prepares for the upcoming removal of the MAX_ORDER-1 alignment
> requirement for CMA and alloc_contig_range().
> 
> MIGRARTE_HIGHATOMIC should not merge with other migratetypes like
> MIGRATE_ISOLATE and MIGRARTE_CMA[1], so this commit prevents that too.
> 
> Remove MIGRARTE_CMA and MIGRATE_ISOLATE from fallbacks list, since they
> are never used.
> 
> [1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.net/
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

