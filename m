Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3C4522F00
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiEKJJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiEKJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:09:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1B25A5BD
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:09:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y41so1420538pfw.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5y47Ze+puPsrR0aFbFwPILElAdn4Fvp9ntV65sizufo=;
        b=IkcjWKCEDyJTCkONRkQb7ptSXZeFKswqvr6NFyTO9ByroqljqH40Xr8qmuoPuC2/dE
         7gD8Xgf2+5CIgPo4IIICtA+ad7y+vaoiR4k43MH1a1vCreYAamj3qFvOPDc/GkBwi3Cp
         tQDTHqqHRKPiyltRJdHJbh4Lhyhu33La++I8PdBbuovaOX3ReihQRSlyj9y06JQfX55+
         VX7YKqlEdL9fpfqRaiPJCdRo3Vb/S/bEsPJTnb4THRMkR02o1wS4D55zMq/IKJCXKR3J
         1Jt/nMBVmsXVpHm6JM2eTZtE1G78cjPxX71JcjZCgP7BX2v1iAX42S071GwpGUyD5kdX
         QOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5y47Ze+puPsrR0aFbFwPILElAdn4Fvp9ntV65sizufo=;
        b=sz2zDFosnrSWuyWMjXDR+6UjBXDM7JDAbBPZpzdSt3QAF2nhlB+f3QLlQa/4JY8oPM
         fJipFRpq+YnAE9vZ840jaqrRCu0neY69ESZjADrlfsdBJgxNNKQ5QuhLXq6uvsfkr6vd
         CPr0OhoOd56E2rt1pgdtCMKsNKkcJ7dnDDwdYtpnIJGZwPzsPsU+TvWdBHWhcuZgy10r
         sSlbO+VnyIwmvyeUxKnOhWgA+b4FAExedzeX02ssHKc9r3xXFJhBmLTTnIxUuiPbzvNk
         BUD6uA0rf/f55M0hDeIQa/LepPNor5H5LoPPO2gWwJmrqLhiTU53438DxPnFeU5yWmqd
         vSYg==
X-Gm-Message-State: AOAM531nuMLm9BD1HSNM81/yJ65qzdlOGCPOZGsY7O+kBjOeT2UFefXc
        TYFm04N0xVN8GYi038dNzg==
X-Google-Smtp-Source: ABdhPJzxUYOkr6sk+bfh47QK6sHUduEB6chMlePEMrS6bT0X6tEiKzXJK71SNvOGXrbvLa0r9SmOhA==
X-Received: by 2002:a63:4e:0:b0:3c4:a040:fff3 with SMTP id 75-20020a63004e000000b003c4a040fff3mr19769918pga.22.1652260188517;
        Wed, 11 May 2022 02:09:48 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a10-20020a631a4a000000b003c14af505f1sm1242020pgm.9.2022.05.11.02.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 02:09:48 -0700 (PDT)
Date:   Wed, 11 May 2022 17:09:40 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Baokun Li <libaokun1@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCHv3 1/2] cpu/hotplug: Keep cpu hotplug disabled until the
 rebooting cpu is stable
Message-ID: <Ynt9VHkNYEzsSRnF@piliu.users.ipa.redhat.com>
References: <20220509041305.15056-1-kernelfans@gmail.com>
 <20220509041305.15056-2-kernelfans@gmail.com>
 <87ee13rn52.ffs@tglx>
 <YnneUeRJ42SRM/M+@piliu.users.ipa.redhat.com>
 <87y1z9pzac.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1z9pzac.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 10:28:11AM +0200, Thomas Gleixner wrote:
> On Tue, May 10 2022 at 11:38, Pingfan Liu wrote:
> > On Mon, May 09, 2022 at 12:55:21PM +0200, Thomas Gleixner wrote:
> >> On Mon, May 09 2022 at 12:13, Pingfan Liu wrote:
> >> > The following code chunk repeats in both
> >> > migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
> >> > This is due to a breakage like the following:
> >> 
> >> I don't see what's broken here.
> >> 
> >
> > No, no broken. Could it be better to replace 'breakage' with
> > 'breakin'?
> 
> There is no break-in. There is a phase where CPU hotplug is reenabled,
> which might be avoided.
> 

OK, I will rephrase like this.

> >> > +/* primary_cpu keeps unchanged after migrate_to_reboot_cpu() */
> >> 
> >> This comment makes no sense.
> >> 
> >
> > Since migrate_to_reboot_cpu() disables cpu hotplug, so the selected
> > valid online cpu -- primary_cpu keeps unchange.
> 
> So what is that parameter for then? If migrate_to_reboot_cpu() ensured
> that the current task is on the reboot CPU then this parameter is
> useless, no?
> 

Yes, it is useless after this patch. I will post V4 to kill it.

> >> >  void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
> >> >  {
> >> >  	unsigned int cpu;
> >> >  	int error;
> >> >  
> >> > +	/*
> >> > +	 * Block other cpu hotplug event, so primary_cpu is always online if
> >> > +	 * it is not touched by us
> >> > +	 */
> >> >  	cpu_maps_update_begin();
> >> > -
> >> >  	/*
> >> > -	 * Make certain the cpu I'm about to reboot on is online.
> >> > -	 *
> >> > -	 * This is inline to what migrate_to_reboot_cpu() already do.
> >> > +	 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> >> > +	 * no further code needs to use CPU hotplug (which is true in
> >> > +	 * the reboot case). However, the kexec path depends on using
> >> > +	 * CPU hotplug again; so re-enable it here.
> >> 
> >> You want to reduce confusion, but in reality this is even more confusing
> >> than before.
> >> 
> >
> > This __cpu_hotplug_enable() can be considered to defer from kernel_kexec() to
> > arch-dependent code chunk (here), which is a more proper point.
> >
> > Could it make things better by rephrasing the words as the following?
> >    migrate_to_reboot_cpu() disables CPU hotplug to prevent the selected
> >    reboot cpu from disappearing. But arches need cpu_down to hot remove
> >    cpus except rebooting-cpu, so re-enabling cpu hotplug again.
> 
> Can you please use proper words. arches is not a word and it's closer to
> the plural of arch, than to the word architecture. This is not twitter.
> 

OK, I will correct it.

> And no, the architectures do not need cpu_down() at all. This very
> function smp_shutdown_nonboot_cpus() invokes cpu_down_maps_locked() to
> shut down the non boot CPUs. That fails when cpu_hotplug_disabled != 0.
> 

Yes. I will pay attention to the accuracy of the description.

> >> >  	 */
> >> > -	if (!cpu_online(primary_cpu))
> >> > -		primary_cpu = cpumask_first(cpu_online_mask);
> >> > +	__cpu_hotplug_enable();
> >> 
> >> How is this decrement solving anything? At the end of this function, the
> >> counter is incremented again. So what's the point of this exercise?
> >> 
> > This decrement enables the cpu hot-removing.  Since
> > smp_shutdown_nonboot_cpus()->cpu_down_maps_locked(), if
> > cpu_hotplug_disabled, it returns -EBUSY.
> 
> Correct, so why can't you spell that out in concise words in the first
> place right at that comment which reenables hotplug?
> 

OK, thanks for the suggestion.

> >> What does that for arch/powerpc/kernel/kexec_machine64.c now?
> >> 
> >> Nothing, as far as I can tell. Which means you basically reverted
> >> 011e4b02f1da ("powerpc, kexec: Fix "Processor X is stuck" issue during
> >> kexec from ST mode") unless I'm completely confused.
> >> 
> >
> > Oops. Forget about powerpc. Considering the cpu hotplug is an
> > arch-dependent feature in machine_shutdown(), as x86 does not need it.
> 
> It's not a feature, it's a architecture specific requirement. x86 is
> irrelevant here because this is a powerpc requirement.
> 

Yes.

> >> This is tinkering at best. Can we please sit down and rethink this whole
> >> machinery instead of applying random duct tape to it?
> >> 
> > I try to make code look consistent.
> 
> Emphasis on try. So far the attempt failed and resulted in a regression.
> 

I will fix the powerpc issue and post V4 after a test.


Thanks for your precious time.

Best Regards,

	Pingfan

