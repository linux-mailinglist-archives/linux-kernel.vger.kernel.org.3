Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BEB524E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347763AbiELN1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354454AbiELN1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8241950E0E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652362032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQHk1D2gA8IdQnpMaDs2+SCOHC+ID64ViIQaNi8kML0=;
        b=BA3JRHpN/8/7sXLVsQ0irABID0kY1BrlmXrSFzzRToHqea52ALfLcDu3qq5iGOSDJxoxNt
        qVGeC4hpaDaReTnOdLBrJzcGLlC0Q3hMQ/BzYNB535DywXZRh/8FSO1E59FpjUpfvb+idw
        dro9PJ28NJUVng/MB2yezGxid8iXwNQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-61HAUnp1NeiIe_l8W6O6MQ-1; Thu, 12 May 2022 09:27:10 -0400
X-MC-Unique: 61HAUnp1NeiIe_l8W6O6MQ-1
Received: by mail-wm1-f69.google.com with SMTP id bg7-20020a05600c3c8700b0039468585269so1628471wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=bQHk1D2gA8IdQnpMaDs2+SCOHC+ID64ViIQaNi8kML0=;
        b=Ne34HWweUq8iPQzQvWLqXZfWWYhoGw8CpTZz3ntH57MiBh3Q/uD/vdQQ44LyO2Pu9M
         RAAVMJYVnJvU14J9nVlsRWCoAJTx5Nq9Rwe5Q8cZnZGOpwR4dFlz6q5Dfme28VINDtMA
         0ashbiyGMYlzkEJPQ9NSRgSO5BFqhIrKHw9WH7svH094ZHzHTPXVzvukNYyMZBSJSJJc
         vskhpyer8/9vqgb+GhP9RZwtDKDb6Tk36mMRBgvfV8ESm7QapiPwuPclTLm8TFc+PU3k
         WHIHLDvYSNjX5hRTAygTl9shdnpNK1A5EwMgODkoSSbEJBZQgknwGgMoVKLXIPvczuOj
         GaTQ==
X-Gm-Message-State: AOAM531LBe+Vwvf8mM8ShRgMUDvz6brsJ+D6eqsTbQuBMS616sSUm7KH
        yV+oj7ll6WbTKxmF/4od7spUoM+lq6Zwufie6UCxKKiEF6iGAzoAbGBiSyfANjmPuGCRdNljYvC
        +O1OISdM4WE2qWb5M6NKFfURI
X-Received: by 2002:a05:600c:42c3:b0:394:7ef8:41c2 with SMTP id j3-20020a05600c42c300b003947ef841c2mr10147986wme.50.1652362029564;
        Thu, 12 May 2022 06:27:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymYc5uo9bcGPb2gArUSPwrRLA9V+VtN5MiG/OnRj0sgFN6X5OmhwXkxKrT+mhuENdoyskCJg==
X-Received: by 2002:a05:600c:42c3:b0:394:7ef8:41c2 with SMTP id j3-20020a05600c42c300b003947ef841c2mr10147967wme.50.1652362029208;
        Thu, 12 May 2022 06:27:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id b1-20020adfc741000000b0020c5253d8cbsm4540368wrh.23.2022.05.12.06.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:27:08 -0700 (PDT)
Message-ID: <8e640253-36e6-5975-7897-174e9210c235@redhat.com>
Date:   Thu, 12 May 2022 15:26:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 01/15] mm/swap: use helper is_swap_pte() in
 swap_vma_readahead
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        peterx@redhat.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-2-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220509131416.17553-2-linmiaohe@huawei.com>
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
> Use helper is_swap_pte() to check whether pte is swap entry to make code
> more clear. Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

