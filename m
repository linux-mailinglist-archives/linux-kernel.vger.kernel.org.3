Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E78497BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiAXJQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:16:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39048 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbiAXJQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643015772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0GMN4I0PomTcsrR7i+/ihPb1vMayuvLCjOy0QcpPfLM=;
        b=ZNYHBOeMf5+dEW4c74IlBc4ASXHDvai50n6PR7jujjPOoHE7vXZy/exD0IQmGYmxw6NNC9
        MF0AFiTr9ARm3B/6Gkv0/DXOrcrRCt0leuvjO4Gbj7Z8ou6OtSENOShjEx6G2O1EVR/3PR
        fe7uiN9W39c1DHOC4ZFn8PADDFT4udM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-i03-_pS_OYOK_xB3fBcWDQ-1; Mon, 24 Jan 2022 04:16:11 -0500
X-MC-Unique: i03-_pS_OYOK_xB3fBcWDQ-1
Received: by mail-wm1-f70.google.com with SMTP id b4-20020a7bc244000000b0034f4c46217cso2933754wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 01:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0GMN4I0PomTcsrR7i+/ihPb1vMayuvLCjOy0QcpPfLM=;
        b=2RRB6fMi0FEbdkqCUNsJLo+6BRMdZQ44G3jM1HAkWYB60m7Wrm/Cbw+BBgPOzmEHqH
         yFbl4Dv4OEy65579KPgyp2BBklIzKK67mgQHGUPW33bYm6nnoQ15W9RMSDoYBa2V7/pn
         3c6F/SjSvH0+0ULNXof0qTttoo+7rcHlXC+HQvlZ21M/wioLo3MZsV2tCKa9qD/uCpeS
         n+YEok+fL2qNMJKW1g5jeCD6leq7WZNECEFVCHfm8UJsMmjtmP6jU99tbdoSJIH/sIrH
         HsoBuInRDS9Crj1+SMtf2nPEbUaexuYFEewdGtENeHpaSfJtk842fmrMs2yxT9SBZbXZ
         a9KQ==
X-Gm-Message-State: AOAM531S2NuvGNzo+/YUa2cuK1ZftCZEEED7rmu7IBi2fCXmLeXmUzqI
        zWe4Pj4cBw5JRqjgigfHUHiIF/4pBwngU06/a0p3Oq/XE43XuAWx1xLJpvHmX0ckKwSutA/ZKZi
        lnNCkaxv9yLq65pnMEwwBWWEB
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr963801wmh.57.1643015770232;
        Mon, 24 Jan 2022 01:16:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwI6gadj+njviMp6rGo0iSzUv6Z7FJvFoPF6z/uFtYk1HxkHbioTJ4HN8vTT/q3jAb1qbStww==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr963777wmh.57.1643015770056;
        Mon, 24 Jan 2022 01:16:10 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n13sm14096315wrm.68.2022.01.24.01.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 01:16:09 -0800 (PST)
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
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 41/54] arch/x86: replace cpumask_weight with
 cpumask_weight_eq where appropriate
In-Reply-To: <20220123183925.1052919-42-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-42-yury.norov@gmail.com>
Date:   Mon, 24 Jan 2022 10:16:08 +0100
Message-ID: <87v8y9ijdz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yury Norov <yury.norov@gmail.com> writes:

> smpboot code in somw places calls cpumask_weight() to compare the weight
> of cpumask with a given number. We can do it more efficiently with
> cpumask_weight_eq() because conditional cpumask_weight may stop traversing
> the cpumask earlier, as soon as condition is met.

I think this is misleading. cpumask_weight_eq() with any implementation
can only stop earlier if the condition is NOT met (when the number of
set bits is already higher than needed), to check for equality all bits
always need to be examined.

>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/x86/kernel/smpboot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 617012f4619f..e851e9945eb5 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1608,7 +1608,7 @@ static void remove_siblinginfo(int cpu)
>  		/*/
>  		 * last thread sibling in this cpu core going down
>  		 */
> -		if (cpumask_weight(topology_sibling_cpumask(cpu)) == 1)
> +		if (cpumask_weight_eq(topology_sibling_cpumask(cpu), 1))
>  			cpu_data(sibling).booted_cores--;
>  	}
>  
> @@ -1617,7 +1617,7 @@ static void remove_siblinginfo(int cpu)
>  
>  	for_each_cpu(sibling, topology_sibling_cpumask(cpu)) {
>  		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
> -		if (cpumask_weight(topology_sibling_cpumask(sibling)) == 1)
> +		if (cpumask_weight_eq(topology_sibling_cpumask(sibling), 1))
>  			cpu_data(sibling).smt_active = false;
>  	}

-- 
Vitaly

