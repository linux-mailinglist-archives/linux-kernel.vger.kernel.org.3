Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFC44615B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhK2NGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:06:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232282AbhK2NEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638190867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1Stf5Vws0n2EejeKlEUNVuIDUq0vyjO3qRdJV6eojQ=;
        b=Dv07UTXZ6/bxv23Gcm0vfSE3FoK8/3oH9U6X5D+LIOKbOFu9COtnXYjp8YqDqnxlZyNEWZ
        tKJdxX9bct37On8S/z6PxqYnwYxxl06wH0+DjBriVgpuaGAtOBuZ2S3EAJ/QdEIAo7lRdn
        o4lPF3QXcqjdGlH+NNUNU6dv2XdYXFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-TKVpxDgSO3yVSpiVcRtqBQ-1; Mon, 29 Nov 2021 08:01:04 -0500
X-MC-Unique: TKVpxDgSO3yVSpiVcRtqBQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D67F1006AA2;
        Mon, 29 Nov 2021 13:01:02 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56EC95C22B;
        Mon, 29 Nov 2021 13:01:01 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 1E87241752B6; Mon, 29 Nov 2021 09:47:05 -0300 (-03)
Date:   Mon, 29 Nov 2021 09:47:05 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        mingo@redhat.com, nilal@redhat.com
Subject: Re: [RFC PATCH 2/2] KVM: arm64: export cntvoff in debugfs
Message-ID: <20211129124705.GB131894@fuller.cnet>
References: <20211119102117.22304-1-nsaenzju@redhat.com>
 <20211119102117.22304-3-nsaenzju@redhat.com>
 <87fsrs732b.wl-maz@kernel.org>
 <0e948a211bd8d63ba05594fb8c03bf3a77a227a0.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e948a211bd8d63ba05594fb8c03bf3a77a227a0.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 09:40:52PM +0100, Nicolas Saenz Julienne wrote:
> Hi Marc, thanks for the review.
> 
> On Fri, 2021-11-19 at 12:17 +0000, Marc Zyngier wrote:
> > On Fri, 19 Nov 2021 10:21:18 +0000,
> > Nicolas Saenz Julienne <nsaenzju@redhat.com> wrote:
> > > 
> > > While using cntvct as the raw clock for tracing, it's possible to
> > > synchronize host/guest traces just by knowing the virtual offset applied
> > > to the guest's virtual counter.
> > > 
> > > This is also the case on x86 when TSC is available. The offset is
> > > exposed in debugfs as 'tsc-offset' on a per vcpu basis. So let's
> > > implement the same for arm64.
> > 
> > How does this work with NV, where the guest hypervisor is in control
> > of the virtual offset? 
> 
> TBH I handn't thought about NV. Looking at it from that angle, I now see my
> approach doesn't work on hosts that use CNTVCT (regardless of NV). Upon
> entering into a guest, we change CNTVOFF before the host is done with tracing,
> so traces like 'kvm_entry' will have weird timestamps. I was just lucky that
> the hosts I was testing with use CNTPCT.
> 
> I believe the solution would be to be able to force a 0 offset between
> guest/host. With that in mind, is there a reason why kvm_timer_vcpu_init()
> imposes a non-zero one by default? I checked out the commits that introduced
> that code, but couldn't find a compelling reason. VMMs can always change it
> through KVM_REG_ARM_TIMER_CNT afterwards.

One reason is that you leak information from host to guest (the hosts
TSC value).

Another reason would be that you introduce a configuration which is 
different from the what the hardware has, which can in theory trigger
guest bugs.

> > I also wonder why we need this when userspace already has direct access to
> > that information without any extra kernel support (read the CNTVCT view of
> > the vcpu using the ONEREG API, subtract it from the host view of the counter,
> > job done).
> 
> Well IIUC, you're at the mercy of how long it takes to return from the ONEREG
> ioctl. The results will be skewed. For some workloads, where low latency is
> key, we really need high precision traces in the order of single digit us or
> even 100s of ns. I'm not sure you'll be able to get there with that approach.

If the guest can read the host to guest HW clock offset already, it
could directly do the conversion.

> [...]
> 
> > > diff --git a/arch/arm64/kvm/debugfs.c b/arch/arm64/kvm/debugfs.c
> > > new file mode 100644
> > > index 000000000000..f0f5083ea8d4
> > > --- /dev/null
> > > +++ b/arch/arm64/kvm/debugfs.c
> > > @@ -0,0 +1,25 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2021 Red Hat Inc.
> > > + */
> > > +
> > > +#include <linux/kvm_host.h>
> > > +#include <linux/debugfs.h>
> > > +
> > > +#include <kvm/arm_arch_timer.h>
> > > +
> > > +static int vcpu_get_cntv_offset(void *data, u64 *val)
> > > +{
> > > +	struct kvm_vcpu *vcpu = (struct kvm_vcpu *)data;
> > > +
> > > +	*val = timer_get_offset(vcpu_vtimer(vcpu));
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +DEFINE_SIMPLE_ATTRIBUTE(vcpu_cntvoff_fops, vcpu_get_cntv_offset, NULL, "%lld\n");
> > > +
> > > +void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry)
> > > +{
> > > +	debugfs_create_file("cntvoff", 0444, debugfs_dentry, vcpu, &vcpu_cntvoff_fops);
> > > +}
> > 
> > This should be left in arch_timer.c until we actually need it for
> > multiple subsystems. When (and if) that happens, we will expose
> > per-subsystem debugfs initialisers instead of exposing the guts of the
> > timer code.
> 
> Noted.
> 
> -- 
> Nicolás Sáenz
> 
> 

