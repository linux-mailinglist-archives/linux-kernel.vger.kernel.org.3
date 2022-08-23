Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AF959E3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243705AbiHWMl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 08:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243526AbiHWMlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0D910AE06
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661248242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KHenf9Y4DFpeTcrsigI5eYZv5fPQCg/1pJFHFFXrAkY=;
        b=VhRZKYrDJq4Marv1ar2AgopAGNrZL3RhWFpNYfUQrNERfisQbhFKthJjTau4qZAx3Xbacb
        U2o7H6zEcwl97pFgMmFDpaXOX4fgZlFvky+U++shcbXvUpalgx92eOBm92kEGIeoIfDXFJ
        pnB4xejL/cj0trxVnidwG5cSbB3WzBE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-671-ZP0cXqw0NSyk1aOpYoQ8KQ-1; Tue, 23 Aug 2022 05:50:41 -0400
X-MC-Unique: ZP0cXqw0NSyk1aOpYoQ8KQ-1
Received: by mail-wm1-f70.google.com with SMTP id c64-20020a1c3543000000b003a61987ffb3so7724129wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KHenf9Y4DFpeTcrsigI5eYZv5fPQCg/1pJFHFFXrAkY=;
        b=xqkoZzm13p0s5BLstn1Xrt2lRUoX4x2Z2wkQ3hQmQP3XdK+S705OxyPRQQfmCEsR1p
         /BL8ePtJCgOmBi07KLsqC0L8NoLz6FqFFvVxzaSatmW5V34XNGyAMLIwiAbzJnH34oPZ
         l/WRQ8eQFSY2Z5y/AKQH3X4r7Y/GqZrIsANm2pEM72nVmOCwpyTD6P+O8Se0hr9fvc0H
         085lT4n/OJN/uEaoaM2IDpPdjh2qfbXxYMxCETrBMV9+jV9FlX8SxpzWUtaqn9Vt/1zY
         IrSOliD/2yj9TQY4s+NEkbpgyCqcY4JkrOZ9X0YceK4yt1AGX/mmM/bz/GMgPWPTf4qg
         iRzQ==
X-Gm-Message-State: ACgBeo1QJV/Y74+w/YB1GXEdlf5M+qXr7chc06hRGOCECroclhtIb7jH
        5XoJlKLXY7Xkzjq+2cAWcYtHd909/cqlemkJoyQLegpotO0C5sfjILQzRf80gUn6wk7Kjk9/JlV
        1Pv6Z6j3jf05C8OQVaD2/fsg5
X-Received: by 2002:a7b:c016:0:b0:3a5:fff2:62f4 with SMTP id c22-20020a7bc016000000b003a5fff262f4mr1677682wmb.104.1661248240091;
        Tue, 23 Aug 2022 02:50:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR50PAvQXqub9ePpZCra5XYmWO1KHAJO9QPff/hyZeepdtYN+uUftogOYxzz/L7mAEPT4to1aQ==
X-Received: by 2002:a7b:c016:0:b0:3a5:fff2:62f4 with SMTP id c22-20020a7bc016000000b003a5fff262f4mr1677677wmb.104.1661248239837;
        Tue, 23 Aug 2022 02:50:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id c9-20020a05600c100900b003a2f6367049sm16580098wmc.48.2022.08.23.02.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 02:50:39 -0700 (PDT)
Message-ID: <bdb4cb00-f245-d98f-a49d-9371eff0a127@redhat.com>
Date:   Tue, 23 Aug 2022 11:50:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 6/8] memblock tests: update alloc_nid_api to test
 memblock_alloc_try_nid_raw
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1660897732.git.remckee0@gmail.com>
 <c8d86890f5b7168a162c9aee867e338b76e1cf0b.1660897732.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c8d86890f5b7168a162c9aee867e338b76e1cf0b.1660897732.git.remckee0@gmail.com>
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
> Update memblock_alloc_try_nid() tests so that they test either
> memblock_alloc_try_nid() or memblock_alloc_try_nid_raw() depending on the
> value of alloc_nid_test_flags. Run through all the existing tests in
> alloc_nid_api twice: once for memblock_alloc_try_nid() and once for
> memblock_alloc_try_nid_raw().
> 
> When the tests run memblock_alloc_try_nid(), they test that the entire
> memory region is zero. When the tests run memblock_alloc_try_nid_raw(),
> they test that the entire memory region is nonzero.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  tools/testing/memblock/tests/alloc_nid_api.c | 188 ++++++++++++-------
>  1 file changed, 119 insertions(+), 69 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> index 82fa8ea36320..2c1d5035e057 100644
> --- a/tools/testing/memblock/tests/alloc_nid_api.c
> +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> @@ -1,6 +1,34 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  #include "alloc_nid_api.h"
>  
> +static const char * const func_testing[] = {
> +	"memblock_alloc_try_nid",
> +	"memblock_alloc_try_nid_raw"
> +};
> +
> +static int alloc_nid_test_flags = TEST_ZEROED;
> +
> +static inline const char * const get_func_testing(int flags)
> +{
> +	if (flags & TEST_RAW)
> +		return func_testing[1];
> +	else
> +		return func_testing[0];
> +}

Same comments as for patch #5. Otherwise looks good.


-- 
Thanks,

David / dhildenb

