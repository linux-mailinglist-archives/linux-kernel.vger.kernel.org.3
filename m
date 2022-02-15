Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3744B6A99
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbiBOLXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:23:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiBOLXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:23:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7053CAB44A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644924173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9XqhwGYN094qwt4YHsGwrAuGrVX5AKcgWAioi8UK100=;
        b=QXUPQDKmvww6NYZUhDk3x78M7kd2YDCAchY6WGmmKsExnMYdTqutWoPlStvxIK5rbuXCLQ
        bPCCkfCI3xVBAyDZzPDfFRrJwDEeQQ+Ridkz5gbk5yT6Lay/DfeSBTrhjja3bVzf/oBSKa
        3g/gAusfS8PkVx1mY36Q01yGQrBaE1o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-Yay1TOemNwKwDdAcopkodg-1; Tue, 15 Feb 2022 06:22:51 -0500
X-MC-Unique: Yay1TOemNwKwDdAcopkodg-1
Received: by mail-wr1-f71.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so8210067wrg.19
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=9XqhwGYN094qwt4YHsGwrAuGrVX5AKcgWAioi8UK100=;
        b=V7E6QrIX5l1nHXimvFlNmxaR6EHouErRYLGQUlEomPnRmzbWkNMSI7znZV2thUQQSg
         2rcIhvFEbk9dURWTtZK0GM8bCZ+GjjVlJX4ab0D8nW4pJX92OHw3B2pCr/OwrSlBy3e6
         b/Cjddw73fC4Du9GHd/ztrvjmgpAlAyZ2X/ZAjAfgx24O+JRBMV+JUxzJ7RHqSDe5Wat
         ij7lXUM1aKbdMvC5e1yROL8GWm0IA9pOWRbFFPSQH+Dg5WwZgZIahZY3NJg+jYSiV4M+
         s+I1YUppyvWigzx/8dXtHNQpRQzg5wciSZpkAWtvzGc6SAm9jyjHoYxhPCALKVd1icZQ
         6VWQ==
X-Gm-Message-State: AOAM532L5nwhqHILzfKndc4UISsVSzRleuINv0KKBEpcQfkbfjo9hbEG
        0WCVxuesKjmpYX5AHrseKEiBNwUL8xpg2Txmf/FEnwEZXBGq6VdMgaAy4W3xL1e/ygjLVlXXG1R
        2p9RBGYn61RvY0ZTS7XSk2zKn
X-Received: by 2002:a05:600c:2251:: with SMTP id a17mr2747299wmm.88.1644924170082;
        Tue, 15 Feb 2022 03:22:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcIfVMCEHJLu5xgjU8cUK6l+eYU4b2sEheN2xCNVYgq6X6+sTtzgVQ5eUDpsPRNgauInnZdQ==
X-Received: by 2002:a05:600c:2251:: with SMTP id a17mr2747284wmm.88.1644924169809;
        Tue, 15 Feb 2022 03:22:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:3700:9260:2fb2:742d:da3e? (p200300cbc70e370092602fb2742dda3e.dip0.t-ipconnect.de. [2003:cb:c70e:3700:9260:2fb2:742d:da3e])
        by smtp.gmail.com with ESMTPSA id d14sm15871286wrv.50.2022.02.15.03.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 03:22:49 -0800 (PST)
Message-ID: <2a881586-3f5e-c277-f373-a9014d631700@redhat.com>
Date:   Tue, 15 Feb 2022 12:22:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] mm: clean up hwpoison page cache page in fault path
Content-Language: en-US
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, linux-mm@kvack.org,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20220212213740.423efcea@imladris.surriel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220212213740.423efcea@imladris.surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.22 03:37, Rik van Riel wrote:
> Sometimes the page offlining code can leave behind a hwpoisoned clean
> page cache page. This can lead to programs being killed over and over
> and over again as they fault in the hwpoisoned page, get killed, and
> then get re-spawned by whatever wanted to run them.

Hi Rik,

am I correct that you are only talking about soft offlining as triggered
from mm/memory-failure.c, not page offlining as in memory offlining
mm/memory_hotunplug.c ?

Maybe you can clarify that in the patch description, it made me nervous
for a second :)

-- 
Thanks,

David / dhildenb

