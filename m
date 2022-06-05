Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA5A53DAF4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245173AbiFEJKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiFEJKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:10:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3484DF5D;
        Sun,  5 Jun 2022 02:10:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t25so19018989lfg.7;
        Sun, 05 Jun 2022 02:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iz2VX+xfg1+Kh5wYZuNwYsoBuDh5afS5kt7JhTZR9tY=;
        b=CkV5W4uF4902RhBO2hXrFGVs1T0lI3R+ViUOJFG4qQC5RbgFH8Jtv1UgjROB0aTzlj
         L3mNziphJuKoAi8OzGx2aDh1jrPmN/kY/PfwklkMP4KMBbL4bQQGC0k2n/vR1vVndrF1
         S+VmVvQz9B563rz1oYDOAeiWZx+7+Bba/rLvvSZqK4Hx4655v57Hw6mg3yQwurClgQbc
         FSU9/cyrTSy/rGWCm0r5+tmCsmgDZZFz24fjfQoLCgVc/SBjScTqhGceYRbr/zjcbYz+
         UlUdl6L9dp0TSM7WKWlPYiPjAuwNcfUc1GEVUmTU12jNHqX5/NounKifhwDQhVVX6h1F
         ydMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iz2VX+xfg1+Kh5wYZuNwYsoBuDh5afS5kt7JhTZR9tY=;
        b=dCR8fAiJufakgRXlSWFN7IU3jmGeoX0FzNmemddfvBbQAQPAhG1hjyi+PJN+MJ2SUB
         vu6Fi++o0tK8xBrL928n27mfKX3WupLodo3RUi2mznKzIrjfpTN6ThTkudmzCC9XigNh
         ecBf7eW5G96JnkfkigPHQ3YIVhxwA0zwTMvBI170HVlOX6xfxT8tRuj+CUEl8juQAyFW
         qRQw12yPB9rfmBqZtpdoTihSS+F6rnL8SxrIRCmslH/XEp6VgHBCdiJYJmKRMjbyk2Yf
         v5J/KFYRNR090LeH0Q+stY9THl5hjKrEsFYWHB4X7YX/87Q/4QBlitVwBblVhaVIJYmW
         eU/w==
X-Gm-Message-State: AOAM531dJZD9DAXnRfRTJ0bT2ytk+Om5rrsyFvdkdUZDwCquw+iEOFYK
        akt/jAgJnO/BEpnV6NKiFi8JLKb/X+kXvQ==
X-Google-Smtp-Source: ABdhPJz7jQ6wMB/0+iYOaVN9AlPYWNTrvfvl4BhqgpvtwQ8HZtUTqXesQq+kXH8Xub9koe+VfegL0A==
X-Received: by 2002:a05:6512:32c5:b0:473:cc6d:9eaf with SMTP id f5-20020a05651232c500b00473cc6d9eafmr12331539lfg.90.1654420234123;
        Sun, 05 Jun 2022 02:10:34 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id bi25-20020a0565120e9900b0047255d211fdsm2396598lfb.300.2022.06.05.02.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 02:10:33 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Sun, 5 Jun 2022 11:10:31 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] rcu/kvfree: Introduce KFREE_DRAIN_JIFFIES_[MAX/MIN]
 interval
Message-ID: <YpxzB3/HRN/EEHa8@pc638.lan>
References: <20220602080644.432156-1-urezki@gmail.com>
 <20220602080644.432156-2-urezki@gmail.com>
 <20220604155108.GU1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604155108.GU1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jun 02, 2022 at 10:06:44AM +0200, Uladzislau Rezki (Sony) wrote:
> > Currently the monitor work is scheduled with a fixed interval that
> > is HZ/20 or each 50 milliseconds. The drawback of such approach is
> > a low utilization of page slot in some scenarios. The page can store
> > up to 512 records. For example on Android system it can look like:
> > 
> > <snip>
> >   kworker/3:0-13872   [003] .... 11286.007048: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=1
> >   kworker/3:0-13872   [003] .... 11286.015638: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> >   kworker/1:2-20434   [001] .... 11286.051230: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> >   kworker/1:2-20434   [001] .... 11286.059322: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=2
> >   kworker/0:1-20052   [000] .... 11286.095295: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=2
> >   kworker/0:1-20052   [000] .... 11286.103418: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=1
> >   kworker/2:3-14372   [002] .... 11286.135155: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> >   kworker/2:3-14372   [002] .... 11286.135198: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> >   kworker/1:2-20434   [001] .... 11286.155377: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=5
> >   kworker/2:3-14372   [002] .... 11286.167181: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=5
> >   kworker/1:2-20434   [001] .... 11286.179202: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000008ef95e14 nr_records=1
> >   kworker/2:3-14372   [002] .... 11286.187398: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000c597d297 nr_records=6
> >   kworker/3:0-13872   [003] .... 11286.187445: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000050bf92e2 nr_records=3
> >   kworker/1:2-20434   [001] .... 11286.198975: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=4
> >   kworker/1:2-20434   [001] .... 11286.207203: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=4
> > <snip>
> > 
> > where a page only carries few records to reclaim a memory. In order to
> > improve batching and make utilization more efficient the patch introduces
> > a drain interval that can be set either to KFREE_DRAIN_JIFFIES_MAX or
> > KFREE_DRAIN_JIFFIES_MIN. It is adjusted if a flood is detected, in this
> > case a memory reclaim occurs more often whereas in mostly idle cases the
> > interval is set to its maximum timeout that improves the utilization of
> > page slots.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> That does look like a problem well worth solving!
>
Agree, better ideas make better final solution :)

> 
> But I am missing one thing. If we are having a callback flood, why do we
> need a shorter timeout?
>
To offload faster, because otherwise we run into classical issue, it is a low
memory condition state resulting in OOM.

>
> Wouldn't a check on the number of blocks queued be simpler, more direct,
> and provide faster response to the start of a callback flood?
>
I rely on krcp->count because not always we can store the pointer in the page
slots. We can not allocate a page in the caller context thus we use page-cache
worker that fills the cache in normal context. While it populates the cache, 
pointers temporary are queued to the linked-list.

Any thoughts?

--
Uladzislau Rezki
