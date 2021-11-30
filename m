Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5C2463811
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243673AbhK3O55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:57:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243332AbhK3OzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638283901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9Lx9TJJBXg2rHTFjd4QMdkDXGIXIvnZzimFPOne8Kw=;
        b=OfgeVC86I9wg6E/yhCkxQwpxkj7XboZcSI+nIcwqiDa3HSJOeHA36/xN6dhYviG76y79Wx
        XyB4N9FDmVBay9a+aDLj8KlACcExY1iqcWBjbaggSanx1PUcn3dcWx26NeLkmkp5PhPC0S
        Y00BV1AWBZ7FAn8GkXz1TZmUmmRaG44=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-gaKLVd33N7OWwTV3lV1mEg-1; Tue, 30 Nov 2021 09:51:39 -0500
X-MC-Unique: gaKLVd33N7OWwTV3lV1mEg-1
Received: by mail-wr1-f70.google.com with SMTP id v17-20020adfedd1000000b0017c5e737b02so3659729wro.18
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=E9Lx9TJJBXg2rHTFjd4QMdkDXGIXIvnZzimFPOne8Kw=;
        b=gCu0PZi/JZPIuvyHdEssd+o9YAq6zkdCZ48UE3NjvjWdbWT4sV6airr7esD7vfivvC
         VFNUmOT+AwOttKxKgKvTOKpQ5JcbjMLCMtwoGUqP+3aXxejqcqC5OtnN9qLtS7jDPlUJ
         6L//6aNGNFK6cM0I5O6d9fG2CyktT0w87tISHVdAx7C7Mh6GA+Il03zJmh4ddFZaciBA
         Qnt5E1aOxUdg0s7/VpgRVUFqLjDeJx9MqHVczTmunjb+eMBAPlqQ9PcGUaRoewwRx/sn
         CTP7+C3QmfpNIfwJNNm+T8uYpid7kv6tB1fnEQxt9dB+xVGLLzuwF0cC6lIbICnwvIKb
         ET4w==
X-Gm-Message-State: AOAM532JMBJEXNkB58ApVjEHOEBHHSziHo3KChAgmrfHJKuhi0pUe79x
        ZxtzEV+R0L4EbbZCr9DYMcHqzJszCCdWVwMpa/HWHQ5Cj1RBeGI5fB2LLC+BZyA2ATYfJN1kbeC
        59Wlr0oAzId7BgqG6x5ECSY+W
X-Received: by 2002:a05:600c:b43:: with SMTP id k3mr5511845wmr.159.1638283898584;
        Tue, 30 Nov 2021 06:51:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKgqfybofwM4ev+7p0oQTgMUxgl8EpmgO9OSaeiHHO8/ElEuvqxrQdaFyWneC5jrZs7Om0zw==
X-Received: by 2002:a05:600c:b43:: with SMTP id k3mr5511825wmr.159.1638283898421;
        Tue, 30 Nov 2021 06:51:38 -0800 (PST)
Received: from [192.168.3.132] (p5b0c68ec.dip0.t-ipconnect.de. [91.12.104.236])
        by smtp.gmail.com with ESMTPSA id f15sm3295403wmg.30.2021.11.30.06.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 06:51:37 -0800 (PST)
Message-ID: <18472b72-c64f-59b5-f767-d965f0264ef0@redhat.com>
Date:   Tue, 30 Nov 2021 15:51:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 0/2] virtio-mem: prepare for granularity smaller than
 MAX_ORDER - 1
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Gavin Shan <gshan@redhat.com>, Hui Zhu <teawater@gmail.com>,
        Eric Ren <renzhengeek@gmail.com>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
References: <20211126134209.17332-1-david@redhat.com>
 <F0D31D41-7843-4313-8264-E1C97979471B@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <F0D31D41-7843-4313-8264-E1C97979471B@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.21 17:47, Zi Yan wrote:
> On 26 Nov 2021, at 8:42, David Hildenbrand wrote:
> 
>> The virtio-mem driver currently supports logical hot(un)plug in
>> MAX_ORDER - 1 granularity (4MiB on x86-64) or bigger. We want to support
>> pageblock granularity (2MiB on x86-64), to make hot(un)plug even more
>> flexible, and to improve hotunplug when using ZONE_NORMAL.
>>
>> With pageblock granularity, we then have a granularity comparable to
>> hugepage ballooning. Further, there are ideas to increase MAX_ORDER, so
>> we really want to decouple it from MAX_ORDER.
>>
>> While ZONE_MOVABLE should mostly work already, alloc_contig_range() still
>> needs work to be able to properly handle pageblock granularity on
>> ZONE_NORMAL. This support is in the works [1], so let's prepare
>> virtio-mem for supporting smaller granularity than MAX_ORDER - 1.
>>
>> Tested with ZONE_MOVABLE after removing the MAX_ORDER - 1 granularity
>> limitation in virtio-mem, and using different device block sizes (2MiB,
>> 4MiB, 8MiB).
>>
>> [1] https://lkml.kernel.org/r/20211115193725.737539-1-zi.yan@sent.com
> 
> The patchset looks good to me. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks a lot!

-- 
Thanks,

David / dhildenb

