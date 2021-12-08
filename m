Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4099946CF3B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245034AbhLHIm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:42:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240959AbhLHIm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638952736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G645m0btAwFcCTWX1rUo8pbQn2SjCg+rXpPM0KNcd2A=;
        b=CcF5qcA0SHMhifgr5PT0D1NFhvwzMjfMiLQHaJwAGC2RYRx2JZ4GMZjK4Ij1VLQogfcAyj
        BhvgoXrukCtXTHdueWGZjNvxJDdx0tq6QKXOagueU94H9ChASxdBgQzzd2ZJNHwHv9jE7H
        69C3RgKri/mDVqjjZZRRVmsJADhiGjg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-A86ZKkdbNC2ZGjyu2JDwMQ-1; Wed, 08 Dec 2021 03:38:55 -0500
X-MC-Unique: A86ZKkdbNC2ZGjyu2JDwMQ-1
Received: by mail-wm1-f72.google.com with SMTP id g81-20020a1c9d54000000b003330e488323so996756wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 00:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=G645m0btAwFcCTWX1rUo8pbQn2SjCg+rXpPM0KNcd2A=;
        b=UT4QB+UstKGNlettRapJS8QJMjM2kAWb8u9jJp5PG6Sg8r1msJuKtK96pxDBn4uO9z
         U89uuIYLlWD/rfT01z2c7jlW3Rmo8JiiNpKQx/7qq4hQ3BlFjxgtei/d+xBA8EYRS84E
         c7lElEIHHUqPvmizsZv56G2MXSXbqkOQhifaQ6jJ4SgsuE8B3o/cQQrzsxlATWo8X8be
         pOcNIgUUgBeE75JhBbfy8leRN8GEnN0RIQ2dD/jA6jbfksddO/AQ0yE6tN3+mE6O1cL9
         bQ2bJmj9yFwVGXquP029p2aY50ODxF2BAa2CB2WN+vbv3W3es3rFQ2wPYYdCcRkV5P/T
         DWTw==
X-Gm-Message-State: AOAM532UkRk0TPc/kHFhsYporE1i5yw7cxEzFMGNNIRCAx5ovrN+AXyZ
        ygonIaXCd6AM9jQjEWCThPdyC/Q3mVPJJGdjGFd7KPrIU7ea+dX9Oa3QjU+DFuzOa9zz5+d6Clv
        q3eBEn2iYTu0E5WCW1/b+Jmo6
X-Received: by 2002:a5d:4843:: with SMTP id n3mr55905080wrs.335.1638952734104;
        Wed, 08 Dec 2021 00:38:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8h3GpVBEghmbyHhF2c8p2hpDjA+y5sYdpp+Th4+TAlULBhYUkaCk8clV8RtI1801/TKzJVA==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr55905055wrs.335.1638952733897;
        Wed, 08 Dec 2021 00:38:53 -0800 (PST)
Received: from [192.168.3.132] (p5b0c62ba.dip0.t-ipconnect.de. [91.12.98.186])
        by smtp.gmail.com with ESMTPSA id a22sm2024634wme.19.2021.12.08.00.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 00:38:53 -0800 (PST)
Message-ID: <2c790c6c-22e4-687f-6ecd-368683d781a3@redhat.com>
Date:   Wed, 8 Dec 2021 09:38:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] mm: fix panic in __alloc_pages
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <Ya+EHUYgzo8GaCeq@dhcp22.suse.cz>
 <d01c20fe-86d2-1dc8-e56d-15c0da49afb3@redhat.com>
 <Ya+LbaD8mkvIdq+c@dhcp22.suse.cz> <Ya+Nq2fWrSgl79Bn@dhcp22.suse.cz>
 <2E174230-04F3-4798-86D5-1257859FFAD8@vmware.com>
 <21539fc8-15a8-1c8c-4a4f-8b85734d2a0e@redhat.com>
 <78E39A43-D094-4706-B4BD-18C0B18EB2C3@vmware.com>
 <f9786109-518f-38d4-0270-a3e87a13c4ef@redhat.com>
 <YbBo5uvV7wtgOYrj@dhcp22.suse.cz>
 <5a44c44a-141c-363d-c23e-558edc23b9b4@redhat.com>
 <YbBuHSkvd6fDdQ9d@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YbBuHSkvd6fDdQ9d@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> I think we'll soon might see setups (again, CXL is an example, but als
>> owhen providing a dynamic amount of performance differentiated memory
>> via virtio-mem) where this will most probably matter. With performance
>> differentiated memory we'll see a lot more nodes getting used in
>> general, and a lot more nodes eventually getting hotplugged.
> 
> There are certainly machines with many nodes. E.g. SLES kernels are
> build with CONFIG_NODES_SHIFT=10 which is a lot of potential nodes.
> And I have seen really large machines with many nodes but those usually
> come with a lot of memory and they do not tend to have non populated
> nodes AFAIR.

Right, and is about to change as nodes are getting used to represent
memory with differing performance characteristics/individual devices,
not the traditional "this is a socket" setup: we'll see more and more
small (virtual) machines with multiple nodes and eventually many
possible nodes.

-- 
Thanks,

David / dhildenb

