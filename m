Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4E846E70F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhLIKyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:54:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235965AbhLIKyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639047058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8WMX44FIcF1N6xF21LwWdhI92Ui/1ZtttLXrtc8/meE=;
        b=aYNpwcmreILLL+V+YSV2wW8kb0PKKNuoGCSejdajWcz/do7L4lY0ruxL/50kBnb9UMLl+1
        5r800BdyFL9HXBC5D/JTTJbrkE8tP1u+Lxp/+PcqvDidEo55jSU6nfkKmTlHPGNKJkknYS
        t6Q0fh39xaWaGsGjf+0X2YAXZjHdb1E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-IKfYKp0tNzm6treqCBzeNA-1; Thu, 09 Dec 2021 05:50:57 -0500
X-MC-Unique: IKfYKp0tNzm6treqCBzeNA-1
Received: by mail-wm1-f69.google.com with SMTP id i131-20020a1c3b89000000b00337f92384e0so4666575wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 02:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8WMX44FIcF1N6xF21LwWdhI92Ui/1ZtttLXrtc8/meE=;
        b=rE/KVWLavo77Pr6Rgdx9HG/1Mk/H2CopNg5WmYxoJqlWtDLncGct7gCzvg3l5U/vDN
         ZTronwIt4CimbWf6zksgnq/Z56zW2JEaqSDflANRDWUxOgqOJ+y8i+NdzktItLrr/vgd
         +j8GhQ8NAxTT2r1bxz9L9LdRu9kut5ht5GDJ9wvfbURWq7xuBffsofzhXPhRUUETJwaA
         PO9wpe+l9Eg+DyR6uG16m8AQNm9GYWS4XuskTk4RkkkGhMTswdMoY1ZtD7pwGPh4vUdg
         7YYzLBYuz1RA/uqSmDcwFCa0xznxqbScKa0BSKaDdIaHvkatuqY+w5I2CL0K+4puhnJ7
         kAuQ==
X-Gm-Message-State: AOAM532OHCvVfiTykOX6jyCYC+/hdAUh8E5jOEwNQo4KdHbB0Zxgifr9
        Xm+XIVd2MLT6emfVjxDEDh8fVRov+VrwPuLPFQn0qUy+6WlzID+HFFBH8NYX1rz1W9uFGeBZWHd
        Mb/Bfidg06MQWrG+dd2H9rqbH
X-Received: by 2002:a1c:f609:: with SMTP id w9mr6017392wmc.99.1639047056385;
        Thu, 09 Dec 2021 02:50:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFtJxoZ+HMp9tXZ3J0oijd/AaehaJazoUmvUj2rmanSHM0rjneYa37IHLdZm2qxceis4Jp/g==
X-Received: by 2002:a1c:f609:: with SMTP id w9mr6017358wmc.99.1639047056134;
        Thu, 09 Dec 2021 02:50:56 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae? ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id c6sm11112341wmq.46.2021.12.09.02.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:50:55 -0800 (PST)
Message-ID: <fbf5c0aa4109588c9f470b93d9d82d613eeff8fa.camel@redhat.com>
Subject: Re: [PATCH v2 3/3] mm/page_alloc: Remotely drain per-cpu lists
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mtosatti@redhat.com, nilal@redhat.com,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        ppandit@redhat.com
Date:   Thu, 09 Dec 2021 11:50:53 +0100
In-Reply-To: <20211203141306.GG3301@suse.de>
References: <20211103170512.2745765-1-nsaenzju@redhat.com>
         <20211103170512.2745765-4-nsaenzju@redhat.com>
         <20211203141306.GG3301@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Fri, 2021-12-03 at 14:13 +0000, Mel Gorman wrote:
> On Wed, Nov 03, 2021 at 06:05:12PM +0100, Nicolas Saenz Julienne wrote:
> > Some setups, notably NOHZ_FULL CPUs, are too busy to handle the per-cpu
> > drain work queued by __drain_all_pages(). So introduce new a mechanism
> > to remotely drain the per-cpu lists. It is made possible by remotely
> > locking 'struct per_cpu_pages' new per-cpu spinlocks. A benefit of this
> > new scheme is that drain operations are now migration safe.
> > 
> > There was no observed performance degradation vs. the previous scheme.
> > Both netperf and hackbench were run in parallel to triggering the
> > __drain_all_pages(NULL, true) code path around ~100 times per second.
> > The new scheme performs a bit better (~5%), although the important point
> > here is there are no performance regressions vs. the previous mechanism.
> > Per-cpu lists draining happens only in slow paths.
> > 
> 
> netperf and hackbench are not great indicators of page allocator
> performance as IIRC they are more slab-intensive than page allocator
> intensive. I ran the series through a few benchmarks and can confirm
> that there was negligible difference to netperf and hackbench.
> 
> However, on Page Fault Test (pft in mmtests), it is noticable. On a
> 2-socket cascadelake machine I get
> 
> pft timings
>                                  5.16.0-rc1             5.16.0-rc1
>                                     vanilla    mm-remotedrain-v2r1
> Amean     system-1         27.48 (   0.00%)       27.85 *  -1.35%*
> Amean     system-4         28.65 (   0.00%)       30.84 *  -7.65%*
> Amean     system-7         28.70 (   0.00%)       32.43 * -13.00%*
> Amean     system-12        30.33 (   0.00%)       34.21 * -12.80%*
> Amean     system-21        37.14 (   0.00%)       41.51 * -11.76%*
> Amean     system-30        36.79 (   0.00%)       46.15 * -25.43%*
> Amean     system-48        58.95 (   0.00%)       65.28 * -10.73%*
> Amean     system-79       111.61 (   0.00%)      114.78 *  -2.84%*
> Amean     system-80       113.59 (   0.00%)      116.73 *  -2.77%*
> Amean     elapsed-1        32.83 (   0.00%)       33.12 *  -0.88%*
> Amean     elapsed-4         8.60 (   0.00%)        9.17 *  -6.66%*
> Amean     elapsed-7         4.97 (   0.00%)        5.53 * -11.30%*
> Amean     elapsed-12        3.08 (   0.00%)        3.43 * -11.41%*
> Amean     elapsed-21        2.19 (   0.00%)        2.41 * -10.06%*
> Amean     elapsed-30        1.73 (   0.00%)        2.04 * -17.87%*
> Amean     elapsed-48        1.73 (   0.00%)        2.03 * -17.77%*
> Amean     elapsed-79        1.61 (   0.00%)        1.64 *  -1.90%*
> Amean     elapsed-80        1.60 (   0.00%)        1.64 *  -2.50%*
> 
> It's not specific to cascade lake, I see varying size regressions on
> different Intel and AMD chips, some better and worse than this result.
> The smallest regression was on a single CPU skylake machine with a 2-6%
> hit. Worst was Zen1 with a 3-107% hit.
> 
> I didn't profile it to establish why but in all cases the system CPU
> usage was much higher. It *might* be because the spinlock in
> per_cpu_pages crosses a new cache line and it might be cold although the
> penalty seems a bit high for that to be the only factor.
> 
> Code-wise, the patches look fine but the apparent penalty for PFT is
> too severe.

Thanks for taking the time to look at this. I agree the performance penalty is
way too big. I'll move to an alternative approach.

-- 
Nicolás Sáenz

