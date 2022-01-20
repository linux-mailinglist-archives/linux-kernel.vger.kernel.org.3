Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E751494B15
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiATJue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:50:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230428AbiATJuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642672232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZNWy14bNC4fJbtyD6GpQKM/LUxExM+x+l77VyG1ixgQ=;
        b=fd/rOSe3YHyL/7AV4MsiOuHn2Dc/EgFxnQcUvibjruG9Pp9uvkK6Itp1Kdu87dhuOda4ND
        ln7A15YbccsFeJX8z+bkW3KA/1LaNbbpQf9sRWx2kN0Sa3aHQwduMIiU5buhSdUP+1s8Od
        NFl53mI499ekTtUBa2xaKMJeBoEKPaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-uRckonSkOxqb_rkLypEbFA-1; Thu, 20 Jan 2022 04:50:27 -0500
X-MC-Unique: uRckonSkOxqb_rkLypEbFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1E251932482;
        Thu, 20 Jan 2022 09:50:24 +0000 (UTC)
Received: from localhost (ovpn-13-177.pek2.redhat.com [10.72.13.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9AC47CAD5;
        Thu, 20 Jan 2022 09:50:21 +0000 (UTC)
Date:   Thu, 20 Jan 2022 17:50:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jisheng Zhang <jszhang@kernel.org>, akpm@linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
        Alexandre ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v2 0/5] kexec: use IS_ENABLED(CONFIG_KEXEC_CORE) instead
 of #ifdef
Message-ID: <20220120095019.GA4579@MiWiFi-R3L-srv>
References: <20211206160514.2000-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206160514.2000-1-jszhang@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/21 at 12:05am, Jisheng Zhang wrote:
> Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
> by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
> and increase compile coverage.

Only checked the x86 patch, but the whole patchset looks good to me,
thanks, Jisheng.

Acked-by: Baoquan He <bhe@redhat.com>

Maybe Andrew can help pick this whole series lest each patch need be taken
care of by its own ARCH maintainer.

> 
> I only modify x86, arm, arm64 and riscv, other architectures such as
> sh, powerpc and s390 are better to be kept kexec code as-is so they
> are not touched.
> 
> Since v1:
>  - collect Reviewed-by tag
>  - fix misleading commit msg.
> 
> Jisheng Zhang (5):
>   kexec: make crashk_res, crashk_low_res and crash_notes symbols always
>     visible
>   riscv: mm: init: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
>   x86/setup: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
>   arm64: mm: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
>   arm: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
> 
>  arch/arm/kernel/setup.c |  7 +++----
>  arch/arm64/mm/init.c    |  9 +++------
>  arch/riscv/mm/init.c    |  6 ++----
>  arch/x86/kernel/setup.c | 10 +++-------
>  include/linux/kexec.h   | 12 ++++++------
>  5 files changed, 17 insertions(+), 27 deletions(-)
> 
> -- 
> 2.34.1
> 

