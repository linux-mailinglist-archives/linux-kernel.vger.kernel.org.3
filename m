Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49CF5374CD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiE3FvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 01:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiE3Fu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 01:50:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457756C571
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 22:50:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n18so9404595plg.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 22:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BobJJoukDoqDMc7RsnBOslTuYcnA41bZYrPd0qFtxLo=;
        b=HEF7yI75q4/jLPdr8k8FIN79TtOolBn3y8oOoLyjUcQYCeEubGiOVFNCZYHOP2DodO
         U3Wxv75HH2hosZRM/pbXPabBahO3aYxmP0MTfPaO68wLdg/hinLanrclStogNjTTwQet
         TXtPyvEsQ6saNOUa+1mNKc6Jy9BktQiF2Kn9xg0R9GqRE4g7x9dMKt1nuKZKzXbP2761
         E7HNl6lR5tnBzQTLUjEb3ZF82XKABWtVYbmq+1/P/ZQE4Su6qZ7HeRTiNyUXy0u4HbTt
         scgUx+yUTiFQ0fPdV8vmfKAUE6m7EVxKXGJUpVytEDTAHK9P1G/8K5VY6f6E7W6N0KhU
         1qFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BobJJoukDoqDMc7RsnBOslTuYcnA41bZYrPd0qFtxLo=;
        b=PbZN4M1lYKMk9ke/p02XPOc+YbO1j9r1UTibfAezuxt1vrvv5LCIgfpY/2VPXYwLy3
         YF568tX7VVi6m4irENiJpz4Zscm3C2umjmjHEoFXSX73rFkuzP2ISVcx8nVljILp9+MD
         Tk2iy9R+fQ9JGWBuyyZBtq1ON7lcDnXJkJ5auLOzmoVuqblKmKKfs269FDgm/dK1NnDS
         tVZykxo1kG39HVukhd8kHvibqad+PHJyyTYHlEdMknChS4DxvRxVJeUW2f2/PWp6l0G8
         2vUBKDp0EuwE46euqdrA6B4MJhPusLgmfUDmmcJfKzOuyIEgvC//QZ5i7XvZSJ1yeUHx
         3gUA==
X-Gm-Message-State: AOAM5313+O0+SbdoeWiMGksqy9CLEOLaVeIkOxjYnEgAa3SmpSLSb0Pa
        7uI7r6Uk1LnJ2cKD2E08WwLXQwyBL8YCkA==
X-Google-Smtp-Source: ABdhPJzcG+Wj6HLqctwFpGM4LHkzUb2FX/9k6M4jkgCUJI4u5NtU/hy1qSKbgIOb5h07et2CFwjE5A==
X-Received: by 2002:a17:90b:224a:b0:1e2:7afb:3367 with SMTP id hk10-20020a17090b224a00b001e27afb3367mr16511516pjb.37.1653889857790;
        Sun, 29 May 2022 22:50:57 -0700 (PDT)
Received: from [10.255.89.136] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id q11-20020a170903204b00b00163be997587sm3169891pla.100.2022.05.29.22.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 22:50:57 -0700 (PDT)
Message-ID: <286dbd1f-1c62-a171-7453-d772bd98332c@bytedance.com>
Date:   Mon, 30 May 2022 13:46:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 2/3] mm/memory-failure.c: support reset PTE during
 unpoison
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
 <20220520070648.1794132-3-pizhenwei@bytedance.com>
 <20220530050234.GA1036127@hori.linux.bs1.fc.nec.co.jp>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220530050234.GA1036127@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/22 13:02, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Fri, May 20, 2022 at 03:06:47PM +0800, zhenwei pi wrote:
>> Origianlly, unpoison_memory() is only used by hwpoison-inject, and
>> unpoisons a page which is poisoned by hwpoison-inject too. The kernel PTE
>> entry has no change during software poison/unpoison.
>>
>> On a virtualization platform, it's possible to fix hardware corrupted page
>> by hypervisor, typically the hypervisor remaps the error HVA(host virtual
>> address). So add a new parameter 'const char *reason' to show the reason
>> called by.
>>
>> Once the corrupted page gets fixed, the guest kernel needs put page to
>> buddy. Reuse the page and hit the following issue(Intel Platinum 8260):
>>   BUG: unable to handle page fault for address: ffff888061646000
>>   #PF: supervisor write access in kernel mode
>>   #PF: error_code(0x0002) - not-present page
>>   PGD 2c01067 P4D 2c01067 PUD 61aaa063 PMD 10089b063 PTE 800fffff9e9b9062
>>   Oops: 0002 [#1] PREEMPT SMP NOPTI
>>   CPU: 2 PID: 31106 Comm: stress Kdump: loaded Tainted: G   M       OE     5.18.0-rc6.bm.1-amd64 #6
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>>   RIP: 0010:clear_page_erms+0x7/0x10
>>
>> The kernel PTE entry of the fixed page is still uncorrected, kernel hits
>> page fault during prep_new_page. So add 'bool reset_kpte' to get a change
>> to fix the PTE entry if the page is fixed by hypervisor.
>>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   include/linux/mm.h   |  2 +-
>>   mm/hwpoison-inject.c |  2 +-
>>   mm/memory-failure.c  | 26 +++++++++++++++++++-------
>>   3 files changed, 21 insertions(+), 9 deletions(-)
>>
> 
> Do you need undoing rate limiting here?  In the original unpoison's usage,
> avoiding flood of "Unpoison: Software-unpoisoned page" messages is helpful.
> 
> And unpoison seems to be called from virtio-balloon multiple times when
> the backend is 2MB hugepages.  If it's right, printing out 512 lines of
> "Unpoison: Unpoisoned page 0xXXX by virtio-balloon" messages might not be
> so helpful?
> 

All the suggestions(include '[PATCH 1/3] memory-failure: Introduce 
memory failure notifier') are reasonable, I'll fix them in the next 
version. Thanks a lot!


-- 
zhenwei pi
