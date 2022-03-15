Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAF24D9AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348105AbiCOL7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348100AbiCOL7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F46513EB3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647345483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2FtWagwkwgX0MltETfIs1AByeqI6nXJsssWt9g1O7mo=;
        b=ay4/iD/l86+GJG5fJZZw//aCpLK6x1/AlvPhkybYHidi3QzVdzuTVTvn85IwRMWkW54/OE
        t5+gvqA6H1jVzaSOYtpubdESkHQ21wN0veXfAq5OHFwGWYp/HMCA1lYaFkfP2djurx+rIk
        yq5FUhc3sKeUCJOLu1HCnApHHGCQt2g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-fGbAOanoNcKg9MmMCcJeiQ-1; Tue, 15 Mar 2022 07:57:58 -0400
X-MC-Unique: fGbAOanoNcKg9MmMCcJeiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 192D7811E84;
        Tue, 15 Mar 2022 11:57:57 +0000 (UTC)
Received: from localhost (ovpn-12-225.pek2.redhat.com [10.72.12.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1E4B40C1247;
        Tue, 15 Mar 2022 11:57:55 +0000 (UTC)
Date:   Tue, 15 Mar 2022 19:57:52 +0800
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
Message-ID: <YjB/QILintgvo1AL@MiWiFi-R3L-srv>
References: <20220227030717.1464-1-thunder.leizhen@huawei.com>
 <20220227030717.1464-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227030717.1464-2-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Firstly, I am not sure if '-ENOENT' is a right value to return. From the
code comment of ENOENT, it's used for file or dir?
#define ENOENT           2      /* No such file or directory */

Secondly, we ever discussed the case including
 - no crashkernel=,low is provided;
 - messy code is provied, e.g crashkernel=aaaaaabbbb,low

The 2nd one is not handled in this patchset. How about taking the
handling into another round of patches. This patchset just adds
crashkernel=,high purely.

>  
>  	ck_cmdline += strlen(name);
>  
> -- 
> 2.25.1
> 

