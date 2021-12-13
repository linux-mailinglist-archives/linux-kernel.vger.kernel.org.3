Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DAE472D31
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbhLMNZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:25:47 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54374 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233368AbhLMNZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:25:44 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 932BB1EC03AD;
        Mon, 13 Dec 2021 14:25:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639401938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=w7Wxn2nvwqZfbw5KMe+rNGBbbQ7M6VkH+lHcXd8xlm4=;
        b=islFblvRDLrXnZVy3BsHg3hnfXUU+YurjZVPtX5imquEzxh5e5USTjRJWP2TCYJcLVWq2r
        E8zceC1XhZCrqTu018Qe6kifLzqOz0kzbIEKiQKCjwQUKcelBdbtLwJhW/zFiS55WrY7jv
        7MguVHCfTpPrUA0gCkyd0Mb8V9br+nU=
Date:   Mon, 13 Dec 2021 14:25:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, rppt@linux.ibm.com
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when
 no managed pages
Message-ID: <YbdJ00wRFvi0aqze@zn.tnic>
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207031631.GA5604@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211207031631.GA5604@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 11:16:31AM +0800, Baoquan He wrote:
> > This low 1M lock down is needed because AMD SME encrypts memory making
> > the old backup region mechanims impossible when switching into kdump
> > kernel. And Intel engineer mentioned their TDX (Trusted domain extensions)
> > which is under development in kernel also needs lock down the low 1M.
> > So we can't simply revert above commits to fix the page allocation
> > failure from DMA zone as someone suggested.

Did you read

  f1d4d47c5851 ("x86/setup: Always reserve the first 1M of RAM")

carefully for a more generically important reason as to why the first 1M
should not be used?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
