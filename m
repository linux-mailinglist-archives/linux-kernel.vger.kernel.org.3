Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6498D4C8A2E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiCALAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiCALAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:00:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C72A48C7CB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646132366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AWSKkP5/W2jrKvhlrqFekAwUNRqBlbBrLLqgLO5ycLE=;
        b=eZCkOIid5zktKbExR3gzAolZC/7mcc4xz7Tlmea0tEAMc7NCWluubMWGOOmP3cVySyPqV6
        4gkHt3sI/a+5uHTxEu5gO3R0aeZmIZISJghlasZ1+zQSsFi7EgKW4M2ReK1Q9Ni08Fhjkk
        M/EXYl2NzSrch9wX3bF1YCjyzMvPzW0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-eABNW-T9PQaHoZ4Ut7Zyow-1; Tue, 01 Mar 2022 05:59:23 -0500
X-MC-Unique: eABNW-T9PQaHoZ4Ut7Zyow-1
Received: by mail-wm1-f71.google.com with SMTP id i20-20020a05600c051400b00380d5eb51a7so1036135wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AWSKkP5/W2jrKvhlrqFekAwUNRqBlbBrLLqgLO5ycLE=;
        b=HTSF4t7x5UwiHhAJDDk0vXfVToCmY0fWGad6ioWfaOiodNoo/7tABf6Dq2UnaDl2Xl
         AiJBNNvali7oscgnq1D3E0kWOTNIHVeLcFmDd+6+GJdrRKf1fviZu3PpKKEP3nZdw/tC
         AUjJ4VVDw0hRa4wCbg8GGQpkWKIKjywTCNxIk7Bc5vCHAdwnnyv1CdBiTdjbuFGLe6Dv
         vAv9e4m+6I42pIZmQ64I9NmcOFfpOI7B67pjkyTfrt4Th/kieMgEzqUtb+Dg01Y+dNZY
         gG8+e5tMbfrYxVjRMf6JXy9lWZ+SQI+g74OumXBm8dPw37DkFYgARKIgyGywkCuXEvfA
         cT/g==
X-Gm-Message-State: AOAM5320UZQ85zXT7KDLhUB/b1AC/P2/prO86cgLMj9ofuUJ9B0FqKGi
        Xpdm4TCUJ/N+YfVv3YKZ0GWnsybIEtBDqomfm3olQhuKOQpboeuJ+PfHMYmwQmbJ3BvZ20+vOG9
        N8o/jtkzxLPULWX+8E14wU5TP
X-Received: by 2002:a1c:7c18:0:b0:381:4fd6:fcec with SMTP id x24-20020a1c7c18000000b003814fd6fcecmr10460922wmc.45.1646132362380;
        Tue, 01 Mar 2022 02:59:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRyr0dxgKtTrt87jX44QxsxQcuXzIiXM0eSGqcLEaYM6kHMTj82noqxnHzXywmzZ8aIFsvnQ==
X-Received: by 2002:a1c:7c18:0:b0:381:4fd6:fcec with SMTP id x24-20020a1c7c18000000b003814fd6fcecmr10460909wmc.45.1646132362181;
        Tue, 01 Mar 2022 02:59:22 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8? ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id z2-20020a056000110200b001e7140ddb44sm12741739wrw.49.2022.03.01.02.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:59:21 -0800 (PST)
Message-ID: <6bd3b0083427c6cf1c860a021e097af9052cdd75.camel@redhat.com>
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     bristot@kernel.org, paulmck@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com
Date:   Tue, 01 Mar 2022 11:59:20 +0100
In-Reply-To: <20220228104523.01eda61a@gandalf.local.home>
References: <20220228141423.259691-1-nsaenzju@redhat.com>
         <20220228104523.01eda61a@gandalf.local.home>
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

On Mon, 2022-02-28 at 10:45 -0500, Steven Rostedt wrote:
> On Mon, 28 Feb 2022 15:14:23 +0100
> Nicolas Saenz Julienne <nsaenzju@redhat.com> wrote:
> 
> > @@ -1386,6 +1389,22 @@ static int run_osnoise(void)
> >  					osnoise_stop_tracing();
> >  		}
> >  
> > +		/*
> > +		 * Check if we're the only ones running on this nohz_full CPU
> > +		 * and that we're on a PREEMPT_RCU setup. If so, let's fake a
> > +		 * QS since there is no way for RCU to know we're not making
> > +		 * use of it.
> > +		 *
> > +		 * Otherwise it'll be done through cond_resched().
> > +		 */
> > +		if (IS_ENABLED(CONFIG_PREEMPT_RCU) &&
> > +		    !housekeeping_cpu(raw_smp_processor_id(), HK_FLAG_MISC) &&
> > +		    tick_nohz_tick_stopped()) {
> > +			local_irq_save(flags);
> > +			rcu_momentary_dyntick_idle();
> > +			local_irq_restore(flags);
> > +		}
> > +
> 
> This looks very specific and a corner case. Something that depends on how
> RCU works. This really should be in the RCU code such that if something
> changes, RCU maintainers are aware of this and can update this too.

The if statement could be relaxed to some extent (I'm looking into it ATM). I
made it more constraining to avoid the overhead for other users.

As for rcu_momentary_dyntick_idle(), I'm not the first one to use it for such
means. See multi_cpu_stop() in kernel/stop_machine.c. So I'm not sure it counts
as abusing RCU internals.

> I wonder if this is similar to what we have in trace_benchmark(). Would
> using: cond_resched_tasks_rcu_qs() work for you?

IIUC this only affects tasks_rcu, and doesn't help with regular RCU. We already
call cond_resched_tasks_rcu_qs() in osnoise when necesary, actually it was
introduced by you. :)

Thanks!

-- 
Nicolás Sáenz

