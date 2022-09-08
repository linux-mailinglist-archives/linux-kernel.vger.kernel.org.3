Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7065B1CE8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiIHM0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiIHM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3354DE5812
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662639981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ljVEaXF428z2LXt8TxR00ttSDkE8DJv1cjDz3q325ZI=;
        b=Rc3eoaz1UnSSdvaD0l3Okmp50lhX1B0ztfwDJeUvqbomhahduHsr/+FlXWY4ajo+QjEZkJ
        a6uBF6CAO8SWwhypMLlBvl3+Z3T8KCJO1HhJfCimhulILsO/qtNj8tsINVdGyNiZEkHT7C
        9J1GwL1i53k00VaKOQxgTBZP78Q/EH4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-550-ilbVNFWwPlWOtUVVpDOMuw-1; Thu, 08 Sep 2022 08:26:20 -0400
X-MC-Unique: ilbVNFWwPlWOtUVVpDOMuw-1
Received: by mail-wm1-f70.google.com with SMTP id h4-20020a1c2104000000b003b334af7d50so484636wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ljVEaXF428z2LXt8TxR00ttSDkE8DJv1cjDz3q325ZI=;
        b=wRhgtupHEUTyMDGQ/M67mE1AyvNGgPSkrMUOtx/c/wo9ZKk1y0PhTH2VUTt/sJGaH7
         NKi0sxMWM/N9WbVnZxYqvun6mJNRNyiRrgwAbNjVuVd33uoaxWRCo74QTR1NTD+KRwhx
         rmoqSP8m4XieVhLxvDky170AFNVSb+zlzRJhk2xtaDCen8aIstbFh8jfgj7dIGHamdo9
         3SW76L5zd0T6Ze5GAt5pOSPl9UKTdD9XXnJnogOn5MKHxCciVqwwn9xarHeXh9Tu5Kvm
         RvAI3WqRhblDaaS0+g9/ZB5t6JugYtRfgJ9tURKTJ2ILCPjcdKYK5sdC0CZ6lRouC0G6
         fJuw==
X-Gm-Message-State: ACgBeo1RyWp3n6ScEtA5+dG13GYewCLeN1bVybBYmxh6cDHYx5hTPlfg
        ijWwPZVgSa1swMUw0FAzttSBGagdQZFAx11dkAo6TFNybKwjB1IJUtmzXNZax/VxJ2WFwSl7jY7
        dXDDvAlOfWRXfpPCL8pSu9vQp
X-Received: by 2002:a05:6000:188a:b0:226:f057:43bb with SMTP id a10-20020a056000188a00b00226f05743bbmr5094053wri.647.1662639979321;
        Thu, 08 Sep 2022 05:26:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5LOaBHCbLDHBhiBwqUR0qoVAM1VYRbQXxvDhFMeWeWnyPj5OVlpXGh+I5PauuckYp2ewt7nA==
X-Received: by 2002:a05:6000:188a:b0:226:f057:43bb with SMTP id a10-20020a056000188a00b00226f05743bbmr5094046wri.647.1662639979105;
        Thu, 08 Sep 2022 05:26:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a5ea1cc63csm3032964wmq.39.2022.09.08.05.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 05:26:18 -0700 (PDT)
Message-ID: <f00324ed-f852-a695-e2fe-cef97833f9bd@redhat.com>
Date:   Thu, 8 Sep 2022 14:26:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 3/4] memblock tests: add bottom-up NUMA tests for
 memblock_alloc_try_nid*
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1662264560.git.remckee0@gmail.com>
 <b8cce7051a70cb0d4b6aa785bb800638d30c081b.1662264560.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <b8cce7051a70cb0d4b6aa785bb800638d30c081b.1662264560.git.remckee0@gmail.com>
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
> run with a bottom-up allocation direction.
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
>   tools/testing/memblock/tests/alloc_nid_api.c | 568 +++++++++++++++++++
>   1 file changed, 568 insertions(+)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

