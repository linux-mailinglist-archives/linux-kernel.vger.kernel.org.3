Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527D555FEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiF2LfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiF2LfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52C2D271A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656502498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDPyX9bt2HpOiFPkmoMHHpjNaKTkyBrVmLwrrW6VGXE=;
        b=EmQjjtDpmxgMA4MG5iFNkps5HmvjkP47CaXup3J90LJ7ithVcTF1X3w4/VcKpukWv4beeb
        YfKqWB1to5INVUGGYurzU0XVn4Ly0U5czyfDRSFaUUEOZXdxFrl0DnTo44ZmUp+aan+qIm
        w/qExmnf0IrHGqE/09JEHuFXpBhxzUs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-HsR4p5_3NyCuSTkgDWSAPw-1; Wed, 29 Jun 2022 07:34:56 -0400
X-MC-Unique: HsR4p5_3NyCuSTkgDWSAPw-1
Received: by mail-wm1-f72.google.com with SMTP id bg6-20020a05600c3c8600b003a03d5d19e4so7443630wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=sDPyX9bt2HpOiFPkmoMHHpjNaKTkyBrVmLwrrW6VGXE=;
        b=jQhT9X3U1PDKpV+dwyyqLHvu9ZvTknZ+9JShfi5wcfSpxm4N/p4dKM1GDycDIJJiy3
         nS1vy5rsSP0UvHm4Uy9G4/1OLh3859QB8JGiYCt1ezIj+f6IAQJvzJkeA51MbRI/fPrf
         PIU1lw+YUZJfiwiwMIMjUxMZiy44/g45MiElZ5bWOYxHQScRqFDWvxRhlfZDZs7mJjsm
         hkUw514ideDtgIAV0tlLpw89RFUzxT4Ow/v3qsYKdkkQ6pel4l1VU9zrNJ1Rvwn4GGCx
         fS/lAwUeRqXEB6DLBOVv/8xO+Tb/NER9L99iZ10TnM3VGZYEI1t2B2X4T0yUFrkUIk0y
         g2RQ==
X-Gm-Message-State: AJIora/nOtFifyA8tF15t61g8nPfydmX8t4Q6vXaDb0PJ01RUtH46cGP
        s0raFouQVDcDwgOuuvCarQiWWGzSsKZ1H3QpekZ0wdGYujysIa3wRt3sxkQmbau8rEdc5YMiq6Q
        x3wWGyrgm4QXO9/xFaxNvgcVL
X-Received: by 2002:a05:6000:1541:b0:21d:2afa:17ed with SMTP id 1-20020a056000154100b0021d2afa17edmr2247625wry.311.1656502495745;
        Wed, 29 Jun 2022 04:34:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u3XLB5CcpJjlAAgk6ocajqIVVWthKRl+wXrWoZ5+rko6PsxgOQ96w23HFad6LRYYByOL54BA==
X-Received: by 2002:a05:6000:1541:b0:21d:2afa:17ed with SMTP id 1-20020a056000154100b0021d2afa17edmr2247606wry.311.1656502495471;
        Wed, 29 Jun 2022 04:34:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:e600:d4fa:af4b:d7b6:20df? (p200300cbc708e600d4faaf4bd7b620df.dip0.t-ipconnect.de. [2003:cb:c708:e600:d4fa:af4b:d7b6:20df])
        by smtp.gmail.com with ESMTPSA id q3-20020a1c4303000000b003a03185231bsm2775257wma.31.2022.06.29.04.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 04:34:54 -0700 (PDT)
Message-ID: <5db2944e-9d64-8faa-83d3-fd02fce583bd@redhat.com>
Date:   Wed, 29 Jun 2022 13:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 2/4] memblock tests: add verbose output to memblock
 tests
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1656368930.git.remckee0@gmail.com>
 <883c28e34527fd4cdc55df97c791ed8b2e79538d.1656368930.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <883c28e34527fd4cdc55df97c791ed8b2e79538d.1656368930.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.22 00:34, Rebecca Mckeever wrote:
> Add and use functions and macros for printing verbose testing output.
> 
> If the Memblock simulator was compiled with VERBOSE=1:
> - prefix_push(): appends the given string to a prefix string that will be
>   printed in test_fail() and test_pass*().
> 
> - prefix_pop(): removes the last prefix from the prefix string.
> 
> - prefix_reset(): clears the prefix string.
> 
> - test_fail(): prints a message after a test fails containing the test
>   number of the failing test and the prefix.
> 
> - test_pass(): prints a message after a test passes containing its test
>   number and the prefix.
> 
> - test_print(): prints the given formatted output string.
> 
> - test_pass_pop(): runs test_pass() followed by prefix_pop().
> 
> - PREFIX_PUSH(): runs prefix_push(__func__).
> 
> If the Memblock simulator was not compiled with VERBOSE=1, these
> functions/macros do nothing.
> 
> Add the assert wrapper macros ASSERT_EQ(), ASSERT_NE(), and ASSERT_LT().
> If the assert condition fails, these macros call test_fail() before
> executing assert().
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>


[...]

>  
> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> index 62d3191f7c9a..e55b2a8bf0ff 100644
> --- a/tools/testing/memblock/tests/common.c
> +++ b/tools/testing/memblock/tests/common.c
> @@ -4,8 +4,12 @@
>  
>  #define INIT_MEMBLOCK_REGIONS			128
>  #define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
> +#define PREFIXES_LEN_MAX			256
> +#define DELIM					": "
> +#define DELIM_LEN				strlen(DELIM)

Why not simply

#define PREFIXES_MAX	15
static const char * __maybe_unused prefixes[PREFIXES_MAX];
static int nr_prefixes;

And then simply insert/clear the corresponding prefixes[] pointer and
update nr_prefixes?

When printing, you only have to walk prefixes from 0 ... nr_prefixes - 1
and print the values.

Avoids any string modifications.


Anyhow, this LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

