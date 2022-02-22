Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1EB4BFE4E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbiBVQRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiBVQRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:17:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 354C899EE4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645546617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DcDTSDbLiZYgGC8YhFYfluc7f+Em6a/9jzmbqQfcKtU=;
        b=ftetj9FacAOYCUK2N1FM58yXAj1z2rfXcTkqS+rsmZcw1LcpQlemRTs5Ex+23hec66esF7
        atfJXGcI147YflyRG0zQh7c4R+WghpzbnIWemgwP94K1WEWEIE2VX2t6leZl798qBph8hm
        UxiL8DEDK7TQaFaVHioox5JI/QJxIxc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-blwuw1oQNweDGD63gFA9iw-1; Tue, 22 Feb 2022 11:16:56 -0500
X-MC-Unique: blwuw1oQNweDGD63gFA9iw-1
Received: by mail-wm1-f72.google.com with SMTP id i20-20020a05600c051400b00380d5eb51a7so762158wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:16:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DcDTSDbLiZYgGC8YhFYfluc7f+Em6a/9jzmbqQfcKtU=;
        b=qwdtwzDI4NQ6LWbC2zwF1j2xsGRwS67Z+64OfEcLU1vMVY9cahLHA+gIdvUmJdMOfm
         f3rQmNsJc05jJWAC2vaafnB0yBGsA6a+ADCqsL89XxcWgfMnqKw9ZM2xSTjU7FLyTEU3
         ovfZaMDCeiTf+BawEqimuLJ8x4naH4juLH1CGtBtLwxC4fqj2+Fng0JYyfZ/DyPRk4SB
         J/Xs9nVWHuYTsUQarKR2srDw0eJAjX29u9qY6F7tLzVA8nCGMPQrbb8UmhDKLZMEuFoZ
         7LPxlHaPFlX6myG56I0R7QCaBnZF83Xl5EIwgjs3oLjDj+3uy8E8AQwaCNXv9JEZ5Cxe
         o51w==
X-Gm-Message-State: AOAM5328rjM/vDw8kXRfkRJuXneIELk6ZUy8Gy9Y34kvOwyuRePdeNu3
        676P7xkezOnN3bs/NQHkIhyFOdOpHOfc8arNMLBdiQqCow9OA1hiA85gZNJQDWXTPxaHgabRcnF
        6tUcxeGIOVNTNHuVurxM+6SqE
X-Received: by 2002:adf:ba8f:0:b0:1e9:4afb:179b with SMTP id p15-20020adfba8f000000b001e94afb179bmr15601789wrg.57.1645546614896;
        Tue, 22 Feb 2022 08:16:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyThEU7QPElbkNMLqPCYNmo2W/qlX4MGgKFIqLhioQUq+UurFeWt5wGJoy3B/oRfP18q5F+ZQ==
X-Received: by 2002:adf:ba8f:0:b0:1e9:4afb:179b with SMTP id p15-20020adfba8f000000b001e94afb179bmr15601772wrg.57.1645546614722;
        Tue, 22 Feb 2022 08:16:54 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1204:1500:37e7:8150:d9df:36f? ([2a0c:5a80:1204:1500:37e7:8150:d9df:36f])
        by smtp.gmail.com with ESMTPSA id 14sm25944252wrb.34.2022.02.22.08.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:16:54 -0800 (PST)
Message-ID: <601c504a381de76d6e39ae2fe86456c411c8b62e.camel@redhat.com>
Subject: Re: [patch 1/2] mm: protect local lock sections with rcu_read_lock
 (on RT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juril@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Date:   Tue, 22 Feb 2022 17:16:53 +0100
In-Reply-To: <YhUGl2F6gZxaNA7v@fuller.cnet>
References: <20220222144706.937848439@redhat.com>
         <20220222144907.023121407@redhat.com>
         <5f96c7e306546af4604cfaddb895a089811cb99b.camel@redhat.com>
         <YhUGl2F6gZxaNA7v@fuller.cnet>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-22 at 12:51 -0300, Marcelo Tosatti wrote:
> On Tue, Feb 22, 2022 at 04:21:26PM +0100, Nicolas Saenz Julienne wrote:
> > On Tue, 2022-02-22 at 11:47 -0300, Marcelo Tosatti wrote:
> > > For the per-CPU LRU page vectors, augment the local lock protected
> > > code sections with rcu_read_lock.
> > > 
> > > This makes it possible to replace the queueing of work items on all 
> > > CPUs by synchronize_rcu (which is necessary to run FIFO:1 applications
> > > uninterrupted on isolated CPUs).
> > 
> > I don't think this is needed. In RT local_locks use a spinlock. See
> > kernel/locking/spinlock_rt.c:
> > 
> > "The RT [spinlock] substitutions explicitly disable migration and take
> > rcu_read_lock() across the lock held section."
> 
> Nice! Then the migrate_disable from __local_lock and friends seems unnecessary as
> well
>
> #define __local_lock(__lock)                                    \
>         do {                                                    \
>                 migrate_disable();                              \
>                 spin_lock(this_cpu_ptr((__lock)));              \
>         } while (0)
> 

It's needed as you might migrate between:

	cpu1_lock = this_cpu_ptr(__lock);
	// migrate here to cpu2
	spin_lock(cpu1_lock);
	// unprotected write into cpu2 lists

Regards,

-- 
Nicolás Sáenz

