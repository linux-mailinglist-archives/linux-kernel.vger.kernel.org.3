Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4AC4CA269
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbiCBKrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbiCBKq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:46:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8CEABE1E8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646217975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CcgSVhR3v1Q4DF91nNA8Ox25JFwZZ/xXnD/Xr8Ohi4E=;
        b=WLIdgg9zpWt3AX/SjhX2h5cQTvHHc/GHOh2TqIE8L1WD5Y7ctkTaSFjJnUpR7gJ4lZ0SRl
        0eSVCiL5afwhej8ker4hz6K+CjuYVdQYP+kgW+UjYLTNwTYVASeluAYU/FD+yEPtM85ySc
        od1ZA6nVD5KhMtmv0OdfxAxoY6Ujs0s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-j7Eue7GyNMKjTruZ6B2ucw-1; Wed, 02 Mar 2022 05:46:13 -0500
X-MC-Unique: j7Eue7GyNMKjTruZ6B2ucw-1
Received: by mail-wm1-f69.google.com with SMTP id h19-20020a05600c351300b0038141cf26deso675178wmq.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 02:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=CcgSVhR3v1Q4DF91nNA8Ox25JFwZZ/xXnD/Xr8Ohi4E=;
        b=k+qQRxRi/A0/PRQnfi+WVFmmjTTLf5z0Jo8c4DDv2PvJ5qW3n+uXRvtIJMVNQS924u
         VCYdSkqVBqrOGkCFDF1TmJURy8fz7KgcwHhrpD6YjbG0t0h6cMKgP1VtqzWLzluQ7W+R
         udRAZkMta+Y+fU3TIh5QrnxljwZHcfjiYJPRBVCovDm9fL16E6Qur1W1oTuBr+SsKBqd
         DDjQ0NdkgibUP3hHT+Z6/oCXGdu2t+Eo77XExviY75d66Zct0VoNrH4iX9Jd74ss7Iu7
         j7FMSqi6AM6zgM6DPm+nySI5xDssGQ/33W277gOgg8sWjOKSmHJLWqkFRZIUCM37E4gy
         c8LQ==
X-Gm-Message-State: AOAM532CCXc5NNXhvLSmKUO2F4J+wRsvmXtkbBFhUGhFzaJe9T3gXKq0
        6bG20kvIqhX7rnYY2uXSVbYXKRN9jFOZTvscbLyRfgyHMqonJ9ou88vUL+KKdEzWORE6tygzEGf
        dMS+L+oWHppEFOjLMEjpg+ipu
X-Received: by 2002:adf:e108:0:b0:1ef:97ad:5372 with SMTP id t8-20020adfe108000000b001ef97ad5372mr12301270wrz.658.1646217972728;
        Wed, 02 Mar 2022 02:46:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3eTCKEw4hLbypwFmYuE8h4jh5anSTEP5pUVs2vPgZ5BptjSvDyAQv8Wkzla2u3AER8KBvjw==
X-Received: by 2002:adf:e108:0:b0:1ef:97ad:5372 with SMTP id t8-20020adfe108000000b001ef97ad5372mr12301255wrz.658.1646217972426;
        Wed, 02 Mar 2022 02:46:12 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8? ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id x15-20020adfdd8f000000b001f0473a0a3fsm616371wrl.14.2022.03.02.02.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 02:46:12 -0800 (PST)
Message-ID: <14775dadbf47ce3bcc8c375be82028ef4dcdba87.camel@redhat.com>
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     paulmck@kernel.org
Cc:     rostedt@goodmis.org, bristot@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com
Date:   Wed, 02 Mar 2022 11:46:11 +0100
In-Reply-To: <20220301175621.GP4285@paulmck-ThinkPad-P17-Gen-1>
References: <20220228141423.259691-1-nsaenzju@redhat.com>
         <20220228221154.GN4285@paulmck-ThinkPad-P17-Gen-1>
         <1b388cdc409fdfae75ef2280674d8211e5b6194e.camel@redhat.com>
         <20220301175621.GP4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-01 at 09:56 -0800, Paul E. McKenney wrote:
> On Tue, Mar 01, 2022 at 11:00:08AM +0100, Nicolas Saenz Julienne wrote:
> > On Mon, 2022-02-28 at 14:11 -0800, Paul E. McKenney wrote:
> > > On Mon, Feb 28, 2022 at 03:14:23PM +0100, Nicolas Saenz Julienne wrote:
> > > > At the moment running osnoise on an isolated CPU and a PREEMPT_RCU
> > > > kernel might have the side effect of extending grace periods too much.
> > > > This will eventually entice RCU to schedule a task on the isolated CPU
> > > > to end the overly extended grace period, adding unwarranted noise to the
> > > > CPU being traced in the process.
> 
> Ah, I misread the above paragraph.  Apologies!
> 
> Nevertheless, could you please add something explicit to the effect that
> RCU is completing grace periods as required?

Yes, of course.

[...]
> > > o	At about 30 milliseconds into the grace period, RCU forces an
> > > 	explicit context switch on the wayward CPU.  This should get
> > > 	the CPU's attention even in CONFIG_PREEMPT=y kernels.
> > > 
> > > So what is happening for you instead?
> > 
> > Well, that's exactly what I'm seeing, but it doesn't play well with osnoise.
> 
> Whew!!!  ;-)
> 
> > Here's a simplified view of what the tracer does:
> > 
> > 	time1 = get_time();
> > 	while(1) {
> > 		time2 = get_time();
> > 		if (time2 - time1 > threshold)
> > 			trace_noise();
> > 		cond_resched();
> > 		time1 = time2;
> > 	}
> > 
> > This is pinned to a specific CPU, and in the most extreme cases is expected to
> > take 100% of CPU time. Eventually, some SMI, NMI/interrupt, or process
> > execution will trigger the threshold, and osnoise will provide some nice traces
> > explaining what happened.
> > 
> > RCU forcing a context switch on the wayward CPU is introducing unwarranted
> > noise as it's triggered by the fact we're measuring and wouldn't happen
> > otherwise.
> > 
> > If this were user-space, we'd be in an EQS, which would make this problem go
> > away. An option would be mimicking this behaviour (assuming irq entry/exit code
> > did the right thing):
> > 
> > 	rcu_eqs_enter(); <--
> > 	time1 = get_time();
> > 	while(1) {
> > 		time2 = get_time();
> > 		if (time2 - time1 > threshold)
> > 			trace_noise();
> > 		rcu_eqs_exit(); <--
> > 		cond_resched();
> > 		rcu_eqs_enter(); <--
> > 		time1 = time2;
> > 	}
> > 
> > But given the tight loop this isn't much different than what I'm proposing at
> > the moment, isn't it? rcu_momentary_dyntick_idle() just emulates a really fast
> > EQS entry/exit.
> 
> And that is in fact exactly what rcu_momentary_dyntick_idle() was
> intended for:
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Thanks!

-- 
Nicolás Sáenz

