Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440BA53912F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbiEaM6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343774AbiEaM63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90B8A165A2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654001906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJzRl/EAUUDSUoaXNS58+5bfHcPFBTMs+k9QJoMWfnM=;
        b=Te6ddr7wyeVbgAQki8hgiM9yTt22TQp95K9cClJoYWh+A5SLBMks+J0bOEn21HwFntxY5T
        nsE48vgfJYiO5wT7c4HAcMf8DJow9v4z0DYLjmpSDX+2sYjBSJHMsNavcBAW81wyO92PvN
        yd1cjEFhFuPbac0hD19kuXf6cd82isQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-aUaWv3QHOQ6-nN1jCocdKw-1; Tue, 31 May 2022 08:58:25 -0400
X-MC-Unique: aUaWv3QHOQ6-nN1jCocdKw-1
Received: by mail-wm1-f70.google.com with SMTP id u12-20020a05600c19cc00b0038ec265155fso1420941wmq.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=cJzRl/EAUUDSUoaXNS58+5bfHcPFBTMs+k9QJoMWfnM=;
        b=0vgYJYCf/3NjKPG03wxYKpnKw19/kEbn4/aayiVCZMT7BEOpZnnQhUDVl/TtH/l5Ko
         LZb0ZJZYSgldR1EVny8kr9yTvXz42bR1d/xRr7X2p5teDxa+mzXQ6T5/yGDoFg2YO8E8
         X2AsSzC3k4VSC+FyvfOzxGA2lgezsjYe3ljzJJwkMQkRAVSumzxxzRVs2LpXZVKCNhx+
         3cAaJKEyeUBP+R4icCizKj7llzPR3ridkbkMHRJ3aEzgsnqRTy+/0qVIXF8WEHV7KZqr
         T7+unKXMWW2b19+qfzgrQC0HsJz35c38ZRAvd4B4h36K3cTwrFnL3AAdqh62iP/hId27
         foyQ==
X-Gm-Message-State: AOAM531F3dTjZorGFVMPDsPhNBvZsLAptfGZ/LSJfo8NM2xVr3UrTELC
        LAS0yh1F/qK9WVgV1RJs8DxdiVFGSiqQQdQ5ImIi9IcOaYyVz19LJUz2tcey4p/koyzl/mkIX8I
        9BTenjk4s1B66LXsePoePspo6
X-Received: by 2002:a5d:6dd1:0:b0:210:7a1:cda0 with SMTP id d17-20020a5d6dd1000000b0021007a1cda0mr22110702wrz.570.1654001904016;
        Tue, 31 May 2022 05:58:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4lEZ2qYCcp+tZI59iZ53qvkpDUdPbWhwtv+KszQQJhbzbDUSUqZ4BFrX3BMLlZOcjJRvNkQ==
X-Received: by 2002:a5d:6dd1:0:b0:210:7a1:cda0 with SMTP id d17-20020a5d6dd1000000b0021007a1cda0mr22110685wrz.570.1654001903796;
        Tue, 31 May 2022 05:58:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f100:8096:9368:ba52:a341? (p200300cbc708f10080969368ba52a341.dip0.t-ipconnect.de. [2003:cb:c708:f100:8096:9368:ba52:a341])
        by smtp.gmail.com with ESMTPSA id s14-20020a7bc38e000000b003942a244ee7sm2053956wmj.44.2022.05.31.05.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 05:58:22 -0700 (PDT)
Message-ID: <33d6aec8-b4fc-aa37-27f4-f33984ea33d3@redhat.com>
Date:   Tue, 31 May 2022 14:58:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] mm/swapfile: avoid confusing swap cache statistics
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220527092626.31883-1-linmiaohe@huawei.com>
 <20220527092626.31883-3-linmiaohe@huawei.com>
 <20220530160409.c9b17085adb6112d8580f37d@linux-foundation.org>
 <c7d6fec7-039d-2f54-c3b3-95deb7417a73@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c7d6fec7-039d-2f54-c3b3-95deb7417a73@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.22 04:55, Miaohe Lin wrote:
> On 2022/5/31 7:04, Andrew Morton wrote:
>> On Fri, 27 May 2022 17:26:25 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>>> At swapoff time, we're going to swap in the pages continuously. So calling
>>> lookup_swap_cache would confuse statistics. We should use find_get_page
>>> directly here.
>>
>> Why is the existing behaviour wrong?  swapoff() has to swap stuff in to
>> be able to release the swap device.  Why do you believe that this
>> swapin activity should not be accounted?
> 
> IMHO, statistics, e.g. swap_cache_info.find_success, are used to show the effectiveness
> of the swap cache activity. So they should only reflect the memory accessing activity
> of the user. I think swapoff can't reflect the effectiveness of the swap cache activity
> because it just swaps in pages one by one. Or statistics should reflect all the activity
> of the user including swapoff?

I'm wondering who cares and why?


-- 
Thanks,

David / dhildenb

