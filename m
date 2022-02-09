Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4305C4AE7D5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345124AbiBIDRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346424AbiBIDQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:16:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CA5FC0613CC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644376618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4KguVXJBsbOFpLwfjfe5WokTE0k6qOeZu3h5xh8SaKs=;
        b=bnv8IALQ8X+/6aXf97S4/lpZuhqF9a5fxBYUL84mAoE2aNMP2bOBoKcppuwrfPgi5eo01G
        szIEqFNfso0q1TosHLF0gd/EW5Lr6Gmmh3ojLlnGCLA7M+bfZaIUh5qa1is8wBmG4FGJq2
        fg48LRrIXS6oS2nCiISbgalMHYHw7Eo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-mfr6iKPnOOirDDrfV4yHKA-1; Tue, 08 Feb 2022 22:16:55 -0500
X-MC-Unique: mfr6iKPnOOirDDrfV4yHKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 882401091DA1;
        Wed,  9 Feb 2022 03:16:53 +0000 (UTC)
Received: from localhost (ovpn-12-114.pek2.redhat.com [10.72.12.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C176610A6;
        Wed,  9 Feb 2022 03:16:51 +0000 (UTC)
Date:   Wed, 9 Feb 2022 11:16:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Huang Shijie <shijie@os.amperecomputing.com>,
        Kazuhito Hagio <k-hagio-ab@nec.com>,
        Lianbo Jiang <lijiang@redhat.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, zwang@amperecomputing.com,
        patches@amperecomputing.com, darren@os.amperecomputing.com
Subject: Re: [PATCH] arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP
 ranges
Message-ID: <YgMyIOZ+USwLKCQI@MiWiFi-R3L-srv>
References: <20220209092642.9181-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209092642.9181-1-shijie@os.amperecomputing.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/22 at 09:26am, Huang Shijie wrote:
> The following interrelated ranges are needed by the kdump crash tool:
> 	MODULES_VADDR ~ MODULES_END,
> 	VMALLOC_START ~ VMALLOC_END,
> 	VMEMMAP_START ~ VMEMMAP_END
> 
> Since these values change from time to time, it is preferable to export
> them via vmcoreinfo than to change the crash's code frequently.

Add Kazu and Lianbo to CC since they take care of Crash utility now,
please check if this is necessary for Crash.

> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  Documentation/admin-guide/kdump/vmcoreinfo.rst | 8 ++++++++
>  arch/arm64/kernel/crash_core.c                 | 6 ++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 3861a25faae1..a339af45a22e 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -494,6 +494,14 @@ architecture which is used to lookup the page-tables for the Virtual
>  addresses in the higher VA range (refer to ARMv8 ARM document for
>  more details).
>  
> +MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END
> +-------------
> +
> +Used to get the correct ranges:
> +	MODULES_VADDR ~ MODULES_END-1 : Kernel module space.
> +	VMALLOC_START ~ VMALLOC_END-1 : vmalloc() / ioremap() space.
> +	VMEMMAP_START ~ VMEMMAP_END-1 : vmemmap region, used for struct page array.
> +
>  arm
>  ===
>  
> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> index 314391a156ee..2b65aae332ce 100644
> --- a/arch/arm64/kernel/crash_core.c
> +++ b/arch/arm64/kernel/crash_core.c
> @@ -20,6 +20,12 @@ void arch_crash_save_vmcoreinfo(void)
>  {
>  	VMCOREINFO_NUMBER(VA_BITS);
>  	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
> +	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
> +	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
> +	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
> +	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
> +	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
> +	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
>  	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
>  						kimage_voffset);
>  	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
> -- 
> 2.30.2
> 

