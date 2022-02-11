Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29174B2A67
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351536AbiBKQbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:31:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245006AbiBKQbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:31:39 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3840FCCD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:31:38 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p6so4901156plf.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hv55MHrUjWPg6SLvcoUYwj9EYcyXIsOpD2RebB8dtAA=;
        b=tOIBEYmlz923nLvZzzWPSrWLENFBs9a+1t7cAfDrrKsThHYe3+YFOpjT4VmNYFBx0o
         wwBczxHJnOEV6NHvDkAvuWg77YDCZxg/dN6ysW3MGUdOJ9iCQmBT03ipUOcplgkdArJ9
         qUZWwhKhA9ErhQb5jh4VON/uRE9hoAN3dU1ryeOWNvaOrEqAJwJMGqyHiYQQoDukNJeG
         H0Py5wuA+9p6GTQnWixAns0r2MSJH2nWERUG5BlPwRFWXQ2fvZ1l8scvZoquvWVPUEMF
         1YXPKCBGvTy4ysboZuRRuiofdlLKEORI2FzIEtb1uTNIZwLWoDyGiNjdMK2SQQissd/U
         QpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hv55MHrUjWPg6SLvcoUYwj9EYcyXIsOpD2RebB8dtAA=;
        b=LM3oGr6oWZLT9cWQyXO5tHL3OED5HGfzO89ARJNsslEZFn06T6VGD1t3qF744fOnNg
         D2pgo3dM4LUfFIooHxi+ZS3A5gaMmPU4zAJp3SYlJID+OOoNz5Kz/3gcuUfW5Kq+ONQk
         81k33qqKl2mWHEsTGRJMflk2cjHZwIqDbYLGyaEISJhbx5XsjY56gXCCNoYl7eBqBdzl
         A7NyKayzZA87lkfOr4ODZ+0ocSKiO3JIvv6oaa+gb7OZZfnDCi7ML5uCbwghAj16RO1s
         aO7gAOROUCuiGyFcIRSK8i/ZDzzWD2wiUUD9n6l0dXPhe7EjbOtQK//gzT0+oh9iLXpz
         xUUA==
X-Gm-Message-State: AOAM530XNM9FzJLn7gvZwBuG3IDsfCbdd1ctqtGRbo4Y5q0Wtx+h0YXJ
        zgJmvZDAliy/r8TEPIatkRMMHc1Vg1oJgg==
X-Google-Smtp-Source: ABdhPJxZb5PmAI77baHoWMCjmV7utFuCtkKMJn807ck5hrUSOvsfEfEAfZWcWz85hbhRu/eFPCB6JQ==
X-Received: by 2002:a17:903:41ce:: with SMTP id u14mr2227983ple.49.1644597097432;
        Fri, 11 Feb 2022 08:31:37 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q2sm5656813pjj.32.2022.02.11.08.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:31:36 -0800 (PST)
Date:   Fri, 11 Feb 2022 16:31:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: Re: [PATCH 0/3] KVM: x86: Fixes for kvm/queue
Message-ID: <YgaPZcET90k14fBa@google.com>
References: <20211216021938.11752-1-jiangshanlai@gmail.com>
 <7fc9348d-5bee-b5b6-4457-6bde1e749422@redhat.com>
 <CANRm+CyHfgOyxyk7KPzYR714dQaakPrVbwSf_cyvBMo+vQcmAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+CyHfgOyxyk7KPzYR714dQaakPrVbwSf_cyvBMo+vQcmAw@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022, Wanpeng Li wrote:
> On Tue, 21 Dec 2021 at 04:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 12/16/21 03:19, Lai Jiangshan wrote:
> > > From: Lai Jiangshan <laijs@linux.alibaba.com>
> > >
> > > Patch 1 and patch 2 are updated version of the original patches with
> > > the same title.  The original patches need to be dequeued.  (Paolo has
> > > sent the reverting patches to the mail list and done the work, but I
> > > haven't seen the original patches dequeued or reverted in the public
> > > kvm tree.  I need to learn a bit more how patches are managed in kvm
> > > tree.)
> >
> > This cycle has been a bit more disorganized than usual, due to me taking
> > some time off and a very unusual amount of patches sent for -rc.
> > Usually kvm/queue is updated about once a week and kvm/next once every
> > 1-2 weeks.
> 
> Maybe the patch "Revert "KVM: VMX: Save HOST_CR3 in
> vmx_prepare_switch_to_guest()"" is still missing in the latest
> kvm/queue, I saw the same warning.

It hasn't made it way to Linus either.
