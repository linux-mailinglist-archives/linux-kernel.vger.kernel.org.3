Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BE74FF790
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiDMN1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbiDMN1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1D2E27CD2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649856277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fbsrIlecYgH7XGqNRgPdEH/fCCS2sSxeuc+Wr3qYlJ8=;
        b=OI9mXT/3MJ1gackXgC5bbRbwTSxE2zZ/+ADZ0hnQv4SzR+v90uYEUuKgBnIBO0sCiVGVJI
        ji0RjQwCIkUIT98gI+8GEeSNF/Et8ttURyf/hbTootQBPaGY2BholxfV+M0DlF5sFrT8Lc
        aMLgLY7ZgSXO1EO7qzVnJKYyYbJOUdU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-v-rTBKHGM9i9Wyc6uLaIgg-1; Wed, 13 Apr 2022 09:24:33 -0400
X-MC-Unique: v-rTBKHGM9i9Wyc6uLaIgg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 049CE29DD987;
        Wed, 13 Apr 2022 13:24:33 +0000 (UTC)
Received: from localhost (ovpn-12-51.pek2.redhat.com [10.72.12.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5213C424743;
        Wed, 13 Apr 2022 13:24:32 +0000 (UTC)
Date:   Wed, 13 Apr 2022 21:24:29 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v6 4/8] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <YlbPDedkatzrbWMX@MiWiFi-R3L-srv>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
 <20220401183040.1624-5-eric.devolder@oracle.com>
 <YlPy8CKU4zHsx6Bc@MiWiFi-R3L-srv>
 <821b3c62-eedf-c1a3-4aba-671c90d83288@oracle.com>
 <YlY4SlF07iH08Qnj@MiWiFi-R3L-srv>
 <d3ae80cd-7e1f-50e3-d90d-becf779788c0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3ae80cd-7e1f-50e3-d90d-becf779788c0@oracle.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13/22 at 07:37am, Eric DeVolder wrote:
> 
> 
> On 4/12/22 21:41, Baoquan He wrote:
> > On 04/11/22 at 08:54am, Eric DeVolder wrote:
> > > 
> > > 
> > > On 4/11/22 04:20, Baoquan He wrote:
> > > > Hi Eric,
> > > > 
> > > > On 04/01/22 at 02:30pm, Eric DeVolder wrote:
> > > > ... ...
> > > > 
> > > > > +static void crash_hotplug_handler(unsigned int hp_action,
> > > > > +	unsigned long a, unsigned long b)
> > > > 
> > > > I am still struggling to consider if these unused parameters should be
> > > > kept or removed. Do you foresee or feel on which ARCH they could be used?
> > > > 
> > > > Considering our elfcorehdr updating method, once memory or cpu changed,
> > > > we will update elfcorehdr and cpu notes to reflect all existing memory
> > > > regions and cpu in the current system. We could end up with having them
> > > > but never being used. Then we may finally need to clean them up.
> > > > 
> > > > If you have investigated and foresee or feel they could be used on a
> > > > certain architecture, we can keep them for the time being.
> > > 
> > > So 'hp_action' and 'a' are used within the existing patch series.
> > > In crash_core.c, there is this bit of code:
> > > 
> > > +       kexec_crash_image->offlinecpu =
> > > +           (hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
> > > +               (unsigned int)a : ~0U;
> > > 
> > > which is referencing both 'hp_action' and using 'a' from the cpu notifier handler.
> > > I looked into removing 'a' and setting offlinecpu directly, but I thought
> > > it better that offlinecpu be set within the safety of the kexec_mutex.
> > > Also, Sourabh Jain's work with PowerPC utilizing this framework directly
> > > references hp_action in the arch-specific handler.
> > > 
> > > The cpu and memory notifier handlers set hp_action accordingly. For cpu handler,
> > > the 'a' is set with the impacted cpu. For memory handler, 'a' and 'b' form the
> > > impacted memory range. I agree it looks like the memory range is currently
> > > not useful.
> > 
> > OK, memory handler doesn't need the action, memory regions. While cpu
> > handler needs it to exclude the hot plugged cpu.
> > 
> > We could have two ways to acheive this as below. How do you think about
> > them?
> > 
> > static void crash_hotplug_handler(unsigned int hp_action,
> >          unsigned long cpu)
> > 
> > static int crash_memhp_notifier(struct notifier_block *nb,
> >          unsigned long val, void *v)
> > {
> > ......
> >          switch (val) {
> >          case MEM_ONLINE:
> >                  crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
> >                          -1UL);
> >                  break;
> > 
> >          case MEM_OFFLINE:
> >                  crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
> >                          -1UL);
> >                  break;
> >          }
> >          return NOTIFY_OK;
> > }
> > 
> > static int crash_cpuhp_online(unsigned int cpu)
> > {
> >          crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu);
> >          return 0;
> > }
> > 
> > static int crash_cpuhp_offline(unsigned int cpu)
> > {
> >          crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
> >          return 0;
> > }
> 
> I'm OK with the above. Shall I post v7 or are you still looking at patches 7 and 8?
> Thanks!

Just acked patch 8. Patch 7 need be updated too, so will check in v7.

> > 
> > OR,
> > 
> > static void crash_hotplug_handler(unsigned int hp_action,
> >          int* cpu)
> > 
> > static int crash_cpuhp_online(unsigned int cpu)
> > {
> >          crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, NULL);
> >          return 0;
> > }
> > 
> > static int crash_cpuhp_offline(unsigned int cpu)
> > {
> > 	int dead_cpu = cpu;
> >          crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, &cpu);
> >          return 0;
> > }
> > 
> 

