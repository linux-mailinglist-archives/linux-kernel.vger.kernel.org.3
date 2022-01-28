Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9738D49F5AF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347422AbiA1Ix3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347361AbiA1Ix1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643360006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ui+9um5xfQ0oHtLsJggPNkOjXF3dvpzwJbYCtfSP3w=;
        b=MJzLXeRBtlwg1B/i9P7pkd9h0RvB1/va0Rs2qXdlZfn+c6pWOwoawqU5yTDBf7Q7TFTyJv
        yvS0zLKzHV6lHhSBbYNIfd3WcJ7by/+qkzXKmlwyDIIXXq4yS+Z+YYD9vjhZB8FAMqWzBk
        tgwmr0pTZEogCBYbd/L9yjl1GXM7pEI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-f4ql-72lNMu1srBNnjSGAw-1; Fri, 28 Jan 2022 03:53:24 -0500
X-MC-Unique: f4ql-72lNMu1srBNnjSGAw-1
Received: by mail-pg1-f200.google.com with SMTP id r9-20020a6560c9000000b00343fa9529e5so3033229pgv.18
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:53:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ui+9um5xfQ0oHtLsJggPNkOjXF3dvpzwJbYCtfSP3w=;
        b=pti/71XRw8CcI4wYseJ3yQBaGtFHbTrgCSLkU3guswlDKB6xChABT+jZFjyTfW5UKs
         6Uj870Z3yZ9WpOV/PqdVbnKY+0IfmQ3K0R9OrXIgvwYhzNTqxoT36zVbGEy98tlDJTDK
         yWofWcq6+fXYna3IrFCwRTe5/4u1sF8xJlZvMhaaX5QqZFO24RW3qDDG6Plj8MKcDVBC
         p2ObX02sNU0oYPIYQCb6Zi6BD62wC66vkvHhSwPl9ipCMefr253hcmytN4kyckwIUwxR
         KsYbhau8v4aTd+iBvoJu9vjcj1Us7xTxaLZEZsvue4o5G36ApXQfZaHzy6mVGsoRPW8E
         vfRQ==
X-Gm-Message-State: AOAM530WFpvu2dUDbMfWDDgIixjKY4z1lNBRvKFQq9LCRxEZfOSVCisH
        njFjCRb95yJ6sEDEUsZVcj59WYiSpwdPUZX19h7vdXKp63+YbbehxOo+eq3WchgEVDCK2SqjwAb
        rS3psMCZADIIRiqYxTD1OJvrb
X-Received: by 2002:a63:d503:: with SMTP id c3mr5901441pgg.159.1643360002957;
        Fri, 28 Jan 2022 00:53:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxu2JzxEwlkerHoOsLf2Vu4nsUK8VZ/RXYifDboeZnYi1KRcw8RePI89Nq5PXGEO9KbiLZ2rg==
X-Received: by 2002:a63:d503:: with SMTP id c3mr5901415pgg.159.1643360002581;
        Fri, 28 Jan 2022 00:53:22 -0800 (PST)
Received: from xz-m1.local ([94.177.118.75])
        by smtp.gmail.com with ESMTPSA id bf23sm1651107pjb.52.2022.01.28.00.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 00:53:22 -0800 (PST)
Date:   Fri, 28 Jan 2022 16:53:15 +0800
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 2/4] mm: Rename zap_skip_check_mapping() to
 should_zap_page()
Message-ID: <YfOu+4ugmx39KWPF@xz-m1.local>
References: <20220128045412.18695-1-peterx@redhat.com>
 <20220128045412.18695-3-peterx@redhat.com>
 <eb415c6d-8ae3-1fa4-9c36-efe4231fd8ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb415c6d-8ae3-1fa4-9c36-efe4231fd8ad@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 09:16:07AM +0100, David Hildenbrand wrote:
> On 28.01.22 05:54, Peter Xu wrote:
> > The previous name is against the natural way people think.  Invert the meaning
> > and also the return value.  No functional change intended.
> > 
> > Suggested-by: Hugh Dickins <hughd@google.com>
> 
> Could have sworn it was me :P

Yeah it's possible. :)

I'll add both of you in the next version if there is.

> 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks,

-- 
Peter Xu

