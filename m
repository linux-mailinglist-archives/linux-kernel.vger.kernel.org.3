Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FD159E42E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbiHWMy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 08:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240467AbiHWMyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459AD11F745
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661248740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eNgzriyywXL9TuuKIudqOgLv5q07dltNhohdSXbABsY=;
        b=cKrQGK4HZF6rrOCz5cdq+XsryKxLFjHzZk5IHmxdiT6bS3ztFUHSlUHd3Pvo3OpG+PkV2h
        dxrWcp+LHpm0qlup6RnOlJyuagqtP5xq3+AIjWegi2hUs8cNBvCdOrxZHHBkhCFDELnZdF
        rhvYNzz2y7K94laQdt0uJKi5fqKGqqY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-610-dtSz7GQ0OMmNv-QoChmFAA-1; Tue, 23 Aug 2022 05:55:01 -0400
X-MC-Unique: dtSz7GQ0OMmNv-QoChmFAA-1
Received: by mail-wm1-f69.google.com with SMTP id 203-20020a1c02d4000000b003a5f5bce876so10015158wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=eNgzriyywXL9TuuKIudqOgLv5q07dltNhohdSXbABsY=;
        b=jmnmHHvjtMkbn7eu1L3E6gKH9KxLANrfSRSoApBbugnB/XfbZ0krgynmxbAEep0geV
         UUdhRzycSXFNy0/UOJ5EURzGjaqqjfwrrmF3lPRNzbYGV2nsq/HEu+KEGkH0jzHsEFA0
         54qMYUwQAyyk11fQkO9348VrUbUSOrUU1o/LhAqoJF/szPUJq8i0uE+1dX4KB+UGg0Zu
         PuPzIhlqQSijSMS1oANPjlq+5LPTFcNP/RQea5lBBz34TjU64leN+H9XSU41POBzgxF2
         EaOOrQWBtmcHZRWVR3ImcAgbozPRqj5fNGonvgM9nJSMi6263VqEarEo+Ix4plOPi8TZ
         X49Q==
X-Gm-Message-State: ACgBeo39earu7cEhTzctY4WIjdbCrzZ1JVHkrYgGDZLXVcbAbkbbewDz
        lSUG/A8GS2QbAFXyVBR4/Xq0z60t0V2JrBoh9FoGWbd7/VAq7Aoyp1s4RzVjFZT8iUpobqOOFhY
        HWqV5svGs/hMgR+E4LaJIiDw/
X-Received: by 2002:a05:600c:3ac6:b0:3a5:c03f:510d with SMTP id d6-20020a05600c3ac600b003a5c03f510dmr1627260wms.120.1661248500588;
        Tue, 23 Aug 2022 02:55:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR65Jq1hO7F3LQ7a1IOP4qhQdMKQbbjgZXrDqYYser19vNBXf0fVzg1beAiFRcgPcWCQF4arLw==
X-Received: by 2002:a05:600c:3ac6:b0:3a5:c03f:510d with SMTP id d6-20020a05600c3ac600b003a5c03f510dmr1627249wms.120.1661248500265;
        Tue, 23 Aug 2022 02:55:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d4851000000b0021eff2ecb31sm13784512wrs.95.2022.08.23.02.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 02:54:59 -0700 (PDT)
Message-ID: <c9536f33-2f66-af0a-472a-c982a2341738@redhat.com>
Date:   Tue, 23 Aug 2022 11:54:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 8/8] memblock tests: add tests for memblock_trim_memory
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1660897732.git.remckee0@gmail.com>
 <4157021eecdd3abb503d4b1d1449844baac2d7b9.1660897732.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <4157021eecdd3abb503d4b1d1449844baac2d7b9.1660897732.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.22 10:34, Rebecca Mckeever wrote:
> Add tests for memblock_trim_memory() for the following scenarios:
> - all regions aligned
> - one region unalign that is smaller than the alignment

s/region unalign/unaligned region/

> - one region unaligned at the base
> - one region unaligned at the end

"unaligned region" ?

[...]

>  
> +/*
> + * A test that tries to trim memory when both ends of the memory region are
> + * aligned. Expect that the memory will not be trimmed. Expect the counter to
> + * not be updated.
> + */
> +static int memblock_trim_memory_aligned_check(void)
> +{
> +	struct memblock_region *rgn;
> +	phys_addr_t alignment = SMP_CACHE_BYTES;

Could make that "const" -- same applies to other functions.

> +
> +	rgn = &memblock.memory.regions[0];
> +
> +	struct region r = {
> +		.base = alignment,
> +		.size = alignment * 4
> +	};
> +

[[[.]

> +static int memblock_trim_memory_checks(void)
> +{
> +	prefix_reset();
> +	prefix_push(FUNC_TRIM);
> +	test_print("Running %s tests...\n", FUNC_TRIM);

Just a note that this could have been

test_print("Running " FUNC_TRIM " tests...\n");

But it's good to keep this consistent for all tests.


Nice test cases!

-- 
Thanks,

David / dhildenb

