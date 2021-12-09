Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD746E036
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241851AbhLIBZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbhLIBZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:25:24 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BE3C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:21:51 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id s137so3628471pgs.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 17:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w/2SmMvf9K2cSdfzoqFxaQEz5ChfX3X+U4tpykInEaw=;
        b=mwo4lkEwwBUJir6tlHp+fTlpznBWkrUVJWP6QbZ5pFMr6tlT8/+dDemVj+2n6BkTOn
         4foW2SIczEF7RvWwmSMmZkjJ3ZECtRLD8eT7j0xTPchQT7UOBr2cwvPb9Nc8lEFq0KPZ
         sQUyDXN+GiJEU8JE632N4Uzjaxve4XAIzgC+0ydwRt2EuALsfbe1hcATX79u+qFSOyXs
         1reWxe3BoV10R3ZwKDEOhh5ANxW/6YIVqVSOo0Dqc6V7CvckS81Q1plLbqepubpr6NWD
         xDHqKxVx3MwW/Wl2r9CkHrr0Sj13+n/+ID+X7pAk//ybTFsQkOzfJYNU1fau4dtGJupq
         kBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w/2SmMvf9K2cSdfzoqFxaQEz5ChfX3X+U4tpykInEaw=;
        b=40IjMKYKUa49MWbIOfsR927434yf2LBzszg80SZ/Gl4FFFvifzvc9In7H78cxf9uYC
         WH4Y02NzIP9R/eGISKZ0UYSJ0uqub/CU1ZcjC5dxeAX/Jk5U5vY7RDw8r18pQftjkZUM
         kQBwLnexDRbjt/STwPVvOiHVbDGlOilVZ8wrYEiYQUwiW0aqHnOgOvYllAd+272kXUJP
         e9TwVL0mLWzTX13W8SONpTlZ9Z1d4OLWId2peGvSr5+rG/yXw8gOXsdiHYsTweEPfZQl
         9BCAAapdB8sz2uJhUA31p4JNS+sp/ELOic99NmxRRzZ0hoU0sE++h1hIyN+K+uCLenPd
         tcVw==
X-Gm-Message-State: AOAM531cvWhsmsoHxV3A9WO9pln6XeYkd42MupEkc104edDql5GSq/Iz
        BGMAsr9PzI4snsHnSwW0Fv0WgQ==
X-Google-Smtp-Source: ABdhPJyzY+aozezUHQm+uFO0WdH/nyLw/UF99ZDTG9ckrSFpFzI7DHGTlNtknPEeWMOSrwtiXY60uw==
X-Received: by 2002:a63:c003:: with SMTP id h3mr32145470pgg.261.1639012911092;
        Wed, 08 Dec 2021 17:21:51 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v1sm4550953pfg.169.2021.12.08.17.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 17:21:50 -0800 (PST)
Date:   Thu, 9 Dec 2021 01:21:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 1/12] KVM: X86: Fix when shadow_root_level=5 && guest
 root_level<4
Message-ID: <YbFaK8E3hg5lVX/X@google.com>
References: <20211124122055.64424-1-jiangshanlai@gmail.com>
 <20211124122055.64424-2-jiangshanlai@gmail.com>
 <YbFY533IT3XSIqAK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbFY533IT3XSIqAK@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021, Sean Christopherson wrote:
> On Wed, Nov 24, 2021, Lai Jiangshan wrote:
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> > 
> > If the is an L1 with nNPT in 32bit, the shadow walk starts with
> > pae_root.
> > 
> > Fixes: a717a780fc4e ("KVM: x86/mmu: Support shadowing NPT when 5-level paging is enabled in host)
> 
> Have you actually run with 5-level nNPT?  I don't have access to hardware, at least
> not that I know of :-)
> 
> I'm staring at kvm_mmu_sync_roots() and don't see how it can possibly work for
> 5-level nNPT with a 4-level NPT guest.

Oh, and fast_pgd_switch() will also break kvm_mmu_sync_prev_roots() / is_unsync_root()
by putting a root into the prev_roots array that doesn't have a shadow page associated
with the root.
