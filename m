Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A1751EABE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 02:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiEHAft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 20:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiEHAfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 20:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A39D2B9
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 17:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651969916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7oJ/pNGEcyEUOU4PfPLwqKmVyn82Hpz01lnvE5XFThg=;
        b=PwhAQJAq1Z1NOqb3kxcQqY3VsO5zL5BGfoAk8ghOwdtWLrY8kSH5pMYJIiNPn7DU6vOxnl
        Gp513uAAPoqmlqGQU2YK0zTt9LYry9ohm5kJecvksyiPSEbPL8T8eaK3SrQgBX7/oJGsdO
        M4ytLisv4biJKmH2yV7OM+uuRYw0bXU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-evukXkT1MXuQHtgwS17ndg-1; Sat, 07 May 2022 20:31:54 -0400
X-MC-Unique: evukXkT1MXuQHtgwS17ndg-1
Received: by mail-qt1-f199.google.com with SMTP id a18-20020ac85b92000000b002f3c5e0a098so5133166qta.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 17:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=7oJ/pNGEcyEUOU4PfPLwqKmVyn82Hpz01lnvE5XFThg=;
        b=52PpV9pGKfVbIWc2YpGQ1mnz5C9Syv5Q2mdSOcTh8N1oWLoc5SSz4A+g1UT7VS1mPQ
         /DsY0ziVfCZAavJg/FSfeZMXN15uao1iA7G0XGSM7+PqvHRb/zJNPNOBsGPPIFIrMOEm
         9yuwr80YpC0r7Cmm+RuBsXACBEytrYzOgNJjZbScIHOILcDNHBTXFfgp7pWxOCwOLigB
         UfwYUxwVxetNCPLP8T1omFyGwKnrAwqXChEWWXWIPWfo4ohOBRi0DB38r1RjAiEjjUOo
         WSc8ze3qXIKFj4vJvZfV/Dg3zvHFXCWAvmbOvmWRmgJ1BMYt3jaXxhvbm10UT35Du9+9
         mhqw==
X-Gm-Message-State: AOAM5303c9AZIPDbAqGkWBtziBPVANo1jGPRC4p/h47gIUAq0f4XAnPw
        /p35kNzAisz3g57ndPY2zknKy7HpfDHfi2ICIPNrooXVMGCGF+6WyEXmAO2bJZtF2QRKKqftZlN
        KV9hrd33SFz6AJSRaSkdnSmmt
X-Received: by 2002:ae9:de47:0:b0:69f:8818:fe78 with SMTP id s68-20020ae9de47000000b0069f8818fe78mr7627077qkf.32.1651969914172;
        Sat, 07 May 2022 17:31:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYIJsa/PnyIM3Bnxy8zBrAyaPRSk7/RvDKyW0rFlL6k56vpQe0r5UM3VF5ScwkkDtgIa7QvQ==
X-Received: by 2002:ae9:de47:0:b0:69f:8818:fe78 with SMTP id s68-20020ae9de47000000b0069f8818fe78mr7627071qkf.32.1651969913922;
        Sat, 07 May 2022 17:31:53 -0700 (PDT)
Received: from [10.23.153.165] ([46.248.132.196])
        by smtp.gmail.com with ESMTPSA id p185-20020a37bfc2000000b0069fc13ce24fsm4764442qkf.128.2022.05.07.17.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 17:31:52 -0700 (PDT)
Message-ID: <5480feb2-9b02-1c03-2396-d8cc75f981c9@redhat.com>
Date:   Sun, 8 May 2022 02:31:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>
References: <20220502173558.2510641-1-minchan@kernel.org>
 <29d0c1c3-a44e-4573-7e7e-32be07544dbe@redhat.com>
 <YnAhaRNjmIhtGUjk@google.com>
 <08e9855c-395d-f40c-de3d-1ec8b644bfe8@redhat.com>
 <YnFJss0doXGCmq3w@google.com>
 <da07530d-92ad-7aef-2f2b-d115f878ef76@redhat.com>
 <YnMC1jFoPvNLWqnG@google.com> <YnNzPlehofB57XXU@google.com>
 <dd4588a4-c1ca-481c-ac33-06abef6cf70a@oracle.com>
 <YnQIoVqXZQGILt6F@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YnQIoVqXZQGILt6F@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.05.22 19:25, Peter Xu wrote:
> On Thu, May 05, 2022 at 10:00:07AM -0700, Mike Kravetz wrote:
>> Gigantic pages can only be migrated IF there is another (already allocated)
>> gigantic page available.  The routine to try and allocate a page 'on the fly'
>> for migration will fail if passed a gigantic size.  There 'might' be a free
>> pre-allocated gigantic page.  However, if the user set up CMA reserves for
>> gigantic page allocations it is likely the free gigantic page is also in CMA.
>> Therefore, it can not be used for this migration.  So, unless my reasoning
>> is wrong, FOLL_LONGTERM would almost always fail for gigantic pages in CMA.
> 
> I'm probably not familiar enough with CMA, but.. I just noticed that if CMA
> is destined to not be able to be pinned then maybe it'll lose quite a few
> scenarios where pinning is a possible use case.  It doesn't even need to be
> the major use case, but as long as it's possible (e.g. hypervisors hosting
> virtual machines with device assignment) it'll be a hard no to CMA, which
> seems to be a pity.
> 

Well, the same applies to ZONE_MOVABLE as well, unfortunately.
Eventually, we might want to disable placing hugetlb pages on CMA areas
if it turns out to be a problem. In case of ZONE_MOVABLE we can already
fail "gracefully" when trying offlining (although that's really far from
beautiful).

-- 
Thanks,

David / dhildenb

