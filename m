Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE33476744
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 02:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhLPBKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:10:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhLPBKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639617051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7PsHP3o6bLXjBaAh5ST1mpelrJUr8X2zDVlQphXzPvw=;
        b=AkH1W0lxyBU07Xss4qiDH0/1nerlf/Ma7moeWvPKhusEvPCqqKi4csghu2VN9oap06SqwD
        jkMWRQI7cblhPSpJ6/encWz9j4ZUlkoSDjT6K/3ygh+LetVoYUAJ5LVGJaMIFn/7geSRP6
        PG+SRnfsetyOI8mp711JyLU9ABKv7t8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-vpEjysboPVCVLvL-enb8MQ-1; Wed, 15 Dec 2021 20:10:48 -0500
X-MC-Unique: vpEjysboPVCVLvL-enb8MQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE8CC1023F4F;
        Thu, 16 Dec 2021 01:10:44 +0000 (UTC)
Received: from localhost (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 34C0C27CC2;
        Thu, 16 Dec 2021 01:10:43 +0000 (UTC)
Date:   Thu, 16 Dec 2021 09:10:40 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20211216011040.GG3023@MiWiFi-R3L-srv>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com>
 <YbntdtQo2jfbO4cO@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbntdtQo2jfbO4cO@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/21 at 02:28pm, Borislav Petkov wrote:
> On Fri, Dec 10, 2021 at 02:55:26PM +0800, Zhen Lei wrote:
> > @@ -518,7 +519,7 @@ static void __init reserve_crashkernel(void)
> >  		}
> >  	}
> >  
> > -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
> > +	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
> >  		memblock_phys_free(crash_base, crash_size);
> >  		return;
> >  	}
> 
> That's not a equivalent transformation on X86_32.

reserve_crashkernel_low() always return 0 on x86_32, so the not equivalent
transformation for x86_32 doesn't matter, I think.

