Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB8C49E25A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbiA0M1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236262AbiA0M1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643286456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kc5fEgzFmRUH5x4Pq9WjYnO9vzdgqgqUjKf+MBTzNg4=;
        b=MeSAzVxESc1Vpgu/QRugj+ov7wUa8WuUT+SW3U73mXczhXzI+7S0+FlExnqA80PT7HIMmC
        33IOjjnfNr7xt6Ene1ZSbf960IPLMeirm0i55fN/bX7M5LeOMjTjPlcKWKVkG/UxNgcSJV
        lKTknSHocI3A62anXuvyJxRYmowjCYg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-1cRPy1ZPOrGerldBmVpv8A-1; Thu, 27 Jan 2022 07:27:35 -0500
X-MC-Unique: 1cRPy1ZPOrGerldBmVpv8A-1
Received: by mail-wm1-f69.google.com with SMTP id d184-20020a1c1dc1000000b00350769d4bcfso592536wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=kc5fEgzFmRUH5x4Pq9WjYnO9vzdgqgqUjKf+MBTzNg4=;
        b=QZSeP38x6/azzQZhvUw+WVvyAAfb/OrJOYMDie2TUaDzTaPwqwdUbeTIVR9Pt+Tcox
         k2QFbU3Xvobvby41b7l00tNytz0Cp9c72vXG/IGN/f9dr+kdFjont5LDniMWWt7Ah1GQ
         icoiEEfXTdLAYRM70K+SmkKyBhUF9H4lzppNx4OvIbCbmHbqaCM6hpIUwsZlwSh+kbN3
         6e53M8jSU6WeFW19qPJoPFp+OFH3eIPKt+tbQoin6JXvDUjWsoOJrojz5h7USDGObeen
         VkPv8DwLtMcyKhvsJzQ5OwreJPWi+p3tVPXPJBnSf0Pfw/mHDo8aWk1nd9Enxp1gjgW7
         w1Lw==
X-Gm-Message-State: AOAM5338afHPkglR9cadyMW3op63/Isbh1sopXzXAQBV4pJ1pObFksOc
        F5K7upjCHrEXPPKVegwss399Xs0s1KuHXInlbEWHP88Ha/2F91aXyx9127PR6Pi5REdOXSaFr7v
        L5Mp+j6iJmwj9+QIonnjo0337
X-Received: by 2002:a05:600c:4ecb:: with SMTP id g11mr2918830wmq.167.1643286454380;
        Thu, 27 Jan 2022 04:27:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxJBy8vY/Qb7x1cM7bsscDUV+FZbp9Mc2KtKi0RdlxsclM+bp6sWEiznidXy2L58G/e/pnYg==
X-Received: by 2002:a05:600c:4ecb:: with SMTP id g11mr2918812wmq.167.1643286454160;
        Thu, 27 Jan 2022 04:27:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:8300:4812:9d4f:6cd8:7f47? (p200300cbc70d830048129d4f6cd87f47.dip0.t-ipconnect.de. [2003:cb:c70d:8300:4812:9d4f:6cd8:7f47])
        by smtp.gmail.com with ESMTPSA id n2sm2317685wrw.63.2022.01.27.04.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 04:27:33 -0800 (PST)
Message-ID: <ca1484d1-6afa-83ca-08f9-9c9247585323@redhat.com>
Date:   Thu, 27 Jan 2022 13:27:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/6] mm, memory_hotplug: make arch_alloc_nodedata
 independent on CONFIG_MEMORY_HOTPLUG
Content-Language: en-US
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>,
        Michal Hocko <mhocko@suse.com>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-2-mhocko@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220127085305.20890-2-mhocko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.22 09:53, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> This is a preparatory patch and it doesn't introduce any functional
> change. It merely pulls out arch_alloc_nodedata (and co) outside of
> CONFIG_MEMORY_HOTPLUG because the following patch will need to call this
> from the generic MM code.
> 

I would have hoped we'd have dropped support for ia64 by now, to get rid
of this special case ...

> Acked-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  arch/ia64/mm/discontig.c       |   2 -
>  include/linux/memory_hotplug.h | 119 ++++++++++++++++-----------------
>  2 files changed, 59 insertions(+), 62 deletions(-)

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

