Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40DD50D7E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbiDYDxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiDYDxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73F502F021
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 20:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650858600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6+BjK5j3p07NV8YTOKQRJe/TLrsI/cMPaYzFnvSMXsY=;
        b=aTq2xpoiL1fV+LGJAJxSgdALkp2FfcztOy2w2EcQ9xvJUhgi+c4VgdWSAfu/gXoctmIwSu
        M3CyevPvVtFASmBTCNbg9KpsLIfRp9GIIqI1CL/lbUh3vegAk1Q7WnKOUKqMWbPzbaLumx
        1mXg5SjAYWJ2ectCh+XfinKEhK9o3Q4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-66BGPX6ZN3KzlUNj4q2GrQ-1; Sun, 24 Apr 2022 23:49:54 -0400
X-MC-Unique: 66BGPX6ZN3KzlUNj4q2GrQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C3E13810D40;
        Mon, 25 Apr 2022 03:49:53 +0000 (UTC)
Received: from localhost (ovpn-12-73.pek2.redhat.com [10.72.12.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C317755105D;
        Mon, 25 Apr 2022 03:49:51 +0000 (UTC)
Date:   Mon, 25 Apr 2022 11:49:48 +0800
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
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v22 1/9] kdump: return -ENOENT if required cmdline option
 does not exist
Message-ID: <YmYaXDrEYOXLzT5H@MiWiFi-R3L-srv>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414115720.1887-2-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/22 at 07:57pm, Zhen Lei wrote:
> According to the current crashkernel=Y,low support in other ARCHes, it's
> an optional command-line option. When it doesn't exist, kernel will try
> to allocate minimum required memory below 4G automatically.
> 
> However, __parse_crashkernel() returns '-EINVAL' for all error cases. It
> can't distinguish the nonexistent option from invalid option.
> 
> Change __parse_crashkernel() to return '-ENOENT' for the nonexistent option
> case. With this change, crashkernel,low memory will take the default
> value if crashkernel=,low is not specified; while crashkernel reservation
> will fail and bail out if an invalid option is specified.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  kernel/crash_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 256cf6db573cd09..4d57c03714f4e13 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -243,9 +243,8 @@ static int __init __parse_crashkernel(char *cmdline,
>  	*crash_base = 0;
>  
>  	ck_cmdline = get_last_crashkernel(cmdline, name, suffix);
> -
>  	if (!ck_cmdline)
> -		return -EINVAL;
> +		return -ENOENT;
>  
>  	ck_cmdline += strlen(name);
>  
> -- 
> 2.25.1
> 

