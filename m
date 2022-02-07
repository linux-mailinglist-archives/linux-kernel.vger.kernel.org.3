Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3E34AC1A4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382760AbiBGOn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441840AbiBGOdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:33:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4A37C0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644244417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DooD/eUQIOsSU0GuUs2p2pfvlueEe65OpvoCl34gtw8=;
        b=hdwdP0jlo7MejfflofK37s03V47uemtSnt9pjX87XVdHHA9LvnXhNCB97J0L6OEwq8i61x
        F1kayMaDTmmH0i8Wr1LbbpuRvkVg7igNOTYZzVudUIQs7+921CPwPce5/2YFO4NAvqN7Cs
        Y8yZzxVrygosJfHBaJGzkb79b5ncgUM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-89983t8LMgyh3AWiTGAiaw-1; Mon, 07 Feb 2022 09:33:36 -0500
X-MC-Unique: 89983t8LMgyh3AWiTGAiaw-1
Received: by mail-wm1-f72.google.com with SMTP id n3-20020a05600c294300b0037bc685b717so1637294wmd.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 06:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=DooD/eUQIOsSU0GuUs2p2pfvlueEe65OpvoCl34gtw8=;
        b=Dhx1QxsLF/sgmgDrv/8+usHu8Ymdfdw7twIdVerHK9UHRYfml9klBe6FxXxgGfIvfE
         5y6fNWdtyQeg4P4JKvLoniZ0QjSoLMuc/UwcV4lFahbg2RbwC3YiwJTqfLNOGKxR3FlM
         VcWmiBkHI6sltSWLtL7YFhk/XnPpzsd/onIygnhwnOz3AAq16nOX/brmrTpZanWa+bAR
         fA82bBpylPtrifkrub8q1jCfpjv1bzuoJBxc4luI5BByT81nsRqEIFH8n2uqq59yzfjw
         oBkKod4FSRP+akYVF0vYC9dek2x3XH1/lPkjjtWtsDhfHi1873eaMISJSeGnqtxhZqEc
         EcJQ==
X-Gm-Message-State: AOAM533PVZDeJxozkeAzvb7KZ3acgvbj26CXJnXmFE8QLEjNHNYNGdv7
        wNtjzcP2XoAVc8X1O7O5rXgjfJtswcNz3ulYxnnoc5myXu4k46w7s5Eh7r0tPcWU8O50W1GiTN/
        74Ze5BNmLOopvVFpWQ00jBy2z
X-Received: by 2002:a5d:47c2:: with SMTP id o2mr10221395wrc.143.1644244415598;
        Mon, 07 Feb 2022 06:33:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXPlrsc3WVU2WCDHC7xWrbyQ8MhMs0AxOT19FexSR5IVk1QQ4rP0mfzjK34/aqbM6LemoI8A==
X-Received: by 2002:a5d:47c2:: with SMTP id o2mr10221378wrc.143.1644244415397;
        Mon, 07 Feb 2022 06:33:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:6300:a751:d742:1f76:8639? (p200300cbc7096300a751d7421f768639.dip0.t-ipconnect.de. [2003:cb:c709:6300:a751:d742:1f76:8639])
        by smtp.gmail.com with ESMTPSA id u7sm2354316wrq.112.2022.02.07.06.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 06:33:34 -0800 (PST)
Message-ID: <6d4ab70e-b944-5f7d-e9a3-979ac66c70f7@redhat.com>
Date:   Mon, 7 Feb 2022 15:33:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm/memory_hotplug: fix kfree() of bootmem memory
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     isimatu.yasuaki@jp.fujitsu.com, toshi.kani@hp.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220207135618.17231-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220207135618.17231-1-linmiaohe@huawei.com>
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

On 07.02.22 14:56, Miaohe Lin wrote:
> We can't use kfree() to release the resource as it might come from bootmem.
> Use release_mem_region() instead.

How can this happen? release_mem_region() is called either from
__add_memory() or from add_memory_driver_managed(), where we allocated
the region via register_memory_resource(). Both functions shouldn't ever
be called before the buddy is up an running.

Do you have a backtrace of an actual instance of this issue? Or was this
identified as possibly broken by code inspection?

-- 
Thanks,

David / dhildenb

