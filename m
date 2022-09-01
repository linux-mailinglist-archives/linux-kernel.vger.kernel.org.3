Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0635A92AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiIAJFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbiIAJEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5362C134D4E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662022991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrKHoCTy/cp62lo3FDhMr8bD3kYn4ot6+m7P8dmXw60=;
        b=GtPkh9c2Tlxkd+KT5TY5Emqr2cQiyk4MIWSTKKSMKH6/hUBxmpfnQAOEg5WnY2kZmO5q1a
        NG3VJ0j16nzflSqgsq+yTu14yWshrfRMA2x9IIYo+V7AM23xNbMAaIHP5BkxGTVq+vdY8j
        Hf/zGvOFyv50H8hTZ9i549/QkrwGS0I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-5-MYls7W_GMIm_qjTfgPOZWg-1; Thu, 01 Sep 2022 05:03:10 -0400
X-MC-Unique: MYls7W_GMIm_qjTfgPOZWg-1
Received: by mail-wm1-f69.google.com with SMTP id r83-20020a1c4456000000b003a7b679981cso968276wma.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=mrKHoCTy/cp62lo3FDhMr8bD3kYn4ot6+m7P8dmXw60=;
        b=TPmbjHR20uf4oT51jkOyrhYkprBq0mozZQ76/gOILcT7Kwr8/B7w2/ickIKGguxuvA
         oijgkhAxV6IGZluOx3quSbCPQ742onXLXVCiWeSde5zxwKCuKTWKr/6zOlZCGqsxQJA9
         HYCQXshxszyBHs6CI3A2weDp0H/5Q0wtF80gdz43nLIqKQS6WwMcj2fR8Jlx46xzR7jt
         HnYLEOIIy4HyM4HPECvKqRQ5kh271XkPS1qyGt6xu0DwrH7xqCD2YPA3E3yPJXhWq9jx
         GnLCvlG5+j2lZFXOVvVS5pf2ooBgjlnVqau9Vmz7lv5KA1hU/GP6GQ8EjoTQiLrlo+J+
         MADg==
X-Gm-Message-State: ACgBeo0onB3MjY+oURFZmrQsoNBCn/aL1lixO9NhRdJO9xoYWJBK2S00
        cgbMS1YDjqls01AHVonFj/ghFcLVoUmYEusKGpkrLSO09QkgKIdukrUxgdzNF4U1QKmVdqGsKBw
        khuK3c5KQxQ0Zu6DMQii/bKxN
X-Received: by 2002:a05:6000:15c7:b0:226:f1f6:a061 with SMTP id y7-20020a05600015c700b00226f1f6a061mr2160715wry.395.1662022989305;
        Thu, 01 Sep 2022 02:03:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6A195Tuml2HQ1a93DU2zk3JUgL5Enmdh6tJBboweFD9ejBDdn4Dq3In44+Nfh9iP7w/u9dxg==
X-Received: by 2002:a05:6000:15c7:b0:226:f1f6:a061 with SMTP id y7-20020a05600015c700b00226f1f6a061mr2160702wry.395.1662022989069;
        Thu, 01 Sep 2022 02:03:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9e00:fec0:7e96:15cb:742? (p200300cbc7079e00fec07e9615cb0742.dip0.t-ipconnect.de. [2003:cb:c707:9e00:fec0:7e96:15cb:742])
        by smtp.gmail.com with ESMTPSA id q3-20020adff943000000b0021efc75914esm14186300wrr.79.2022.09.01.02.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 02:03:08 -0700 (PDT)
Message-ID: <e20c2f22-5df7-270c-27c4-13af0d3b3904@redhat.com>
Date:   Thu, 1 Sep 2022 11:03:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm: hugetlb: eliminate memory-less nodes handling
Content-Language: en-US
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Muchun Song <songmuchun@bytedance.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, ying.huang@intel.com, rientjes@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220901083023.42319-1-songmuchun@bytedance.com>
 <c39c6ed2-4766-71d2-d459-6bb39f09943a@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c39c6ed2-4766-71d2-d459-6bb39f09943a@linux.ibm.com>
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

On 01.09.22 11:00, Aneesh Kumar K V wrote:
> On 9/1/22 2:00 PM, Muchun Song wrote:
>> The memory-notify-based approach aims to handle meory-less nodes, however, it just adds
>> the complexity of code as pointed by David in thread [1].  The handling of memory-less
>> nodes is introduced by commit 4faf8d950ec4 ("hugetlb: handle memory hot-plug events").
>> From its commit message, we cannot find any necessity of handling this case. So, we can
>> simply register/unregister sysfs entries in register_node/unregister_node to simlify the
>> code.
> 
> Isn't that hotplug callback added because in hugetlb_register_all_nodes() we register
> sysfs nodes only for N_MEMORY nodes? 
> 

Right, that needs adjustment as well.


-- 
Thanks,

David / dhildenb

