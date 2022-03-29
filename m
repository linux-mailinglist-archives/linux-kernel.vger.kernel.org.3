Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128284EA473
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiC2BM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiC2BM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:12:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEB312C663
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648516243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tppbPpxvZiSCvj+jhHhyRRhzMtav7zPASHDnKGwGNto=;
        b=ioqQeCQfK6ldKQ7RGNOV1zwfHISk7ThX2HIcGVUgp0Z3FSLBYN8Am7MbHc+3Xyr/yw1r2o
        a5BuqfWchGnmycp/vggIxIRHuJVVyOozzjDPfKmtGbuv7wpF5o9GESoAQyVhqSAgkCp16j
        Vzt8XcMBIy50UQ3i/TayPOsxxp9IBkY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-Pha1Pc8NP_C53JRilIqnTw-1; Mon, 28 Mar 2022 21:10:40 -0400
X-MC-Unique: Pha1Pc8NP_C53JRilIqnTw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FDB4811E75;
        Tue, 29 Mar 2022 01:10:39 +0000 (UTC)
Received: from localhost (ovpn-13-83.pek2.redhat.com [10.72.13.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0C881402642;
        Tue, 29 Mar 2022 01:10:37 +0000 (UTC)
Date:   Tue, 29 Mar 2022 09:10:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v5 4/8] crash: generic crash hotplug support
 infrastructure
Message-ID: <YkJciuCXKuU4a4gp@MiWiFi-R3L-srv>
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-5-eric.devolder@oracle.com>
 <20220324133856.GC354864@MiWiFi-R3L-srv>
 <20220324134911.GA354791@MiWiFi-R3L-srv>
 <d12cd750-4f7e-46e8-8f31-66e29edbede9@oracle.com>
 <20220324143300.GD354864@MiWiFi-R3L-srv>
 <8b68f5b6-f6e0-ca61-56cf-69046edce58d@oracle.com>
 <6f59af6a-8a70-85ce-b36c-38eb31503c7d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f59af6a-8a70-85ce-b36c-38eb31503c7d@oracle.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28/22 at 11:08am, Eric DeVolder wrote:
> Baoquan, a comment below.
> eric
> 
> On 3/24/22 09:37, Eric DeVolder wrote:
> > 
> > 
> > On 3/24/22 09:33, Baoquan He wrote:
> > > On 03/24/22 at 08:53am, Eric DeVolder wrote:
> > > > Baoquan,
> > > > Thanks, I've offered a minor correction below.
> > > > eric
> > > > 
> > > > On 3/24/22 08:49, Baoquan He wrote:
> > > > > On 03/24/22 at 09:38pm, Baoquan He wrote:
> > > > > > On 03/03/22 at 11:27am, Eric DeVolder wrote:
> > > > > > > This patch introduces a generic crash hot plug/unplug infrastructure
> > > > > > > for CPU and memory changes. Upon CPU and memory changes, a generic
> > > > > > > crash_hotplug_handler() obtains the appropriate lock, does some
> > > > > > > important house keeping and then dispatches the hot plug/unplug event
> > > > > > > to the architecture specific arch_crash_hotplug_handler(), and when
> > > > > > > that handler returns, the lock is released.
> > > > > > > 
> > > > > > > This patch modifies crash_core.c to implement a subsys_initcall()
> > > > > > > function that installs handlers for hot plug/unplug events. If CPU
> > > > > > > hotplug is enabled, then cpuhp_setup_state() is invoked to register a
> > > > > > > handler for CPU changes. Similarly, if memory hotplug is enabled, then
> > > > > > > register_memory_notifier() is invoked to install a handler for memory
> > > > > > > changes. These handlers in turn invoke the common generic handler
> > > > > > > crash_hotplug_handler().
> > > > > > > 
> > > > > > > On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
> > > > > > > CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
> > > > > > > the CPU still shows up in foreach_present_cpu() during the regeneration
> > > > > > > of the new CPU list, thus the need to explicitly check and exclude the
> > > > > > > soon-to-be offlined CPU in crash_prepare_elf64_headers().
> > > > > > > 
> > > > > > > On the memory side, each un/plugged memory block passes through the
> > > > > > > handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
> > > > > > > memory events, one for each 128MiB memblock.
> > > > > > 
> > > > > > I rewrite the log as below with my understanding. Hope it's simpler to
> > > > > > help people get what's going on here. Please consider to take if it's
> > > > > > OK to you or adjust based on this. The code looks good to me.
> > > > > > 
> > > > > Made some tuning:
> > > > > 
> > > > > crash: add generic infrastructure for crash hotplug support
> > > > > 
> > > > > Upon CPU and memory changes, a generic crash_hotplug_handler() is added
> > > > > to dispatch the hot plug/unplug event to the architecture specific
> > > > > arch_crash_hotplug_handler(). During the process, kexec_mutex need be
> > > > > held.
> > > > > 
> > > > > To support cpu hotplug, one callback pair are registered to capture
> > > > > KEXEC_CRASH_HP_ADD_CPU and KEXEC_CRASH_HP_REMOVE_CPU events via
> > > > > cpuhp_setup_state_nocalls().
> > > > s/KEXEC_CRASH_HP_ADD}REMOVE_CPU/CPUHP_AP_ONLINE_DYN/ as the KEXEC_CRASH are the
> > > > names I've introduced with this patch?
> > > 
> > > Right.
> > > 
> > > While checking it, I notice hp_action which you don't use actually.
> > > Can you reconsider that part of design, the hp_action, the a, b
> > > parameter passed to handler?
> > 
> > Sure I can remove. I initially put in there as this was generic
> > infrastructure and not sure if it would benefit others.
> > eric
> > 
> 
> Actually, I will keep the hp_action as the work by Sourabh Jain for PPC uses
> the hp_action. I'll drop the a and b.

Sounds great.

> 
> Also, shall I post v6, or are you still looking at patches 7 and 8?

Will check today, thanks for the effort.

