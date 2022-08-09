Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B9358DA8E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244468AbiHIOva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbiHIOv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C8CC140E0
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660056686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfc/XL1jm/fZbt5EGR6fy3ohsW4Si3tCDlCcEICIpkw=;
        b=MsDV6me8KkxSEr7b/yUrjm6ToGFKk5TQ6DuhgiB42nTIKvE+C+j/GzDMWY41fZupvtsWS8
        uw6SykR9lS6yLBcHVH3bpU8xvqBI89tEgvTOCSBWU33pqaCJQ7Z3mj72lbxBoks/kF2WIi
        Gyzyr81A4CKAbq5InsEbPm65E/NtX0k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-14-GSbqvmeEOV6nfNTZSIXR1w-1; Tue, 09 Aug 2022 10:51:25 -0400
X-MC-Unique: GSbqvmeEOV6nfNTZSIXR1w-1
Received: by mail-wr1-f72.google.com with SMTP id t12-20020adfba4c000000b0021e7440666bso1903521wrg.22
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 07:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=vfc/XL1jm/fZbt5EGR6fy3ohsW4Si3tCDlCcEICIpkw=;
        b=1G9vUykcveSNt164tk3DRKlnutl7uYyxBgxny3YubfRNnBEv3ygjwPaTpmwOyBCd7p
         MyFNicGVeEm2ueNy24cY+fKz7H451SzmD0PL9AlBohIue6ACaYoB9A7jnzlpPcjJVPy6
         KbH8K2b2sMwxOxAcQwG+HIvMl5Y7o57C7o4Bhd/E0DYCV0NZoC1Lls9GTfN8gLLPvjnD
         xzHFvM2xN5+NQ1/RzCtLsbMucDfoXJA1T9lZnPrxEKPC5OMzjjrh+47+x9agDSSg1H6T
         LeWpexEcjuw/LzkZq3bJUQTCYF/H4e6hyYlxVPXAAkuSvAHT6gEeJuVpfDGhQXwBB6WC
         vI0w==
X-Gm-Message-State: ACgBeo0OJz/GhLDYQGWgxbMBRnrWoOdY7NthqzOKabCzY82OhibevY99
        S/OfuSYwSoXqkB6yRgA253hE7pDhEmHpnQJp7bU8JtpfxrGPfOdlb5CAfZBwDgKZvyZTjJW0YDh
        SD4SLyZhm6rwH3f1l3LgbhGAd
X-Received: by 2002:a1c:f618:0:b0:3a4:e569:946b with SMTP id w24-20020a1cf618000000b003a4e569946bmr20667244wmc.106.1660056684253;
        Tue, 09 Aug 2022 07:51:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7qwhy4StXqMQoTGiKwluARjwk2LuQfdIRMp6P8vtwj6ysi8BYdYLz5aTzHIHq5y36BEje+Cg==
X-Received: by 2002:a1c:f618:0:b0:3a4:e569:946b with SMTP id w24-20020a1cf618000000b003a4e569946bmr20667225wmc.106.1660056683937;
        Tue, 09 Aug 2022 07:51:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:c300:d2ce:1fb5:2460:179a? (p200300d82f15c300d2ce1fb52460179a.dip0.t-ipconnect.de. [2003:d8:2f15:c300:d2ce:1fb5:2460:179a])
        by smtp.gmail.com with ESMTPSA id j4-20020a05600c1c0400b003a31fd05e0fsm2614814wms.2.2022.08.09.07.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 07:51:23 -0700 (PDT)
Message-ID: <2dd8a91b-7d88-5847-3e7b-1315fae9ecee@redhat.com>
Date:   Tue, 9 Aug 2022 16:51:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm: re-allow pinning of zero pfns (again)
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Felix Kuehling <felix.kuehling@amd.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, alex.sierra@amd.com,
        akpm@linux-foundation.org, hch@lst.de, apopple@nvidia.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <166002010021.381133.11357879752637949308.stgit@omen>
 <YvJTi0fAgl/T4WA4@casper.infradead.org>
 <cd25ebd9-52f9-2e66-841e-fc94b3949f7d@amd.com>
 <YvJynaZPAJayhgBK@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YvJynaZPAJayhgBK@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.22 16:43, Matthew Wilcox wrote:
> On Tue, Aug 09, 2022 at 10:14:12AM -0400, Felix Kuehling wrote:
>> Am 2022-08-09 um 08:31 schrieb Matthew Wilcox:
>>> On Mon, Aug 08, 2022 at 10:42:24PM -0600, Alex Williamson wrote:
>>>> The below referenced commit makes the same error as 1c563432588d ("mm: fix
>>>> is_pinnable_page against a cma page"), re-interpreting the logic to exclude
>>>> pinning of the zero page, which breaks device assignment with vfio.
>>> Perhaps we need to admit we're not as good at boolean logic as we think
>>> we are.
>>>
>>> 	if (is_device_coherent_page(page))
>>> 		return false;
>>> 	if (is_zone_movable_page(page))
>>> 		return false;
>>> 	return is_zero_pfn(page_to_pfn(page));
>>>
>>> (or whatever the right logic is ... I just woke up and I'm having
>>> trouble parsing it).
>>
>> This implies an assumption that zero-page is never device-coherent or
>> moveable, which is probably true, but not part of the original condition. A
>> more formally correct rewrite would be:
>>
>> 	if (is_zero_pfn(page_to_pfn(page)))
>> 		return true;
>> 	if (is_device_coherent_page(page))
>> 		return false;
>> 	return !is_zone_moveable_page(page);
> 
> It's definitely true that the zero page is never device-coherent, nor
> movable.  Moreover, we want to avoid calling page_to_pfn() if we can.
> So it should be the last condition that we check.

IIRC, with "kernelcore" and/or "movablecore", the zero page could
eventually end up in the movable zone (whereby we can have boottime
allocations being placed into the movable zone). IIRC that's why we have
to special-case on the zero-page here at all.

So taking out the zero page first is correct.

-- 
Thanks,

David / dhildenb

