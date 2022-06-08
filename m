Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8E0542BFA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbiFHJuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiFHJua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A06423AB1F8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654679979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13NAg8Y7+eREL6LPlJWQbbTH4LT7eT0fI4DvffznR04=;
        b=W0qr5jKys4ej/dK4hGYClpef1hVq7SvqdXlBRV5RmkGzYVQAzo3KlZq0McQfDxavyLwK4b
        jWc9XwDhyt55yOGAYD5FUY1dW4+T5fqmRcUVEmnAzj+IWijOsBiHY6rRv4fr5AZy72LCbv
        g5rYp8rmFyFa3b+S1z0AdOKDk+ixxa0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-7DwGPYEMO3WNUjj0ZE-J1g-1; Wed, 08 Jun 2022 05:19:38 -0400
X-MC-Unique: 7DwGPYEMO3WNUjj0ZE-J1g-1
Received: by mail-wm1-f72.google.com with SMTP id 130-20020a1c0288000000b0039c6608296dso12905wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=13NAg8Y7+eREL6LPlJWQbbTH4LT7eT0fI4DvffznR04=;
        b=wJ62ovkhKyZQ51FJpxiIQX39RgjgVhmdsTNVsvmgVnETKFmF66LdYM8LWKdpBWmKRb
         lsm8h8YR8NN8LkVq+1MXrLd8DGP+dHptSlh4h2teybVk+V/mPfN/0OOTUBUs5484pYSJ
         KhhY7Rc/iw1FDuhj2rmPIuJMlH+KeGG+yhxx2l4VPsfPTkzNDFvPQ7pMx/CYZZWjfPKf
         RfI6wKW+GKTHCbbNvwD3LlPkNXu6oVYSleG0pa96lZISFdHMlT5VgtRFYxSF8P3DGo4w
         NTUSEySsjzJwMcRsKxkFj5hfhpIfgzRMhWkJ9Kad06Lrjh/SKISOlm2UzAlCfmmoWnzI
         NQxg==
X-Gm-Message-State: AOAM5328VEsc6yv2dWiS6yN2Y9jKsH7kJgu/hNy+ugohZaFaXfJt1HEz
        dkqh9PR4bHUzeAaQLtdsEo0bNhPgj/dnAOLpYf195s/8EuMmwy6mwY+dRhv890N5drTDKmfwWcz
        vT0O7MAgepxE5S7RhO+P36/TQ
X-Received: by 2002:a5d:6201:0:b0:214:624f:3b with SMTP id y1-20020a5d6201000000b00214624f003bmr26536252wru.34.1654679976983;
        Wed, 08 Jun 2022 02:19:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmoHFG+ZHWvDCZ+ku1HYxYNMBOth7o3mggV/oOgCUiNBVb3tPsXzcn47+zI3XgF1qZBQqc4w==
X-Received: by 2002:a5d:6201:0:b0:214:624f:3b with SMTP id y1-20020a5d6201000000b00214624f003bmr26536226wru.34.1654679976713;
        Wed, 08 Jun 2022 02:19:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ad00:db2:4c6:8f3a:2ec4? (p200300cbc705ad000db204c68f3a2ec4.dip0.t-ipconnect.de. [2003:cb:c705:ad00:db2:4c6:8f3a:2ec4])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c4f8800b0039c325eaff2sm20090977wmq.26.2022.06.08.02.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 02:19:33 -0700 (PDT)
Message-ID: <c180681a-7735-4862-ef0b-c69ce6c46d9a@redhat.com>
Date:   Wed, 8 Jun 2022 11:19:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 1/5] mm, hwpoison, hugetlb: introduce
 SUBPAGE_INDEX_HWPOISON to save raw error page
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
 <20220602050631.771414-2-naoya.horiguchi@linux.dev>
 <ea4cc6c8-a772-dce0-a7a3-4c3ceb31735f@redhat.com>
 <20220608013125.GA1404644@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220608013125.GA1404644@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.06.22 03:31, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Jun 07, 2022 at 03:04:15PM +0200, David Hildenbrand wrote:
>> On 02.06.22 07:06, Naoya Horiguchi wrote:
>>> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>
>>> When handling memory error on a hugetlb page, the error handler tries to
>>> dissolve and turn it into 4kB pages.  If it's successfully dissolved,
>>> PageHWPoison flag is moved to the raw error page, so that's all right.
>>> However, dissolve sometimes fails, then the error page is left as
>>> hwpoisoned hugepage. It's useful if we can retry to dissolve it to save
>>> healthy pages, but that's not possible now because the information about
>>> where the raw error page is lost.
>>>
>>> Use the private field of a tail page to keep that information.  The code
>>> path of shrinking hugepage pool used this info to try delayed dissolve.
>>> This only keeps one hwpoison page for now, which might be OK because it's
>>> simple and multiple hwpoison pages in a hugepage can be rare. But it can
>>> be extended in the future.
>>>
>>>
>>
>> But what would happen now if you have multiple successive MCE events on
>> such a page now?
> 
> The 2nd and later events are ignored due to "already hwpoisoned hugepage",
> this might not be good when the hwpoisoned hugepage is freed/dissolved later.
> So a temporal workaround is to remember "hugepage has multiple hwpoison pages"
> and disable free/dissolve for such hugepages.

Right. We might want to indicate exactly one vs. multiple, and then in
__update_and_free_page(), move the hwpoison flag to one subpage,
eventually exposing other corrupted subpages to the system.

-- 
Thanks,

David / dhildenb

