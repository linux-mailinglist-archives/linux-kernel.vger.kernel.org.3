Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823CE5B2367
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiIHQQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiIHQPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:15:46 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE25B1BA7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:15:42 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id v1so5039284plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 09:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=WRizZ/elGsKzYrgR6wHhu5mQCbmwoq7lJMsQ4A5WuXk=;
        b=vwfy5U6ErUToEm2JuxFc9hLjVPxVoke67KGDmgkoQSDqpmc7aXYryqFBgwxYEpoBV/
         vrbiC7yWnICk9GDxa8nmmAv6tyaaaSdp6D/6nTaXnza/Lux5kDMh5gsAKT7nOLkWmOTu
         RCDmr/97dYtOQpmzslpQEXxAYNyvBgR8yISWQHujMtt15md3Ep1/278NUd+rFsMwqUUd
         AmFH9Moqda6R+S9SYOxso5PtaBjnQLi1xNbIGx+gg4nB0TYfmbPnwg3WY5E7hFRadSuc
         DfVL8Te1nKoc2vGLfrMO4ifmgeAD1sQD2NsO5G0wDd2MlVH8nclGFchBJCJEm2xUn2wn
         4I1A==
X-Gm-Message-State: ACgBeo1IJIgiOSqm0bKs3YkHgJ9GSp8oV9f2EB15pfvmDLFL3Kb+lFpR
        V9f5CLov0E6Pkxwuq0gvwL4=
X-Google-Smtp-Source: AA6agR6KpN7x7XlsPo6Q7kge66cDmDp3fSYTyoziPQRe/m8ELeYmKS1qH7kGqoQP3k0HhEr/Ng0tpQ==
X-Received: by 2002:a17:90b:1a91:b0:1ff:f703:ccad with SMTP id ng17-20020a17090b1a9100b001fff703ccadmr5061311pjb.154.1662653741656;
        Thu, 08 Sep 2022 09:15:41 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id r20-20020a634414000000b00421841943dfsm12633501pga.12.2022.09.08.09.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:15:41 -0700 (PDT)
Date:   Thu, 8 Sep 2022 09:15:37 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Sun, Jiebin" <jiebin.sun@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, vasily.averin@linux.dev,
        shakeelb@google.com, tj@kernel.org, cl@linux.com,
        ebiederm@xmission.com, legion@kernel.org, manfred@colorfullife.com,
        alexander.mikhalitsyn@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tim.c.chen@intel.com,
        feng.tang@intel.com, ying.huang@intel.com, tianyou.li@intel.com,
        wangyang.guo@intel.com
Subject: Re: [PATCH v4] ipc/msg: mitigate the lock contention with percpu
 counter
Message-ID: <YxoVKVVfnrq3js9O@fedora>
References: <CALvZod44uUFnwfF4StC24t+d1s_XE10hkmSCgb04FjtTATo6xQ@mail.gmail.com>
 <20220907172516.1210842-1-jiebin.sun@intel.com>
 <eb13cb3e5e1625afe1bb783810f4d6b52a66a2f6.camel@linux.intel.com>
 <20220907143427.0ce54bbf096943ffca197fee@linux-foundation.org>
 <c8e771c8-4b01-f2b4-5b54-e9931f556270@intel.com>
 <20220908083859.24c989f08d62ddbd031005de@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908083859.24c989f08d62ddbd031005de@linux-foundation.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 08, 2022 at 08:38:59AM -0700, Andrew Morton wrote:
> On Thu, 8 Sep 2022 16:25:47 +0800 "Sun, Jiebin" <jiebin.sun@intel.com> wrote:
> 
> > In our case, if the local 
> > percpu counter is near to INT_MAX and there comes a big msgsz, the 
> > overflow issue could happen.
> 
> percpu_counter_add_batch() handles this - your big message
> won't overflow an s64.
> 
> 
> Lookng at percpu_counter_add_batch(), is this tweak right?
> 
> - don't need to update *fbc->counters inside the lock
> - that __this_cpu_sub() is an obscure way of zeroing the thing
> 
> --- a/lib/percpu_counter.c~a
> +++ a/lib/percpu_counter.c
> @@ -89,8 +89,8 @@ void percpu_counter_add_batch(struct per
>  		unsigned long flags;
>  		raw_spin_lock_irqsave(&fbc->lock, flags);
>  		fbc->count += count;
> -		__this_cpu_sub(*fbc->counters, count - amount);
>  		raw_spin_unlock_irqrestore(&fbc->lock, flags);
> +		__this_cpu_write(*fbc->counters, 0);

I don't think this is irq safe. It'd be best to leave it inside the
spinlock as then we can use __this_cpu_write() to 0 in there.

>  	} else {
>  		this_cpu_add(*fbc->counters, amount);
>  	}
> _
> 

Thanks,
Dennis
