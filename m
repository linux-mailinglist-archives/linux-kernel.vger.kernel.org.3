Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4204A48F9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377168AbiAaOGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:06:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359088AbiAaOGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643638007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lq4puUkj4hgrag1BwbEA+M/NEvqmLEeOxbVsYJ+Z5vo=;
        b=NXaiQz2ogwQi2v+UsH3XJXPOsVktObvfOPO3K4v8pabgycMiayLkTFzpqXxnH23rvWIDay
        atVs1MI7kTiSNnDDwQ69la49yAK5Jx1SGtooePOmF/d6YdtKKypa/XDCpseRsoUqnxnOzc
        3nIlaY6lc2dXU3WePF5XXJOhZBRTOOc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-O5_NTByiOxiHJpcdU2q3ZA-1; Mon, 31 Jan 2022 09:06:46 -0500
X-MC-Unique: O5_NTByiOxiHJpcdU2q3ZA-1
Received: by mail-ed1-f72.google.com with SMTP id l16-20020aa7c3d0000000b004070ea10e7fso6949420edr.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 06:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=lq4puUkj4hgrag1BwbEA+M/NEvqmLEeOxbVsYJ+Z5vo=;
        b=MTkFCm6cKTupoZuqF6s8BFj5oRx1ev44u3wQ4MqMr9tuNFpHtx4VYjgmfhTtvG9M5d
         IL7v6SXbauGQUgvCZFb6lDxO26rMLksfFM/RWpLTjEyShICKU8cKusEgEl/NUiIcv5JN
         JXGC5/y74Oi82WHHEcJsvxciW3sp1EIGGJohF4b0tzJJ+SeoAiaU5ICmA/tLOdtmRJEh
         RPfKqpWJn8o4YzkyO7aN1Kmlmr27sBmtfzflF7Lpe96GPJMiJu8Pewz2ASGbpqP2VCsC
         guHx1948WQw/sbyx5AYOn33r+D3NWCzxptI4MSG7OUfKGnrzV+UssE3eaii1HfTeE7lx
         zNIA==
X-Gm-Message-State: AOAM531D9caPhOBN2odxFfYb3K7RTFgOePwdRhjeQsgNwSRVuviTr4NC
        P7Xr12jKGbvCQMXxaPHxvqzpJjzFVLX4U2JvQgKe+PQAgHKUZWj6ADbvxMo4V4OjtG2y7N/JwkM
        xfLYeRojDDnWHqZTXQQRuDFsJ
X-Received: by 2002:a17:906:6a19:: with SMTP id qw25mr17483340ejc.558.1643638005079;
        Mon, 31 Jan 2022 06:06:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAO4eS7yGV8BJ6dApQRUxgeb4fW4AamF/LYz6ovahRis752lzaJ3TJIm62SEUFaDMA+X5X2Q==
X-Received: by 2002:a17:906:6a19:: with SMTP id qw25mr17483320ejc.558.1643638004923;
        Mon, 31 Jan 2022 06:06:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:b200:f007:5a26:32e7:8ef5? (p200300cbc709b200f0075a2632e78ef5.dip0.t-ipconnect.de. [2003:cb:c709:b200:f007:5a26:32e7:8ef5])
        by smtp.gmail.com with ESMTPSA id p29sm17930429edi.11.2022.01.31.06.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 06:06:44 -0800 (PST)
Message-ID: <c668a7a2-35c1-dea7-440a-bffaf2868701@redhat.com>
Date:   Mon, 31 Jan 2022 15:06:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/4] mm/gup: remove unused pin_user_pages_locked()
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jan Kara <jack@suse.cz>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20220131051752.447699-1-jhubbard@nvidia.com>
 <20220131051752.447699-4-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220131051752.447699-4-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.01.22 06:17, John Hubbard wrote:
> This routine was used for a short while, but then the calling code was
> refactored and the only caller was removed.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

