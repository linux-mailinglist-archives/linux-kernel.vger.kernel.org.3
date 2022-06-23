Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C25A55885B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiFWTIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFWTCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 463C988959
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656007638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fcy1Q3vZZLDhsnG6KdBWdg+6I5F1iLma0wO2j1hoD9c=;
        b=glLvaMctamQV2BzonT7qOkKdbbYagcxDj1qNoYTWAvr42JPQzJOAXzftQZlNG/j19GtLr6
        99AwyV/gYqLNVsqBYEBNDhvqKPPokfBfxa3zAdkynvvkInsDrz6R4HVLQ0h3eY27CC3Y28
        ed9C+WPX6ekx9tZI1IyP7Grwc+UkUe0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-CPSqdDc9P3WGi1Z1LxmZdA-1; Thu, 23 Jun 2022 14:07:17 -0400
X-MC-Unique: CPSqdDc9P3WGi1Z1LxmZdA-1
Received: by mail-wm1-f69.google.com with SMTP id p22-20020a05600c359600b0039c7b23a1c7so1754623wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Fcy1Q3vZZLDhsnG6KdBWdg+6I5F1iLma0wO2j1hoD9c=;
        b=TqBKHCK9NGbbXFkQSWNZq0fEqMOJQnHF2eRuBv88jt2CfIQiC0J7cK56dsB3VVGrrD
         PsdXsek1UVsEakK594my5Dv7oqVH0H3N759G0Zn0KPh94Mit/WqR7FgttTaQYVp+Sr7U
         GevrNnLn1t1BAlC05TUv4ZmqUxWe34HJE5Kij0dpKAhx88NIqypRL01EzmlT8RPfVRLy
         x5DKpNrmKiI9TEaHNEkyxVvQ+oTXiN7+0BH2Nuf6zp+7VDSRtUX0ebdxeW9LUs+RJRVo
         EBoC0uH4Lqpvngy774O/XNqY0+0uRjThkqrAxh3qLsDrRAdGLXy4wBGch0Aj4ArpqYbD
         20zA==
X-Gm-Message-State: AJIora/sugP3IURP4bCOdb6sj6NWuQKB+5LRnYwm3hVblrAC8FRw3nEH
        y6kL7V0eOnBo12JU+emycZCIxwmXOe+BCcs9h3KCJk+ghaEfLC8EcH/v5WSd3GWAa0Bt9p7Cnoy
        GUPzFmskXEUsOHCxgzFqujf0z
X-Received: by 2002:a05:6000:1f87:b0:21b:970b:e88c with SMTP id bw7-20020a0560001f8700b0021b970be88cmr9595591wrb.320.1656007635870;
        Thu, 23 Jun 2022 11:07:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tbTbYL8XeaDCd4moOYGgY+zKqfgCzDvLfPAFyx+vQt+Z7MS+QQ3dZipJa7LzvlXGFa+V6pug==
X-Received: by 2002:a05:6000:1f87:b0:21b:970b:e88c with SMTP id bw7-20020a0560001f8700b0021b970be88cmr9595562wrb.320.1656007635576;
        Thu, 23 Jun 2022 11:07:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b100:7694:f34e:d0dd:95e7? (p200300cbc704b1007694f34ed0dd95e7.dip0.t-ipconnect.de. [2003:cb:c704:b100:7694:f34e:d0dd:95e7])
        by smtp.gmail.com with ESMTPSA id r127-20020a1c4485000000b0039c4ba160absm11819520wma.2.2022.06.23.11.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 11:07:15 -0700 (PDT)
Message-ID: <cb7efb0f-5537-5ce4-7aec-bb10ea81d5de@redhat.com>
Date:   Thu, 23 Jun 2022 20:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        jhubbard@nvidia.com, joaodias@google.com
References: <165490039431.944052.12458624139225785964.stgit@omen>
 <bb120b4a-e6f6-de81-35f0-9803acf9b0be@redhat.com>
 <20220615155659.GA7684@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: Re-allow pinning of zero pfns
In-Reply-To: <20220615155659.GA7684@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.22 17:56, Jason Gunthorpe wrote:
> On Sat, Jun 11, 2022 at 08:29:47PM +0200, David Hildenbrand wrote:
>> On 11.06.22 00:35, Alex Williamson wrote:
>>> The commit referenced below subtly and inadvertently changed the logic
>>> to disallow pinning of zero pfns.  This breaks device assignment with
>>> vfio and potentially various other users of gup.  Exclude the zero page
>>> test from the negation.
>>
>> I wonder which setups can reliably work with a long-term pin on a shared
>> zeropage. In a MAP_PRIVATE mapping, any write access via the page tables
>> will end up replacing the shared zeropage with an anonymous page.
>> Something similar should apply in MAP_SHARED mappings, when lazily
>> allocating disk blocks.

^ correction, shared zeropage is never user in MAP_SHARED mappings
(fortunally).

>>
>> In the future, we might trigger unsharing when taking a R/O pin for the
>> shared zeropage, just like we do as of now upstream for shared anonymous
>> pages (!PageAnonExclusive). And something similar could then be done
>> when finding a !anon page in a MAP_SHARED mapping.
> 
> I'm also confused how qemu is hitting this and it isn't already a bug?
> 

I assume it's just some random thingy mapped into the guest physical
address space (by the bios? R/O?), that actually never ends up getting
used by a device.

So vfio simply only needs this to keep working ... but weon't actually
ever user that data.

But this is just my best guess after thinking about it.

> It is arising because vfio doesn't use FOLL_FORCE|FOLL_WRITE to move
> away the zero page in most cases.
> 
> And why does Yishai say it causes an infinite loop in the kernel?


Good question. Maybe $something keeps retying if pinning fails, either
in the kernel (which would be bad) or in user space. At least QEMU seems
to just fail if pinning fails, but maybe it's a different user space?


-- 
Thanks,

David / dhildenb

