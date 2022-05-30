Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189C5538483
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiE3POc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238865AbiE3POF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59C641A448C
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653920028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rWHGtydye04Pc0qlr5FGyqa1kfhiweLX/99E3DuULf0=;
        b=DjfZSdNtRAGFg7jpRAZQ9XNCanKrYCFcveMhlosA5p6WyZNPmM+RkNsmlT0Yoow+yi/O2E
        tNKJm7VX8NC+IPqCqDLYWKzcGcMQqe/ac/I4ilTAtKe00SgjnsV/9Lwvk4DXPNO0qcAmUe
        FaBz/zxrRXpur3dsHyHD/NA1F0vz41o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-_4azY-9lMDucgJoqEULIVg-1; Mon, 30 May 2022 10:13:47 -0400
X-MC-Unique: _4azY-9lMDucgJoqEULIVg-1
Received: by mail-wm1-f72.google.com with SMTP id c187-20020a1c35c4000000b003970013833aso4652442wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rWHGtydye04Pc0qlr5FGyqa1kfhiweLX/99E3DuULf0=;
        b=WTuxL6cJjOOq3p6vYvgevi/JKl02iG9QgBll8nf4bAzSWJ2AAxwWLpqp5HPS4tIDi9
         Y1fDX+GMm1RgGxvhWab97wK+WNfzbIJAEHyfu3TExPdfHmz+gDbQgK5rRkkjPrV48Z4Y
         bWx6yuEumDxOmD558VN7uDcRyk/kfcG3dgVofcLh3tgk/UNak7+WCnzHTljc/57/ovP9
         BwYVwkYBBEBJaS5g7BtoNKM00RilIjcfSpfOSzYOEVoS+UbjDUKx8znzn8vlZ14qBi41
         H4ITPV/gVz4x9yjHQk2fOBkGnJ5xlrecyR8Nq2sylKpx6yjcPV9IvVLtyx1uLK87UKMz
         E6pg==
X-Gm-Message-State: AOAM532nS53TsgGjVAsV4XirTZuJ0afMbkEevf32Nagq3MAbLSMLzf4g
        hTL6RT+5uSFc2Ah0QXlnkxCKTHB2A5pL9KhME7xTO8/QjEnkHnhfo4+F8BfLyUNPHbDYDQyHHV9
        vNohF+dEQWYABvSzajflA0gnX
X-Received: by 2002:a05:600c:1f0e:b0:397:707f:5a60 with SMTP id bd14-20020a05600c1f0e00b00397707f5a60mr18750193wmb.3.1653920026201;
        Mon, 30 May 2022 07:13:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1e34u+loAw8VqZvb9FL0bHKiEQ+1d9UEpMOs2QB0ub76Kzi7QWkgcn90Ht1UuKmcalYImZg==
X-Received: by 2002:a05:600c:1f0e:b0:397:707f:5a60 with SMTP id bd14-20020a05600c1f0e00b00397707f5a60mr18750170wmb.3.1653920025881;
        Mon, 30 May 2022 07:13:45 -0700 (PDT)
Received: from localhost.localdomain ([151.29.54.194])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c1c0d00b00397243d3dbcsm11368749wms.31.2022.05.30.07.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 07:13:45 -0700 (PDT)
Date:   Mon, 30 May 2022 16:13:42 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <YpTRFotSs0UnMEJJ@localhost.localdomain>
References: <20220526225141.GA1214445@lothringen>
 <YpAHEt0j30vBw9au@slm.duckdns.org>
 <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
 <YpAdSW8JXVPOoNJl@slm.duckdns.org>
 <20220527083018.n43nc73vuuzm5ixo@localhost.localdomain>
 <YpIwsiaY2IPK96WO@hirez.programming.kicks-ass.net>
 <20220530004049.GA1251147@lothringen>
 <YpR8PUlIraYE2+5L@worktop.programming.kicks-ass.net>
 <20220530105650.GA1257179@lothringen>
 <YpTDq6Z/+hp+CHwf@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpTDq6Z/+hp+CHwf@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/22 15:16, Peter Zijlstra wrote:
> On Mon, May 30, 2022 at 12:56:50PM +0200, Frederic Weisbecker wrote:
> 
> > > This is ABI, you can't walk back on it. I would suggest starting with an
> > > 'all feature' isolation. Only if there's real demand for something more
> > > fine-grained add that on top. Simple first etc.
> > 
> > That's actually my worry. If we start with an all in one ABI, how do we later
> > mix that up with more finegrained features? Like what will be the behaviour of:
> > 
> > cpuset.isolation.rcu_nocb = 0
> > cpuset.isolation.all = 1
> 
> Well clearly that doesn't make sense. I was more thinking along the
> lines of cgroup.subtree_control, where instead all features are enabled
> by default.
> 
> But only if there's a real usecase, otherwise there's no point in
> providing such knobs.

All features on/off knob + house-keeping sub-partition/mask seem to be
what isolation users I could reach so far (OCP mostly) would indeed like
to have in the future.

