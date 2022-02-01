Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1244A585C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiBAIQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:16:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230491AbiBAIQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643703374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iF9w/EWzbcab7CEp+886dB7LcQJEOM9pY9E+Ls1yiTc=;
        b=TV2v7tl1Zvt9iVoN6V4YOl+wiL5JKoZaHumc5lttzuhncCwRYf9ktyUhiJ83wX52MpqgPA
        B9Khprja1jKg9mZ3F9grJ5w3bh3mTvElv0b1ysL/KbzCgKY/fS+lXpCdFYYxYceF6ITXnI
        GUv5UguLbukFDr6LoCWa0um0wiBoHLI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-mxdZkSWGPBObDAurRi-dJQ-1; Tue, 01 Feb 2022 03:16:13 -0500
X-MC-Unique: mxdZkSWGPBObDAurRi-dJQ-1
Received: by mail-ed1-f72.google.com with SMTP id bc24-20020a056402205800b00407cf07b2e0so8312341edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=iF9w/EWzbcab7CEp+886dB7LcQJEOM9pY9E+Ls1yiTc=;
        b=drtax22yIievYpN1p2dUqvLaVmTQE5hJ2WdDd98vcL4LGlzW2eFyUk2GfAMGjapgd7
         ujK1lwIca/QH55KBSWavQGEs8W1fptkG6duFUVUgKOv2CvNkrprw8r7SmOn79Dm0GGLL
         JgmZYo7xseG+aQzSHvAta15qFXhwyZ/hG6843XkfVhiXMhQCs6ISPCBNhdEP+Egx2NIZ
         ZogBIEhZA3LMhl6eh/s42cS4BcqC6PVF6lpsdvmfKG48eGFNbm7RltZoxxyvQAXGfyMW
         HYGJ/wDcCEGJs/m46KoKK8jQiUEas5U3GImnALrJactF9RdQ9D4HlX69Ol+HvnrGPCbI
         hKoA==
X-Gm-Message-State: AOAM532EC7JNP0azmsgYXyO8vR7ur65kk4d+iHY0pC9FENlAYObiJba1
        igoI/m4Xh7VeZFXUsodgZc67iuS9N8kXRForxysaZ/jjJhUPqWMwrjYm6Q2UDbolDtkP/Y32gug
        wQ7DJTkLvOnQtboiZjRoP3pFu
X-Received: by 2002:aa7:db8f:: with SMTP id u15mr23878845edt.36.1643703372250;
        Tue, 01 Feb 2022 00:16:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwamLK6ay27bqiSrVmgRcJ7JB3jtltO7wdzb/R1xyMI58jT5fc1iRd1ruBPTJB8FcSJ0H18yA==
X-Received: by 2002:aa7:db8f:: with SMTP id u15mr23878827edt.36.1643703372010;
        Tue, 01 Feb 2022 00:16:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c711:ba00:67b6:a3ab:b0a8:9517? (p200300cbc711ba0067b6a3abb0a89517.dip0.t-ipconnect.de. [2003:cb:c711:ba00:67b6:a3ab:b0a8:9517])
        by smtp.gmail.com with ESMTPSA id t27sm14169757ejd.168.2022.02.01.00.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 00:16:11 -0800 (PST)
Message-ID: <a457b70a-004c-e49a-26d2-c207c28bda98@redhat.com>
Date:   Tue, 1 Feb 2022 09:16:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1] drivers/base/memory: add memory block to memory group
 after registration succeeded
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>
References: <20220128144540.153902-1-david@redhat.com>
 <20220131170123.42d7f46ecea0da1cb1579113@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220131170123.42d7f46ecea0da1cb1579113@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.22 02:01, Andrew Morton wrote:
> On Fri, 28 Jan 2022 15:45:40 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> If register_memory() fails, we freed the memory block but already added
>> the memory block to the group list, not good. Let's defer adding the
>> block to the memory group to after registering the memory block device.
>>
>> We do handle it properly during unregister_memory(), but that's not
>> called when the registration fails.
>>
> 
> I guess this has never been known to happen.  So I queued the fix for
> 5.18-rc1, cc:stable.

Triggering that registration error is fairly hard, usually we fail
memory hotplug because we fail to allocate the (largish) memmap. So I am
not aware that this BUG actually triggered.

-- 
Thanks,

David / dhildenb

