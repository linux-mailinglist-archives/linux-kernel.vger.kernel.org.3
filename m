Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8155B1CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiIHMYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiIHMXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F51F6BBF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662639814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=79g5VpFONhuMPtawANlVR2ff/cNbGpCflmstr/JbOIo=;
        b=HA74NKFpezNtNzbOIyb75LSsbDIixKYdhT64aW1KO6DjsFqnkesxUGSVusk6Hdxb4NjsY0
        ZS3J5HNbVy7Vq3m4vEbxV1wSsIa4uyJ63gv8f90MQTAKC4paiKEwfEkVfPBUUFBBUQjsaM
        dFCRGj5Pj5Gx2Vs9bq1gf3jAm0O9cEk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-118-1Abfu_IUN36-45nXYxFuag-1; Thu, 08 Sep 2022 08:23:32 -0400
X-MC-Unique: 1Abfu_IUN36-45nXYxFuag-1
Received: by mail-wm1-f70.google.com with SMTP id p3-20020a7bcc83000000b003b2973dab4bso1059804wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=79g5VpFONhuMPtawANlVR2ff/cNbGpCflmstr/JbOIo=;
        b=zsGCfucwc/Nafa2WCYWRb8zhS3bkwR7nKGVOFUi7Z5s0T1l8/sfdpMClrmwk2OrQtb
         nnbjeLB/BbhFQOmmo5G7+R3NKM+yD14y2Ep1xb3aTAipKiIK81Igi01tAmpDf7R29TXB
         /ObFEDWNxhB1CyquRoml8FhEyWCGiGtcLrhb7UYMOK2BEHhnjIWEfZO9f1C+hHgVaVbP
         PbFqCHZH2fKFMwJuotF4XaP49ghWmJhpFIC8N+iEs0FZ2RLvh2DP7Ht0VPboJYuYJj00
         SpcA4z9v1DRwk60huSP3uxlQSnGBXhsefIjFAm3+/dWuEN3xHKl6IU5RElO06JQYwdz7
         XKJA==
X-Gm-Message-State: ACgBeo0HNewIoCEj5C0BF5pWbFVwXOarBBbkPgNtEo7y67krZT228fIL
        Mr20B34+LyNp//0Cww0QjsXMHfRNGUQnh1ZC3Oyy149cKmediFD83V3zNWywo+/UO37YaDtUo9p
        8lLsMvt3QB7ABGuO3OruhWEqa
X-Received: by 2002:a05:6000:381:b0:221:7542:61bb with SMTP id u1-20020a056000038100b00221754261bbmr4934144wrf.305.1662639811622;
        Thu, 08 Sep 2022 05:23:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6lEwY3r9hTla4Z6KBQ6ssYqnMJ1AS54mmV7VZRMfZnvmvazj3IMqsdpTmP0X2s/dv0JIT9ew==
X-Received: by 2002:a05:6000:381:b0:221:7542:61bb with SMTP id u1-20020a056000038100b00221754261bbmr4934129wrf.305.1662639811311;
        Thu, 08 Sep 2022 05:23:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id r3-20020a05600c434300b003a5fa79007fsm2276556wme.7.2022.09.08.05.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 05:23:30 -0700 (PDT)
Message-ID: <ffb7f9e5-676d-e382-11bd-8bd87c40ee0c@redhat.com>
Date:   Thu, 8 Sep 2022 14:23:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 2/4] memblock tests: add top-down NUMA tests for
 memblock_alloc_try_nid*
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1662264560.git.remckee0@gmail.com>
 <03b434f9ccbeb059a04d5af57d69038a14c21ec6.1662264560.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <03b434f9ccbeb059a04d5af57d69038a14c21ec6.1662264560.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.22 06:21, Rebecca Mckeever wrote:
> Add tests for memblock_alloc_try_nid() and memblock_alloc_try_nid_raw()
> where the simulated physical memory is set up with multiple NUMA nodes.
> Additionally, all of these tests set nid != NUMA_NO_NODE. These tests are
> run with a top-down allocation direction.
> 
> The tested scenarios are:
> 
> Range unrestricted:
> - region can be allocated in the specific node requested:
>        + there are no previously reserved regions
>        + the requested node is partially reserved but has enough space
> - the specific node requested cannot accommodate the request, but the
>    region can be allocated in a different node:
>        + there are no previously reserved regions, but node is too small
>        + the requested node is fully reserved
>        + the requested node is partially reserved and does not have
>          enough space
> 
> Range restricted:
> - region can be allocated in the specific node requested after dropping
>    min_addr:
>        + range partially overlaps with two different nodes, where the first
>          node is the requested node
>        + range partially overlaps with two different nodes, where the
>          requested node ends before min_addr
> - region cannot be allocated in the specific node requested, but it can be
>    allocated in the requested range:
>        + range overlaps with multiple nodes along node boundaries, and the
>          requested node ends before min_addr
>        + range overlaps with multiple nodes along node boundaries, and the
>          requested node starts after max_addr
> - region cannot be allocated in the specific node requested, but it can be
>    allocated after dropping min_addr:
>        + range partially overlaps with two different nodes, where the
>          second node is the requested node
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>   tools/testing/memblock/tests/alloc_nid_api.c | 694 ++++++++++++++++++-
>   tools/testing/memblock/tests/alloc_nid_api.h |  16 +
>   tools/testing/memblock/tests/common.h        |  18 +
>   3 files changed, 717 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> index 32b3c1594fdd..a639e9d3e098 100644
> --- a/tools/testing/memblock/tests/alloc_nid_api.c
> +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> @@ -3,6 +3,14 @@
>   
>   static int alloc_nid_test_flags = TEST_F_NONE;
>   
> +/*
> + * contains the denominators of the fractions of MEM_SIZE contained in each node
> + * (e.g., if node_fractions[0] = SZ_8, node 0 will contain 1/8th of MEM_SIZE)
> + */
> +static const phys_addr_t node_fractions[] = {
> +	SZ_4, SZ_16, SZ_8, SZ_8, SZ_16, SZ_16, SZ_4, SZ_16
> +};
> +

Besides that part, that I consider confusing :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

