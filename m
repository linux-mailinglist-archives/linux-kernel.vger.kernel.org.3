Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963FC4DA9FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 06:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353649AbiCPFlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 01:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbiCPFlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 01:41:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D32B45FF33
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 22:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647409193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AWzW/AiFghgBpQmEgCb3aWpx2QwBfw3FXug4mOjTdG8=;
        b=bVd7XFOg04kqNTDzRDhREOwROpNsiKPVxNqwiLCfWLiWISPP4y0qFbKaDwEAL7a6sT2GTU
        PZ0EZStzuE2rG5NmdMjySySvkv4REhin+iNz8R8oessl5AIOr+u1i3XoAb9rAx63sQcnhp
        oe4oxFBQJh/rfjpr7MuZ4Gdv3s+GogA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-Qv-RiQxdOImnaY6CTmAwsQ-1; Wed, 16 Mar 2022 01:39:49 -0400
X-MC-Unique: Qv-RiQxdOImnaY6CTmAwsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E783282A6C2;
        Wed, 16 Mar 2022 05:39:48 +0000 (UTC)
Received: from localhost (ovpn-13-134.pek2.redhat.com [10.72.13.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9091C26E80;
        Wed, 16 Mar 2022 05:39:47 +0000 (UTC)
Date:   Wed, 16 Mar 2022 13:39:44 +0800
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
Subject: Re: [PATCH v21 1/5] kdump: return -ENOENT if required cmdline option
 does not exist
Message-ID: <YjF4IMuMlVDMYOas@MiWiFi-R3L-srv>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <20220227030717.1464-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227030717.1464-2-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/22 at 11:07am, Zhen Lei wrote:
> The crashkernel=Y,low is an optional command-line option. When it doesn't
> exist, kernel will try to allocate minimum required memory below 4G
> automatically. Give it a unique error code to distinguish it from other
> error scenarios.

This log is a little confusing. __parse_crashkernel() has three callers. 
 - parse_crashkernel()
 - parse_crashkernel_high()
 - parse_crashkernel_low()

How about tuning the git log as below:

==================
According to the current crashkernel=Y,low support in other ARCHes, it's
an optional command-line option. When it doesn't exist, kernel will try
to allocate minimum required memory below 4G automatically. 

However, __parse_crashkernel() returns '-EINVAL' for all error cases. It
can't distinguish the nonexistent option from invalid option. 

Change __parse_crashkernel() to return '-ENOENT' for the nonexistent option
case. With this change, crashkernel,low memory will take the default
value if crashkernel=,low is not specified; while crashkernel reservation
will fail and bail out if an invalid option is specified.
==================

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/crash_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
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

