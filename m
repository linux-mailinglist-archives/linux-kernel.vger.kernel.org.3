Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16760543739
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbiFHPV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245731AbiFHPUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:20:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC58113903A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654701423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8H9jGB7E9Z50aLgeVMMhOdyAwsTkxFP1izvYrfhgfg=;
        b=RA8oGHf3moQi17BWYwf+nWOSbdXxkWLU1z+KxxJKfioDm4TnD31H5yjm4stQ9zzcddQuNY
        fQf3cX/y1evtP7kCwRDENETKn3gNGtmZfDaEvyvRS1J0Q0JT85VlshEc7OOEX+wNpzvYCY
        24nm6TIDSXFAZE5ZE3kGtNhL33G8Kbc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-yZE0pfDoM22pRZoGQAD0hg-1; Wed, 08 Jun 2022 11:17:02 -0400
X-MC-Unique: yZE0pfDoM22pRZoGQAD0hg-1
Received: by mail-wm1-f71.google.com with SMTP id ay1-20020a05600c1e0100b0039c3a3fc6a4so7078502wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=y8H9jGB7E9Z50aLgeVMMhOdyAwsTkxFP1izvYrfhgfg=;
        b=Oknl6+roN8fXlfMg2cI2oLj4ntzO5DdNYxDLbtQ5Hdm88C/kARa7r9S1KcJUio4Ni0
         mjEzPY9BSrX/UixNCFU3VZYoigAHdFT5bOm107JwI6+zQ59g9cavDf5zPo67IfqCm9Bl
         FdRXOrFWp+RwxVr01meNeVwIUiyhyLVocK4oKHMMkRGj8Y4uu9UrYW9YJGknJfyk/41T
         czSXSdiCCwoxgdqnf4BM2YTG1twbCEk9lAKVKwnj9ytn2XsGORftBC75BpcAlYZ4eeZS
         DYN9llspiF6GedDMgqxnUQgbywUYFYs819DODWNqWZIEGMN54ULQFwOM9HPtsxOZu/LN
         B7Dg==
X-Gm-Message-State: AOAM532QdTqD13phX2/INyeahnllNthyYyQcLT6I5EWwwCSHOCOUwf3S
        kVXd1Ljsd3OyNlN2/ySKxVYvX0hm6hmLkPz2tPIbQdXfpswcty4DsB8zN1fL/q7V2GT+zsKuPRu
        B3HE+3NPem5LsVno7YDbivXKy
X-Received: by 2002:a05:600c:3ba6:b0:397:5508:652d with SMTP id n38-20020a05600c3ba600b003975508652dmr64645336wms.126.1654701420809;
        Wed, 08 Jun 2022 08:17:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzACjV0q1j/MZdf3myhyht9jNflmTjecKJCZdzLXqgYUj70QjsvLN+eY19mHafUixzLazP+zw==
X-Received: by 2002:a05:600c:3ba6:b0:397:5508:652d with SMTP id n38-20020a05600c3ba600b003975508652dmr64645310wms.126.1654701420494;
        Wed, 08 Jun 2022 08:17:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ad00:db2:4c6:8f3a:2ec4? (p200300cbc705ad000db204c68f3a2ec4.dip0.t-ipconnect.de. [2003:cb:c705:ad00:db2:4c6:8f3a:2ec4])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c4f0d00b0039c55bc2c97sm7819484wmq.16.2022.06.08.08.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 08:16:58 -0700 (PDT)
Message-ID: <b27d36fe-0403-f56d-e3f1-324298f1d5ed@redhat.com>
Date:   Wed, 8 Jun 2022 17:16:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 3/3] mm/swap: remove swap_cache_info statistics
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220608144031.829-1-linmiaohe@huawei.com>
 <20220608144031.829-4-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220608144031.829-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.06.22 16:40, Miaohe Lin wrote:
> swap_cache_info are not statistics that could be easily used to tune system
> performance because they are not easily accessile. Also they can't provide
> really useful info when OOM occurs. Remove these statistics can also help
> mitigate unneeded global swap_cache_info cacheline contention.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

