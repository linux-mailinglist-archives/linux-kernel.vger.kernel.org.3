Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68AA5385A4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242207AbiE3P6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbiE3P6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FF0661288
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 08:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653925765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3rYstiXH+DFFxpN0eJSYZFfNb9vwPKdu6j6eGmXRMcc=;
        b=M2cuTkNMQteUJHFEgHcyE+jcpA5EHymk6THJWjRxBeQNvw+Kd5RBbidrImObkV8A/rAmtd
        dB7Wrr/azt/ilBQxc5TKJvQdB6I+5rX7RMUeJ25fJiO8Qhx3CKdZneAEYHTECNNSyLlj0T
        E8no5hIgnFW3e7igApGwel4+ecSMRn0=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-FxmxosBQNbCIdY8Zk7ERHA-1; Mon, 30 May 2022 11:49:24 -0400
X-MC-Unique: FxmxosBQNbCIdY8Zk7ERHA-1
Received: by mail-il1-f197.google.com with SMTP id u8-20020a056e021a4800b002d3a5419d1bso2748250ilv.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 08:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3rYstiXH+DFFxpN0eJSYZFfNb9vwPKdu6j6eGmXRMcc=;
        b=uvN8G6ZNkG7JJov6OlS9osWXjy3PGrZcHfGOFebD7a0sdUmZeSmqKVAW3wI7oc0fsq
         yZZfcX2MaD3D8yeF64ozouRPCOL8JZ7SG97kL4X6bVbY+sExE7+0gEYLKSGG6f/sFY/9
         Z55ibBCmL66J3AkbGcNHx2i2N6VxKykU9370RbXEqUrpfgONP5126bgTvUKPhcG5xzbg
         6o+glJ5E8KQjl+aPFKy99c3XhzqwJtpxKXb7M6gBKKcvEkoAiOOIQgp9G/Rj60cbIy6g
         NtjR6B1+ILfYS7z0je7uWS4dJB1ABVVoUCDi3rt7hujQCZTW+dUMJubWN59MuKWkIH+7
         FHlA==
X-Gm-Message-State: AOAM530xjVYAvy1xhtV0y6zwh8Zepn91+TodgLWV0+AKf/fxQq66TeMV
        bXJinRmkknSuYv8Pgu8Rd+pWNR8BbHDLJk5egCxKFJRHalvReuIF7IAPIa1hJaQhs4Eq+jGuuN9
        Jgtrqcft0kJXBNOKsXJmvTCoz
X-Received: by 2002:a05:6e02:1c4e:b0:2d1:a8d:e94d with SMTP id d14-20020a056e021c4e00b002d10a8de94dmr29213933ilg.194.1653925763929;
        Mon, 30 May 2022 08:49:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyavXgOOvyHvCgnhXUybuBh2qRd2Dsuuan5kKliX95y7YWU6WnNJ4Q63813uIsXDGIP+OZk1Q==
X-Received: by 2002:a05:6e02:1c4e:b0:2d1:a8d:e94d with SMTP id d14-20020a056e021c4e00b002d10a8de94dmr29213912ilg.194.1653925763620;
        Mon, 30 May 2022 08:49:23 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id u20-20020a926014000000b002cde6e35302sm3764514ilb.76.2022.05.30.08.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 08:49:22 -0700 (PDT)
Date:   Mon, 30 May 2022 11:49:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     David Hildenbrand <david@redhat.com>, Jue Wang <juew@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, jasowang@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, mst@redhat.com,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, qemu-devel@nongnu.org,
        virtualization@lists.linux-foundation.org
Subject: Re: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
Message-ID: <YpTngZ5Qr0KIvL0H@xz-m1.local>
References: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
 <Yo/I3oLkd9OU0ice@xz-m1.local>
 <24a95dea-9ea6-a904-7c0b-197961afa1d1@bytedance.com>
 <0d266c61-605d-ce0c-4274-b0c7e10f845a@redhat.com>
 <4b0c3e37-b882-681a-36fc-16cee7e1fff0@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b0c3e37-b882-681a-36fc-16cee7e1fff0@bytedance.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 07:33:35PM +0800, zhenwei pi wrote:
> A VM uses RAM of 2M huge page. Once a MCE(@HVAy in [HVAx,HVAz)) occurs, the
> 2M([HVAx,HVAz)) of hypervisor becomes unaccessible, but the guest poisons 4K
> (@GPAy in [GPAx, GPAz)) only, it may hit another 511 MCE ([GPAx, GPAz)
> except GPAy). This is the worse case, so I want to add
>  '__le32 corrupted_pages' in struct virtio_balloon_config, it is used in the
> next step: reporting 512 * 4K 'corrupted_pages' to the guest, the guest has
> a chance to isolate the other 511 pages ahead of time. And the guest
> actually loses 2M, fixing 512*4K seems to help significantly.

It sounds hackish to teach a virtio device to assume one page will always
be poisoned in huge page granule.  That's only a limitation to host kernel
not virtio itself.

E.g. there're upstream effort ongoing with enabling doublemap on hugetlbfs
pages so hugetlb pages can be mapped in 4k with it.  It provides potential
possibility to do page poisoning with huge pages in 4k too.  When that'll
be ready the assumption can go away, and that does sound like a better
approach towards this problem.

> 
> > 
> > I assume when talking about "the performance memory drops a lot", you
> > imply that this patch set can mitigate that performance drop?
> > 
> > But why do you see a performance drop? Because we might lose some
> > possible THP candidates (in the host or the guest) and you want to plug
> > does holes? I assume you'll see a performance drop simply because
> > poisoning memory is expensive, including migrating pages around on CE.
> > 
> > If you have some numbers to share, especially before/after this change,
> > that would be great.
> > 
> 
> The CE storm leads 2 problems I have even seen:
> 1, the memory bandwidth slows down to 10%~20%, and the cycles per
> instruction of CPU increases a lot.
> 2, the THR (/proc/interrupts) interrupts frequently, the CPU has to use a
> lot time to handle IRQ.

Totally no good knowledge on CMCI, but if 2) is true then I'm wondering
whether it's necessary to handle the interrupts that frequently.  When I
was reading the Intel CMCI vector handler I stumbled over this comment:

/*
 * The interrupt handler. This is called on every event.
 * Just call the poller directly to log any events.
 * This could in theory increase the threshold under high load,
 * but doesn't for now.
 */
static void intel_threshold_interrupt(void)

I think that matches with what I was thinking..  I mean for 2) not sure
whether it can be seen as a CMCI problem and potentially can be optimized
by adjust the cmci threshold dynamically.

-- 
Peter Xu

