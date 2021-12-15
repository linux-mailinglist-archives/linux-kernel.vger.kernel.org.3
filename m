Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AD0475510
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbhLOJWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:22:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241122AbhLOJWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639560173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oUh0bcGmELD1OnjdrFkEycYt4atPMShERUPuuPbvtk8=;
        b=DWBaz4awggwr+4ul5XI90u/Fr6J8Tdxh/DW43ByxXBUCekT7RLWSVUX/UMWYYZosl7tuyc
        o4wueNxcGcpbGo3twBrA0F/rAHJbvGDZ9cWHCBF3Vi68eSKJ1tlq2qNj/zGox9AodcwUXB
        Lz2yciPMx+Sbn9mfrH8O/s0AIPP8UXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-j4UYqMpBM5a1H3pa9AG24w-1; Wed, 15 Dec 2021 04:22:49 -0500
X-MC-Unique: j4UYqMpBM5a1H3pa9AG24w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABC2F190B2A3;
        Wed, 15 Dec 2021 09:22:46 +0000 (UTC)
Received: from localhost (ovpn-12-120.pek2.redhat.com [10.72.12.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19135838E1;
        Wed, 15 Dec 2021 09:22:32 +0000 (UTC)
Date:   Wed, 15 Dec 2021 17:22:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
Subject: Re: [PATCH v17 04/10] x86: kdump: move xen_pv_domain() check and
 insert_resource() to setup_arch()
Message-ID: <20211215092230.GE3023@MiWiFi-R3L-srv>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-5-thunder.leizhen@huawei.com>
 <d328aede-1282-b4d5-f17a-aa9c3e9f6563@huawei.com>
 <03bd43f3-14a1-dbd1-9fff-118c0885653c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03bd43f3-14a1-dbd1-9fff-118c0885653c@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/21 at 04:56pm, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/12/14 19:40, Leizhen (ThunderTown) wrote:
> > 
> > 
> > On 2021/12/10 14:55, Zhen Lei wrote:
> >> From: Chen Zhou <chenzhou10@huawei.com>
> >>
> >> We will make the functions reserve_crashkernel() as generic, the
> >> xen_pv_domain() check in reserve_crashkernel() is relevant only to
> >> x86, the same as insert_resource() in reserve_crashkernel[_low]().
> >> So move xen_pv_domain() check and insert_resource() to setup_arch()
> >> to keep them in x86.
> >>
> >> Suggested-by: Mike Rapoport <rppt@kernel.org>
> >> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> >> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> >> Acked-by: Baoquan He <bhe@redhat.com>
> >> ---
> >>  arch/x86/kernel/setup.c | 19 +++++++++++--------
> >>  1 file changed, 11 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> >> index bb2a0973b98059e..7ae00716a208f82 100644
> >> --- a/arch/x86/kernel/setup.c
> >> +++ b/arch/x86/kernel/setup.c
> >> @@ -456,7 +456,6 @@ static int __init reserve_crashkernel_low(void)
> >>  
> >>  	crashk_low_res.start = low_base;
> >>  	crashk_low_res.end   = low_base + low_size - 1;
> >> -	insert_resource(&iomem_resource, &crashk_low_res);
> >>  #endif
> >>  	return 0;
> >>  }
> >> @@ -480,11 +479,6 @@ static void __init reserve_crashkernel(void)
> >>  		high = true;
> >>  	}
> >>  
> >> -	if (xen_pv_domain()) {
> >> -		pr_info("Ignoring crashkernel for a Xen PV domain\n");
> >> -		return;
> >> -	}
> >> -
> >>  	/* 0 means: find the address automatically */
> >>  	if (!crash_base) {
> >>  		/*
> >> @@ -531,7 +525,6 @@ static void __init reserve_crashkernel(void)
> >>  
> >>  	crashk_res.start = crash_base;
> >>  	crashk_res.end   = crash_base + crash_size - 1;
> >> -	insert_resource(&iomem_resource, &crashk_res);
> >>  }
> >>  #else
> >>  static void __init reserve_crashkernel(void)
> >> @@ -1143,7 +1136,17 @@ void __init setup_arch(char **cmdline_p)
> >>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
> >>  	 * won't consume hotpluggable memory.
> >>  	 */
> >> -	reserve_crashkernel();
> > 
> > Hi Baoquan:
> >   How about move "#ifdef CONFIG_KEXEC_CORE" here, so that we can remove the
> > empty reserve_crashkernel(). In fact, xen_pv_domain() is invoked only
> > when CONFIG_KEXEC_CORE is enabled before.
> 
> Hi Baoquan:
>   Did you miss this email? If no reply, I will keep it no change.

I checked this patch, and it's no update since I acked it. 

Moving reserve_crashkernel() into the CONFIG_KEXEC_CORE ifdeffery is
also fine to me.

