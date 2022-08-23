Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE1759DEE2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359471AbiHWMIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 08:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359508AbiHWMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 08:06:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62216DF4F8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661247423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nEnl5FVShRbfX9bxOxgHI5l05EhEroNOdj3tfZ7Zdw4=;
        b=IP0WAamgJScfmT2gxd6XJakZV1GpC5RiV/VKiGxqdhaqsOu185VU+lhn/cha2uJGU485Np
        PblpzFWpwe0KS2ZjuHCjozlpx3MU/ROv0F1D9U9tCfiH8lWq85komNqaJwvhwQWNxoZ6oJ
        CBgGlE9dUuY/UottnlgGBZ0GSgyiGH8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-yxyTD2FHOe6EYqXMcIFCDw-1; Tue, 23 Aug 2022 05:37:00 -0400
X-MC-Unique: yxyTD2FHOe6EYqXMcIFCDw-1
Received: by mail-wm1-f69.google.com with SMTP id 203-20020a1c02d4000000b003a5f5bce876so9996913wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 02:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=nEnl5FVShRbfX9bxOxgHI5l05EhEroNOdj3tfZ7Zdw4=;
        b=7P/0esde1Eh7ONE6nK5XLY4f0RAT1pAu2uAMjr0/VeLmi71iEYdC1OTucKz4NclHTK
         qqkGNMmMEFooPua3JT+/ut9vBwtEm7RLpy3I21JZjADHILhhbzTjiN3AB+28XWcukAlk
         6o5ZAzPD6+BJEgVvEPC40aSKmhTY8AygRGxA09/u351RcyCO12Us3LfmOcocu6nfekuS
         +9XVv2G79yR9R/Xpq84/cTPWenNpRo36c7MLxCF7LCNyJ9mv0rw6XavUBCGAS4C8pw1Y
         J9kDvWd3I/LHuFnQsUDdIwvddRVRqUg9PJlvDAgJAPtfHB6JSgJd37u+ZkrhrmHjsYou
         RGtw==
X-Gm-Message-State: ACgBeo3xA5MqsBrGsztGEc3YoWlB7mYVYT/ZXdQldwCokeVv7b4X1LDr
        F0meg7uDvsa8i5MEDvoduFEEB3AuixbUH35Lv/y332nOPpMJd7wkzURaO+kb5VS37nTzn6G9K81
        tGkfJtTzRNfPTqDcfRnpsF3P1
X-Received: by 2002:a05:6000:15ca:b0:225:4575:746d with SMTP id y10-20020a05600015ca00b002254575746dmr7719041wry.147.1661247419142;
        Tue, 23 Aug 2022 02:36:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7XJsJFK4+5+04kPo9xzd7r7glHujIb/q9IfHO4DPFp9HoQNR1VaEwbfBReHf1AjZ2VMxslEw==
X-Received: by 2002:a05:6000:15ca:b0:225:4575:746d with SMTP id y10-20020a05600015ca00b002254575746dmr7719028wry.147.1661247418852;
        Tue, 23 Aug 2022 02:36:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d5612000000b0021ee65426a2sm13599193wrv.65.2022.08.23.02.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 02:36:58 -0700 (PDT)
Message-ID: <6382c2d4-ac0b-644e-4c69-8650afe30bb9@redhat.com>
Date:   Tue, 23 Aug 2022 11:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/8] memblock tests: update tests to check if
 memblock_alloc zeroed memory
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>
References: <cover.1660897732.git.remckee0@gmail.com>
 <669782f4f508c3dd60c5efd6d130d12a77573448.1660897732.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <669782f4f508c3dd60c5efd6d130d12a77573448.1660897732.git.remckee0@gmail.com>
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
> Add an assert in memblock_alloc() tests where allocation is expected to
> occur. The assert checks whether the entire chunk of allocated memory is
> cleared.
> 
> The current memblock_alloc() tests do not check whether the allocated
> memory was zeroed. memblock_alloc() should zero the allocated memory since
> it is a wrapper for memblock_alloc_try_nid().
> 
> Reviewed-by: Shaoqin Huang <shaoqin.huang@intel.com>
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

