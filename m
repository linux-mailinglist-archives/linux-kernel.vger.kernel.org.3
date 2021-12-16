Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6031947741C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhLPOMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:12:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237840AbhLPOLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639663907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LxEr9tmEVeheVToZs03bhOi9wHYOSCcfdTm3BiAij44=;
        b=g8bDzkETwzcFsSDIICowhVpJLTS/7lMB/aGlpouDAcs8Inc3cr6R5FjH/UNxf4Cdoxd6w4
        6q09EJPz/brVOM7S1erw9kbHspIV7ysasKUVzGAjI+DCG/igTqScn4xxbVkCs31qG0QjPO
        0JRHleyPShMncLbjntfsS1aOEq0inJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-yizGPNbOObC_bgzvhqZZTQ-1; Thu, 16 Dec 2021 09:11:44 -0500
X-MC-Unique: yizGPNbOObC_bgzvhqZZTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A699C8015CD;
        Thu, 16 Dec 2021 14:11:40 +0000 (UTC)
Received: from localhost (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDA7C5ED3B;
        Thu, 16 Dec 2021 14:11:18 +0000 (UTC)
Date:   Thu, 16 Dec 2021 22:11:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
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
Subject: Re: [PATCH v17 03/10] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel()
Message-ID: <20211216141115.GA18773@MiWiFi-R3L-srv>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com>
 <YbntdtQo2jfbO4cO@zn.tnic>
 <20211216011040.GG3023@MiWiFi-R3L-srv>
 <YbsbO1XnrzLAIBEu@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbsbO1XnrzLAIBEu@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 at 11:55am, Borislav Petkov wrote:
> On Thu, Dec 16, 2021 at 09:10:40AM +0800, Baoquan He wrote:
> > reserve_crashkernel_low() always return 0 on x86_32, so the not equivalent
> > transformation for x86_32 doesn't matter, I think.
> 
> That is, of course, very obvious... not!
> 
> Why is that function parsing crashkernel=XM, and crashkernel=X,high,
> then it attempts some low memory reservation too? Why isn't
> crashkernel=Y,low parsed there too?
> 
> I guess this alludes to why:
> 
>         crashkernel=size[KMG],low
>                         [KNL, X86-64] range under 4G. When crashkernel=X,high
>                         is passed, kernel could allocate physical memory region
>                         above 4G, that cause second kernel crash on system
>                         that require some amount of low memory, e.g. swiotlb
>                         requires at least 64M+32K low memory, also enough extra
>                         low memory is needed to make sure DMA buffers for 32-bit
>                         devices won't run out.
> 
> So, before this is going anywhere, I'd like to see this function
> documented properly. I see Documentation/admin-guide/kdump/kdump.rst
> explains the crashkernel= options too so you can refer to it in the
> comments so that when someone looks at that code, someone can follow why
> it is doing what it is doing.
> 
> Then, as a future work, all that parsing of crashkernel= cmdline options
> should be concentrated at the beginning and once it is clear what the
> user requests, the reservations should be done.

Totally agree we should refactor code to make reserve_crashkernel()
clearer on logic and readibility. In this patchset, we can rewrite the
kernel-doc of reserve_crashkernel() to add more words to explain. As for
the code refactoring, it can be done in another patchset.

> 
> As it is, reserve_crashkernel() is pretty unwieldy and hard to read.

