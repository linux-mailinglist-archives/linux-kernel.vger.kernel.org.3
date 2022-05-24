Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A115330C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbiEXS7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiEXS7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 197AB5B3E8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653418754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/u3XlUG6KtQr1BQPpeDQC4OLmlAGTwSNLNWZkdYSkog=;
        b=YfICYk1DtlgD5jQRw+BhJIfe4ve8rvI87YHCO9ZkdHxoUqiWfo7t7BI1nCWNNGn8l3jBul
        pTOH0RV7onGljkYVZYO9ze2M7skLkS159PQb/yEfPrGfhjHhFjEdwC8q5i9rv/Vuwv17Cj
        8pnj7q51Y8wNYptFE3S1EGJMxJ9je80=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-tC-OfNboMlCRdW6ksfwmtA-1; Tue, 24 May 2022 14:59:13 -0400
X-MC-Unique: tC-OfNboMlCRdW6ksfwmtA-1
Received: by mail-wm1-f72.google.com with SMTP id n25-20020a05600c3b9900b0039733081b4dso1635147wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=/u3XlUG6KtQr1BQPpeDQC4OLmlAGTwSNLNWZkdYSkog=;
        b=n7DVlg1jFiRxnD7K0jTGkVu+I0QYLoR0xcrDErFZPvqKUdBTAp2i5EuzucYaBtlRtW
         67YJnRlQymuzkVgVHLfIKdgx3ds24vjWn2RzoXXQboHvu0wGtFqxSz1k9otTFQKLtVPN
         uLjUwxyyRp4ay5+dKCvUAjCY/RgEXSMljfgzwHAa5S9mE0l02YJf1O9J4egnmmOA+Pyp
         H98TdMMVcXAi8sGOVS4Sf/T7RFGSQL4DSCmcSmjPDeM2+2a99LnThXl1g3FXo1Z3Vgzy
         fhkuYFADYLFQcoAWvAkJ+RmFuwOOA/6W3KiM5AZRic7ogCQZufA8UmFKbtUXNNPfDngs
         ZiJQ==
X-Gm-Message-State: AOAM532Ka+RQdWK9+B5vQZpx5Hut7098IxGZnHe40fMw9TQM/QRzdF6O
        m10bNpghESkHc35sEamHSTelXvX/KV2mhrImJB3UJxHZVKV2a5duc+GKKsFuZAVczyFkqf9q+T+
        xOyjfELDSPW+c2jy1mqu0LLkR
X-Received: by 2002:adf:c80a:0:b0:20c:ffa0:6a3 with SMTP id d10-20020adfc80a000000b0020cffa006a3mr23572796wrh.360.1653418751819;
        Tue, 24 May 2022 11:59:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGSz2pcp7eL3O58tziWOYGbUj4OEBI4+pd8yfPiv1mrR1trcb64B+iGECL8KJSWE+HJH27zw==
X-Received: by 2002:adf:c80a:0:b0:20c:ffa0:6a3 with SMTP id d10-20020adfc80a000000b0020cffa006a3mr23572784wrh.360.1653418751530;
        Tue, 24 May 2022 11:59:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:5200:b78b:b654:3bbe:992? (p200300cbc70a5200b78bb6543bbe0992.dip0.t-ipconnect.de. [2003:cb:c70a:5200:b78b:b654:3bbe:992])
        by smtp.gmail.com with ESMTPSA id r15-20020a056000014f00b0020e609dd274sm187544wrx.76.2022.05.24.11.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 11:59:10 -0700 (PDT)
Message-ID: <68a4a96b-9c66-6509-e75d-b1bea6cd55d1@redhat.com>
Date:   Tue, 24 May 2022 20:59:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, mst@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        pbonzini@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220520070648.1794132-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.22 09:06, zhenwei pi wrote:
> Hi,
> 
> I'm trying to recover hardware corrupted page by virtio balloon, the
> workflow of this feature like this:
> 
> Guest              5.MF -> 6.RVQ FE    10.Unpoison page
>                     /           \            /
> -------------------+-------------+----------+-----------
>                    |             |          |
>                 4.MCE        7.RVQ BE   9.RVQ Event
>  QEMU             /               \       /
>              3.SIGBUS              8.Remap
>                 /
> ----------------+------------------------------------
>                 |
>             +--2.MF
>  Host       /
>        1.HW error
> 
> 1, HardWare page error occurs randomly.
> 2, host side handles corrupted page by Memory Failure mechanism, sends
>    SIGBUS to the user process if early-kill is enabled.
> 3, QEMU handles SIGBUS, if the address belongs to guest RAM, then:
> 4, QEMU tries to inject MCE into guest.
> 5, guest handles memory failure again.
> 
> 1-5 is already supported for a long time, the next steps are supported
> in this patch(also related driver patch):
> 
> 6, guest balloon driver gets noticed of the corrupted PFN, and sends
>    request to host side by Recover VQ FrontEnd.
> 7, QEMU handles request from Recover VQ BackEnd, then:
> 8, QEMU remaps the corrupted HVA fo fix the memory failure, then:
> 9, QEMU acks the guest side the result by Recover VQ.
> 10, guest unpoisons the page if the corrupted page gets recoverd
>     successfully.
> 
> Test:
> This patch set can be tested with QEMU(also in developing):
> https://github.com/pizhenwei/qemu/tree/balloon-recover
> 
> Emulate MCE by QEMU(guest RAM normal page only, hugepage is not supported):
> virsh qemu-monitor-command vm --hmp mce 0 9 0xbd000000000000c0 0xd 0x61646678 0x8c
> 
> The guest works fine(on Intel Platinum 8260):
>  mce: [Hardware Error]: Machine check events logged
>  Memory failure: 0x61646: recovery action for dirty LRU page: Recovered
>  virtio_balloon virtio5: recovered pfn 0x61646
>  Unpoison: Unpoisoned page 0x61646 by virtio-balloon
>  MCE: Killing stress:24502 due to hardware memory corruption fault at 7f5be2e5a010
> 
> And the 'HardwareCorrupted' in /proc/meminfo also shows 0 kB.
> 
> About the protocol of virtio balloon recover VQ, it's undefined and in
> developing currently:
> - 'struct virtio_balloon_recover' defines the structure which is used to
>   exchange message between guest and host.
> - '__le32 corrupted_pages' in struct virtio_balloon_config is used in the next
>   step:
>   1, a VM uses RAM of 2M huge page, once a MCE occurs, the 2M becomes
>      unaccessible. Reporting 512 * 4K 'corrupted_pages' to the guest, the guest
>      has a chance to isolate the 512 pages ahead of time.
> 
>   2, after migrating to another host, the corrupted pages are actually recovered,
>      once the guest gets the 'corrupted_pages' with 0, then the guest could
>      unpoison all the poisoned pages which are recorded in the balloon driver.
> 

Hi,

I'm still on vacation this week, I'll try to have a look when I'm back
(and flushed out my overflowing inbox :D).


-- 
Thanks,

David / dhildenb

