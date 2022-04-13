Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773BE4FED1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 04:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiDMCnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 22:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiDMCnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 22:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D438C38DB9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 19:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649817682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p70NKAiRaMP1vXhr16nDpbz8CDB6K3j4Y5fwgjlv39Y=;
        b=GNp0eNjJABEIzA+wtUgTK3pjfECX6qENLU2n1TzHQSy6dVn0mlywKCftST+atFtZXhofgR
        RybYKg1yKtc3y17SOA3HDHitdfC5//iOL9trBI+DP+mhEOP/Vd6vl5M7HxNkw6fPHdEriv
        RWO3v2FD1qXODrYIiwiGMzJnU8+Tl/c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-n2wUoT7TOIy_Kmx79pZrIw-1; Tue, 12 Apr 2022 22:41:19 -0400
X-MC-Unique: n2wUoT7TOIy_Kmx79pZrIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F19491C05EC6;
        Wed, 13 Apr 2022 02:41:18 +0000 (UTC)
Received: from localhost (ovpn-12-51.pek2.redhat.com [10.72.12.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9AE8C27EA6;
        Wed, 13 Apr 2022 02:41:17 +0000 (UTC)
Date:   Wed, 13 Apr 2022 10:41:14 +0800
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
Message-ID: <YlY4SlF07iH08Qnj@MiWiFi-R3L-srv>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
 <20220401183040.1624-5-eric.devolder@oracle.com>
 <YlPy8CKU4zHsx6Bc@MiWiFi-R3L-srv>
 <821b3c62-eedf-c1a3-4aba-671c90d83288@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <821b3c62-eedf-c1a3-4aba-671c90d83288@oracle.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/22 at 08:54am, Eric DeVolder wrote:
> 
> 
> On 4/11/22 04:20, Baoquan He wrote:
> > Hi Eric,
> > 
> > On 04/01/22 at 02:30pm, Eric DeVolder wrote:
> > ... ...
> > 
> > > +static void crash_hotplug_handler(unsigned int hp_action,
> > > +	unsigned long a, unsigned long b)
> > 
> > I am still struggling to consider if these unused parameters should be
> > kept or removed. Do you foresee or feel on which ARCH they could be used?
> > 
> > Considering our elfcorehdr updating method, once memory or cpu changed,
> > we will update elfcorehdr and cpu notes to reflect all existing memory
> > regions and cpu in the current system. We could end up with having them
> > but never being used. Then we may finally need to clean them up.
> > 
> > If you have investigated and foresee or feel they could be used on a
> > certain architecture, we can keep them for the time being.
> 
> So 'hp_action' and 'a' are used within the existing patch series.
> In crash_core.c, there is this bit of code:
> 
> +       kexec_crash_image->offlinecpu =
> +           (hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
> +               (unsigned int)a : ~0U;
> 
> which is referencing both 'hp_action' and using 'a' from the cpu notifier handler.
> I looked into removing 'a' and setting offlinecpu directly, but I thought
> it better that offlinecpu be set within the safety of the kexec_mutex.
> Also, Sourabh Jain's work with PowerPC utilizing this framework directly
> references hp_action in the arch-specific handler.
> 
> The cpu and memory notifier handlers set hp_action accordingly. For cpu handler,
> the 'a' is set with the impacted cpu. For memory handler, 'a' and 'b' form the
> impacted memory range. I agree it looks like the memory range is currently
> not useful.

OK, memory handler doesn't need the action, memory regions. While cpu
handler needs it to exclude the hot plugged cpu.

We could have two ways to acheive this as below. How do you think about
them?

static void crash_hotplug_handler(unsigned int hp_action,
        unsigned long cpu)

static int crash_memhp_notifier(struct notifier_block *nb,
        unsigned long val, void *v)
{
......
        switch (val) {
        case MEM_ONLINE:
                crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
                        -1UL);
                break;

        case MEM_OFFLINE:
                crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
                        -1UL);
                break;
        }
        return NOTIFY_OK;
}

static int crash_cpuhp_online(unsigned int cpu)
{
        crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu);
        return 0;
}

static int crash_cpuhp_offline(unsigned int cpu)
{
        crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
        return 0;
}

OR,

static void crash_hotplug_handler(unsigned int hp_action,
        int* cpu)

static int crash_cpuhp_online(unsigned int cpu)
{
        crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, NULL);
        return 0;
}

static int crash_cpuhp_offline(unsigned int cpu)
{
	int dead_cpu = cpu;
        crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, &cpu);
        return 0;
}

