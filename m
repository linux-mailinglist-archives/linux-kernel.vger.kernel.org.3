Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C0958A8DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240458AbiHEJdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240358AbiHEJdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 307F9785A4
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659692014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xYlx1DnAo8B9+NfOiZ3N/1FJnpyi9Ccc/zGwvzzjckA=;
        b=emU67s/j87JTNik36g5Byeu/LORojTlI7ZHFAWvXTJaBNYIlGK+1RrEI9strhL414zpaTQ
        FmtAOOadUV/gREsmzEU9X5kU9yMVzwZFkbUnTJnxq8WJSiZRmdAbnSLDSLcTmfdRWVvDeU
        MmyLUUdaEk7yf88BbAJYXlPjkb+Zwcw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-ecdi-_GqPeCVQeOE5tFqAg-1; Fri, 05 Aug 2022 05:33:33 -0400
X-MC-Unique: ecdi-_GqPeCVQeOE5tFqAg-1
Received: by mail-ed1-f72.google.com with SMTP id w5-20020a05640234c500b0043dda025648so1271260edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 02:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=xYlx1DnAo8B9+NfOiZ3N/1FJnpyi9Ccc/zGwvzzjckA=;
        b=W1vYtz7Ts7ePId91/JnsCEjXlLuCr3Ii73PTUcCEoR5w+epiT2ch1JG2M3KsQwc3W0
         5+aGiINC0A1X21RJTeKBBpzrIM0hcTnc5yCySCL+kukJe98qe+vzNhcGPEk7Q+K3SoD2
         ElNirusEi3PXI2VGpxxsH4y2MKT9NCLdHK4ob8kkp4dPKD/WcgofAP4/h9MvX+hbgld5
         TBmMVNPwRelW9J1/ehQKoFtGUc4dFvBzOAYdFm6slZiIq6BtaenUQtw9BZNGO2xULa/W
         enVlhlvuoeJ9c6ZDZEHhxWT/wzPAg0lmxiDxfHUtnZoupb/Se/emVsvmncw7Vu4tATdy
         mdcQ==
X-Gm-Message-State: ACgBeo00C8tKWeW53kbMO9oQwLDjZLcQCyMugti1nEFl6tQmuh8FU1G+
        8xJcA3M60gCfK1yvZGtk/X2UnNkX96U3AjkCsv0XRAuAqZaEcw0rrEmKrtqnHLRFTrjAzmqvBHs
        1joqRjcP2JtWEKTJm7tAH6Q0e
X-Received: by 2002:a05:6402:14b:b0:43d:a7dd:4376 with SMTP id s11-20020a056402014b00b0043da7dd4376mr5720905edu.89.1659692011865;
        Fri, 05 Aug 2022 02:33:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR46YXts34qcUmbZ8bk88rZFf9E99ZwGCvk7kKq0jUzslOf62qTsuofT429JrWEKTMlswPHRuQ==
X-Received: by 2002:a05:6402:14b:b0:43d:a7dd:4376 with SMTP id s11-20020a056402014b00b0043da7dd4376mr5720896edu.89.1659692011657;
        Fri, 05 Aug 2022 02:33:31 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id bc2-20020a056402204200b0043e8334f762sm1793670edb.65.2022.08.05.02.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 02:33:31 -0700 (PDT)
Message-ID: <ba7e528b-8f60-5c0d-868f-98a8fa5cf847@redhat.com>
Date:   Fri, 5 Aug 2022 11:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220805073544.555261-1-leobras@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 1/1] kvm: Use a new spinlock to avoid atomic
 operations in kvm_get_dirty_log_protect
In-Reply-To: <20220805073544.555261-1-leobras@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/22 09:35, Leonardo Bras wrote:
> 1 - Spin-Locking in mark_page_dirty_in_slot():
> I understand this function happens a lot in the guest and should probably
> be as fast as possible, so introducing a lock here seems
> counter-productive, but to be fair, I could not see it any slower than a
> couple cycles in my current setup (x86_64 machine).

Maybe too small workload?  32 vcpus at 8 GB/s would mean 256 MB/s/vCPU, 
i.e. 16384 pages/second *at most*.  That might not create too much 
contention.

One possibility here is to use a global (for all VMs) 
percpu_rw_semaphore, or perhaps even RCU.  The write critical section is 
so short that it could be a win nevertheless.

However...

> 2 - Qemu will use the 'manual_dirty_log_protect'
> I understand that more recent versions qemu will use
> 'manual_dirty_log_protect' when available, so this approach will not
> benefit this use case, which is quite common.
> A counter argument would be: there are other hypervisors that could benefit
> from it, and that is also applicable for older qemu versions.

... that was my first thought indeed.  I would just consider the old API 
to be legacy and not bother with it.  Mostly because of the ability to 
clear a small part of the bitmap(*), and the initially-all-set 
optimization, manual dirty log ought to be superior even if 
CLEAR_DIRTY_LOG has to use atomics.

> - I am also trying to think on improvements for the
>   'manual_dirty_log_protect' use case, which seems to be very hard to
>   improve. For starters, using the same approach to remove the atomics
>   does not seem to cause any relevant speedup.

Yes, there are two issues:

1) CLEAR_DIRTY_LOG does not clear all bits, only those passed in by 
userspace.  This means that the inactive bitmap still has some bits set

2) the ability to clear part of the bitmap makes it hard to do a 
wholesale switch in CLEAR_DIRTY_LOG; this is the dealbreaker

Thanks,

Paolo

(*) for the old API, that requires a workaround of using multiple small 
memslots, e.g. 1-32G in size

