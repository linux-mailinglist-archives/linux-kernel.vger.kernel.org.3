Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF7655492B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbiFVIRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244217AbiFVIRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2819938185
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655885821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5I/iErIMtMGpE55q/wJaJnkGwpxHk2Uqy8J578HM5OU=;
        b=TUXGs9etLS4iyoo7mNW3Dk4dapSD43qGDu8BEqnLU5OACiQeo+BI8tS23bIWAy3FnNf2hj
        ZW1YaxiBKepPYXHhSDStCXYDQKsMNggXjMaislg6mb4aCGLjH6Sdx4CzZ1cBGI2Xn0TKgt
        MwiieC9x89De+zN3vQ/CsrzjVICcelY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-J6o4FJi3MQm-otSuf83Gig-1; Wed, 22 Jun 2022 04:16:59 -0400
X-MC-Unique: J6o4FJi3MQm-otSuf83Gig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50F9B8001EA;
        Wed, 22 Jun 2022 08:16:59 +0000 (UTC)
Received: from localhost (ovpn-13-227.pek2.redhat.com [10.72.13.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CF2440C141F;
        Wed, 22 Jun 2022 08:16:57 +0000 (UTC)
Date:   Wed, 22 Jun 2022 16:16:54 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Tao Liu <ltao@redhat.com>
Cc:     vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kdump: round up the total memory size to 128M for
 crashkernel reservation
Message-ID: <YrLP9i4YtJz71ecx@MiWiFi-R3L-srv>
References: <20220616024803.5091-1-ltao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616024803.5091-1-ltao@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

On 06/16/22 at 10:48am, Tao Liu wrote:
> The total memory size we get in kernel is usually slightly less than 2G
> with a 2G memory module machine. The main reason is bios/firmware
> reserve some area it will not export all memory as usable to Linux.
> 
> 2G memory X86 kvm guest test result of the total_mem value:
> UEFI boot with ovmf: 0x7ef10000
> Legacy boot kvm guest: 0x7ff7cc00
> This is also a problem on arm64 UEFI booted system according to my test.
> 
> Thus for example crashkernel=1G-2G:128M, if we have a 1G memory
> machine, we get total size 1023M from firmware then it will not fall
> into 1G-2G thus no memory reserved.  User will never know that, it is
> hard to let user to know the exact total value we get in kernel

The code change looks good to me, while the patch log need be improved.
I rewrite it at below. However, here, the crashkernel=1G-2G:128M exmaple,
above it there has been a 2G memory kvm guest example, then we get here
to give an crashkernel=1G-2G:128M case. The logic looks not so smooth.

Could you rethink about this, e.g using the crashkernel=2G-3G:192M, or
trying on kvm guest with 1G meory and getting its total_mem value? I
mean unifying the examples based on your testing.

And also see inline comment about the code comment part.

......

Rewritten log:
===
The total memory size we get in kernel is usually slightly less than
the actual memory size because BIOS/firmware will reserve some meory
region. So it won't export all memory as usable.

E.g, on my kvm guest with 2G meory, the total_mem value shows:
UEFI boot with ovmf: 0x7ef10000
Legacy boot kvm guest: 0x7ff7cc00

When specifying crashkernel=1G-2G:128M, if we have a 1G memory
machine, we get total size 1023M from firmware. Then it will not fall
into 1G-2G, thus no memory reserved.  User will never know this, it is
hard to let user know the exact total value in kernel

One way is to use dmi/smbios to get physical memory size, but it's not
reliable as well. According to Prarit hardware vendors sometimes screw
this up. Thus round up total size to 128M to work around this problem.

This patch is a resend of [1] and rebased onto v5.19-rc2, and the
original credit goes to Dave Young <dyoung@redhat.com>.
===
>

> 
> [1]: http://lists.infradead.org/pipermail/kexec/2018-April/020568.html
> 
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
>  kernel/crash_core.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 71122e01623c..f6c1ffce9d5a 100644
> --- a/kernel/crash_core.c
>

> 
> [1]: http://lists.infradead.org/pipermail/kexec/2018-April/020568.html
> 
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
>  kernel/crash_core.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 71122e01623c..f6c1ffce9d5a 100644
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
> +	 * Firmware sometimes reserves some memory regions for it's own use.
                                                               ~~~ its, typo
> +	 * so we get less than actual system memory size.
           so the system memory size is less than the actual physical memory size.

> +	 * Workaround this by round up the total size to 128M which is
           s/Work around/Workaround/, workaround is an noun. s/round up/rounding up/
> +	 * enough for most test cases.
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

