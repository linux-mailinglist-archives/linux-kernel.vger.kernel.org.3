Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84C476B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhLPIEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:04:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229676AbhLPIEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639641861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xwzuye7S0T3rwM3SGB9JNQpOpgQOfE/ay4CTJUX9JRc=;
        b=TgWmFmeuju9AEDnMqrku7h6LGkTg5TDiYURPx9DU1ULbygrkR80f76upYqkncriOlURj5V
        uY4HBU9fkBCTtr1SsMs58WP1I4wHPnLKGZ37s5xHsezF0rBPBnwqBoRk4wfxZIOq18eLse
        U7TRQKyYkWAZmidFjH1ZuqEl2/TZdlc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-J_a3_pzPNC6U1V0Ds_tDEg-1; Thu, 16 Dec 2021 03:04:20 -0500
X-MC-Unique: J_a3_pzPNC6U1V0Ds_tDEg-1
Received: by mail-wm1-f72.google.com with SMTP id l6-20020a05600c4f0600b0033321934a39so9953604wmq.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xwzuye7S0T3rwM3SGB9JNQpOpgQOfE/ay4CTJUX9JRc=;
        b=vA9DWtTBRCwPzwdvRaBRXHTrsn9x+jyq2XvTwqGFsLds/Ht/2a/92QG79h3dJAR5j/
         LXRcEB/qobIOliZB474AkT11dCGpEEwfDU24mkc644UInsTxosRvo8lR9br8dGw42oKH
         Cp1g/zkUs42wPeRUE4TFcDpVs4Nm/mVDaBy0bWiN2IYlV1CCz4Jnky5YPIxr2yKk9iBd
         SEKNJ+AgoV0tBHXBUa4QQEjtM1wp9I7w05xJFdeEkWhj2ymI7EwsSdstGV8qELDD6KBX
         kFIRCX0isem0+zZx15br3T3X9ghIy5yXl+3D5cODrWxcE9wsfkUihL+E/74YQWpauWwP
         Zxkw==
X-Gm-Message-State: AOAM531U1pJwSuCIZDlDOrnbjSLKCLmRYZwI/KTUVc9DO2BanW46H+KT
        QsgjylyV5efoSwpsi90qBKmyN0DyYodKkhwVN5AJrPFTEAAGvA6gLjXbgCJN8VLSowrXI4vz1vM
        HtzvL+1piy9obKNiK3+mjZSPb
X-Received: by 2002:a5d:4d91:: with SMTP id b17mr1634284wru.214.1639641858781;
        Thu, 16 Dec 2021 00:04:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwCNul3EgDYz4gN3NPHyWlIp5E3OiCQeHtcX7O0+0vAVS6aKibqQ2Z2F3z248ifzQPcq8W4A==
X-Received: by 2002:a5d:4d91:: with SMTP id b17mr1634255wru.214.1639641858525;
        Thu, 16 Dec 2021 00:04:18 -0800 (PST)
Received: from xz-m1.local ([64.64.123.12])
        by smtp.gmail.com with ESMTPSA id o5sm3912703wrx.83.2021.12.16.00.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 00:04:18 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:04:09 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v6 03/23] mm: Check against orig_pte for finish_fault()
Message-ID: <Ybry+cBqY71/Y3OT@xz-m1.local>
References: <20211115075522.73795-1-peterx@redhat.com>
 <1760244.MLhrlNdmRJ@nvdebian>
 <Ybrljg7nWppMpfMG@xz-m1.local>
 <2472202.YjDCsHb11M@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2472202.YjDCsHb11M@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 06:45:07PM +1100, Alistair Popple wrote:
> On Thursday, 16 December 2021 6:06:54 PM AEDT Peter Xu wrote:
> 
> [...]
> 
> > I wondered how it could have worked - I thought e.g. pte_alloc_one() will
> > always return a pgtable page will all zero-filled, whose allocation should
> > require __GFP_ZERO anyway.  But then I quickly noticed that pte_alloc_one() is
> > per-arch too..  That explains, because per-arch can re-initialize the default
> > pte values.
> 
> Yes, I have wondered the same things before as well. It's all a little bit of
> fun some of this stuff.
> 
> > I thought this patch can greatly simplify things but I overlooked the
> > pte_none() check you mentioned.  So it seems I have no good choice but add that
> > flag back.
> > 
> > There's another alternative is we do pte_clear() on vmf->orig_pte as the new
> > way to initialize it.  I believe it should work too for s390 and xtensa.
> > 
> > Any preference?
> 
> I prefer the later approach (initialising to pte_clear) as it seems cleaner,
> and pte_none(pte_clear()) is true for every architecture afaik.

Will do.

-- 
Peter Xu

