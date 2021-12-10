Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8F94705FA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243786AbhLJQnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:43:35 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37808 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbhLJQne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:43:34 -0500
Received: by mail-ot1-f46.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so10149187otg.4;
        Fri, 10 Dec 2021 08:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U8AzNdkQs1VFeOH+BSfiPv2cItiIyXIcpLga5ITOTUg=;
        b=LD8aUDFOwo2E6o21G/fRYBTqh4IVM6NFqa14VqESmo3c15IksVLucr2bsD9LsgSZiq
         S+PrOINKDut3KqZujO8XcUyFPItqr3arONgc0U6g5l6ik3CmzyW35kJubMPLd6Vr6Qbs
         WQ47zqte9MUksVFaYO0FYr2QIttMjZO3fU55HWBRVPxjF3Ti6OCGk29FcuydSwx5weq3
         ma+4ybna04xH47iDPYoEWR0eTiaXTMw5ufslA6RqByanF6SUpFah7GG+I8+uqp9kr9Ns
         sJDRphaAhQGZSjTt1FXBqPgBbWUCUEPXPyBbfWadUTDEl+JySNg+bkC7nYk4m1hD+hxH
         NwuQ==
X-Gm-Message-State: AOAM530Hqfimm6khvLG3elEi+XPQTwRJ68iDNQMcVkRB9zOZ1l1NVY6E
        ymupAmztSQMmKRgmnxCylg==
X-Google-Smtp-Source: ABdhPJymSnAwtWRFNniWT4nkI6ZJg0484AHzkAllwJwxXceIA97LSLGuBuaFZadbFlvA0zXECbbnHA==
X-Received: by 2002:a05:6830:3155:: with SMTP id c21mr11900196ots.183.1639154398721;
        Fri, 10 Dec 2021 08:39:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w71sm732337oiw.6.2021.12.10.08.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 08:39:58 -0800 (PST)
Received: (nullmailer pid 1492155 invoked by uid 1000);
        Fri, 10 Dec 2021 16:39:56 -0000
Date:   Fri, 10 Dec 2021 10:39:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, kexec@lists.infradead.org,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v17 08/10] of: fdt: Aggregate the processing of
 "linux,usable-memory-range"
Message-ID: <YbOC3NmxXsQb/Te/@robh.at.kernel.org>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-9-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210065533.2023-9-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 14:55:31 +0800, Zhen Lei wrote:
> Currently, we parse the "linux,usable-memory-range" property in
> early_init_dt_scan_chosen(), to obtain the specified memory range of the
> crash kernel. We then reserve the required memory after
> early_init_dt_scan_memory() has identified all available physical memory.
> Because the two pieces of code are separated far, the readability and
> maintainability are reduced. So bring them together.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>  drivers/of/fdt.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
