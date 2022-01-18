Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D381B49283E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244985AbiAROVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244543AbiAROUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:20:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59EFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 06:20:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 46353CE19F2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60690C00446;
        Tue, 18 Jan 2022 14:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642515646;
        bh=LQnVNXXFkBGvBwIEYlzUC8mACRKwyF7PmpnrofVDnmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khXMs8nOsMDKs5MbBbUOYqR0A/rLczE6TVnUebuvjd1p/2kox9EI8UHHK3/EjV30Z
         ohxTVi74dxt8DMuc247yuDL7XlpUTU0Zx8h9nonZxWsId6kYqmpHC0XIVOLA3xeXAW
         eLxJcJWMsST1k9ztnKqcMMcgjxgmKJ1NGTpgYlI8lE/i+uFAOa1rMuu5RoDEDEz6wo
         SSUb1DBt8Hrs4qjX8iLFIZWLnncgw7TBwix/+xt7cI42bgjDT8OXg7e7JtRjocepJ3
         oxCpVtpas1q4P4rbAkfT+tu3MbIqUJlCCTdjPERSM3/oTW+JZf6DSlaAj1WDwvVpDO
         ZU5KAaVkdPuvw==
Date:   Tue, 18 Jan 2022 22:13:03 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Baoquan He <bhe@redhat.com>
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
Message-ID: <YebK70Sx4w8zLfj/@xhacker>
References: <20211206160514.2000-1-jszhang@kernel.org>
 <20220116133847.GE2388@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220116133847.GE2388@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 09:38:47PM +0800, Baoquan He wrote:
> Hi Jisheng,

Hi Baoquan,

> 
> On 12/07/21 at 12:05am, Jisheng Zhang wrote:
> > Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
> > by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
> > and increase compile coverage.
> 
> I go through this patchset, You mention the benefits it brings are
> 1) simplity the code;
> 2) increase compile coverage;
> 
> For benefit 1), it mainly removes the dummy function in x86, arm and
> arm64, right?

Another benefit: remove those #ifdef #else #endif usage. Recently, I
fixed a bug due to lots of "#ifdefs":
http://lists.infradead.org/pipermail/linux-riscv/2021-December/010607.html

> 
> For benefit 2), increasing compile coverage, could you tell more how it
> achieves and why it matters? What if people disables CONFIG_KEXEC_CORE in
> purpose? Please forgive my poor compiling knowledge.

Just my humble opinion, let's compare the code::

#ifdef CONFIG_KEXEC_CORE

code block A;

#endif

If KEXEC_CORE is disabled, code block A won't be compiled at all, the
preprocessor will remove code block A;

If we convert the code to:

if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
	code block A;
}

Even if KEXEC_CORE is disabled, code block A is still compiled.

Thanks
