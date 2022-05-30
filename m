Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A27537529
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiE3Gun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiE3GuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8848D56C3C
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653893405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OA2EU1n3m5GYJZ5id1x49ev2OO8TYlhuVqKxXwmud78=;
        b=jNN37wvfN8rQ3Vy3dCnCQ1QwJWJwmrN1qHZffJK8Pi4zGUIFS5CzSM/oBnl8XGYNBH/U77
        v1d47IfTAoHYE0he8iOVoYTIF9Kxxhh0Q8J0mPpiVZH6EFHZ1C7pB2QBsjvD37TxeLl0zJ
        aoTQEw1fbYR+hBIShMGIWz5+A3jyhgE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-QAp0YBhdM4OQq60PdAV32Q-1; Mon, 30 May 2022 02:50:04 -0400
X-MC-Unique: QAp0YBhdM4OQq60PdAV32Q-1
Received: by mail-wm1-f70.google.com with SMTP id j40-20020a05600c1c2800b003972dbb1066so9227139wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=OA2EU1n3m5GYJZ5id1x49ev2OO8TYlhuVqKxXwmud78=;
        b=wbTzVo3QWnP1vOtcHkgFFeIqoJi4rClj1BWRKPIJ0beboUm8MIq0BELQuJ+YObmYEY
         QABR6N2FvXwmfpCFLXs7Gu0p7R/wO6EYoF+7vwgm3FaYHzWFXJPq/BwfkZ9z8uF13IH+
         5cexM/sh2AGf80Z/8R+qi4fADtvg7o7znU+t2MxGoGLG5RHI4QJJlQwgjc7cINrk/Qcb
         mOZJRBmo0Mfjo66dsMQpzCvMp9ctZJL2Scju7xA3XHraKlNo7Sp1zltC8KhveEG2G4wP
         Ops472sFFDoIBS6IwsPyTYNSken8DZo4oce7YlNtBvNmWhnalUglypCoxOs5DvV9ffSH
         sWkg==
X-Gm-Message-State: AOAM532c5NHmUgBEt26OTfDznz2z0Ki7HfrpRRdF0j+sSn+t3ghM7D+w
        hKqqAajKp2yhqcVauAS+RQmiG4C7sKmeNxf8fT799hrSydwgM/uJi83z37KM12B9pEXhdnbGkqJ
        mT6PaHsL/jC7t29CV7vLo4HrT
X-Received: by 2002:adf:9cca:0:b0:210:2f76:93fe with SMTP id h10-20020adf9cca000000b002102f7693femr4575104wre.12.1653893403106;
        Sun, 29 May 2022 23:50:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ4OTL2ca2wmWyNO4crgHpqC/B3lDmwhG91OltBGji82xyGj9aMMNAtDCPwYTN03OTbIPtxw==
X-Received: by 2002:adf:9cca:0:b0:210:2f76:93fe with SMTP id h10-20020adf9cca000000b002102f7693femr4575084wre.12.1653893402877;
        Sun, 29 May 2022 23:50:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736? (p200300cbc7047c00aaa92ce55aa0f736.dip0.t-ipconnect.de. [2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d64a5000000b0020c5253d8casm9032773wrp.22.2022.05.29.23.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 23:50:02 -0700 (PDT)
Message-ID: <2d742b58-efd2-9a74-0af6-68948a06bfe8@redhat.com>
Date:   Mon, 30 May 2022 08:50:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, mst@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        pbonzini@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org
References: <20220520070648.1794132-1-pizhenwei@bytedance.com>
 <20220520070648.1794132-3-pizhenwei@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/3] mm/memory-failure.c: support reset PTE during
 unpoison
In-Reply-To: <20220520070648.1794132-3-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.22 09:06, zhenwei pi wrote:
> Origianlly, unpoison_memory() is only used by hwpoison-inject, and
> unpoisons a page which is poisoned by hwpoison-inject too. The kernel PTE
> entry has no change during software poison/unpoison.
> 
> On a virtualization platform, it's possible to fix hardware corrupted page
> by hypervisor, typically the hypervisor remaps the error HVA(host virtual
> address). So add a new parameter 'const char *reason' to show the reason
> called by.
> 
> Once the corrupted page gets fixed, the guest kernel needs put page to
> buddy. Reuse the page and hit the following issue(Intel Platinum 8260):
>  BUG: unable to handle page fault for address: ffff888061646000
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0002) - not-present page
>  PGD 2c01067 P4D 2c01067 PUD 61aaa063 PMD 10089b063 PTE 800fffff9e9b9062
>  Oops: 0002 [#1] PREEMPT SMP NOPTI
>  CPU: 2 PID: 31106 Comm: stress Kdump: loaded Tainted: G   M       OE     5.18.0-rc6.bm.1-amd64 #6
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:clear_page_erms+0x7/0x10
> 
> The kernel PTE entry of the fixed page is still uncorrected, kernel hits
> page fault during prep_new_page. So add 'bool reset_kpte' to get a change
> to fix the PTE entry if the page is fixed by hypervisor.

Why don't we want to do that for the hwpoison case?

> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  include/linux/mm.h   |  2 +-
>  mm/hwpoison-inject.c |  2 +-
>  mm/memory-failure.c  | 26 +++++++++++++++++++-------
>  3 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 665873c2788c..7ba210e86401 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3191,7 +3191,7 @@ enum mf_flags {
>  extern int memory_failure(unsigned long pfn, int flags);
>  extern void memory_failure_queue(unsigned long pfn, int flags);
>  extern void memory_failure_queue_kick(int cpu);
> -extern int unpoison_memory(unsigned long pfn);
> +extern int unpoison_memory(unsigned long pfn, bool reset_kpte, const char *reason);
>  extern int sysctl_memory_failure_early_kill;
>  extern int sysctl_memory_failure_recovery;
>  extern void shake_page(struct page *p);
> diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
> index 5c0cddd81505..0dd17ba98ade 100644
> --- a/mm/hwpoison-inject.c
> +++ b/mm/hwpoison-inject.c
> @@ -57,7 +57,7 @@ static int hwpoison_unpoison(void *data, u64 val)
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> -	return unpoison_memory(val);
> +	return unpoison_memory(val, false, "hwpoison-inject");

s/hwpoison-inject/hwpoison/

or maybe

s/hwpoison-inject/debugfs/

>  }
>  
>  DEFINE_DEBUGFS_ATTRIBUTE(hwpoison_fops, NULL, hwpoison_inject, "%lli\n");
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 95c218bb0a37..a46de3be1dd7 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2132,21 +2132,26 @@ core_initcall(memory_failure_init);
>  /**
>   * unpoison_memory - Unpoison a previously poisoned page
>   * @pfn: Page number of the to be unpoisoned page
> + * @reset_kpte: Reset the PTE entry for kmap
> + * @reason: The callers tells why unpoisoning the page
>   *
> - * Software-unpoison a page that has been poisoned by
> - * memory_failure() earlier.
> + * Unpoison a page that has been poisoned by memory_failure() earlier.
>   *
> - * This is only done on the software-level, so it only works
> - * for linux injected failures, not real hardware failures
> + * For linux injected failures, there is no need to reset PTE entry.
> + * It's possible to fix hardware memory failure on a virtualization platform,
> + * once hypervisor fixes the failure, guest needs put page back to buddy and
> + * reset the PTE entry in kernel.

Why can't we do this unconditionally? Just check if the PTE is poisoned,
and if so, reset it.

-- 
Thanks,

David / dhildenb

