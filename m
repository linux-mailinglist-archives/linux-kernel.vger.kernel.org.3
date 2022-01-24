Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B61C497BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiAXJUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:20:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231851AbiAXJUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643016033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JrLz3L3tcI/I3BMhVWiGKT3p97BtzBHRcz9TbUScQEA=;
        b=iY2NuSFV1q4+9h3OWqL3ukwaXKHzrK2aHNZFxbJhqL/8ugWrvLYKXNWsOtrxHpCUvP34cN
        7org6r5rQZa0qeG1iZ6YXiVf8dP3W3OH4lYIaxdc8BQGqRMbKqRpXblK7t3EdT0/R+TRmd
        StPnDEIxauMrshr7EVvld3zSjufO3GE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-sVK2baS2PrO6OtYlEX78Lw-1; Mon, 24 Jan 2022 04:20:32 -0500
X-MC-Unique: sVK2baS2PrO6OtYlEX78Lw-1
Received: by mail-wm1-f72.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so14675222wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 01:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JrLz3L3tcI/I3BMhVWiGKT3p97BtzBHRcz9TbUScQEA=;
        b=SYQRDWiRHxlTC9xzwDkaPuDMMDdXAS5E05QU22X6eMGYUMolInh0tt2NalQl3pz8om
         I6+eF86QpZ9aKwJ36vU2DqFyvjSlJfPpLKpegDNfbMsEAQuRSFvjDQF2W6JxSYWHVFja
         oc6+UVpSncqHlA32hvzd4w9OTLNPAh/50sQKcXqHJr/NaF2c8CTM5o9mV3FEW/yesgRh
         wjHG8UxoZ90GRXBDwAGJiOLv/Vsu80PMbcRLM94KqDvfJn1FOpPTXPSHFcRrNVe4DDtF
         D/s/czsneVuqlndIJTLd89uWxXcKtIYz+s+cq2aDIRZFB5AzYgPgT/GBpGF391OgTfQl
         yxjQ==
X-Gm-Message-State: AOAM533LnjSWFabxHr3xHtY67Wr6hgI1BIxucUQvoHu2PYdyOCvLAH3H
        1eHx/DBCSYTNmeRhVpGw1fh/FNYn+pIYHywkrEMM8/YZagwI/iM+hgcGjPw0K6Qw30F+XAkxmKl
        X+3dM10+sWSo2wHqCW3OEAGc1
X-Received: by 2002:a05:6000:15cd:: with SMTP id y13mr8194683wry.717.1643016016240;
        Mon, 24 Jan 2022 01:20:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4R22u7FIxHqgpdrWuaajXWUTtWvmGkHFSfBJmpgldZHbqSTAVOG6ygBQXND7VsYnOQae8Ww==
X-Received: by 2002:a05:6000:15cd:: with SMTP id y13mr8194655wry.717.1643016016053;
        Mon, 24 Jan 2022 01:20:16 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 31sm16657869wrl.27.2022.01.24.01.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 01:20:15 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 43/54] drivers/hv: replace cpumask_weight with
 cpumask_weight_eq
In-Reply-To: <20220123183925.1052919-44-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-44-yury.norov@gmail.com>
Date:   Mon, 24 Jan 2022 10:20:13 +0100
Message-ID: <87sftdij76.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yury Norov <yury.norov@gmail.com> writes:

> init_vp_index() calls cpumask_weight() to compare the weights of cpumasks
> We can do it more efficiently with cpumask_weight_eq because conditional
> cpumask_weight may stop traversing the cpumask earlier (at least one), as
> soon as condition is met.

Same comment as for "PATCH 41/54": cpumask_weight_eq() can only stop
earlier if the condition is not met, to prove the equality all bits need
always have to be examined.

>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 60375879612f..7420a5fd47b5 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -762,8 +762,8 @@ static void init_vp_index(struct vmbus_channel *channel)
>  		}
>  		alloced_mask = &hv_context.hv_numa_map[numa_node];
>  
> -		if (cpumask_weight(alloced_mask) ==
> -		    cpumask_weight(cpumask_of_node(numa_node))) {
> +		if (cpumask_weight_eq(alloced_mask,
> +			    cpumask_weight(cpumask_of_node(numa_node)))) {

This code is not performace critical and I prefer the old version:

 	cpumask_weight() == cpumask_weight()

 looks better than

	cpumask_weight_eq(..., cpumask_weight())

(let alone the inner cpumask_of_node()) to me.

>  			/*
>  			 * We have cycled through all the CPUs in the node;
>  			 * reset the alloced map.

-- 
Vitaly

