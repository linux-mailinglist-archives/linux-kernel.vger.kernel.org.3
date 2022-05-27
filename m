Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BD9535820
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 05:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbiE0DvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 23:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiE0DvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 23:51:06 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A6AB0D11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:51:05 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s68so2903370pgs.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j9jk044M9+cYvVEixSPS19EP9SvL+t/qLlqlyuGxZM8=;
        b=Kb2Tpf83/RKgq6La7zyoqDnn6vsobEKp71dRb7mjiTOPUYH+IgtHlE6f1TsGuBkzlq
         zk8ScHr3clPBi/fp0b0KggejpFlhgAoYM8H/xBtIxZ2v9hGCd1vL5uMVXtIWavL9t4Y9
         JWf4KACOV0+0zz8LnmBlpHFReoWwuSbpazzgp7EeApZRHB0IyewrDmjuNm158ZKeZYfy
         bKp66XYbZMuoWwqPniW8LYvYBSpLq8WGGyhhxmoToYWnpJQTw5BWXghCyDz4aRCDJYN3
         j7TxCnSVkihYuDcfzyecLjBPPde2J9sn0rNsdkfTHMeKt4D6wBdc8Zoh6D42eJB69+QY
         2C7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j9jk044M9+cYvVEixSPS19EP9SvL+t/qLlqlyuGxZM8=;
        b=yxXzYlYsUcjW7tyebZ+5BdNZ6OA5ErPe6LlLFn+5zdUBwIZpqNwN8cPJ4SLclBWUc4
         cRYRAfOb9+W/3q5m78TOuw0bH3p3YO0zxll3864no4922JFq6E+izqnghrHWbNR5qsBl
         YG7ZmoeLndrdnCfdK35FQEOFJRa76ZD1nXYZnCPvJ01XYofDLILUV0KIUCO4vCydVzdR
         TEdouXPzw+qeBb1pWhve2US9zZPnUxZfzYnnhihcA7HxzykwWvVQNGtUp7PUcqRrGGgo
         +YXmrPL4rETkXMtMaFQ5cEcOxbCdW9MZva8HL1RfyqXjcNUBIivmheQdic2nLvZha6DH
         5FSw==
X-Gm-Message-State: AOAM533ZgBn9A8x22r85vxl5EsFhCJFvOdV/ntLjuEB+e6BBDStyOa/9
        iFGNiX39th0XDiIqxCU5WzG8XLvMonvWtg==
X-Google-Smtp-Source: ABdhPJy3h9b0t9+huzLue6kvbq3gMPhl9OzbyMxsuZP1FK+is3ahv5iuUbCsnMJzlrcDe8zU0831QQ==
X-Received: by 2002:a65:6c06:0:b0:3f5:f29d:e030 with SMTP id y6-20020a656c06000000b003f5f29de030mr34969235pgu.22.1653623464792;
        Thu, 26 May 2022 20:51:04 -0700 (PDT)
Received: from [10.255.70.20] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id s3-20020a170903214300b0015e8d4eb1fcsm2358469ple.70.2022.05.26.20.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 20:51:04 -0700 (PDT)
Message-ID: <d41bf9f8-9ea2-e4be-7e96-d69d2e4ec5f2@bytedance.com>
Date:   Fri, 27 May 2022 11:47:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
Content-Language: en-US
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        david@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, pbonzini@redhat.com,
        peterx@redhat.com, qemu-devel@nongnu.org
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20220520070648.1794132-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew & Naoya

I would appreciate it if you could give me any hint about the changes of 
memory/memory-failure!

On 5/20/22 15:06, zhenwei pi wrote:
> Hi,
> 
> I'm trying to recover hardware corrupted page by virtio balloon, the
> workflow of this feature like this:
> 
> Guest              5.MF -> 6.RVQ FE    10.Unpoison page
>                      /           \            /
> -------------------+-------------+----------+-----------
>                     |             |          |
>                  4.MCE        7.RVQ BE   9.RVQ Event
>   QEMU             /               \       /
>               3.SIGBUS              8.Remap
>                  /
> ----------------+------------------------------------
>                  |
>              +--2.MF
>   Host       /
>         1.HW error
> 
> 1, HardWare page error occurs randomly.
> 2, host side handles corrupted page by Memory Failure mechanism, sends
>     SIGBUS to the user process if early-kill is enabled.
> 3, QEMU handles SIGBUS, if the address belongs to guest RAM, then:
> 4, QEMU tries to inject MCE into guest.
> 5, guest handles memory failure again.
> 
> 1-5 is already supported for a long time, the next steps are supported
> in this patch(also related driver patch):
> 
> 6, guest balloon driver gets noticed of the corrupted PFN, and sends
>     request to host side by Recover VQ FrontEnd.
> 7, QEMU handles request from Recover VQ BackEnd, then:
> 8, QEMU remaps the corrupted HVA fo fix the memory failure, then:
> 9, QEMU acks the guest side the result by Recover VQ.
> 10, guest unpoisons the page if the corrupted page gets recoverd
>      successfully.
> 
> Test:
> This patch set can be tested with QEMU(also in developing):
> https://github.com/pizhenwei/qemu/tree/balloon-recover
> 
> Emulate MCE by QEMU(guest RAM normal page only, hugepage is not supported):
> virsh qemu-monitor-command vm --hmp mce 0 9 0xbd000000000000c0 0xd 0x61646678 0x8c
> 
> The guest works fine(on Intel Platinum 8260):
>   mce: [Hardware Error]: Machine check events logged
>   Memory failure: 0x61646: recovery action for dirty LRU page: Recovered
>   virtio_balloon virtio5: recovered pfn 0x61646
>   Unpoison: Unpoisoned page 0x61646 by virtio-balloon
>   MCE: Killing stress:24502 due to hardware memory corruption fault at 7f5be2e5a010
> 
> And the 'HardwareCorrupted' in /proc/meminfo also shows 0 kB.
> 
> About the protocol of virtio balloon recover VQ, it's undefined and in
> developing currently:
> - 'struct virtio_balloon_recover' defines the structure which is used to
>    exchange message between guest and host.
> - '__le32 corrupted_pages' in struct virtio_balloon_config is used in the next
>    step:
>    1, a VM uses RAM of 2M huge page, once a MCE occurs, the 2M becomes
>       unaccessible. Reporting 512 * 4K 'corrupted_pages' to the guest, the guest
>       has a chance to isolate the 512 pages ahead of time.
> 
>    2, after migrating to another host, the corrupted pages are actually recovered,
>       once the guest gets the 'corrupted_pages' with 0, then the guest could
>       unpoison all the poisoned pages which are recorded in the balloon driver.
> 
> zhenwei pi (3):
>    memory-failure: Introduce memory failure notifier
>    mm/memory-failure.c: support reset PTE during unpoison
>    virtio_balloon: Introduce memory recover
> 
>   drivers/virtio/virtio_balloon.c     | 243 ++++++++++++++++++++++++++++
>   include/linux/mm.h                  |   4 +-
>   include/uapi/linux/virtio_balloon.h |  16 ++
>   mm/hwpoison-inject.c                |   2 +-
>   mm/memory-failure.c                 |  59 ++++++-
>   5 files changed, 315 insertions(+), 9 deletions(-)
> 

-- 
zhenwei pi
