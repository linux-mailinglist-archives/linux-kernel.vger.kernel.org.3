Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDB359F49F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiHXH4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiHXH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1EB84ECB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661327774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yX/+8Rw7cX7PklWPsILs75376rGACdvLy1y8/1aR3u8=;
        b=NhJ8m6evaZeCXfmQ76AyfV+dRfZXL0S3+caCnelV76gTtdX99Aph8HrjFZBGp3Zf6qs8hH
        fujsyyPOMqQtF1EoWd5QL3wczFAvTgC8sznOEVxSRfaUY833fYl8YJHdCDiw6ktTQtFH8u
        opK4TNPOFlRRkEiHrhy+gYGb7eysfjY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-247-jVYl7HX0O3idmq81f2QM8w-1; Wed, 24 Aug 2022 03:56:12 -0400
X-MC-Unique: jVYl7HX0O3idmq81f2QM8w-1
Received: by mail-wr1-f71.google.com with SMTP id v27-20020adfa1db000000b002252854ec99so2577037wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=yX/+8Rw7cX7PklWPsILs75376rGACdvLy1y8/1aR3u8=;
        b=1516WkuVJTwp9gwFleqqwncvpBzHhtH6tpnoVgN/ihDgndiziAXzLU7OScp87dipGO
         VU9EFqeGfHYbX08C6T4aitME9CDWZFkS5DIqdyjG+Yfg2De2eeE0E9Q5v+VZAW9PiTIn
         hCOiDoZfCcowhgLbqFvTKyIbufMvbQAIAro6/OfliGJroS0nNXWUSqAgWPbbjaemvWba
         ZeamvMNzDkiq0NKI+QWMWQC+gHSUwHDPB7iwnJa+LYo9kEswoWIlSGmUOqZXsDKhqNMP
         rA1j0tCTIpJvCGnk4ud+rgCMCKLFmljI4jWTiP0sZJsXZakgW2Uvibasqk+WHMZC+FbW
         kt3A==
X-Gm-Message-State: ACgBeo2wuZPIipeEpsftsljelc9XHkCnfvqoWH3W0s3ZbN1/67SsDrut
        MeRnBnCLBNDbwJPwfZaaU2/txZDekqNdXVYTuV7L6O0lfcBmMvnRKLFP8vwqrYTMomIAybtmXEO
        llELiv8ZQtbhdPbmSOqc3KiEI
X-Received: by 2002:a05:6000:15c5:b0:220:727a:24bf with SMTP id y5-20020a05600015c500b00220727a24bfmr16132370wry.621.1661327771582;
        Wed, 24 Aug 2022 00:56:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5KMVcgjXhsJt9cJZpZ9jn66ZFfTYNIfIB4dQ29fC/nC3ivi5z6k/oNJTkKKauWbbvmnb+4rg==
X-Received: by 2002:a05:6000:15c5:b0:220:727a:24bf with SMTP id y5-20020a05600015c500b00220727a24bfmr16132354wry.621.1661327771228;
        Wed, 24 Aug 2022 00:56:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:c500:5445:cf40:2e32:6e73? (p200300cbc707c5005445cf402e326e73.dip0.t-ipconnect.de. [2003:cb:c707:c500:5445:cf40:2e32:6e73])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003a690f704absm216374wmq.4.2022.08.24.00.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 00:56:10 -0700 (PDT)
Message-ID: <38e227e1-63f4-4aa4-e05c-c47c3345a60f@redhat.com>
Date:   Wed, 24 Aug 2022 09:56:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     muchun.song@linux.dev, linux-kernel@vger.kernel.org
References: <20220824071909.192535-1-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/2] mm: fix null-ptr-deref in kswapd_is_running()
In-Reply-To: <20220824071909.192535-1-wangkefeng.wang@huawei.com>
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

On 24.08.22 09:19, Kefeng Wang wrote:
> The kswapd_run/stop() will set pgdat->kswapd to NULL, which
> could race with kswapd_is_running() in kcompactd(),
> 
> kswapd_run/stop()	kcompactd()
> 			  kswapd_is_running()
> 				if (pgdat->kswapd) // load non-NULL pgdat->kswapd
>   pgdat->kswapd = NULL
> 				task_is_running(pgdat->kswapd) // Null pointer derefence
> 
> The KASAN report the null-ptr-deref shown below,
> 
>   vmscan: Failed to start kswapd on node 0
>   ...
>   BUG: KASAN: null-ptr-deref in kcompactd+0x440/0x504
>   Read of size 8 at addr 0000000000000024 by task kcompactd0/37
> 
>   CPU: 0 PID: 37 Comm: kcompactd0 Kdump: loaded Tainted: G           OE     5.10.60 #1
>   Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>   Call trace:
>    dump_backtrace+0x0/0x394
>    show_stack+0x34/0x4c
>    dump_stack+0x158/0x1e4
>    __kasan_report+0x138/0x140
>    kasan_report+0x44/0xdc
>    __asan_load8+0x94/0xd0
>    kcompactd+0x440/0x504
>    kthread+0x1a4/0x1f0
>    ret_from_fork+0x10/0x18
> 
> For race between kswapd_run() and kcompactd(), adding a temporary value
> when create a kthread, and only set it to pgdat->kswapd if kthread_run()
> return successful task_struct to fix the issue.
> 
> For race between kswapd_stop() and kcompactd(), let's call kcompactd_stop()
> before kswapd_stop() to fix the issue.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/memory_hotplug.c | 2 +-
>  mm/vmscan.c         | 8 +++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index fad6d1f2262a..2fd45ccbce45 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1940,8 +1940,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  
>  	node_states_clear_node(node, &arg);
>  	if (arg.status_change_nid >= 0) {
> -		kswapd_stop(node);
>  		kcompactd_stop(node);
> +		kswapd_stop(node);
>  	}

This looks just fragile to randomly break again in the future when
people work on this code without being aware of this condition. Or once
with other (future?) kswapd_is_running() users. We at least need some
comment explaining that the order here matters and why.

But I do wonder if we can't handle it in a cleaner, more obvious, way.

kswapd_start()/kswapd_stop() should have a proper way to synchronize
with kswapd_is_running(). Just the matter of finding a suitable locking
primitive :)

-- 
Thanks,

David / dhildenb

