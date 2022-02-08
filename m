Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0694AD4A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353959AbiBHJUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353986AbiBHJUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:20:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5CCBC03FEC9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644311989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgE3JiFXNWBGyW03yQCPZB4yjBQ25a9J59YHnaFuEGk=;
        b=CB6HktTjOZxs0VGEu9mv6QyTF53UYJCJfqRmK/lpG6LAPzzMTRlOfG1OL1TkDW/Rdo4ZSl
        WrGaGOL2hGkCAaRZ8q6gAYg4AxEuwqWGyZbsjClXwslB9bh/c2qrTVwrplwh4BMPtG3QiJ
        f64TRjI6gFTUzV9tyKtGA42OgqmOg1g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-bRT8A4bJP6WeZ66EP8Z6Qw-1; Tue, 08 Feb 2022 04:19:48 -0500
X-MC-Unique: bRT8A4bJP6WeZ66EP8Z6Qw-1
Received: by mail-wm1-f69.google.com with SMTP id a8-20020a7bc1c8000000b0037bc4c62e97so297384wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:19:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=fgE3JiFXNWBGyW03yQCPZB4yjBQ25a9J59YHnaFuEGk=;
        b=SDM3bdhzNicJGaQ0ANSZYpCmLldSepAyhpI034Ti4S2Xt7oIWdvIaPaVUfKaS19sW3
         uSxLqjSBgDzDQVn8NqpudDYblVwqJahWAdmOfb+OnCNQ/1lPxhheDdpd65qzGZBZvQon
         6mLCWUCU7saKvAoKKIlZS3sff/Pndq6iaPBLDTSF9qiGKwKUmm24gijM/K/gNxa6F1Tc
         9vg+f/o6X3R2K/R8lBsknMIIMzu8TFm9GuMZb8h99law7wklcxlPrrsn13fzNQ9E/dqa
         QfGQsIdbPDr9XlC6afRiYIokBXEKjEALzkGRLzRx1/GHCO7EpgB5JMJxV0LyiGSCiBfB
         RMdQ==
X-Gm-Message-State: AOAM532fcu/whWankI4MR7Yh87AipSs00O4CspvMvdqwqaefLJB7gOjf
        u8XNADIE1hbDX3ue0odT1urA4LZ+XEL3W9HapBlpho8Xed6QpNwRAdcU/LuO1clyVMzgoN1JQet
        8Q0PCZG86dyRREfiIZKQ3iEXn
X-Received: by 2002:a05:600c:3d8c:: with SMTP id bi12mr257730wmb.109.1644311987459;
        Tue, 08 Feb 2022 01:19:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+jC4XaVIAqmUjzqE4Je42JPMCnYWJ1tp9Ma4OMpqAmYGYyuzchSbYXG2LU+CPhV2XdI1Wpw==
X-Received: by 2002:a05:600c:3d8c:: with SMTP id bi12mr257716wmb.109.1644311987231;
        Tue, 08 Feb 2022 01:19:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c712:a800:a1a0:a823:5301:d1af? (p200300cbc712a800a1a0a8235301d1af.dip0.t-ipconnect.de. [2003:cb:c712:a800:a1a0:a823:5301:d1af])
        by smtp.gmail.com with ESMTPSA id o3sm4567283wrc.41.2022.02.08.01.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 01:19:46 -0800 (PST)
Message-ID: <72ae5d5b-512e-4dd4-4bb0-d867fb788f60@redhat.com>
Date:   Tue, 8 Feb 2022 10:19:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     isimatu.yasuaki@jp.fujitsu.com, toshi.kani@hp.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220207135618.17231-1-linmiaohe@huawei.com>
 <6d4ab70e-b944-5f7d-e9a3-979ac66c70f7@redhat.com>
 <828c9b16-6ff0-abb7-3a16-277d2d60de81@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/memory_hotplug: fix kfree() of bootmem memory
In-Reply-To: <828c9b16-6ff0-abb7-3a16-277d2d60de81@huawei.com>
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

On 08.02.22 02:59, Miaohe Lin wrote:
> Hi:
> On 2022/2/7 22:33, David Hildenbrand wrote:
>> On 07.02.22 14:56, Miaohe Lin wrote:
>>> We can't use kfree() to release the resource as it might come from bootmem.
>>> Use release_mem_region() instead.
>>
>> How can this happen? release_mem_region() is called either from
>> __add_memory() or from add_memory_driver_managed(), where we allocated
>> the region via register_memory_resource(). Both functions shouldn't ever
>> be called before the buddy is up an running.
>>
>> Do you have a backtrace of an actual instance of this issue? Or was this
>> identified as possibly broken by code inspection?
>>
> 
> This is identified as possibly broken by code inspection. IIUC, alloc_resource
> is always used to allocate the resource. It has the below logic:
> 
>   if (bootmem_resource_free) {
> 	res = bootmem_resource_free;
> 	bootmem_resource_free = res->sibling;
>   }
> 
> where bootmem_resource_free is used to reusing the resource entries allocated by boot
> mem after the system is up:
> 
> /*
>  * For memory hotplug, there is no way to free resource entries allocated
>  * by boot mem after the system is up. So for reusing the resource entry
>  * we need to remember the resource.
>  */
> static struct resource *bootmem_resource_free;
> 
> So I think register_memory_resource() can reuse the resource allocated by bootmem.
> Or am I miss anything?

I think you're right, if we did a previous free_resource() of a resource allocated
during boot we could end up reusing that here. My best guess is that this never
really happens.

Wow, that's ugly. It affects essentially anybody reserving+freeing a resource.

E.g., dax/kmem.c similarly does a release_resource(res)+kfree(res)


We could either

a) Expose free_resource() and replace all kfree(res) instances by it

b) Just simplify that. I don't think we care about saving a couple of 
   bytes in corner cases. I might be wrong (IIRC primarily ppc64 really 
   succeeds in unplugging boot memory)


diff --git a/kernel/resource.c b/kernel/resource.c
index 9c08d6e9eef2..fe91a72fd951 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -56,14 +56,6 @@ struct resource_constraint {
 
 static DEFINE_RWLOCK(resource_lock);
 
-/*
- * For memory hotplug, there is no way to free resource entries allocated
- * by boot mem after the system is up. So for reusing the resource entry
- * we need to remember the resource.
- */
-static struct resource *bootmem_resource_free;
-static DEFINE_SPINLOCK(bootmem_resource_lock);
-
 static struct resource *next_resource(struct resource *p)
 {
        if (p->child)
@@ -160,36 +152,19 @@ __initcall(ioresources_init);
 
 static void free_resource(struct resource *res)
 {
-       if (!res)
-               return;
-
-       if (!PageSlab(virt_to_head_page(res))) {
-               spin_lock(&bootmem_resource_lock);
-               res->sibling = bootmem_resource_free;
-               bootmem_resource_free = res;
-               spin_unlock(&bootmem_resource_lock);
-       } else {
+       /*
+        * If the resource was allocated using memblock early during boot
+        * we'll leak it here: we can only return full pages back to the
+        * buddy and trying to be smart and reusing them eventually in
+        * alloc_resource() overcomplicates resource handling.
+        */
+       if (res && PageSlab(virt_to_head_page(res)))
                kfree(res);
-       }
 }
 
 static struct resource *alloc_resource(gfp_t flags)
 {
-       struct resource *res = NULL;
-
-       spin_lock(&bootmem_resource_lock);
-       if (bootmem_resource_free) {
-               res = bootmem_resource_free;
-               bootmem_resource_free = res->sibling;
-       }
-       spin_unlock(&bootmem_resource_lock);
-
-       if (res)
-               memset(res, 0, sizeof(struct resource));
-       else
-               res = kzalloc(sizeof(struct resource), flags);
-
-       return res;
+       return kzalloc(sizeof(struct resource), flags);
 }
 
 /* Return the conflict entry if you can't request it */


-- 
Thanks,

David / dhildenb

