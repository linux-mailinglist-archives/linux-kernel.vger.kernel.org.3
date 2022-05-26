Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428F453534A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348369AbiEZSVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349387AbiEZSVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:21:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4CA1F2;
        Thu, 26 May 2022 11:21:15 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q18so2095176pln.12;
        Thu, 26 May 2022 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d0fpBE5F3NBZ+8URTPU18WW4lxXrMNmlzzHMRZ9RPHQ=;
        b=Jgv1cy1fSegcVuFBb7XtRbtvqraroRghd4FALpubleZyS+6GNvymMX1cVvAW6IrtAE
         hpIJu3SFz/SYl0SXcl6eOMo4HdsGwEzpeV1X5DE+FLnRSK+ePV36K4wUyxbWUT7D0Zj2
         p6nNauqH01SYLSXeEbtuJU+30stYEIYSc0JfXbaBzSdKvL78BVj7FRdZSUxTvfZdFEJl
         ftwP060IqJr4HuaN+DhGm77w+G21dXAUrPxq3RZ2x/alT0jHwSMAK47s6DujCs81BQPB
         Q1MHu3801obdazhkN+Z/2glllSlmwccWgwHAoQ9bejig/MsY77hI1Nb5/9iqBNajobIZ
         CNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=d0fpBE5F3NBZ+8URTPU18WW4lxXrMNmlzzHMRZ9RPHQ=;
        b=NUbODkXzmW9wtGCEosOiSVz2nyHXV3THDLLHUZ5lNg58vsGL5Nq0Js6loTivxRc7h0
         LSzsijvCPvIrRnfXT1qbYoSpfQSoVLBBb5lmHo2ul+AHTJMjLfNeeXg3R0QUsX9XERfI
         CNH2/3Vv7yKkNkqNBcB9c2vJEyMGRt87fPspMCpBentGQ90QDcly/Yv/BkRURUYQ8k5y
         JWznlvMv01TsQaUyPkhquuH3jCB/ZatMO6LGRLJPYZC21wmAlrKk7vh+Z/HSnGddjKP9
         JnvwxSEdMX0GpgddWlU65/sM0PBHhbc00EKc1OEHERiiVo2c032ZA2MfImQqqUYoJqzT
         HF9Q==
X-Gm-Message-State: AOAM530t28MFAGR3/YGG4YEaVu4SLZV6TZaqcSh+e6b92uXk53rHp2PS
        DZC4afn8xcnYhgYdXVvz1K5K7uJ2Kp4=
X-Google-Smtp-Source: ABdhPJy3P33MjfdPZQfI4ErViA8YVXpSHO5EuUvNcQ7uu2BfW7Tnb5XK9Slrzs5WGQofuodD6/OlIg==
X-Received: by 2002:a17:90b:1808:b0:1e0:4dbc:8781 with SMTP id lw8-20020a17090b180800b001e04dbc8781mr3915707pjb.58.1653589275194;
        Thu, 26 May 2022 11:21:15 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:aafd])
        by smtp.gmail.com with ESMTPSA id n4-20020a6563c4000000b003f67294ed87sm1823871pgv.70.2022.05.26.11.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:21:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 26 May 2022 08:21:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
Message-ID: <Yo/FGcG+uiBh88sT@slm.duckdns.org>
References: <20220525221055.1152307-1-frederic@kernel.org>
 <20220525221055.1152307-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525221055.1152307-5-frederic@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 12:10:55AM +0200, Frederic Weisbecker wrote:
> Introduce a new "isolation.rcu_nocb" file within a cgroup2/cpuset
> directory which provides support for a set of CPUs to either enable ("1")
> or disable ("0") RCU callbacks offloading (aka. RCU NOCB). This can
> overwrite previous boot settings towards "rcu_nocbs=" kernel parameter.
> 
> The file is only writeable on "root" type partitions to exclude any
> overlap. The deepest root type partition has the highest priority.
> This means that given the following setting:
> 
>                     Top cpuset (CPUs: 0-7)
>                     cpuset.isolation.rcu_nocb = 0
>                               |
>                               |
>                     Subdirectory A (CPUs: 5-7)
>                     cpuset.cpus.partition = root
>                     cpuset.isolation.rcu_nocb = 0
>                               |
>                               |
>                     Subdirectory B (CPUs: 7)
>                     cpuset.cpus.partition = root
>                     cpuset.isolation.rcu_nocb = 1
> 
> the result is that only CPU 7 is in rcu_nocb mode.
> 
> Note that "rcu_nocbs" kernel parameter must be passed on boot, even
> without a cpulist, so that nocb support is enabled.

Does it even make sense to make this hierarchical? What's wrong with a
cpumask under sys/ or proc/?

Thanks.

-- 
tejun
