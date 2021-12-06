Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BF0469811
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhLFOLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:11:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235350AbhLFOLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638799694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=plAKcY3zE9AG7NARrXkcDvzfn8zhxmcQdnXCPw2jA+o=;
        b=ASs+ZKfZqBoxKlOC2MXuo0tGakL2JJ2ssjwfriwgNyKBxXcuKb78a9qA3lUDdy6Fm6WB2T
        9/Hu+SPyZa/QoSocj+DP9O1bts2RLKWGXhlKycSehNLbzrv2j/Mcndf3VTfywrgt7yqKFu
        vD85l53cIWmtcKTM2VAj9TegjdbYBJs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-O7wGJaRBPLCm-l4ZBdWW2Q-1; Mon, 06 Dec 2021 09:08:13 -0500
X-MC-Unique: O7wGJaRBPLCm-l4ZBdWW2Q-1
Received: by mail-wr1-f69.google.com with SMTP id h13-20020adfa4cd000000b001883fd029e8so2054482wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 06:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=plAKcY3zE9AG7NARrXkcDvzfn8zhxmcQdnXCPw2jA+o=;
        b=2a4XKqcUqB3Q21eKm3RyCdqUIIZHk/EJxtyVenHRedg2Bma1ThxZLvhLDXEIfqREef
         PSUMhKMmBov6RglGnaXnxAxKn8/BYVy6Xm91xV+eWN+Su25dt01KZb3YURhkKBfjru3L
         dnllkTCsnccHa+T0VQ5NUrocZWCYPzJlGrG/F+IIMAfHlrixTZ6dRRxFqVtempZclbth
         dKah3EbiXLujCEpIgM7AY2mpYQam/we50s+ijvFker1o+47t5+2kVJqAYuxG2xUxX7hX
         ckyxlxIrUMykyDUb9fF1RwNJgM8HAjFb0ynvC4Uhp/vskhzUVJUMmdGXHkqaJpKhKo7l
         cOlw==
X-Gm-Message-State: AOAM532toV1VglQ843a9DvV80bnk0U7xJ1KT3x9TCOfO/JzRioR3HhBX
        A/2QSK0b9vkgv5FGvNlJy7Yz1g+OPiTaHlSeDuqaMHt0acuz1GDmdmHSR1K8+sP5OaZoBkDiv9W
        gKUZUa1RTQTqh5eBDeqEtpxX3
X-Received: by 2002:a05:6000:181:: with SMTP id p1mr44057755wrx.292.1638799691704;
        Mon, 06 Dec 2021 06:08:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyps9N0YXTf13xG7dKmWLRLJ73KOm8Adx63eP8b3GYpmvmwSHfl/H4wC04hc8W3i9jm3uMhVg==
X-Received: by 2002:a05:6000:181:: with SMTP id p1mr44057727wrx.292.1638799691504;
        Mon, 06 Dec 2021 06:08:11 -0800 (PST)
Received: from [192.168.3.132] (p5b0c62c6.dip0.t-ipconnect.de. [91.12.98.198])
        by smtp.gmail.com with ESMTPSA id v15sm11948277wro.35.2021.12.06.06.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 06:08:10 -0800 (PST)
Message-ID: <d4f281e6-1999-a3de-b879-c6ca6a25ae67@redhat.com>
Date:   Mon, 6 Dec 2021 15:08:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com> <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <Ya3r3C/OpnK7OBPt@dhcp22.suse.cz>
 <840cb3d0-61fe-b6cb-9918-69146ba06cf7@redhat.com>
 <Ya3yZWkj2wGRWDMz@dhcp22.suse.cz>
 <51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com>
 <Ya4K0+XCmv3NBmwQ@dhcp22.suse.cz>
 <05157de4-e5df-11fc-fc46-8a9f79d0ddb4@redhat.com>
 <Ya4Y07Iu2ygj5zwZ@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Ya4Y07Iu2ygj5zwZ@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> But there might be more missing. Onlining a new zone will get more
>> expensive in setups with a lot of possible nodes (x86-64 shouldn't
>> really be an issue in that regard).
> 
> Honestly, I am not really concerned by platforms with too many nodes
> without any memory. If they want to shoot their feet then that's their
> choice. We can optimize for those if they ever prove to be standar.
>  
>> If we want stable backports, we'll want something simple upfront.
> 
> For stable backports I would be fine by doing your NODE_DATA check in
> the allocator. In upstream I think we should be aiming for a more robust
> solution that is also easier to maintain further down the line. Even if
> that is an investment at this momemnt because the initialization code is
> a mess.
> 

Agreed. I would be curious *why* we decided to dynamically allocate the
pgdat. is this just a historical coincidence or was there real reason to
not allocate it for all possible nodes during boot?

-- 
Thanks,

David / dhildenb

