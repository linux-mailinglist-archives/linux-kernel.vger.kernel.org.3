Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBB755D7E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbiF0Kf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiF0Kfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BE9063CE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656326151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xKvZnCkoXt+4PjaORqXBx6ym+v+SmPmR3DG/cTeVOIc=;
        b=TyCWNKVAb/jGQKWqnpdEbxcUdezIaNlFe8FKKlNxzFatZryfVVNiLb25mfAp0qtdwTo21X
        nxNd59oG2pOlJkjWHU0Gnrbq3Cq6XwwL6WwtytXT9mHk0a/qNqkthXxywzSFit+nZk1PKf
        P02Cg8AnRl93tPOi3XiBAfsYlBABIeA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-MRuSKrRuP0GnZrfy_gPN4Q-1; Mon, 27 Jun 2022 06:35:48 -0400
X-MC-Unique: MRuSKrRuP0GnZrfy_gPN4Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE66F101A586;
        Mon, 27 Jun 2022 10:35:47 +0000 (UTC)
Received: from localhost (ovpn-13-65.pek2.redhat.com [10.72.13.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CA9E492CA3;
        Mon, 27 Jun 2022 10:35:46 +0000 (UTC)
Date:   Mon, 27 Jun 2022 18:35:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Tao Liu <ltao@redhat.com>
Cc:     vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2] kdump: round up the total memory size to 128M for
 crashkernel reservation
Message-ID: <YrmH/728erRohHeU@MiWiFi-R3L-srv>
References: <20220627074440.187222-1-ltao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627074440.187222-1-ltao@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/22 at 03:44pm, Tao Liu wrote:
> The total memory size we get in kernel is usually slightly less than
> the actual memory size because BIOS/firmware will reserve some memory
> region. So it won't export all memory as usable.
> 
> E.g, on my x86_64 kvm guest with 1G memory, the total_mem value shows:
> UEFI boot with ovmf:   0x3faef000
> Legacy boot kvm guest: 0x3ff7ec00
> 
> When specifying crashkernel=1G-2G:128M, if we have a 1G memory machine,
> we get total size 1023M from firmware. Then it will not fall into
> 1G-2G, thus no memory reserved. User will never know this, it is hard
> to let user know the exact total value in kernel.
> 
> One way is to use dmi/smbios to get physical memory size, but it's not
> reliable as well. According to Prarit hardware vendors sometimes screw
> this up. Thus round up total size to 128M to work around this problem.
> 
> This patch is a resend of [1] and rebased onto v5.19-rc2, and the
> original credit goes to Dave Young <dyoung@redhat.com>.

This should be put into cover letter, or put together with change log.
Other than this, LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> [1]: http://lists.infradead.org/pipermail/kexec/2018-April/020568.html
> 
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
> v1 -> v2:
> Modified commit log based on Baoquan's advice.
> ---
>  kernel/crash_core.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 71122e01623c..b58b27cbdb61 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -9,6 +9,7 @@
>  #include <linux/init.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
> +#include <linux/sizes.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -43,6 +44,15 @@ static int __init parse_crashkernel_mem(char *cmdline,
>  					unsigned long long *crash_base)
>  {
>  	char *cur = cmdline, *tmp;
> +	unsigned long long total_mem = system_ram;
> +
> +	/*
> +	 * Firmware sometimes reserves some memory regions for its own use,
> +	 * so the system memory size is less than the actual physical memory
> +	 * size. Work around this by rounding up the total size to 128M,
> +	 * which is enough for most test cases.
> +	 */
> +	total_mem = roundup(total_mem, SZ_128M);
>  
>  	/* for each entry of the comma-separated list */
>  	do {
> @@ -87,13 +97,13 @@ static int __init parse_crashkernel_mem(char *cmdline,
>  			return -EINVAL;
>  		}
>  		cur = tmp;
> -		if (size >= system_ram) {
> +		if (size >= total_mem) {
>  			pr_warn("crashkernel: invalid size\n");
>  			return -EINVAL;
>  		}
>  
>  		/* match ? */
> -		if (system_ram >= start && system_ram < end) {
> +		if (total_mem >= start && total_mem < end) {
>  			*crash_size = size;
>  			break;
>  		}
> -- 
> 2.33.1
> 

