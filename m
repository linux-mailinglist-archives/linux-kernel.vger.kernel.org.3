Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820E3552C33
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347688AbiFUHjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347633AbiFUHjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A95B011177
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655797147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zwfem3uveCMVHvWRElD2ntpsDQotbmTt7QrAnuC0sFY=;
        b=VyOAoU4VTPDJFyLB2OcL73R/hH2uVJ+Kxmbe3diYkInWosVuIW5bv1M3WYjngXaG7gj89P
        WOO36b9RqvFpXFvyXt7G7/ExYg3NM+10ksoGYtPCche/8DNkUxTrkkVRKmwqADdpzYEJZr
        gfPHYbusyweopzM7m8O3mWk0XUVr3Eg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-B8IiqZJyO_Wykxe0SCTYlw-1; Tue, 21 Jun 2022 03:39:03 -0400
X-MC-Unique: B8IiqZJyO_Wykxe0SCTYlw-1
Received: by mail-wr1-f70.google.com with SMTP id i17-20020adfaad1000000b0021b883a2892so1768192wrc.22
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Zwfem3uveCMVHvWRElD2ntpsDQotbmTt7QrAnuC0sFY=;
        b=nOp6/bJ1NkgfMGz96S3b2enFnfnB1kX3VkDJTBzkHE9VbuS0ddlhBWwEOxpxk/0Xj1
         3wdAzhrPnVHyUEivdXAOS0ckbMyuNMMwjxW5U8bIRjPkXkivOXYH4yfGvyfVfH+PdX99
         lnApl5QzTypnrk6WSna21xvwShnjTNUg7qnNW6mYjrD511OOccjMJn1VCZChgRM4dQi+
         2knVD8XiS68RIW+HfI9Qe0N97EztTll0gNpuyBCSuxqHyELNVYNezpVXQ3WiAOCnokW4
         j/EOgo61HGB6ImcAXX3zh2B8PdLLHR/omCwqxN0nthMYbQHZCjmGvXm1BO3dC0UyvD/D
         Pv6w==
X-Gm-Message-State: AJIora+85tiaTLIFM5nMW74DyzOgDskrOamKHzr8A9mteq0bkcZveQb+
        5D90asXSaruRVR++l2L+UAy8Ns4+v6bW+ATlbjqgzYCiXMqiGlFkABow9zPAnJmj6Q9ZvKgH+Xj
        d1+YHSZUNMXs6Lb98n03eG43O
X-Received: by 2002:a05:6000:18c4:b0:21b:8b8e:4994 with SMTP id w4-20020a05600018c400b0021b8b8e4994mr11042347wrq.122.1655797142359;
        Tue, 21 Jun 2022 00:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tY34WWq2a1oDkkjRucMjmAsNPLPMUQUiGG5ZZmJwsDBonqnup9PU4sqC5FozyGwDBO7hjWWQ==
X-Received: by 2002:a05:6000:18c4:b0:21b:8b8e:4994 with SMTP id w4-20020a05600018c400b0021b8b8e4994mr11042323wrq.122.1655797142065;
        Tue, 21 Jun 2022 00:39:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:2500:cdb0:9b78:d423:43f? (p200300d82f042500cdb09b78d423043f.dip0.t-ipconnect.de. [2003:d8:2f04:2500:cdb0:9b78:d423:43f])
        by smtp.gmail.com with ESMTPSA id y6-20020a5d6206000000b0021350f7b22esm16641626wru.109.2022.06.21.00.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 00:39:01 -0700 (PDT)
Message-ID: <41477111-dc5d-d0ef-7d4a-ca1c6336bbbf@redhat.com>
Date:   Tue, 21 Jun 2022 09:39:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 2/2] mm: memory_hotplug: make hugetlb_optimize_vmemmap
 compatible with memmap_on_memory
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        corbet@lwn.net, mike.kravetz@oracle.com, osalvador@suse.de,
        paulmck@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220620110616.12056-1-songmuchun@bytedance.com>
 <20220620110616.12056-3-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220620110616.12056-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.22 13:06, Muchun Song wrote:
> For now, the feature of hugetlb_free_vmemmap is not compatible with the
> feature of memory_hotplug.memmap_on_memory, and hugetlb_free_vmemmap
> takes precedence over memory_hotplug.memmap_on_memory. However, someone
> wants to make memory_hotplug.memmap_on_memory takes precedence over
> hugetlb_free_vmemmap since memmap_on_memory makes it more likely to
> succeed memory hotplug in close-to-OOM situations.  So the decision
> of making hugetlb_free_vmemmap take precedence is not wise and elegant.
> The proper approach is to have hugetlb_vmemmap.c do the check whether
> the section which the HugeTLB pages belong to can be optimized.  If
> the section's vmemmap pages are allocated from the added memory block
> itself, hugetlb_free_vmemmap should refuse to optimize the vmemmap,
> otherwise, do the optimization.  Then both kernel parameters are
> compatible.  So this patch introduces VmemmapSelfHosted to mask any
> non-optimizable vmemmap pages. The hugetlb_vmemmap can use this flag
> to detect if a vmemmap page can be optimized.
> 

Makes sense to me and looks good

Acked-by: David Hildenbrand <david@redhat.com>



-- 
Thanks,

David / dhildenb

