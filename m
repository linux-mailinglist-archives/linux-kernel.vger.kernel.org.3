Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8754505DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346055AbiDRRyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiDRRyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:54:38 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2149234B8D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:51:59 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id a11so10527170qtb.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CF4XNFiOWH5Eo3YeFIexRr3vkZzKzTqeWNNAvXODhVk=;
        b=tFoq+Zh8Xl0j2+4CVgdlgmgRcilf0t0hcLLhN1rgjaGcQhuSUd+u2ziUhAbF9wdG5r
         i3MtpBNOII/qx4D2StE0W4/SlkHMleEwBIBrXANX+e+OqJA9KYELMjlZTsx6U0WvkJK+
         v5CgRJgVN9e3tNZhoCCJUsb9mVpmZTPglNUpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CF4XNFiOWH5Eo3YeFIexRr3vkZzKzTqeWNNAvXODhVk=;
        b=AQS1hhHQFJpS++5wW24UadGV/sFGDroIVF2C+KV7f95ygEvFv99gnQcJvpXIisUS9P
         KvIZ8yly0/NriH1UttfzvI0iqtuvrQvsUTj0j46Ks5a9/DglOGsGmSRramWSjDUteWTy
         CbeWwI1+yzpfsuoLtMiKY1tAynEXgGnvSjPkqbyiQ+1ZOEkxmFZX27/iaybUFZ1ugbjP
         cWbkTfICrowCNUzccygD84b3vuFRqDz4n8KD9ubMg5fnTUSYGOcTmRR5pxwh92MlQZUX
         f5AdI1siSLzI40EOFIVRiELd30ZXJ5VWXLO0KHnmjMdxZcdA2puUF74A4m5nGciHlKxY
         8U9A==
X-Gm-Message-State: AOAM533V2XgDMThwR2CdTs7QTovvAWA9hD5k43PS1V23BvVhl5gb0L1Q
        xs1d0VZYJh/UMmRwwTmNSfAgeQ==
X-Google-Smtp-Source: ABdhPJw/vtu7u+HS9H+xorA64+qGZQjA+kXLF1an9immjLJxWtC3TBMeSGXdtZud63iSBzfvYxp/Ew==
X-Received: by 2002:ac8:5708:0:b0:2f1:fb71:4459 with SMTP id 8-20020ac85708000000b002f1fb714459mr4818301qtw.603.1650304318215;
        Mon, 18 Apr 2022 10:51:58 -0700 (PDT)
Received: from localhost (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id b186-20020a3780c3000000b00699fbe4a238sm6717910qkd.69.2022.04.18.10.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:51:57 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:51:57 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        rushikesh.s.kadam@intel.com, vineethrp@gmail.com, urezki@gmail.com
Subject: Re: [PATCH v3] rcu/nocb: Add an option to offload all CPUs on boot
Message-ID: <Yl2lPSKZ8fLOkfyZ@google.com>
References: <20220415160224.1904505-1-joel@joelfernandes.org>
 <20220415173515.GL4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415173515.GL4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 10:35:15AM -0700, Paul E. McKenney wrote:
> On Fri, Apr 15, 2022 at 04:02:24PM +0000, Joel Fernandes (Google) wrote:
> > From: Joel Fernandes <joel@joelfernandes.org>
> 
> Much better, thank you!
> 
> > On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> > which ends up not offloading any CPU. This patch removes a dependency
> > from the bootloader having to know about RCU, about how many CPUs the
> > system has, and about how to provide the mask.
> 
> The "about how many CPUs the system has" does not apply to current
> mainline, in which "rcu_nocbs=0-N" says to offload all CPUs.  It can be
> added back in for a backport to v5.10.  ;-)

True, will fix.

> My thought is to queue this after some independent testing.
> 
> > ---
> > v2 was forcing the option to override no_cbs=
> > v3 is back to v1 but with a config option defaulting to 'n'.
> > 
> >  Documentation/admin-guide/kernel-parameters.txt |  3 +++
> >  kernel/rcu/Kconfig                              | 13 +++++++++++++
> >  kernel/rcu/tree_nocb.h                          | 16 ++++++++++++++--
> >  3 files changed, 30 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f5a27f067db9..7648a7dd335e 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4398,6 +4398,9 @@
> >  			no-callback mode from boot but the mode may be
> >  			toggled at runtime via cpusets.
> >  
> > +			Note that this argument takes precedence over
> > +			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
> 
> Very good, thank you!
> 
> Do we want to say the same about nohz_full?  Or am I misreading the
> code below?

You're right, will fix.

> > +
> >  	rcu_nocb_poll	[KNL]
> >  			Rather than requiring that offloaded CPUs
> >  			(specified by rcu_nocbs= above) explicitly
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index bf8e341e75b4..2f8bd694ed85 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -223,6 +223,19 @@ config RCU_NOCB_CPU
> >  	  Say Y here if you need reduced OS jitter, despite added overhead.
> >  	  Say N here if you are unsure.
> >  
> > +config RCU_NOCB_CPU_DEFAULT_ALL
> > +	bool "Offload RCU callback processing from all CPUs by default"
> > +	depends on RCU_NOCB_CPU
> 
> The needed dependency on RCU_EXPERT is provided transitively via
> RCU_NOCB_CPU, so this should be OK.  (To check, build a .config file,
> queue this patch, and do "make oldconfig".  If any questions are asked,
> a change is needed.)

Ok. I did that and no questions were asked.

> > +	default n
> > +	help
> > +	  Use this option to offload callback processing from all CPUs
> > +	  by default, in the absence of the rcu_nocbs boot parameter.
> 
> And also in the absence of the nohz_full boot parameter, correct?

Yes, fixed.

> > +	  This also avoids the need to use any boot parameters to achieve
> > +	  the effect of offloading all CPUs on boot.
> > +
> > +	  Say Y here if you want offload all CPUs by default on boot.
> > +	  Say N here if you are unsure.
> > +
> >  config TASKS_TRACE_RCU_READ_MB
> >  	bool "Tasks Trace RCU readers use memory barriers in user and idle"
> >  	depends on RCU_EXPERT
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index eeafb546a7a0..673fa0d1f801 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1165,12 +1165,21 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
> >  void __init rcu_init_nohz(void)
> >  {
> >  	int cpu;
> > -	bool need_rcu_nocb_mask = false;
> > +	bool need_rcu_nocb_mask = false, offload_all = false;
> 
> Please use the extra line to perserve alphabetical order.  (I do know
> about inverse tree, though I have no idea why it is considered to be a
> good thing.)

Done.

thanks,

 - Joel

