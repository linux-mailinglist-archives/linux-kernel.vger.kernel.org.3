Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014C553FF7D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244297AbiFGMzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244276AbiFGMzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEB3F7B9C2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654606514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5RVe0C3aiNOz3oukHUGPNmLDRkCuls8RKalvV3ngHRA=;
        b=KtgiTA3UuuxpgGVXdwM/f0J2AAZrFRUy49DTrk2dyELY3KyZg5JG2qMYmhZZARQVdbr4kv
        7/iwhpm67/zYjMWIgzrL4ZlDmVn/pqfTZAJFmbDzJRG36vRICGIp84ziAikOlCwI5DJXU3
        KIAlPveZXy1NZ37jA2qT67YQCA7sEaI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-Va_IpmGINBSADjGOSOQ2Rw-1; Tue, 07 Jun 2022 08:55:13 -0400
X-MC-Unique: Va_IpmGINBSADjGOSOQ2Rw-1
Received: by mail-wm1-f69.google.com with SMTP id p24-20020a05600c1d9800b0039c51c2da19so1591083wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=5RVe0C3aiNOz3oukHUGPNmLDRkCuls8RKalvV3ngHRA=;
        b=acUn9Zs/NNTX/qCzTMni5q6UhkvvdCskn3iO7uFnKw7lAFTn0FW2VfBjfmEbuVtzuS
         soD26Erlu3mCEH/PeQO3ePWXdd8udRXLKq5kq1Lw28ee/sinjz3+DSo9WuFW6i/ghorX
         myZP0jNcNkc7vaJFFi3f41tab4KWq7xeFZqhu7DDrfhw+pBQ9qAn4nTSEc5ClLyC3Yhc
         W6wcnCNQyBg6OpopcXKAghVqAWWqIYrcrP1aNkBbvbUO8Ul1CQ/Ij1Xo9cyLtz81pxxT
         uT4Y7dCKrmVPodBN5kQQhQDneH7KE6odjLw/P1jZGKdB2oj4q9J7y+JWJuscL6xVstZH
         N0mg==
X-Gm-Message-State: AOAM530tPj6P4Q/YDCTVgrdPjGKjnF8cSSAaV3fLfri5SAV+2rTl858p
        1m0tQ+WffaJi06HmUudTT4Iprek9QNFr7rL32GcgaHz5B0oObsnOInV/55vxRFmml8ub+zqCJst
        CW4mEHCaBkc2Ntc5sOxKaC35o
X-Received: by 2002:a05:6000:1869:b0:211:7f25:89da with SMTP id d9-20020a056000186900b002117f2589damr27583436wri.696.1654606512504;
        Tue, 07 Jun 2022 05:55:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbWFPyRplg1fzsNFrxr12dVS/TCLObe8BDTTUd8jCGAm7C/o75+Wu8cxSIdVKTvYrcl5Ga5w==
X-Received: by 2002:a05:6000:1869:b0:211:7f25:89da with SMTP id d9-20020a056000186900b002117f2589damr27583405wri.696.1654606512140;
        Tue, 07 Jun 2022 05:55:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:500:4c8d:4886:f874:7b6f? (p200300cbc70905004c8d4886f8747b6f.dip0.t-ipconnect.de. [2003:cb:c709:500:4c8d:4886:f874:7b6f])
        by smtp.gmail.com with ESMTPSA id w11-20020a05600018cb00b0020d0435c97bsm18212989wrq.92.2022.06.07.05.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 05:55:11 -0700 (PDT)
Message-ID: <fc866097-f529-158e-8f24-5d42b11d28b1@redhat.com>
Date:   Tue, 7 Jun 2022 14:55:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mm: add a new emergency page migratetype.
Content-Language: en-US
To:     Huanpeng Xin <xinhuanpeng9@gmail.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xinhuanpeng <xinhuanpeng@xiaomi.com>
References: <20220606032709.11800-1-xinhuanpeng9@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220606032709.11800-1-xinhuanpeng9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.06.22 05:27, Huanpeng Xin wrote:
> From: xinhuanpeng <xinhuanpeng@xiaomi.com>
> 
> add a new page migratetype reserved for
> non-costly non-NOWARN page allocation failure.

Sorry to say, but this patch description is not expressive enough. I
have absolutely no clue what you are trying to achieve and why we should
care.

Especially, why do we care about locally grouping these allocations
(that's what pageblock flags are for after all)?

Your Kconfig option is also not particularly user friendly to read either:

"This enables the migration type MIGRATE_EMERGENCY,which reserves
 a small amount of memory for non-costly non-NOWARN page allocation
 failure."

Usually we reserve memory via different mechanisms, like atomic
reserves? Why can't something like that be used.

On first sight, defining a new pageblock migratype feels wrong to me.
But then, I have no clue what you are actually trying to achieve.

-- 
Thanks,

David / dhildenb

