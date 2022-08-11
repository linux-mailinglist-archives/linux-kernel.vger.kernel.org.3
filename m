Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6224590527
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiHKQv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 12:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbiHKQvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D31521A821
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660235102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjYkrJ0NaTJji01ZcUTXu/HSgTuMTSkVyUx2biIqUJU=;
        b=gONzUm84OyIj01HsCqQXC90RhyMzNuxCjt/4K+VfHdK4yyCWcUwLiugIWbjwvxorHJfwNM
        R6YzRHi6aGoIXA8xiR+x+653Q2f8oqcKnqBuWFYreXd6mWnWKdTY4Ob6wQKAwV8z1UUC6z
        VpkKA8/9zPoR5OqJhbG7BKAv2X83zV0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-EoKppmPOO6qRYXf9WHvhUg-1; Thu, 11 Aug 2022 12:25:01 -0400
X-MC-Unique: EoKppmPOO6qRYXf9WHvhUg-1
Received: by mail-wm1-f69.google.com with SMTP id f21-20020a1cc915000000b003a3551598a1so1822187wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=UjYkrJ0NaTJji01ZcUTXu/HSgTuMTSkVyUx2biIqUJU=;
        b=SU8CIpLKPTfwJh56rUwX8V2tJQs1NUmdUp9F1UHwkDPZVHz+IPQ29XeOU9AYkyiG7z
         beR7HL/YK10HKZekmfxHk4lNewqoboE9Kz3s1sWTXNx634ktUDcEDfC+jCJpQz3C4H+e
         i4LVolW7cqnekbyD5lKEo25Cvrey5Ny4myJohO8axW/Jc0iZ0FA5BflKOkk1p+QYpzfM
         1fVjri6ECLUmOf6qAz+aiipR7UFrAVEGk4jsb+HHXiuKnJSJ4FqyMZDhWjkX/KMyxF0K
         W39Kgxw34CRz9nQLI9m7xzN9//zh3/Ix1ORlN7zScwi7SyNvEj+qZ8KoJqfa1XcWz59b
         9+DQ==
X-Gm-Message-State: ACgBeo2bIhhyaQkTnh7frmsRI8PFRV3v+gHQYuDDl/OhP8t1YtxZ8I3H
        d94+M5heZRJ4AWucx9z+nzYoKXVbdFH1UjM+QDP/BlG37S6Rf2pQqZN1Ks0+a52N4NOtvXdqE2z
        p7JZvOPx4Zf9Vu+xRQc94KEOI
X-Received: by 2002:adf:f38b:0:b0:21e:c041:7726 with SMTP id m11-20020adff38b000000b0021ec0417726mr20306117wro.394.1660235100456;
        Thu, 11 Aug 2022 09:25:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Te87JAxYpUqJdcs0ODOlsz2e/vMQll9hO7m2adqAV0n+VZZwG4sEuMPvGSxUfQ+Q56ZAo6A==
X-Received: by 2002:adf:f38b:0:b0:21e:c041:7726 with SMTP id m11-20020adff38b000000b0021ec0417726mr20306103wro.394.1660235100211;
        Thu, 11 Aug 2022 09:25:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:2e00:4009:47dc:d0e5:dcd2? (p200300cbc7082e00400947dcd0e5dcd2.dip0.t-ipconnect.de. [2003:cb:c708:2e00:4009:47dc:d0e5:dcd2])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d6346000000b0022063e5228bsm19597324wrw.93.2022.08.11.09.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 09:24:59 -0700 (PDT)
Message-ID: <2cb95372-f7dd-61f9-9d2a-461390fb0907@redhat.com>
Date:   Thu, 11 Aug 2022 18:24:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] mm/hugetlb: support write-faults in shared
 mappings
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
References: <20220811103435.188481-1-david@redhat.com>
 <20220811103435.188481-3-david@redhat.com> <YvULP8DtFFhJYNO4@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YvULP8DtFFhJYNO4@xz-m1.local>
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

On 11.08.22 15:59, Peter Xu wrote:
> On Thu, Aug 11, 2022 at 12:34:35PM +0200, David Hildenbrand wrote:
>> Reason is that uffd-wp doesn't clear the uffd-wp PTE bit when
>> unregistering and consequently keeps the PTE writeprotected. Reason for
>> this is to avoid the additional overhead when unregistering. Note
>> that this is the case also for !hugetlb and that we will end up with
>> writable PTEs that still have the uffd-wp PTE bit set once we return
>> from hugetlb_wp(). I'm not touching the uffd-wp PTE bit for now, because it
>> seems to be a generic thing -- wp_page_reuse() also doesn't clear it.
> 
> This may justify that lazy reset of ptes may not really be a good idea,
> including anonymous.  I'm indeed not aware of any app that do frequent
> reg/unreg at least.

Yeah. QEMU snapshots come to mind, but I guess the reg/unreg overhead is
the smallest issue.


> 
> I'll prepare a patch to change it from uffd side too.
> 
> Thanks again for finding this problem.

YW!

-- 
Thanks,

David / dhildenb

