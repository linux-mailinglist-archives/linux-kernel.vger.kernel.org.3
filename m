Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC0524E59
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354465AbiELNct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354447AbiELNco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4023C13F1F6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652362362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LcRouEMbpVJV3CF6tUltj5T8/RbRRxoKRWpQh58FN08=;
        b=QuR4nqLPXjLi4Ab0Ed2sBADZsZQQMc9vkVMeHj7b+mZxBh9UsdBBHvwFM/csU10aEK1S/c
        4+8u53Z/1wXBrC0jvFAlWueUv9z1fbmuz/DyVA5OSH+LLDD6CYlVy9J2DjThY24KA4ckt1
        cF5a3WUohe+cdp+xXqGfxeWGwvhRMgs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-hIr0LyzIMYGanzMBVJ2f5A-1; Thu, 12 May 2022 09:32:41 -0400
X-MC-Unique: hIr0LyzIMYGanzMBVJ2f5A-1
Received: by mail-wm1-f69.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so1703331wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LcRouEMbpVJV3CF6tUltj5T8/RbRRxoKRWpQh58FN08=;
        b=5QDG1H5IPPzK2M11dRdLWX2vv6Akoo1WKtT4PhPq647LDWLRqybYReaixLdkZgjwoz
         7WUa9MbKRwx38V9ZXdblh2meZyAPSKaAH7QcNaRsrjN/R2iKLtLsi6kKZy+EyRXQiEiZ
         ITxrLys+Vr9kN/+JUsWueBZ07ELBRJOfueoweOoY1ZGwo6/iRVVohg16XCDJMCf2SS+R
         esB9Wbp9t5Zs8oHYcmMbW/ZSCjulXEvWr44GJKRR31P0M6FAPjWF8K2vnwj54pzxx4fu
         zgoVwKlkczVwa0h4J3+zbOdRlQ0wemDnlbw/NQVKz+klJj+syWU4P8F89Oz9xr9HUr4s
         bkqg==
X-Gm-Message-State: AOAM530XcgXpWMukSJgMoMNEt6SBXgGVIzTsLoqQnjTU+XPjelB53/l/
        FEwL2Sbqi1Jm597WYdeApyGsk/b2x9xTHfZEgxfSBkXuZaWrJhnBxQeP7gyReSodZ6sMRvBKcwV
        aHt+BDMiPmB1vEYEYevxqvfQ+
X-Received: by 2002:a5d:690c:0:b0:20a:d9d1:f5ce with SMTP id t12-20020a5d690c000000b0020ad9d1f5cemr27506922wru.295.1652362359990;
        Thu, 12 May 2022 06:32:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyd3jndOvxJhiI4HngOf3ex9ZqT8WGUFCHc11sCLiJkasJfigKcQon0rwwJCtpeYPzpq3JK/g==
X-Received: by 2002:a5d:690c:0:b0:20a:d9d1:f5ce with SMTP id t12-20020a5d690c000000b0020ad9d1f5cemr27506905wru.295.1652362359771;
        Thu, 12 May 2022 06:32:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id az14-20020a05600c600e00b003942a244f50sm2812086wmb.41.2022.05.12.06.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:32:39 -0700 (PDT)
Message-ID: <8adbcdfe-3c30-0928-b74b-36fb308339e5@redhat.com>
Date:   Thu, 12 May 2022 15:32:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 05/15] mm/swap: print bad swap offset entry in
 get_swap_device
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        peterx@redhat.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-6-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220509131416.17553-6-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.22 15:14, Miaohe Lin wrote:
> If offset exceeds the si->max, print bad swap offset entry to help debug
> the unexpected case.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

