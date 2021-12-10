Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0418347060C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243868AbhLJQqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:46:53 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40727 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhLJQqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:46:53 -0500
Received: by mail-ot1-f44.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so10173556otj.7;
        Fri, 10 Dec 2021 08:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZwDLkPobIqK5v1+DIR9VlqySsN5PRct8i+lUCHBrkFg=;
        b=kj/i9D9Y9/Vqdt/AWmRLtIUbAX2VDoQhZx1FmDC6n6EZM42M4fEg04w/HyBcuP/2QT
         I5cB4HOKdM7aFsNsTJ32al1ikLzIiesSfKJdzYQJeK0Vx18rtnfvf5YIR4qDjbf87OAy
         aiiToGuPvbe92orrXHFgSheUWhNhUA+E42/xHzKOd8kM2K5N0yMrs5lD8UpN5c840alr
         uKjY6Ktgwj/l7cuR93flIyfYSWf/O+a9JozwG/LJ/4Ex7f+LOiKQovQIbPwy0LShNBD1
         yb0EH2EcClFVaqfET9PLEohq+XYUP1Vm9nkRHzA0q6p8Tv81H/vz7Jw2Ndnp24pFwmZi
         fzhg==
X-Gm-Message-State: AOAM531Co40dOME/0V7V2lZ9JmD96rkTFsaTbJkVhPwX1clGD6Q+MPlY
        dMN2m2cMf8pqoAMhfaAf2w==
X-Google-Smtp-Source: ABdhPJwdcBz7WV5SZemj6BK7U1UUeg/obVDS8OyD99mYsandiDs9PU4igyuiQc5l59usoJWA1UTy9Q==
X-Received: by 2002:a05:6830:8:: with SMTP id c8mr11873067otp.115.1639154597413;
        Fri, 10 Dec 2021 08:43:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a3sm571677oti.29.2021.12.10.08.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:43:16 -0800 (PST)
Received: (nullmailer pid 1497925 invoked by uid 1000);
        Fri, 10 Dec 2021 16:43:15 -0000
Date:   Fri, 10 Dec 2021 10:43:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-doc@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Rob Herring <robh+dt@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Frank Rowand <frowand.list@gmail.com>,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v17 09/10] of: fdt: Add memory for devices by DT property
 "linux,usable-memory-range"
Message-ID: <YbODo3WbV27NyL7h@robh.at.kernel.org>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-10-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210065533.2023-10-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 14:55:32 +0800, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> When reserving crashkernel in high memory, some low memory is reserved
> for crash dump kernel devices and never mapped by the first kernel.
> This memory range is advertised to crash dump kernel via DT property
> under /chosen,
>         linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>
> 
> We reused the DT property linux,usable-memory-range and made the low
> memory region as the second range "BASE2 SIZE2", which keeps compatibility
> with existing user-space and older kdump kernels.
> 
> Crash dump kernel reads this property at boot time and call memblock_add()
> to add the low memory region after memblock_cap_memory_range() has been
> called.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>  drivers/of/fdt.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
