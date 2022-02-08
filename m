Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF184AD508
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355193AbiBHJeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353045AbiBHJeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:34:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 594FBC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644312843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CLinaTSeuGjegGac+pEBMBffMNvAe+MQPaYHOqAxqrk=;
        b=dBzoKEZzyR1vMNik+e+I87rJTZDYTWYpQCh52rKUnkdAHS9i5A2V0rWaDWPyw1QXAw+zqI
        /zcE0H9toSUlUVDUHP1jT29Zr/5BjJM0WiorbcH7obu2iAsUgZ2EfKOizbrk8vKV7e/xbL
        +Oqh3onO78+xxT+Y+YU6gtw0/k7zlCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-R2kTzuk-PIy8AVWm2yFlCQ-1; Tue, 08 Feb 2022 04:34:00 -0500
X-MC-Unique: R2kTzuk-PIy8AVWm2yFlCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F38E5802C8F;
        Tue,  8 Feb 2022 09:33:57 +0000 (UTC)
Received: from localhost (ovpn-12-95.pek2.redhat.com [10.72.12.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBA6F54532;
        Tue,  8 Feb 2022 09:33:55 +0000 (UTC)
Date:   Tue, 8 Feb 2022 17:33:52 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
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
Message-ID: <YgI5AFoL4b/5MJEp@MiWiFi-R3L-srv>
References: <20220127090215.32000-1-kernelfans@gmail.com>
 <20220127094144.GC13508@MiWiFi-R3L-srv>
 <YfOeL6B4CowkCQBC@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfOeL6B4CowkCQBC@piliu.users.ipa.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28/22 at 03:41pm, Pingfan Liu wrote:
> On Thu, Jan 27, 2022 at 05:41:44PM +0800, Baoquan He wrote:
> Hi Baoquan,
> 
> Thanks for reviewing, please see comment inlined
> > Hi Pingfan,
> > 
> > On 01/27/22 at 05:02pm, Pingfan Liu wrote:
> > > The following identical code piece appears in both
> > > migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
> > > 
> > > 	if (!cpu_online(primary_cpu))
> > > 		primary_cpu = cpumask_first(cpu_online_mask);
> > > 
> > > This is due to a breakage like the following:
> > >    migrate_to_reboot_cpu();
> > >    cpu_hotplug_enable();
> > >                           --> comes a cpu_down(this_cpu) on other cpu
> > >    machine_shutdown();
> > > 
> > > Although the kexec-reboot task can get through a cpu_down() on its cpu,
> > > this code looks a little confusing.
> > > 
> > > Make things straight forward by keeping cpu hotplug disabled until
> > > smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
> > > breakage is squashed out and the rebooting cpu can keep unchanged.
> > 
> > If I didn't go through code wrongly, you may miss the x86 case.
> > Several ARCHes do call smp_shutdown_nonboot_cpus() in machine_shutdown()
> > in kexec reboot code path, while x86 doesn't. If I am right, you may
> > need reconsider if this patch is needed or need be adjustd.
> > 
> Citing the code piece in kernel_kexec()
> 
>                 migrate_to_reboot_cpu();
> 
>                 /*
>                  * migrate_to_reboot_cpu() disables CPU hotplug assuming that
>                  * no further code needs to use CPU hotplug (which is true in
>                  * the reboot case). However, the kexec path depends on using
>                  * CPU hotplug again; so re-enable it here.
>                  */
>                 cpu_hotplug_enable();
>                 pr_notice("Starting new kernel\n");
>                 machine_shutdown();
> 
> So maybe it can be considered in such way: "cpu_hotplug_enable()" is not
> needed by x86 and ppc, so this patch removes it, while re-displace it in
> a more appropriate place for arm64/riscv ...

OK, so the thing is:

==
In the current code of kexec, we disable cpu hotplug and check reboot cpu
validity in migrate_to_reboot_cpu(), then enable cpu hotplug. Then in
machine_shutdown()->smp_shutdown_nonboot_cpus(), check the reboot cpu and
disable cpu hotplug again.

In this patch, it disables cpu hotplug in migrate_to_reboot_cpu() and
keep it till entering into smp_shutdown_nonboot_cpus() to shutdown all
other cpu with hotplug mechanism, then disable it again. With this
change, it won't need to double check the reboot cpu validity. 

This change only affect ARCHes relying on hotplug to shutdown cpu before
kexec reboot, e.g arm64, risc-v. Other ARCH like x86 is not affected.
==

Do I got it right?

