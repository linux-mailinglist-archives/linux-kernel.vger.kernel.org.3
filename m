Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BF955E22B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344712AbiF1LsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345170AbiF1LrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:47:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFBD2F671;
        Tue, 28 Jun 2022 04:45:35 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j21so21839488lfe.1;
        Tue, 28 Jun 2022 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X0xzQqH5KpRMLY9+PVHhyVujx5g/6WCMMJw5Qqi65jI=;
        b=jnUdvSPOBJDAxP48Ljv06+Y4FUAIZkOkrCXTaSImmvJPsVoCitqk5nFbdXtgIq3M3R
         VjFQU6sZcciMIQQVEAu10glcOPPmsj5/wyMjNeH2EBqrWKf/A7znwAzQ6eYUOpFFegAP
         ++U/w9iDQu/vkSWCjwLQglsCuLfZpRheX9NIRY6JbrhBemsoEJe4bOPSrff4GH6ZHJEg
         AoGVaDnufkKYVoPwmGbZfQ91c4eVW1ITqXJxjF1pjqB28TQKFZBXNSEJNkC5IA5BPIWX
         2S9GJ7toPEKNRC5fiBJni5fJXoo6cdor3quwS62vP6tuZzH9FrApvwljwOQJ0q05LZ/r
         hgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X0xzQqH5KpRMLY9+PVHhyVujx5g/6WCMMJw5Qqi65jI=;
        b=lGIbvuzpp49hFTHn8Tc2e+9YpIWoxDFVOKlE421EA9+RQL8YBn0PJsi/v13qq5uQ2t
         tKVyn71cnKwEYLoh29V1Vaj/8TAoNuphMsopz4mpDAaTt3CiOS8G5tf+s1wcCPkbZ1wD
         yVhtXEBDukI/sSK7x9avQ0LJIvIEbYlFoyZ/j8CXhj0ix+dFU2rzpEnir8+faM15SNxV
         3JovM7HKlgb+x76zh19EKeqJiKjqln9+k6sLKPCh7YwtEp/Tpt6pv3ToX7SAm0tmKegJ
         RFVt6obWXL6X9DjF8SaBVe/EzESF47sLOYbI5yNie2gM7Bgr5Fb+FAR+MmeV14W3KwnC
         27wg==
X-Gm-Message-State: AJIora+46X9uTTD5jKAGyV7KGIEYK8lPWQMgw0dQih2yMZydIXFQLX34
        niVWGY0/lXQ7T01geMnbAlY=
X-Google-Smtp-Source: AGRyM1spQ+83X4VvzEzhO/24k4ObYmu1Fz0thJaux2DJZYh2Ch0uRYrTaVTArCzlAn0D6n+92ksugQ==
X-Received: by 2002:a05:6512:3b2c:b0:47f:6fc2:a9de with SMTP id f44-20020a0565123b2c00b0047f6fc2a9demr12523314lfv.352.1656416733846;
        Tue, 28 Jun 2022 04:45:33 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id k20-20020a2ea274000000b0025a8c1b5fe2sm1787142ljm.17.2022.06.28.04.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:45:33 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 28 Jun 2022 13:45:31 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 1/1] rcu/kvfree: Update KFREE_DRAIN_JIFFIES interval
Message-ID: <Yrrp2044RY6amuLo@pc638.lan>
References: <20220627195353.1575285-1-urezki@gmail.com>
 <20220627213126.GO1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627213126.GO1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jun 27, 2022 at 09:53:53PM +0200, Uladzislau Rezki (Sony) wrote:
> > Currently the monitor work is scheduled with a fixed interval that
> > is HZ/20 or each 50 milliseconds. The drawback of such approach is
> > a low utilization of page slot in some scenarios. The page can store
> > up to 512 records. For example on Android system it can look like:
> 
> I was looking at queuing this one, but we need a bit more data.  In
> the meantime, here is my wordsmithing of the above paragraph:
> 
> Currently the monitor work is scheduled with a fixed interval of HZ/20,
> which is roughly 50 milliseconds. The drawback of this approach is
> low utilization of the 512 page slots in scenarios with infrequence
> kvfree_rcu() calls.  For example on an Android system:
> 
Good i will update with your changes :)

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
> > where a page only carries few records to reclaim a memory. In order
> > to improve batching and make utilization more efficient the patch sets
> > a drain interval to 1 second as default one. When a flood is detected
> > an interval is adjusted in a way that a reclaim work is re-scheduled
> > on a next timer jiffy.
> 
> And of the above paragraph:
> 
> Out of 512 slots, in all cases, fewer than 10 were actually used.
> In order to improve batching and make utilization more efficient this
> commit sets a drain interval to a fixed 1-second interval. Floods are
> detected when a page fills quickly, and in that case, the reclaim work
> is re-scheduled for the next scheduling-clock tick (jiffy).
> 
Same here, will apply this.

> ---
> 
> But what we need now is a trace like the one above showing higher utilization
> of the pages.  Could you please supply this?
> 
Yep, i will add traces to show that utilization becomes better what is
actually expectable.

--
Uladzislau Rezki
