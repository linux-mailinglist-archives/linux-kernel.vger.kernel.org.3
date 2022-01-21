Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6449587D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 04:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiAUDLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 22:11:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232495AbiAUDLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 22:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642734714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OkumvMwJLc9ntXGBArQpKYeUdQGjlXx/6VBxX3jutYo=;
        b=C1x0T2SQtQy+wu8UFR5K7yQ9EIcrJW2pSwzMXz3gxZpeGcSYSNToI/VR+OhixG4LVtsoOH
        +9o2GDlAeV280uX3Ft0Kn7B90m7mE9KkciMCEHOtTFCsQrHUO2Ar1B2bNMxzu3DoloetXT
        wNsWDask0DdISq+7l37eZ1wnl+bmKEc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-vxaC2xUbOg6N7Mr73ND-Tg-1; Thu, 20 Jan 2022 22:11:52 -0500
X-MC-Unique: vxaC2xUbOg6N7Mr73ND-Tg-1
Received: by mail-pf1-f198.google.com with SMTP id u6-20020a056a00098600b004c603957575so2979543pfg.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 19:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OkumvMwJLc9ntXGBArQpKYeUdQGjlXx/6VBxX3jutYo=;
        b=RfZLq4uSi5+HbCfcwugbtSHECXe8uujGdBQVhirkz1g0S9YKkfGsh85octnWad1TnG
         4LUS0MZh5dMMDUOE7DuW9Nhn9/JF5CORVdUf3mThX1D6QO+oqRNDVvdpuE1o/l98SCC4
         kZIAmBzy1y9o6Dp0VFghGFZGp48YPTRvsRAykGbpUZ/q7JuwkhQufJcQti0sBJgxLZi/
         5Gk13A/CW3fOcu4ZVftCBqHA3gQa4GAomkK621q3iR/lcTtreUURrxOs75+7yDavhkNQ
         mP7uHZu3WwGwY/js/w423J1ddh8ZCt3ozEbHSzR+wAPjPhcn1lGHqfrwoc3VwkxfJ0h2
         ko/g==
X-Gm-Message-State: AOAM530YC7xaHxFjxed1JmXrHedFHi23KVZwTzBwYkGxChgrUUoCIReL
        i5nHgZox+3DMLJmThoURTsfxPQXIIAO7ZVqgpGpD56a76Wj69UslmNfaLwUbKHR7gitJ+6tt/FA
        gaTH1QMoXWyFiDgR1aZsfW715
X-Received: by 2002:a63:83c1:: with SMTP id h184mr1463445pge.325.1642734711554;
        Thu, 20 Jan 2022 19:11:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZU2m8S9bDzSKL6be7T2AZvadR6Ba9axEaxLP5tgbOZuA4YXVrxj+0/ilH0RiVL5y/ZarW8A==
X-Received: by 2002:a63:83c1:: with SMTP id h184mr1463433pge.325.1642734711273;
        Thu, 20 Jan 2022 19:11:51 -0800 (PST)
Received: from xz-m1.local ([94.177.118.81])
        by smtp.gmail.com with ESMTPSA id c26sm3280650pgb.53.2022.01.20.19.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 19:11:50 -0800 (PST)
Date:   Fri, 21 Jan 2022 11:11:42 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details
 specified
Message-ID: <YeokbrpCdAGAYHEl@xz-m1.local>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-2-peterx@redhat.com>
 <9937aaa-d9ab-2839-b0b7-691d85c9141@google.com>
 <Yd7VEXI+/Lu8MVOo@xz-m1.local>
 <Yd7W6ndSPkXQjurY@xz-m1.local>
 <391aa58d-ce84-9d4-d68d-d98a9c533255@google.com>
 <Yek6PaW8fAXY4Bft@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yek6PaW8fAXY4Bft@xz-m1.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 06:32:29PM +0800, Peter Xu wrote:
> > Except that here we have no page to check, so it looks like you'll
> > have to change should_zap_page() to deal with this case too, or just
> > check details->check_mapping directly.
> 
> Yeah I prefer this, as we don't have the page* pointer anyway.
> 
> > Which raises the question again
> > of why I did not just use a boolean flag there originally: aah, I think
> > I've found why.  In those days there was a horrible "optimization", for
> > better performance on some benchmark I guess, which when you read from
> > /dev/zero into a private mapping, would map the zero page there (look
> > up read_zero_pagealigned() and zeromap_page_range() if you dare).  So
> > there was another category of page to be skipped along with the anon
> > COWs, and I didn't want multiple tests in the zap loop, so checking
> > check_mapping against page->mapping did both.  I think nowadays you
> > could do it by checking for PageAnon page (or genuine swap entry)
> > instead.
> 
> It must be PageAnon already, isn't it?

I think I see what you meant now..

I assume the special case is gone, how about I switch zap_mappings back into
a boolean altogether in this patchset?  Thanks,

-- 
Peter Xu

