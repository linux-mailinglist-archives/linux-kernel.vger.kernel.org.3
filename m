Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AD446941C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbhLFKt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:49:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238305AbhLFKt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638787558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LtzfPpymSCQWXehN2vtnTLU+MArjUhcxuJehlXC6fbA=;
        b=Mwi+5wcl8wVkLCeFXph6Fc4M98TvEGLfq9xJ7JEQ6RlV+eO7Czz+8TuAqtoksj9IpO3oLa
        dkz5bO2rD/N2TTR/E/2E60UKUcvA4S/VkA8MPBSy5dP6xvodxmYXG4n5LqFZ/euX02T2+9
        V31NOQSTc5zCb3721rlj9XoXzCSvSbg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-DJ8ZNRG8Nxil1mOLmoIGnQ-1; Mon, 06 Dec 2021 05:45:57 -0500
X-MC-Unique: DJ8ZNRG8Nxil1mOLmoIGnQ-1
Received: by mail-wr1-f72.google.com with SMTP id h13-20020adfa4cd000000b001883fd029e8so1896022wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 02:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LtzfPpymSCQWXehN2vtnTLU+MArjUhcxuJehlXC6fbA=;
        b=bFgydPO3kSNi5YPpUIcnGjBTRPgPJZx5Qi77VhD/GmTd+ar4hhoDkCjo6EwIWGiG28
         IE4P+FqtKw6C2gmjTuQ2b7bYp5dB3+cp6uFvTbDo7tKeZAPhVeBh1T1fAyjcIjpmd8Fk
         6I0QGiEDzDCNY7LeYFq9vKE7VRUKoUK3T7XcaM3uDQiU0Dx6sLl5JkroFf396wwrs7IO
         GAegmx+XJOk1xrKnm4rXyPJczApLX/tb8sfgVsXyqGnPzQ5b0OwuspNV1+04NiwVpl+j
         7XmtEe2xbC8AlVoNUH3cqzJLwaikWEZemgnPFniNP8GeMhyTaKH9xpKt/4GTwX0U3fa8
         uH9g==
X-Gm-Message-State: AOAM532UJTgenku7JPKVA4OVLybH2HuGSZ7/2FJjKhItZXHgxzZCII6t
        KRtqOXNs/biHECZoh2ogc1ULaXfv8OOTptazCbp0/CW/FbAA0LILDUjKFp4HrSGdOmZMnpKg9Kx
        tOlc36huE4sVZxgR7D2A5YLgc
X-Received: by 2002:a05:6000:154b:: with SMTP id 11mr42522314wry.394.1638787556354;
        Mon, 06 Dec 2021 02:45:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyeXwVfpMNW8O5ouM93loc/taBC/yCmnBTDM6EtSSPMu493y3sUM/DepN1wokzVCSG08yKVkg==
X-Received: by 2002:a05:6000:154b:: with SMTP id 11mr42522291wry.394.1638787556156;
        Mon, 06 Dec 2021 02:45:56 -0800 (PST)
Received: from [192.168.3.132] (p5b0c62c6.dip0.t-ipconnect.de. [91.12.98.198])
        by smtp.gmail.com with ESMTPSA id l15sm10591158wme.47.2021.12.06.02.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 02:45:55 -0800 (PST)
Message-ID: <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
Date:   Mon, 6 Dec 2021 11:45:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com> <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This doesn't seen complete. Slab shrinkers are used in the reclaim
> context. Previously offline nodes could be onlined later and this would
> lead to NULL ptr because there is no hook to allocate new shrinker
> infos. This would be also really impractical because this would have to
> update all existing memcgs...

Instead of going through the trouble of updating...

...  maybe just keep for_each_node() and check if the target node is
offline. If it's offline, just allocate from the first online node.
After all, we're not using __GFP_THISNODE, so there are no guarantees
either way ...

-- 
Thanks,

David / dhildenb

