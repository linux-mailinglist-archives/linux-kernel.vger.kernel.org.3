Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CAE518FA2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242627AbiECVGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242592AbiECVF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6852403F4
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651611741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ae6kMRYIsxGSMHrL1kLUD9ToHfPIHWhPvHCGM3MMXg=;
        b=hUeqJLbKHqYIDj2UsHUq1zr+3dyLk12gcuyzE37cD6nJcJ7jyAFRhkEl7qLMznIdQO7L7H
        UzOM+cXqJ3Un/uRniigFMq0WGM/cmS9I49zuI2DKRe5p1ffS/Lju65aVBqa6LRhKr4pVYX
        I/D5aNBGMuZbaUH6H7C/9dqva8Tzjlo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-DuVkIOXpPCawHmgYKZp8gw-1; Tue, 03 May 2022 17:02:17 -0400
X-MC-Unique: DuVkIOXpPCawHmgYKZp8gw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D67318E52DC;
        Tue,  3 May 2022 21:02:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7892C28100;
        Tue,  3 May 2022 21:02:15 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id BEE814112779; Tue,  3 May 2022 16:17:02 -0300 (-03)
Date:   Tue, 3 May 2022 16:17:02 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v12 12/13] mm: vmstat_refresh: avoid queueing work item
 if cpu stats are clean
Message-ID: <YnF/rkiGa2aoJGTl@fuller.cnet>
References: <20220315153132.717153751@fedora.localdomain>
 <20220315153314.287031403@fedora.localdomain>
 <874k2fyopx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k2fyopx.ffs@tglx>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:23:06AM +0200, Thomas Gleixner wrote:
> On Tue, Mar 15 2022 at 12:31, Marcelo Tosatti wrote:
> >  	/*
> >  	 * The regular update, every sysctl_stat_interval, may come later
> > @@ -1948,9 +1977,19 @@ int vmstat_refresh(struct ctl_table *tab
> >  	 * transiently negative values, report an error here if any of
> >  	 * the stats is negative, so we know to go looking for imbalance.
> >  	 */
> > -	err = schedule_on_each_cpu(refresh_vm_stats);
> > -	if (err)
> > -		return err;
> > +	cpus_read_lock();
> > +	for_each_online_cpu(cpu) {
> > +		struct work_struct *work = per_cpu_ptr(works, cpu);
> > +
> > +		INIT_WORK(work, refresh_vm_stats);
> > +		if (need_update(cpu) || need_drain_remote_zones(cpu))
> 
> Of course that makes sense in general, but now you have two ways of
> deciding whether updating this is required.
> 
>    1) The above
> 
>    2) The per CPU boolean which tells whether vmstats are dirty or not.
> 
> Can we have a third method perhaps?

Ok, will think of a third method to increase clarity :-)

By the fourth method it will be clear for sure!

