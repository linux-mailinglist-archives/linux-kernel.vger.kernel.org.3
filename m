Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D835493607
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352218AbiASIJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:09:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233338AbiASIJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642579756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q0Jq/iGEAUJBFkaTrvUcXumSON7O+wGuH4/+IOrgIh0=;
        b=DRRTP0hrHmq1GvQPymAF5D9VqgjLFTrRFMs7juHQlSATLKknMd5li6r/i1LaI6mMxbbpLO
        K3A8xXLcPifrxR9C+DOB2AgT8hOAthbw16pbYiPtMGse+6X9N1RK01bdWwP2h4GMdIsUhb
        iVqojqi0EAkoNLx1sJt3BdU0zXiAaeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-TgfGWhqJOGu-EvyU0rV6uw-1; Wed, 19 Jan 2022 03:09:12 -0500
X-MC-Unique: TgfGWhqJOGu-EvyU0rV6uw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8A651006AA4;
        Wed, 19 Jan 2022 08:09:09 +0000 (UTC)
Received: from localhost (ovpn-12-206.pek2.redhat.com [10.72.12.206])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06F94607CB;
        Wed, 19 Jan 2022 08:09:01 +0000 (UTC)
Date:   Wed, 19 Jan 2022 16:08:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jisheng Zhang <jszhang@kernel.org>
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
Message-ID: <20220119080859.GB4977@MiWiFi-R3L-srv>
References: <20211206160514.2000-1-jszhang@kernel.org>
 <20220116133847.GE2388@MiWiFi-R3L-srv>
 <YebK70Sx4w8zLfj/@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YebK70Sx4w8zLfj/@xhacker>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/18/22 at 10:13pm, Jisheng Zhang wrote:
> On Sun, Jan 16, 2022 at 09:38:47PM +0800, Baoquan He wrote:
> > Hi Jisheng,
> 
> Hi Baoquan,
> 
> > 
> > On 12/07/21 at 12:05am, Jisheng Zhang wrote:
> > > Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
> > > by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
> > > and increase compile coverage.
> > 
> > I go through this patchset, You mention the benefits it brings are
> > 1) simplity the code;
> > 2) increase compile coverage;
> > 
> > For benefit 1), it mainly removes the dummy function in x86, arm and
> > arm64, right?
> 
> Another benefit: remove those #ifdef #else #endif usage. Recently, I
> fixed a bug due to lots of "#ifdefs":
> http://lists.infradead.org/pipermail/linux-riscv/2021-December/010607.html

Glad to know the fix. While, sometime the ifdeffery is necessary. I am
sorry about the one in riscv and you have fixed, it's truly a bug . But,
the increasing compile coverage at below you tried to make, it may cause
issue. Please see below my comment.

> 
> > 
> > For benefit 2), increasing compile coverage, could you tell more how it
> > achieves and why it matters? What if people disables CONFIG_KEXEC_CORE in
> > purpose? Please forgive my poor compiling knowledge.
> 
> Just my humble opinion, let's compare the code::
> 
> #ifdef CONFIG_KEXEC_CORE
> 
> code block A;
> 
> #endif
> 
> If KEXEC_CORE is disabled, code block A won't be compiled at all, the
> preprocessor will remove code block A;
> 
> If we convert the code to:
> 
> if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
> 	code block A;
> }
> 
> Even if KEXEC_CORE is disabled, code block A is still compiled.

This is what I am worried about. Before, if CONFIG_KEXEC_CORE is
unset, those relevant codes are not compiled in. I can't see what
benefit is brought in if compiled in the unneeded code block. Do I miss
anything?

