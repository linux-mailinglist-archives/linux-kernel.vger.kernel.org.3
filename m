Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D8D59E46E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbiHWM4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 08:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241244AbiHWMzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07A92C0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661248811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evJyAqrmQ+PN8lACqVPMdSN0uOt0VMT3OLvez2Taitk=;
        b=Pbo7aSvTM916Za7NhOm9fRj4t5cH851zVaS2NNIqA4OU57c0QyXWsN16jvr50TnT//EtCu
        LiQziiU706JBRT13YkE2K5FGJLl8IwxMxU2QYkg6Xg4fZXqxJtTecgmuNDU//xo817JzaS
        rEmBL+oWepGsKJ8yiVqMbaVEF12AsBs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-227-2fssZnm7N4KZ7nL2-wGlLg-1; Tue, 23 Aug 2022 05:49:49 -0400
X-MC-Unique: 2fssZnm7N4KZ7nL2-wGlLg-1
Received: by mail-wr1-f72.google.com with SMTP id w2-20020adfbac2000000b00225688186e5so191573wrg.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=evJyAqrmQ+PN8lACqVPMdSN0uOt0VMT3OLvez2Taitk=;
        b=fcEluk/OPzJHLNtYsH3LAsGOQlkzO7Z8i5Spynn0gLIyBTQrHTbVgSP+dMdzIAE1c0
         5THs/LhkF1+Q9Qb6lwOWwuyP7+gCGUvWwkjsfe5imIhW6j92vq78/4GJ7FNgKsRip60z
         zT6MVfVPE1hR+QD6HihmiUUtdFzk7b2in5Fk6imb5IAlEMd6LbML/yZpsJ95OaMzAiKG
         VVgML3+9ceIZVhDwkw+bljkkl8nOt3261AlcvLq5BaDJVlRwR8+4xpy9CdV/Gz/LZY9G
         rt8QI0tpDIk+xqMdhEMBj3wvGKosrb8gUXPummmNBZoMbxw95D9pbS4M7zZByKHpO84e
         7YyA==
X-Gm-Message-State: ACgBeo2IYJ1ptg9wLdrJm9uU68SXNAkE6l2GAIfJcfLAKOhxD9vcwLsi
        yBvvK96er2PV35t+vK7Boz9+W8ietOMxr/5qsqRyYogSqVU9rI+2TABAuDc9KTwhDUm1UxemaA1
        uBjNj8P3PKxTiPTcbgNn+L2ED
X-Received: by 2002:a05:600c:ad4:b0:3a5:50b2:f991 with SMTP id c20-20020a05600c0ad400b003a550b2f991mr1537858wmr.146.1661248188012;
        Tue, 23 Aug 2022 02:49:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6NG9jEoNcb22136kmXu7HG2Gru0DTj00CLprYAhQ2al0z3j67ysO2GGC6g9Zt1RN823T9fmg==
X-Received: by 2002:a05:600c:ad4:b0:3a5:50b2:f991 with SMTP id c20-20020a05600c0ad400b003a550b2f991mr1537846wmr.146.1661248187647;
        Tue, 23 Aug 2022 02:49:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id n189-20020a1ca4c6000000b003a540fef440sm21216152wme.1.2022.08.23.02.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 02:49:47 -0700 (PDT)
Message-ID: <d65cf9fe-e22c-7698-0313-879685f1319b@redhat.com>
Date:   Tue, 23 Aug 2022 11:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1660897732.git.remckee0@gmail.com>
 <48cfb01ba417895f28ce7ef9b99d1ce0854bfd5e.1660897732.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 5/8] memblock tests: update alloc_api to test
 memblock_alloc_raw
In-Reply-To: <48cfb01ba417895f28ce7ef9b99d1ce0854bfd5e.1660897732.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.22 10:34, Rebecca Mckeever wrote:
> Update memblock_alloc() tests so that they test either memblock_alloc()
> or memblock_alloc_raw() depending on the value of alloc_test_flags. Run
> through all the existing tests in memblock_alloc_api twice: once for
> memblock_alloc() and once for memblock_alloc_raw().
> 
> When the tests run memblock_alloc(), they test that the entire memory
> region is zero. When the tests run memblock_alloc_raw(), they test that
> the entire memory region is nonzero.

Could add a comment stating that we initialize the content to nonzero in
that case, and expect it to remain unchanged (== not zeroed).

> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  tools/testing/memblock/tests/alloc_api.c | 98 ++++++++++++++++--------
>  tools/testing/memblock/tests/common.h    | 25 ++++++
>  2 files changed, 90 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
> index 65bff77dd55b..cf67687ae044 100644
> --- a/tools/testing/memblock/tests/alloc_api.c
> +++ b/tools/testing/memblock/tests/alloc_api.c
> @@ -1,6 +1,29 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  #include "alloc_api.h"
>  
> +static const char * const func_testing[] = {
> +	"memblock_alloc",
> +	"memblock_alloc_raw"
> +};
> +
> +static int alloc_test_flags = TEST_ZEROED;
> +
> +static inline const char * const get_func_testing(int flags)
> +{
> +	if (flags & TEST_RAW)
> +		return func_testing[1];
> +	else
> +		return func_testing[0];

No need for the else, you can return directly.

Can we avoid the func_testing array?


Persoally, I consider the "get_func_testing()" name a bit confusing.

get_memblock_alloc_name() ?


> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
> index 58f84bf2c9ae..4fd3534ff955 100644
> --- a/tools/testing/memblock/tests/common.h
> +++ b/tools/testing/memblock/tests/common.h
> @@ -12,6 +12,11 @@
>  
>  #define MEM_SIZE SZ_16K
>  
> +enum test_flags {
> +	TEST_ZEROED = 0x0,
> +	TEST_RAW = 0x1
> +};

I'd have called this

enum test_flags {
	/* No special request. */
	TEST_F_NONE = 0x0,
	/* Perform raw allocations (no zeroing of memory).
	TEST_F_RAW = 0x1,
};

Further, I'd just have use #define for the flags.

> +
>  /**
>   * ASSERT_EQ():
>   * Check the condition
> @@ -63,6 +68,18 @@
>  	} \
>  } while (0)
>  
> +/**
> + * ASSERT_MEM_NE():
> + * Check that none of the first @_size bytes of @_seen are equal to @_expected.
> + * If false, print failed test message (if running with --verbose) and then
> + * assert.
> + */
> +#define ASSERT_MEM_NE(_seen, _expected, _size) do { \
> +	for (int _i = 0; _i < (_size); _i++) { \
> +		ASSERT_NE((_seen)[_i], (_expected)); \
> +	} \
> +} while (0)
> +
>  #define PREFIX_PUSH() prefix_push(__func__)
>  
>  /*
> @@ -116,4 +133,12 @@ static inline void run_bottom_up(int (*func)())
>  	prefix_pop();
>  }
>  
> +static inline void verify_mem_content(void *mem, int size, int flags)

nit: why use verify here when the other functions "assert". I'd have
called this something like "assert_mem_content()"


-- 
Thanks,

David / dhildenb

