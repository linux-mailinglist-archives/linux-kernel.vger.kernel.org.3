Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8388B4EEEFE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346741AbiDAOOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346732AbiDAOOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC7D326F232
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648822334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WraCHOqT0eW5aGx8rmejM2R/n43jA4wH/hTNMOW6nUo=;
        b=ZUy09jaGytZb/dwRccqzkTPXN6a8bpuuXVZGLmFSfdJV7YcUiOFF+z07oB5KghLcvKaZPt
        GWSvP9Sd7s3yzk9fUActjmKM5vgoR7kB4TYg4cXITfKbhF0i+ILbHLFB0lRfgp5pGI/WRI
        7bfQ6leI4f2AaoVejsNp6Xr2u64ANE0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-71ywFZiXOM2LOkjQKiyQZA-1; Fri, 01 Apr 2022 10:12:13 -0400
X-MC-Unique: 71ywFZiXOM2LOkjQKiyQZA-1
Received: by mail-wm1-f69.google.com with SMTP id z16-20020a05600c0a1000b0038bebbd8548so2955250wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 07:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=WraCHOqT0eW5aGx8rmejM2R/n43jA4wH/hTNMOW6nUo=;
        b=VbGXUt2aMnZUcTcH2DwwscwwMrnu+msHUXqwAjeoyfKfjTrelqV1zRLu09NRyx58iP
         fDs5K6dq31pZnyfJysgICqvv1oWFHFFrDVG4a2TbXRln/mG5Py7fZMQNIGaMwANIjLLv
         9xapESOTdhzWTGitXqr0EWMDOyGfb0r44Dw1USkntYSiVeXQ4nXQ5cbOwDYdntu+yc/+
         FUB7WuSHU9YgYDApGSZcp3mm6YeqmGkCRSUV+2MskWk+ULz51eI78zGXoyr068ECoFEO
         jqBw324yEH+7/Do3yJ2OoewOaHBbr9txtF5URXPb/Q3hnfSw+l9yl1fKSSykkp/KnQBi
         yp0Q==
X-Gm-Message-State: AOAM530EXE/+WplDLaPFyCVXONTE76YIGeWBgPkK0N3EKBW/7iR364fZ
        2WfF6rFMsxX9iJDOCUdbPONGoMOaNiggfDThkuoe5NoagrahAUTlslYBkYm7pr1Lwqsrfg/1aCK
        /01OaiALNBuOKoiivG+e9QTAI
X-Received: by 2002:a1c:e908:0:b0:38c:782c:2a62 with SMTP id q8-20020a1ce908000000b0038c782c2a62mr8948053wmc.135.1648822332571;
        Fri, 01 Apr 2022 07:12:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWw3Qon/AN3O5rFkGc/S2KGv5g1WDCCyg6ScGw8ZdDGCa06YaDZwZJoVIsXdJOJ9PSzlbnCw==
X-Received: by 2002:a1c:e908:0:b0:38c:782c:2a62 with SMTP id q8-20020a1ce908000000b0038c782c2a62mr8948034wmc.135.1648822332337;
        Fri, 01 Apr 2022 07:12:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:9e00:229d:4a10:2574:c6fa? (p200300cbc7069e00229d4a102574c6fa.dip0.t-ipconnect.de. [2003:cb:c706:9e00:229d:4a10:2574:c6fa])
        by smtp.gmail.com with ESMTPSA id r12-20020a5d6c6c000000b00203ec2b1255sm2883950wrz.60.2022.04.01.07.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 07:12:11 -0700 (PDT)
Message-ID: <134f56da-e827-2d29-75ba-1ec88ae2b118@redhat.com>
Date:   Fri, 1 Apr 2022 16:12:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] mm: page_alloc: simplify pageblock migratetype check
 in __free_one_page().
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20220401135820.1453829-1-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220401135820.1453829-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.22 15:58, Zi Yan wrote:

It's weird, your mails arrive on my end as empty body with attachment. I
first suspected Thunderbird, but I get the same result on the google
mail web client.

Not sure why that happens.


-- 
Thanks,

David / dhildenb

