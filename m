Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D35D4AEB0F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbiBIHby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiBIHbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:31:52 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F1FC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 23:31:55 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so4288031pja.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 23:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rIBgqwQrEoJBYvjzy6eYqdreTO7LrMetg5khlDxpabY=;
        b=kxEYbxAsPzkUy8jRx+OL1o1dpbX3mw3Fw4gNESNXQ7iuluQL8Tw2m+da/c29xCAwWP
         9ePvVVaQBdQ0iL0D+aGBbj1t4pdG+jXjLi7hwgFIPFpzv2OcSVYFwUEv+/COU27Rtnty
         3YIJFFVwFd6Px1mK6whCrfOCN3M9lxALK3z205pKpv6sM2O0JcXPbHADxoMSPIJYnxRz
         b8KvSBHTWCub64/Ll/EKGxR4up5Gtgnhwvf+Ta5QgTvnLBzIXbKzhWytmnzo15Gd2G03
         /BmfaPd9OiSO3Fdhe9rdYnR5x7zIxuTz1XeJSDbnoDRp0cO+/TB5Ef1YnFnPJ7yjVDsi
         aUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rIBgqwQrEoJBYvjzy6eYqdreTO7LrMetg5khlDxpabY=;
        b=plz2yX6lYVR3COgBvqU4lYNFnsh2EbF7EmUB51eE7Z/hLR482L+GCwBS+bQ6YWTb2f
         ukT7cZSimjafkOd66/Igc33z931SCAq2KcbIIYvO/gD6sfiTFUVHeZlWlj+JeQj4B/Ri
         tYgZFXIV/HJ48U0u3cUMzkzPbdzha208pdTHLzlkXttIGwa/YCgaxBDRM+vDCklTQxL5
         R3vArlPt1X4AnEyGpoMVmPFR/ayRyOhWkQ9jRFxeNwlwdYkGhcBAqKpXiDjN/NOn97bE
         FAFNMhDkAyfIPGfKCHdQA4ytqiNDseRxM9pl8zwUPY4ZVzuGOW44W6F0845pOmIys6ke
         HfLg==
X-Gm-Message-State: AOAM530xVm1ewXFQPnC6fP3+oXodOnaVSIW8nlWri6S94XELwdDdBxhO
        tTU/n1lxoHmZs7mddf9HBA==
X-Google-Smtp-Source: ABdhPJx9b/P+3iVsDJmJ8RM3z/4TyIcdGJZs8VJaKdb687vJ45YUPNAmXp0fnhTCoaTICBtM/75G9g==
X-Received: by 2002:a17:902:ea0c:: with SMTP id s12mr935901plg.169.1644391915328;
        Tue, 08 Feb 2022 23:31:55 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 142sm9490275pfy.41.2022.02.08.23.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 23:31:54 -0800 (PST)
Date:   Wed, 9 Feb 2022 15:31:46 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Baokun Li <libaokun1@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org
Subject: Re: [PATCHv2] kexec: disable cpu hotplug until the rebooting cpu is
 stable
Message-ID: <YgNt4slCVxHRex8z@piliu.users.ipa.redhat.com>
References: <20220127090215.32000-1-kernelfans@gmail.com>
 <20220127094144.GC13508@MiWiFi-R3L-srv>
 <YfOeL6B4CowkCQBC@piliu.users.ipa.redhat.com>
 <YgI5AFoL4b/5MJEp@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgI5AFoL4b/5MJEp@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 05:33:52PM +0800, Baoquan He wrote:
> On 01/28/22 at 03:41pm, Pingfan Liu wrote:
> > On Thu, Jan 27, 2022 at 05:41:44PM +0800, Baoquan He wrote:
> > Hi Baoquan,
> > 
> > Thanks for reviewing, please see comment inlined
> > > Hi Pingfan,
> > > 
> > > On 01/27/22 at 05:02pm, Pingfan Liu wrote:
> > > > The following identical code piece appears in both
> > > > migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
> > > > 
> > > > 	if (!cpu_online(primary_cpu))
> > > > 		primary_cpu = cpumask_first(cpu_online_mask);
> > > > 
> > > > This is due to a breakage like the following:
> > > >    migrate_to_reboot_cpu();
> > > >    cpu_hotplug_enable();
> > > >                           --> comes a cpu_down(this_cpu) on other cpu
> > > >    machine_shutdown();
> > > > 
> > > > Although the kexec-reboot task can get through a cpu_down() on its cpu,
> > > > this code looks a little confusing.
> > > > 
> > > > Make things straight forward by keeping cpu hotplug disabled until
> > > > smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
> > > > breakage is squashed out and the rebooting cpu can keep unchanged.
> > > 
> > > If I didn't go through code wrongly, you may miss the x86 case.
> > > Several ARCHes do call smp_shutdown_nonboot_cpus() in machine_shutdown()
> > > in kexec reboot code path, while x86 doesn't. If I am right, you may
> > > need reconsider if this patch is needed or need be adjustd.
> > > 
> > Citing the code piece in kernel_kexec()
> > 
> >                 migrate_to_reboot_cpu();
> > 
> >                 /*
> >                  * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> >                  * no further code needs to use CPU hotplug (which is true in
> >                  * the reboot case). However, the kexec path depends on using
> >                  * CPU hotplug again; so re-enable it here.
> >                  */
> >                 cpu_hotplug_enable();
> >                 pr_notice("Starting new kernel\n");
> >                 machine_shutdown();
> > 
> > So maybe it can be considered in such way: "cpu_hotplug_enable()" is not
> > needed by x86 and ppc, so this patch removes it, while re-displace it in
> > a more appropriate place for arm64/riscv ...
> 
> OK, so the thing is:
> 
> ==
> In the current code of kexec, we disable cpu hotplug and check reboot cpu
> validity in migrate_to_reboot_cpu(), then enable cpu hotplug. Then in
> machine_shutdown()->smp_shutdown_nonboot_cpus(), check the reboot cpu and
> disable cpu hotplug again.
  ^^^
No, there is no any new call to cpu_hotplug_disable() after
migrate_to_reboot_cpu(). smp_shutdown_nonboot_cpus() just leaves
cpu_hotplug_disabled==0 as it is.
> 
> In this patch, it disables cpu hotplug in migrate_to_reboot_cpu() and
> keep it till entering into smp_shutdown_nonboot_cpus() to shutdown all
> other cpu with hotplug mechanism, then disable it again. With this
                                         ^^^
Here is enable, i.e. smp_shutdown_nonboot_cpus() makes
cpu_hotplug_disabled switch from 1 to 0, so the following fn can work
||	static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
||	{
||		if (cpu_hotplug_disabled)
||			return -EBUSY;
||		return _cpu_down(cpu, 0, target);
||	}

> change, it won't need to double check the reboot cpu validity. 
> 
> This change only affect ARCHes relying on hotplug to shutdown cpu before
> kexec reboot, e.g arm64, risc-v. Other ARCH like x86 is not affected.

Yes.
> ==
> 
> Do I got it right?
> 
Here, neither the original code nor this patch has another
cpu_hotplug_disable(), the only change is the shift of cpu_hotplug_enable() to an onwards place.

And I think you should get my idea except this.

Thanks,

	Pingfan
