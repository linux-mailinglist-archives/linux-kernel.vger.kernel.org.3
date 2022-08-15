Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF55927FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiHODLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiHODLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0811D64DF
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660533091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SjMszlsPJzqPdD9SX0g5g2TJ7r/jfUNF1gkXOi6GAxg=;
        b=hnOvz8IepOsBbJSwH7bIasw7teAWZi9xcu8GcrYpVJ3djcY6agL6fp8alRHZriGEWly/KV
        zfSYk3qeNwrfidCifw3hERQw4K7hOi2svOEge6bioXCjb9/7e2KbT1WJRSKqG83rcKk5rw
        aO0hR7J8f1G67JWktdbEq0qzjwcZu+A=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-435-wJSQYP1DMdaV8iMGA_G_Og-1; Sun, 14 Aug 2022 23:11:29 -0400
X-MC-Unique: wJSQYP1DMdaV8iMGA_G_Og-1
Received: by mail-lf1-f69.google.com with SMTP id z1-20020a0565120c0100b0048ab2910b13so1002676lfu.23
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=SjMszlsPJzqPdD9SX0g5g2TJ7r/jfUNF1gkXOi6GAxg=;
        b=6E+dMT1bOQbQKk3qlP+G9UZ5mp429gS2wAg+uTpPywS3d5RghVA0je5gaBQHI7KZfe
         NHgrPnmMxi7CDDA+A9AxNG+IPFSvPnH+wyWrUkM4yH5rvCZYosw0qoLC4njUrjWbeJYf
         ZBMpKzbJejrmn63Dv0LDF7RHO0QniHA+hasRuJvXpQFXFqtxL3uh9j2Z6jYIA+n7IJ5J
         V32ent/rldPVYprT/uxWjau5JQ9xaBNlP7EtyONRs3nZcn2BuU3Y0h0fvo0xm/PmmCWi
         h3m1zFpXvCyGcLWUgoJJq8si2vP954TSH6qGQyzVO499GD4l7WVv8TIuXdWD8uH3SK5Z
         cKFw==
X-Gm-Message-State: ACgBeo0QsFbbbj3VvMkFEtoxPVdGjfWEToXblc7IFDkTXZk4McxtoLUC
        VLvWG2HwM4r3U92EZWc2E04/096hqeSlx+iSMWDQhbOXCUUDI7J8CE3O0DPrGN0/jQ5crYOcjAh
        w9p86j+Nxc4eqoN5A3hRm3CY=
X-Received: by 2002:a05:651c:1584:b0:25d:c6ad:6237 with SMTP id h4-20020a05651c158400b0025dc6ad6237mr4128017ljq.509.1660533088452;
        Sun, 14 Aug 2022 20:11:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR75Rkq4uNFv4jWdO6CE/+UN/BzpT4Y4J0IXpmyBUcSf+60GXQXh+SEmp9hi7JNUXySLvgWU7A==
X-Received: by 2002:a05:651c:1584:b0:25d:c6ad:6237 with SMTP id h4-20020a05651c158400b0025dc6ad6237mr4128010ljq.509.1660533088227;
        Sun, 14 Aug 2022 20:11:28 -0700 (PDT)
Received: from [192.168.1.121] (91-145-109-188.bb.dnainternet.fi. [91.145.109.188])
        by smtp.gmail.com with ESMTPSA id h5-20020a05651c124500b0025e2cb58c6esm1271348ljh.37.2022.08.14.20.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 20:11:27 -0700 (PDT)
Message-ID: <58be2b37-0c3a-06d8-35f5-50bf4b765fb2@redhat.com>
Date:   Mon, 15 Aug 2022 06:11:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] selftests/hmm-tests: Add test for dirty bits
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linuxram@us.ibm.com,
        paulus@ozlabs.org
References: <a9daea363991c023d0364be22a762405b6c6f5c4.1660281458.git-series.apopple@nvidia.com>
 <8f19b172d32be2e889b837f88b1ba070bf2c97ee.1660281458.git-series.apopple@nvidia.com>
 <1ec090fa-f93b-c197-e5b3-ff2b0d5862ef@redhat.com>
 <87lerqw72n.fsf@nvdebian.thelocal>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <87lerqw72n.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.8.2022 5.35, Alistair Popple wrote:
> 
> Mika Penttilä <mpenttil@redhat.com> writes:
> 
>> Hi Alistair!
>>
>> On 12.8.2022 8.22, Alistair Popple wrote:
> 
> [...]
> 
>>> +	buffer->ptr = mmap(NULL, size,
>>> +			   PROT_READ | PROT_WRITE,
>>> +			   MAP_PRIVATE | MAP_ANONYMOUS,
>>> +			   buffer->fd, 0);
>>> +	ASSERT_NE(buffer->ptr, MAP_FAILED);
>>> +
>>> +	/* Initialize buffer in system memory. */
>>> +	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>>> +		ptr[i] = 0;
>>> +
>>> +	ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 1UL<<30));
>>> +
>>> +	/* Fault pages back in from swap as clean pages */
>>> +	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>>> +		tmp += ptr[i];
>>> +
>>> +	/* Dirty the pte */
>>> +	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>>> +		ptr[i] = i;
>>> +
>>
>> The anon pages are quite likely in memory at this point, and dirty in pte.
> 
> Why would the pte be dirty? I just confirmed using some modified pagemap
> code that on my system at least this isn't the case.
> 
>>> +	/*
>>> +	 * Attempt to migrate memory to device, which should fail because
>>> +	 * hopefully some pages are backed by swap storage.
>>> +	 */
>>> +	ASSERT_TRUE(hmm_migrate_sys_to_dev(self->fd, buffer, npages));
>>
>> And pages marked dirty also now. But could you elaborate how and where the above
>> fails in more detail, couldn't immediately see it...
> 
> Not if you don't have patch 1 of this series applied. If the
> trylock_page() in migrate_vma_collect_pmd() succeeds (which it almost
> always does) it will have cleared the pte without setting PageDirty.
> 

Ah yes but I meant with the patch 1 applied, the comment "Attempt to 
migrate memory to device, which should fail because hopefully some pages 
are backed by swap storage" indicates that hmm_migrate_sys_to_dev() 
would fail..and there's that ASSERT_TRUE which means fail here.

So I understand the data loss but where is the hmm_migrate_sys_to_dev() 
failing, with or wihtout patch 1 applied?




> So now we have a dirty page without PageDirty set and without a dirty
> pte. If this page gets swapped back to disk and is still in the swap
> cache data will be lost because reclaim will see a clean page and won't
> write it out again.
> 
> At least that's my understanding - please let me know if you see
> something that doesn't make sense.
> 
>>> +
>>> +	ASSERT_FALSE(write_cgroup_param(cgroup, "memory.reclaim", 1UL<<30));
>>> +
>>> +	/* Check we still see the updated data after restoring from swap. */
>>> +	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>>> +		ASSERT_EQ(ptr[i], i);
>>> +
>>> +	hmm_buffer_free(buffer);
>>> +	destroy_cgroup();
>>> +}
>>> +
>>>    /*
>>>     * Read anonymous memory multiple times.
>>>     */
>>
>>
>> --Mika
> 

