Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E780532CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbiEXOzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbiEXOzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:55:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6B99C2EF
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:55:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n10so17037325pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=swJTOk6cv1Li2ZbdtR4uFgtmFnbVqjAMb3FAHJidh94=;
        b=MWcMv1JPX0DlOMeo0MLt6sW6brPq0AaMpEhWTOZ+wHf9G70cGIJ3JOluW/eC1Q+3Di
         FuoFf/aXElVc3gCZ1a1/1q64V+NNCzZgYOnEnAhy0QeUWJ8qbGS4Gwu3zacBqFzplmAc
         XonBFrW5olfmiS1xKHWeSUJaQkV26SKegvEO7Za6WInGsILwINSyCfWpPnKfHuA+fqq2
         YKI81JUG5ifmYefpF5U6uSlyoWo0TSsrPgWa6BOZ8hBhCf4P511I+ftVp9RwPh5HJ48G
         DgTIjeaJ86q+Uhe1W/HNzbtqtqJQMkrfQcVLXbu+Q7nhgg2/vaQcomQ3YT6iQtCnj9pM
         aUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=swJTOk6cv1Li2ZbdtR4uFgtmFnbVqjAMb3FAHJidh94=;
        b=HGYHdOxIS/IjUvJ5REkfBoOBI/xv3eO/kviP7SIDv+OlaAwJVjee41+hw6UxfAcHUI
         QT3CPx3CFgI1UJbeKf2MrCvmDrwbodWGroG4xtCpdOkNRlbtI8QINU/Vhh09BKuC9aNW
         nS2ZC97Z1ebrhd70n8ymlQzq4HK5KTTJx7SLHx0SbZktPAYi9hzxwcM63qDxPCG6hOhN
         dUPmEUIJiI1AZVIgugOV/mV9nE203x2KovJ6sLXL717RjnRLs3O8kb7d/SVM0b6hLpOx
         pT0p9TibVUrynOPAFDNewtdZ6NLUUEjliZDIfEtWLXYWH6TnT5nfgdHYurgS1qV1GfFi
         N0hA==
X-Gm-Message-State: AOAM533OfGAYR3aN5FUs3Pe5LLjwaNSPJquicbMuQt3/ALeOaa53I9PH
        pletPquvjQk6fNatHfpPDGg=
X-Google-Smtp-Source: ABdhPJyyO8muck+yr7EqJvnfIsmYtgc0glFHfPDyeVZgquby+fWgmcyDS/1jYIU19I0pxMkzi7jyfw==
X-Received: by 2002:a17:90a:ae14:b0:1e0:51fa:5182 with SMTP id t20-20020a17090aae1400b001e051fa5182mr5003029pjq.60.1653404139581;
        Tue, 24 May 2022 07:55:39 -0700 (PDT)
Received: from localhost ([192.55.54.48])
        by smtp.gmail.com with ESMTPSA id jx5-20020a17090b46c500b001df40fdf858sm1843618pjb.27.2022.05.24.07.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 07:55:39 -0700 (PDT)
Date:   Tue, 24 May 2022 07:55:37 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        frederic@kernel.org, paulmck@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@kernel.org,
        isaku.yamahata@gmail.com
Subject: Re: [RFC][PATCH 9/9] arch/idle: Change arch_cpu_idle() IRQ behaviour
Message-ID: <20220524145537.GA3181491@ls.amr.corp.intel.com>
References: <20220519212750.656413111@infradead.org>
 <20220519213422.119695559@infradead.org>
 <20220519220349.GM2578@worktop.programming.kicks-ass.net>
 <20220520022052.mkrc4v4evtp74bxe@black.fi.intel.com>
 <20220520070614.GP2578@worktop.programming.kicks-ass.net>
 <20220520101322.flxf52mg6vkkbc7r@box.shutemov.name>
 <20220520125819.GS2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220520125819.GS2578@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:58:19PM +0200,
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, May 20, 2022 at 01:13:22PM +0300, Kirill A. Shutemov wrote:
> 
> > So you want to call call the HLT hypercall with .irq_disabled=false and
> > .do_sti=false, but actual RFLAGS.IF in the guest is 0 and avoid CLI on
> > wake up expecting it to be cleared already, right?
> 
> Yep, just like MWAIT can, avoids pointless IF flipping.
> 
> > My reading of the spec is "don't do that". But actual behaviour is up to
> > VMM and TDX module implementation. VMM doens't have access to the guest
> > register file, so it *may* work, I donno.
> 
> Yeah, it totally *can* work, but I've no idea if they done the right
> thing.

There are two cases when interrupt arrives.

- If interrupts arrives after the CPU start executing VMM (or the TDX module),
  VMM can know if interrupt for vCPU arrives. VMM will unblock vcpu scheduling.
  The HLT hypercall returns back to guest.

- If interrupts arrives and vcpu recognizes it before the CPU starts executing
  VMM (or TDX module), the interrupt request is recorded in vRVI (VMCS.RVI)
  due to vRFLAGS.IF=0.  After that, CPU exits from guest to VMM due to HLT
  hypercall.
  Before KVM blocking vcpu scheduling, due to irq_disable=false TDX KVM checks
  if deliverable interrupt events is pending by TDX SEAMCALL (because CPU state
  is protected, VMM can't peek vRVI and vPPR directly.  Note that vRFLAGS.IF is
  ignored in this check).  If vcpu has deliverable pending interrupt, HLT
  hypercall returns.

  Anyway this scenario isn't tested, I need to test it.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
