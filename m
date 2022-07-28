Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE724583B29
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbiG1JXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiG1JXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50E476566A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659000217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MUUHnK3mGjBTIixFdMqpioqDxoaunFSmdGJUDWVh8gY=;
        b=fy1hI5tSguC+KnHazRGc9PMlA76Hnp/gem56+vEykEjR6jl0qyZSW6nOdffaHoiHUmYlkJ
        CnYIJQVVzo5eOo0Yuvj4r4QE688Vto0tsyzpx9iBmzmAsfrVtOqTvGaW0WK2OW12wjv4+Q
        FhnQAVt3HCmWULavUgBkvUheA+e+238=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-tAaXZ2XBPQa1vbNrIsQVkw-1; Thu, 28 Jul 2022 05:23:35 -0400
X-MC-Unique: tAaXZ2XBPQa1vbNrIsQVkw-1
Received: by mail-wm1-f70.google.com with SMTP id n19-20020a05600c3b9300b003a314062cf4so2367197wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=MUUHnK3mGjBTIixFdMqpioqDxoaunFSmdGJUDWVh8gY=;
        b=L9xo3ADhYs8wYfTYicGrsKgoKkZSYn6F/F19E4N9lQvRNuqmRVNuSqONpqZ+0eIbcB
         XptMdl9vbFoEQ8rGlU6V6fJRSWu+s6KAHoqq5qxv5W9FrSQQ9D280+h+fJvZ9zDAeSaD
         KRU+9736E5IFFuAoQodjji4Hr8oinlsP5N9o+/RM35jSX293Zb59bWH0Wgj+KJCH3W9e
         pNfVazMzdJoOfgTxyntx12mXjZvIxOIpt/uMccQnk0LN9q2zNDNeZtzxTqEBB8vkYT53
         iZGKS6qtVzjkhr5C4jnniDrlqPs2Tids8zIwjduOsoBmPCFsWlidmW1VCgHKjgzjzrLk
         fqnw==
X-Gm-Message-State: AJIora9wKLZ8NPKM7xXc8uCLT2e8KiHcyTURYG+hdluj05ped3j4kJAM
        LzKGc8DnBOdJjAE5jiuUbHTyWVOO5Ctk7bayYfzg229NeVM0reIVOYPMLrf42h48LfMnymG4UvU
        Y9Iwndbb1jy/oqBtzDuxFKaaL
X-Received: by 2002:a05:600c:3510:b0:3a3:34e7:cfc8 with SMTP id h16-20020a05600c351000b003a334e7cfc8mr6168706wmq.164.1659000214724;
        Thu, 28 Jul 2022 02:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v68N2cLgOVDHlO2BHTuQI5rx78/bTHvWixAJqi4+qCUXnGL4+jti75UpEFTdiWn82+6TUIgA==
X-Received: by 2002:a05:600c:3510:b0:3a3:34e7:cfc8 with SMTP id h16-20020a05600c351000b003a334e7cfc8mr6168689wmq.164.1659000214387;
        Thu, 28 Jul 2022 02:23:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:7b00:9c4:744b:b126:3a28? (p200300cbc7047b0009c4744bb1263a28.dip0.t-ipconnect.de. [2003:cb:c704:7b00:9c4:744b:b126:3a28])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm254643wro.91.2022.07.28.02.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 02:23:33 -0700 (PDT)
Message-ID: <6492e852-8acf-95a9-a3a0-8ce8bbaf46d6@redhat.com>
Date:   Thu, 28 Jul 2022 11:23:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm: Re-allow pinning of zero pfns
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        jhubbard@nvidia.com, joaodias@google.com
References: <165490039431.944052.12458624139225785964.stgit@omen>
 <bb120b4a-e6f6-de81-35f0-9803acf9b0be@redhat.com>
 <20220615155659.GA7684@nvidia.com>
 <cb7efb0f-5537-5ce4-7aec-bb10ea81d5de@redhat.com>
 <20220623142139.462a0841.alex.williamson@redhat.com>
 <20220623204712.GG4147@nvidia.com> <87a6a2zyxk.fsf@nvdebian.thelocal>
 <20220624013415.GI4147@nvidia.com> <874k0ax1s0.fsf@nvdebian.thelocal>
 <878rodvcty.fsf@nvdebian.thelocal>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <878rodvcty.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.22 10:45, Alistair Popple wrote:
> 
> Looks like the original patch might need rebasing. I am about to post a
> clean-up for the tortured logic in check_and_migrate_movable_pages() so
> can incorporate it there, but I'm wondering what the consensus was for
> pinning of zero pfn?

We have to keep it working right now, but in most cases (inside
MAP_PRIVATE regions) it's shaky and undesired.

> 
> Currently my clean-up will result in PUP returning an error for the zero
> pfn rather than looping indefinitely in the kernel. However it wasn't
> clear from this thread if returning an error is ok, or if R/O pinning
> of the zero pfn should succeed?

I'm working on proper COW breaking in MAP_PRIVATE mappings, which will,
for example, unshare the shared zeropage and properly replace it by
exclusive anon pages first in the FOLL_LONGTERM case.

-- 
Thanks,

David / dhildenb

