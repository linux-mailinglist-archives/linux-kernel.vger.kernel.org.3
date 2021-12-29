Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6091C4815ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 18:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241147AbhL2RsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 12:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhL2RsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 12:48:01 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2189BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 09:48:01 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 200so19110937pgg.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 09:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1rOX0Rhr3pSvZPL3W/XjJ3a02uPzDPkhU1/kY8aPA24=;
        b=gbyays0vPGWAJDhFBN43d5dOSfa58Gq33Xh3JkxTdZx/tJ9ksBmCGJ2AgNZ1tQy9Jb
         NTlf3Q7/ZUloPIceWRw1ePuYHtfU9giGSjylq1N1ekvmm/2nk/2vYak9YXqWWuqX4bkP
         Ckng/EMazsPHi3pmU8PpMbXNjQ+tOtHKIDTnog4qvmF2lgpkE9GZzb15I5tYIFy2uU2N
         kappAKukTWRaQsGV3LnnRTu99nhPo9oEVbOt3DMTGlNqJN0Vurw0MnZClK8EiIUeBC3Z
         DTt1pD4atnKAkC0TA4VGFNwu2cgvDFGs2bKRhs2dcwLnpCzxX/7tRU9jV+7VA+tKoIoh
         4FxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1rOX0Rhr3pSvZPL3W/XjJ3a02uPzDPkhU1/kY8aPA24=;
        b=SFOrk/b2Kb6sP/wkxJThY+HQSdzXxeXaEFiIrDHrPieTnC7xRRrYdXYk+1cs9825lQ
         S4eio3K04hisE1kuravHsHqD6z4obnQe3u5GnSOw2NjwEBQwYXPzsemElFBwbhzLNzLv
         BWz5mrtFpBxpLvwsx9uQOOtzxXmtV/g8hkGyH0mMcZxeXRCEDi03Q6eKtoC/owwi/2a3
         ik+qm9FkIUbQk44bDyKgrySQUO8WCo2qyMD3Y8zlyexMRW5pcW9gu9AyZf5x6HWXf92a
         1JYptyENfTTMxjBAErt50z731cby7I55pBCFrsZqDx6iXYeGBq1ZLPkmAW1xxunBNM/B
         1POQ==
X-Gm-Message-State: AOAM531dhFt7p5qgrnWgcwaEbjLiaiger2olZ/EmvSCgwvxlWSybraXU
        d91BA9JiEuSuvhvCcv/dHsveiA==
X-Google-Smtp-Source: ABdhPJyIcI+xnZVsXy+/c5q/PNdmWkIsGaPlpXAMbDgQ/DiLGIiCHr7ldvjXOVEgFCzkmpaU8/qxcQ==
X-Received: by 2002:a62:a519:0:b0:4bc:38f0:b1d with SMTP id v25-20020a62a519000000b004bc38f00b1dmr4540640pfm.53.1640800080459;
        Wed, 29 Dec 2021 09:48:00 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j4sm26144369pfj.34.2021.12.29.09.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 09:48:00 -0800 (PST)
Date:   Wed, 29 Dec 2021 17:47:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 04/26] x86/traps: Add #VE support for TDX guest
Message-ID: <YcyfTIPkhxWKxS3B@google.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-5-kirill.shutemov@linux.intel.com>
 <YcTR5HnkHi7CjVyx@zn.tnic>
 <20211228233112.cpycmdv55edxhvbv@black.fi.intel.com>
 <YcxGrw6Ymqs8NPjY@zn.tnic>
 <YcyV1uwa72vhPXPV@google.com>
 <YcyccW9yzAPoo/rX@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcyccW9yzAPoo/rX@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021, Borislav Petkov wrote:
> On Wed, Dec 29, 2021 at 05:07:34PM +0000, Sean Christopherson wrote:
> > FWIW, virtual/guest NMIs are blocked by the TDX module until pending #VE info
> > is retrieved via TDGETVEINFO.  Hardware has nothing to do with that behavior.
> 
> The TDX module can block NMIs?!

It blocks _virtual_ NMIs, which simply means that it doesn't inject an NMI until
NMIs are unblocked _in the guest_.  Hardware NMIs that arrive in the guest are
never blocked and will trigger an exit to the host.

Any hypervisor can do the same, but it requires a contract between the guest and
the hypervisor to define when NMIs are unblocked.  TDX extends the historical x86
contract with the #VE info clause, but again that doesn't help with nested NMIs.

> Can we get that functionality exported to baremetal too pls? Then we can get
> rid of the NMI nesting crap.

I believe that's being addressed with FRED[*].  ERET{S,U} unblock NMIs iff a magic
bit is set on the stack, and that magic bit is set by hardware only when delivering
NMIs.  I.e. so long as the NMI handler doesn't deliberately set the bit when
returning from other faults/events, NMIs will remain blocked until the NMI handler
returns.

[*] https://www.intel.com/content/www/us/en/develop/download/flexible-return-and-event-delivery-specification.html
