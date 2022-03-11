Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD4C4D5EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347384AbiCKJ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiCKJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:56:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57CA31B6E30
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646992518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ylmH23lNYpJ5L3ifT6u21HFSeJ1A7vGW+YoFCvEO9M0=;
        b=BS+EOAtcWUZn4dZ+R9C+4E9dAxsplpEHKXTDG2pj37ZbMl+Lxn+eogxLR+Pi3UyKzriF+V
        8SXZs5aJcWVKyqR76UDyQzhoS4g/s8Y9cjh2dRocsyWoSZFBXVONjRjryQT7p0EB/hHotY
        YBGouwKX2blnkLvBHGF0Rb+CfsrkKFc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-BLmQOyNXP2mCCA7YWe41eg-1; Fri, 11 Mar 2022 04:55:17 -0500
X-MC-Unique: BLmQOyNXP2mCCA7YWe41eg-1
Received: by mail-wr1-f69.google.com with SMTP id t15-20020a5d534f000000b001f1e5759cebso2637515wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ylmH23lNYpJ5L3ifT6u21HFSeJ1A7vGW+YoFCvEO9M0=;
        b=Inb3Nwxatcnxnr/uh654L/xlQHB9MpquETRYCiVt2F5ksG6IyxbZKU+4Dp73G8r+YK
         EmzuzYQ9JX9CApxu7LrjjY7b2nUJkx1y8F8Et/ADLTrMbqk+IWwSRHcSyW/iZErZGxMw
         aq8adg7zgMKnQwshgAHKpWOVJC4nvxUgk9sm0PkRlyLZNFyzc20zXaHEGRj9RGROuiZm
         DjgSZeunH6FY5KS3lUp0GVI8TEKTxLhcqhCzbUUDTEwu0COjMf3CX9jXsWXu6r7hYTgB
         0qZYKASlkBvAUwdXGzDBMko4tAy8yjGhA5aEJh4IGA1aakqJ+rYHGOXyGAKO7JI9TsBf
         sn2g==
X-Gm-Message-State: AOAM530DKvJJmJw2Rk4brN5WRV5k1XQCZlm5+FmKYJz9qTYzJa19RoRb
        kqif4rMtF6VlP1ak9wcy+7Q/U5r4WbMo0UuvqZpBKYKyfbSXoB8tNs3IbpR6zGpDy6W34BLDG0z
        VElo4hIY1JR0kfFVjhZtIu6MQ
X-Received: by 2002:a5d:64e5:0:b0:1f1:fa31:e7d3 with SMTP id g5-20020a5d64e5000000b001f1fa31e7d3mr6940753wri.573.1646992515898;
        Fri, 11 Mar 2022 01:55:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLC643/T4UbINF7UgQYXhn1FtkQIwPzi08Sb5vJL6N19y2iFpM7UaA6J5H7uueEZlzOIGkoQ==
X-Received: by 2002:a5d:64e5:0:b0:1f1:fa31:e7d3 with SMTP id g5-20020a5d64e5000000b001f1fa31e7d3mr6940740wri.573.1646992515653;
        Fri, 11 Mar 2022 01:55:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:8200:163d:7a08:6e61:87a5? (p200300cbc7078200163d7a086e6187a5.dip0.t-ipconnect.de. [2003:cb:c707:8200:163d:7a08:6e61:87a5])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c354b00b00389f440512esm591995wmq.32.2022.03.11.01.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 01:55:15 -0800 (PST)
Message-ID: <caf087b4-b184-c45e-e212-87f0a573a4d0@redhat.com>
Date:   Fri, 11 Mar 2022 10:55:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm/khugepaged: sched to numa node when collapse huge page
Content-Language: en-US
To:     maobibo <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220311090119.2412738-1-maobibo@loongson.cn>
 <52412f08-829a-6c29-60c6-a24c866e6253@redhat.com>
 <d2883450-1278-877e-e273-bda5a5728465@loongson.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <d2883450-1278-877e-e273-bda5a5728465@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.22 10:51, maobibo wrote:
> 
> 
> On 03/11/2022 05:20 PM, David Hildenbrand wrote:
>> On 11.03.22 10:01, Bibo Mao wrote:
>>> collapse huge page is slow, specially when khugepaged daemon runs
>>> on different numa node with that of huge page. It suffers from
>>> huge page copying across nodes, also cache is not used for target
>>> node. With this patch, khugepaged daemon switches to the same numa
>>> node with huge page. It saves copying time and makes use of local
>>> cache better.
>>
>> Hi,
>>
>> just the usual question, do you have any performance numbers to back
>> your claims (e.g., "is slow, specially when") and proof that this patch
>> does the trick?
> With specint 2006 on loongarch 3C5000L 32core numa system, it improves
> about 6%. The page size is 16K and pmd page size is 32M, memory performance
> across numa node is obvious different. However I do not test it on x86 box.
> 

Thanks, can you add these details to the patch description?


-- 
Thanks,

David / dhildenb

