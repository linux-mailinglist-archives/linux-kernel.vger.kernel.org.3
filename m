Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461BC472D86
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbhLMNht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:37:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237716AbhLMNhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639402668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g+u/c+H/rcBrTEgKIs3qQRnTecevHVmV6fnVkgG1Vpo=;
        b=UBQYcRcu+754kkHohpoLBLdQLTF1opbTP6oocfGLwuizME+6uSA23ry+UUprw363EpTCCK
        Z5NdYR99ijkRd2PBGe8gRx5PW9HoMClvD0MFRxUIQUGkJFChBKRRJsH1SZHqaMM8yf8X9h
        8OtmB+6Yce8qGH4pL+5NIt6PX6Mr/Cw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-jX6aXRXDMYqcbyOxnQElnw-1; Mon, 13 Dec 2021 08:37:42 -0500
X-MC-Unique: jX6aXRXDMYqcbyOxnQElnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDC02802C99;
        Mon, 13 Dec 2021 13:37:38 +0000 (UTC)
Received: from localhost (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 903F4ADCD;
        Mon, 13 Dec 2021 13:37:37 +0000 (UTC)
Date:   Mon, 13 Dec 2021 21:37:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
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
Subject: Re: [PATCH v17 02/10] x86: kdump: make the lower bound of crash
 kernel reservation consistent
Message-ID: <20211213133735.GB23510@MiWiFi-R3L-srv>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210065533.2023-3-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 at 02:55pm, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> The lower bounds of crash kernel reservation and crash kernel low
> reservation are different, use the consistent value CRASH_ALIGN.
> 
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

You may need add Co-developed-by to clarify who is author, and who is
co-author. Please check section "When to use Acked-by:, Cc:, and Co-developed-by:"
of Documentation/process/submitting-patches.rst. Otherwise, 

Acked-by: Baoquan He <bhe@redhat.com>

> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>  arch/x86/kernel/setup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 5cc60996eac56d6..6424ee4f23da2cf 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -441,7 +441,8 @@ static int __init reserve_crashkernel_low(void)
>  			return 0;
>  	}
>  
> -	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, CRASH_ALIGN,
> +			CRASH_ADDR_LOW_MAX);
>  	if (!low_base) {
>  		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
>  		       (unsigned long)(low_size >> 20));
> -- 
> 2.25.1
> 

