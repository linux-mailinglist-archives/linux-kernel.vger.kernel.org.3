Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81E2495378
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiATRmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiATRml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:42:41 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E92C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:42:40 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id r29so672650pfl.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=siipzw5qPVJE6LD0sjuwipz56WHSg09btQLgfJcwUzw=;
        b=mu8r0/mBXFnknkfCLySkbX+XsCqQBw7DAX/pnrFPmkiyj/VMPKRZecN7+Fo/Nk2UXq
         gAEY6BUDFrKyik8DsXdv3uRyjv4xUli2vsq8iq8F33HXsAqdVfwRylI4tEgh+9XREwiN
         0GOLpeenqRKGWHs3ZVyL6QrZklGh1RlO9gV2G57s2CP5B9qNBHip7zqUGA+iiqoFXVdf
         EHbJ6zMCX5Y3Fl0pJ8wvVcWzPWhlZ6dh28MkzM7x8KHkaoThkYFrs9D3rVLZd8keKpGx
         LH/bdye5K3EsY4hqcSmLciVPWcHwzXcWzi9//QgJRIEmZyBwelVCdoztMjprlYB7wYGK
         oBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=siipzw5qPVJE6LD0sjuwipz56WHSg09btQLgfJcwUzw=;
        b=gHj17s+gmFgTVkFkSATUbxXCL2uDpluk2U3QWoy6msCjbTd30d6GrP3P+dF752Ig6K
         8VXENCC9T/VZLrNtvczxWDdyBtWHVlJYUy39QMcgbF/MbTBfobGhmkaPe6L9tytbPuQ6
         OY2SKqNNZSGnW6YOkaG/heLhFtSQAXnPdnYbLZoBCYcBdIF43eHD/eDukbsAcjkTfX3R
         XrNyOuVjcEQSb9pBi3AyPEQDKB1FGZuyDzrZ8qMbkjy1WTtbhlHA498nx6kANRXcKXEA
         B8DH7J1Bd8UnoqerHNTyDZCIF9iGLM7+dl2SR0wTqerG6U8MZOUJEBNGesTZDxTnNXAy
         wJBg==
X-Gm-Message-State: AOAM532wVFaXzh5tux7t4pBzF/0I9dZoXdmakpzdk9M5FRLChC/eZE2z
        qsjZ/9LcIJraul8/MJuvyDZ27g==
X-Google-Smtp-Source: ABdhPJx41k3hd3KJSLVFf9u1FAJE0Mg/PY5ptjVA+lOdd1XHy8dCzwGzOkVd6PXrLSh9k8rgPuVwxQ==
X-Received: by 2002:a62:14d5:0:b0:4c7:43cb:863 with SMTP id 204-20020a6214d5000000b004c743cb0863mr54850pfu.23.1642700560231;
        Thu, 20 Jan 2022 09:42:40 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z10sm4148214pfh.77.2022.01.20.09.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:42:39 -0800 (PST)
Date:   Thu, 20 Jan 2022 17:42:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Cooper <amc96@srcf.net>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Alexander Graf <graf@amazon.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH] KVM: VMX: Set vmcs.PENDING_DBG.BS on #DB in STI/MOVSS
 blocking shadow
Message-ID: <YemfC17ZJyR0CLYr@google.com>
References: <20220120000624.655815-1-seanjc@google.com>
 <f3239ec0-9fb8-722a-00c5-11b18f19f047@srcf.net>
 <YemPeqpcFDjhGfRQ@google.com>
 <81aebe8e-ff2a-6b56-fe50-b7917a3948ed@srcf.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81aebe8e-ff2a-6b56-fe50-b7917a3948ed@srcf.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022, Andrew Cooper wrote:
> On 20/01/2022 16:36, Sean Christopherson wrote:
> > On Thu, Jan 20, 2022, Andrew Cooper wrote:
> >> On 20/01/2022 00:06, Sean Christopherson wrote:
> >>> MOVSS blocking can be initiated by userspace, but can be coincident with
> >>> a #DB if and only if DR7.GD=1 (General Detect enabled) and a MOV DR is
> >>> executed in the MOVSS shadow.  MOV DR #GPs at CPL>0, thus MOVSS blocking
> >>> is problematic only for CPL0 (and only if the guest is crazy enough to
> >>> access a DR in a MOVSS shadow).  All other sources of #DBs are either
> >>> suppressed by MOVSS blocking (single-step, code fetch, data, and I/O),
> >> It is more complicated than this and undocumented.  Single step is
> >> discard in a shadow, while data breakpoints are deferred.
> > But for the purposes of making the consitency check happy, whether they are
> > deferred or dropped should be irrelevant, no?
> 
> From that point of view, yes.  The consistency check is specific to TS. 
> I suppose I was mostly questioning the wording of the explanation.
> 
> >>> are mutually exclusive with MOVSS blocking (T-bit task switch),
> >> Howso?  MovSS prevents external interrupts from triggering task
> >> switches, but instruction sources still trigger in a shadow.
> > T-bit #DBs are traps, and arrive after the task switch has completed.  The switch
> > can be initiated in the shadow, but the #DB will be delivered after the instruction
> > retires and so after MOVSS blocking goes away.  Or am I missing something?
> 
> Well - this is where the pipeline RTL is needed, in lieu of anything
> better.  Trap-style #DBs are part of the current instruction, and
> specifically ahead (in the instruction cycle) of the subsequent intchk.

And T-bit traps in particular have crazy high priority...

> There are implementations where NMI/INTR/etc won't be delivered at the
> head of an exception generated in a shadow, which would suggest that
> these implementations have the falling edge of the shadow after intchk
> on the instruction boundary.  (Probably certainly what happens is that
> intchk is responsible for clearing the shadow, but this is entirely
> guesswork on my behalf.)

Well, thankfully hardware's behavior should be moot for VM-Entry since task switches
unconditionally VM-Exit, and KVM has a big fat TODO for handling the T-bit.

> >> and splitlock which is new since I last thought about this problem.
> > Eww.  Split Lock is trap-like, which begs the question of what happens if the
> > MOV/POP SS splits a cache line when loading the source data.  I'm guess it's
> > suppressed, a la data breakpoints, but that'd be a fun one to test.
> 
> They're both reads of their memory operand, so aren't eligible to be
> locked accesses.

Hah, right, the "lock" part of "split lock" is just a minor detail...

> However, a devious kernel can misalign the GDT/LDT such that setting the
> descriptor access bit does trigger a splitlock.  I suppose "kernel
> doesn't misalign structures", or "kernel doesn't write a descriptor with
> the access bit clear" are both valid mitigations.
> 
> >>> This bug was originally found by running tests[1] created for XSA-308[2].
> >>> Note that Xen's userspace test emits ICEBP in the MOVSS shadow, which is
> >>> presumably why the Xen bug was deemed to be an exploitable DOS from guest
> >>> userspace.
> >> As I recall, the original report to the security team was something
> >> along the lines of "Steam has just updated game, and now when I start
> >> it, the VM explodes".
> > Lovely.  I wonder if the game added some form of anti-cheat?  I don't suppose you
> > have disassembly from the report?  I'm super curious what on earth a game would
> > do to trigger this.
> 
> Anti-cheat was my guess too, but no disassembly happened.
> 
> I was already aware of the STI issue, and had posted
> https://lore.kernel.org/xen-devel/1528120755-17455-11-git-send-email-andrew.cooper3@citrix.com/
> more than a year previously.  The security report showed ICEBP pending
> in the INTR_INFO field, and extending the STI test case in light of this
> was all of 30s of work to get a working repro.
> 
> ~Andrew
