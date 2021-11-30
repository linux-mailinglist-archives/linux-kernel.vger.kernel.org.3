Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C1A4640EA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344391AbhK3WIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:08:50 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41931 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhK3WIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:08:48 -0500
Received: by mail-ot1-f43.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so32245627otl.8;
        Tue, 30 Nov 2021 14:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=17xD67r1Po50dKFrN6zPSs2unPvmO1WfBjCX12oxOdY=;
        b=1Sy3TOka/6xcf7Du2aw1fD7G70c5zY8hC9HihFZW4XCAtzINQOqc9i0MBirAFDEibD
         2ukB/xeUhkimHO+lGsh8AFN9ZFIM8+LNn7Kj29PF7NM3z17nAFfr5xzDiDBEiLOQIr77
         VZ+7q2WDIa01FE13F9zBy8rT6UPJGRX9LikoHbKi6Mr6iShEyi5RNGxATTkJ8LWKgM01
         uBlYAoZ8Xlze9D9CzAkXxY6eEGHqyJcjsceWdj6sXwUSCNQ4oQo9Jayme10jmTwPM/0e
         jFTVLVnadS5Ql5JXc6TWXdFoo9qFgz9Z+N8+IohtkL7xAItyQ0d62NcIw9HVwzZH/dPZ
         EvuQ==
X-Gm-Message-State: AOAM533gPSQIbuFYrjE6lh6S1XrJ9mn46Eg7IfO/1ESBLB5uJ7kC8xaV
        0JxNTRwGWXyRUjVjFJy2vQ==
X-Google-Smtp-Source: ABdhPJyj4IRd5mFpSXJj1d5bjNj+dfT6nlMA5FsUuzkeuwrS0n3omP/gEosMzBWySdeTy8h7PGCUyw==
X-Received: by 2002:a9d:7855:: with SMTP id c21mr1891595otm.167.1638309928423;
        Tue, 30 Nov 2021 14:05:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m12sm3348035ots.59.2021.11.30.14.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:05:27 -0800 (PST)
Received: (nullmailer pid 3093201 invoked by uid 1000);
        Tue, 30 Nov 2021 22:05:25 -0000
Date:   Tue, 30 Nov 2021 16:05:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-doc@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v16 09/11] of: fdt: Aggregate the processing of
 "linux,usable-memory-range"
Message-ID: <YaagJQqq2Cx2zyVw@robh.at.kernel.org>
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
 <20211123124646.1995-10-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123124646.1995-10-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 20:46:44 +0800, Zhen Lei wrote:
> Currently, we parse the "linux,usable-memory-range" property in
> early_init_dt_scan_chosen(), to obtain the specified memory range of the
> crash kernel. We then reserve the required memory after
> early_init_dt_scan_memory() has identified all available physical memory.
> Because the two pieces of code are separated far, the readability and
> maintainability are reduced. So bring them together.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/of/fdt.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
