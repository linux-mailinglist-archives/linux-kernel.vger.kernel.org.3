Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F2E50CBC9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbiDWP2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbiDWP2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:28:33 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C650C40E57
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:25:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p10so19092935lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uPFaFyXz+EDuxvlVGUNcApp1IgYD33kJxyk7ho7JgsI=;
        b=qAX7YMz/JVxRQSD3fqnQXDX9zVCZWMtAGJZf1JQG6BC5yFq+jBJs0Bmw87DF2eoCmq
         eB2jJ/jLcplC0r+dgKvQHASQCXlpPx9qQUvjOIRwmext+2BEI0HSQFsH+wCaKaT+dSrx
         pM78v3UdfvFh6ZqEaYYirFC4NVvxB3UYNKeyJAuxTPBGueHYmNO1YXcqFHfXfqC5kFeK
         XCKNDjDTj1YGjwgrnHyOM3osVRjWrQAzoW4HO1CVCAsEzUy/NId/1IIJ6vn2OTwihsxL
         HbGqWv2cHnxee5QlZ8keGC34Wlv1JJF3pXORff0x5PdSPBVpKxUSGjq/0Pa0qxEffFfF
         oZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uPFaFyXz+EDuxvlVGUNcApp1IgYD33kJxyk7ho7JgsI=;
        b=XyI2QWpq0jX+fokHZBGsFLuVlxhvvEAhBObdSOBKHnarVNpeRO8LgoVoddjf1QUdzJ
         pwc8E/UF0IxZAzRXq/mbjD/kBi7s1qUXmWfIkaPNaqQ9vimThv0WlVA+GeYST/8XkX/V
         mYAZDV5Jk6l2/nnIGMJ7wD7b8UJ1dDGwXXbasGWR0qd8crytdouclsQwRvENSbaF8PBL
         kjym2Y4aQJaMXkgWCk/unCa6DjbmFEKW4Xywm7iZhrIaruSMjb2JuyVRmD1eB2DiON9W
         jJioT8QhDqB2B8C6ZuFAxTI6JRF22vOrJ1e8n2hf/IhsDyhX/5Es6+RZTg5Bl+CQPukN
         AkaA==
X-Gm-Message-State: AOAM530CssUzsZ1dumUHoW+nVD6l1rVU97TEwvaRKUcuW3iXBgVWVOgD
        v9oHEjPxh8FtGWQNBuEs+/4=
X-Google-Smtp-Source: ABdhPJwZNl8ZX/SsU1gM9f+mVYW4LB3X8j+kRC6d+voW45tPtkkQcLAFY9FBtTyQGpxCpCgIZRyrOQ==
X-Received: by 2002:a19:dc0f:0:b0:439:702c:d83b with SMTP id t15-20020a19dc0f000000b00439702cd83bmr6906996lfg.192.1650727534046;
        Sat, 23 Apr 2022 08:25:34 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id w23-20020a197b17000000b0046d1729e7d9sm651824lfc.294.2022.04.23.08.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 08:25:33 -0700 (PDT)
Subject: Re: [PATCH V1 3/6] xen/virtio: Add option to restrict memory access
 under Xen
To:     Juergen Gross <jgross@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-4-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204221526221.915916@ubuntu-linux-20-04-desktop>
 <3de2852b-0a94-fd1d-2eb6-fd818f33fc88@gmail.com>
 <8acfaa93-50ce-8dd9-49c6-cc328bb37569@suse.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <cfeec3e9-8a04-b2ae-56bf-153e4ff2d9c7@gmail.com>
Date:   Sat, 23 Apr 2022 18:25:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8acfaa93-50ce-8dd9-49c6-cc328bb37569@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23.04.22 12:10, Juergen Gross wrote:

Hello Juergen

> On 23.04.22 09:05, Oleksandr wrote:
>>
>> On 23.04.22 02:00, Stefano Stabellini wrote:
>>
>> Hello Stefano
>>
>>
>>> On Fri, 22 Apr 2022, Oleksandr Tyshchenko wrote:
>>>> From: Juergen Gross <jgross@suse.com>
>>>>
>>>> Introduce Xen grant DMA-mapping layer which contains special 
>>>> DMA-mapping
>>>> routines for providing grant references as DMA addresses to be used by
>>>> frontends (e.g. virtio) in Xen guests.
>>>>
>>>> In order to support virtio in Xen guests add a config option 
>>>> XEN_VIRTIO
>>>> enabling the user to specify whether in all Xen guests virtio should
>>>> be able to access memory via Xen grant mappings only on the host side.
>>>>
>>>> As this also requires providing 
>>>> arch_has_restricted_virtio_memory_access
>>>> implementation, switch from a pure stub to a real function on Arm
>>>> and combine with existing implementation for the SEV guests on x86.
>>>>
>>>> Add the needed functionality by providing a special set of DMA ops
>>>> handling the needed grant operations for the I/O pages.
>>>>
>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>>> There are a couple of minor things that checkpatch.pl reports,
>>
>> Thank you for pointing this out, my fault.
>>
>>
>>>   but aside
>>> from those the patch looks fine to me.
>>
>> good
>>
>>
>> The attached diff to be squashed for the new version. One thing remains:
>>
>> checkpatch.pl says regarding drivers/xen/grant-dma-ops.c:
>>
>> WARNING: added, moved or deleted file(s), does MAINTAINERS need 
>> updating?
>> #151:
>> new file mode 100644
>>
>>
>> Which, I assume, this is not an issue as new file falls under XEN 
>> HYPERVISOR INTERFACE maintainership?
>
> Yes.


ok, thank you for the confirmation.


>
>
> Juergen

-- 
Regards,

Oleksandr Tyshchenko

