Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886AE535BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344909AbiE0Ipf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349898AbiE0IpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:45:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BCE59B9D;
        Fri, 27 May 2022 01:45:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o9-20020a17090a0a0900b001df3fc52ea7so6545389pjo.3;
        Fri, 27 May 2022 01:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZkWjBvBkp3MoBTy8a44pxEDJROJPPMI6sXaDAZ5cZlw=;
        b=YoCMcidPaedsig1GXzyyoE7gpzcgzvIWctYQ2AnDmiE/BbnD7KO6EYvvtdCBUF/KB7
         wcltN1/deBwOsbcIN4K2ovPD5/ajIij3z/kXxj3vnquuN1bA/sBjN6Iw9UF6aJZSLewk
         j40BsK2lJfFpFX4Mt/wUeuJRVYJZwex1Cpv+7RLr4NaC6PfYkUQD2sAbQc3ErcasJrKD
         mUrpQHcopSBa6t01z75r2oY9yvGD2Q0ZTogGwlHFiICixwdALAS8HxkY+e9R92iYiyWD
         ni1prJxJUZ2mrw6HpQxMqdWRM+91HXudVnpj9vkGbSoieNiZMaHc9PO5wx8RyOgdRiSV
         XEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZkWjBvBkp3MoBTy8a44pxEDJROJPPMI6sXaDAZ5cZlw=;
        b=gsnVbclrNCeOEUrxfFiSIM76Ob92SBGZOriFjJdxw4u4K03QB1byoTjb80JgRVFYsU
         //wlWaXnyL7BnLuQbZIF3BWQy2rd/rpmzhZsQDOMQNMmpE+S3e/ZkquBwogqqq0cIrcW
         FooP5MDWsqhWKvZen/1KlyEihWlrLx6L/XDo9Kq4UWvIJsjlBBmIpZ4XU1KZvuxIWGsy
         1Vat6rV4W91OkHVKFGIXFuHdWYPYgC5t4IB5RrQEiURoPW0a5v9BZKNCaL5ILXJ+x6ec
         zX7VPd7J9M2MSrN3RddFwxl4asahn6NhLY5rlWsS0c9wpwvm4+pL8/2IAxQ9nHSBM1f7
         0Blg==
X-Gm-Message-State: AOAM530JOYQRAF7C23S/c+0x5R357EmHh0bMKYxtKbnrciylba0NQapX
        QGTWr+5i9CgvtOAWfrqh6ec=
X-Google-Smtp-Source: ABdhPJxlCIR2YsBdR8OPEoM9FxLLP69+0yBhyaohRPq+NYW/TldFs1Tp3Qiau3Jr4/mxpwRkH5OjhQ==
X-Received: by 2002:a17:90b:4ace:b0:1df:cb33:5e7e with SMTP id mh14-20020a17090b4ace00b001dfcb335e7emr7083067pjb.5.1653641102713;
        Fri, 27 May 2022 01:45:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:ac0e])
        by smtp.gmail.com with ESMTPSA id n18-20020aa79852000000b0050dc7628195sm2935711pfq.111.2022.05.27.01.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 01:45:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 26 May 2022 22:45:00 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Waiman Long <longman@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
Message-ID: <YpCPjP2jJgLzCo1C@slm.duckdns.org>
References: <20220525221055.1152307-1-frederic@kernel.org>
 <20220525221055.1152307-5-frederic@kernel.org>
 <Yo/FGcG+uiBh88sT@slm.duckdns.org>
 <20220526225141.GA1214445@lothringen>
 <YpAHEt0j30vBw9au@slm.duckdns.org>
 <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
 <YpAdSW8JXVPOoNJl@slm.duckdns.org>
 <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
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

Hello,

On Fri, May 27, 2022 at 10:30:18AM +0200, Juri Lelli wrote:
> FWIW, I was under the impression that this would nicely fit along the
> side of other feaures towards implenting dynamic isolation of CPUs (say
> https://lore.kernel.org/lkml/20220510153413.400020-1-longman@redhat.com/
> for example). Wouldn't be awkward to have to poke different places to
> achieve isolation at runtime?

So, it were just being part of the isolated domain thing, it would make
sense, but as a separate flag which isn't hierarchical, it's weird to put it
there.

> Also, I wonder if a proc/sys interface might be problematic for certain
> middleware that is substantially based on using cgroups. I'll try to ask
> around. :)

There is a downside to making a feature a part of cpuset in that it makes
cgroup usage mandatory. This is fine for something which benefits from
hierarchical organization but it is weird to require building cgroup
hierarchy for straight-forward system-wide features.

Thanks.

-- 
tejun
