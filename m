Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEA757D0BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiGUQJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGUQJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:09:02 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A98073910
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:09:01 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r186so2093421pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kq4tOcuZKKIb0aovN9uV6YoC9FJ55HmRLJusfu89XEw=;
        b=DuWt7aywVJ00JB3vT7dMSz8Z9Cox7G/gaFzAXv8RkZfpCyc92322h9/2Oa/8mJF4PJ
         MMQ+YYhkdOyrsDwmQeO4STsE1c3vQMoCorFyOoivDTt7bJ1J3nd/+lZaVmUbzZbZ4PP+
         QcxpcPqPEbOtJhiW997e+hAtBFfdfyIBz4B75b8S/Jkg48rrRIERk0R0qGcsAoxhxd7A
         7ClJF0yE6dlV0GgeI+yaik8a0jORzuKog4snzsRbdoaTFDNRTmy5bJKWgtY+uthUcpu+
         iy5BYeYgw3mN9LWkKvaaiTgj7sF36AQFmn+q0g/LoCooKkaS5v3pFYKPWjv1/aiarsXh
         KQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kq4tOcuZKKIb0aovN9uV6YoC9FJ55HmRLJusfu89XEw=;
        b=kC2ZnvcVeNQ+c+X6SxbbO4kqx2BLOhZVpBEZMfPIh/cW7JdQgver1Ba41BI/JDj3fJ
         q+2YbNN5pV1WmVLm3N82eLJKP7LTsZkjSNDVYxPdVphvF83INYJJ4od8LIMkIcs/9e4R
         pxNtZPKQrNguxpus7fXjjIzft1jsUH6ZNw1rsHT/qGXG/hZ0GE+R8oJJPlpoFwy/rLRe
         GDMVSxE/ZH3EOQk+JM2HbgZPoIP7sz+mScqa5zwnXVXxIQarnb/TQ5ohRB2wPGHDZqp+
         fjrVP0HzCpY6R8u2Cc6lxNVgopYAT+40cDnh71brikSc16LFaWxmpKSOkV2sR9AKkLbm
         PuaA==
X-Gm-Message-State: AJIora+OEeXRHcaCo0aG8z+S5RAzPY73wLqYHq90zZ177EGHl0PqWA0z
        iAlxppZUVfeJJf+sXTCfduoPgDtPIR3cWw==
X-Google-Smtp-Source: AGRyM1t8MidjDat9EYC6vZTVSXYGFfAYpEF0IwsYFp46gFNQKqfw66NG3/h0fClfB3dy8eVykGg/+g==
X-Received: by 2002:a63:f011:0:b0:416:4b7:5ae4 with SMTP id k17-20020a63f011000000b0041604b75ae4mr37730179pgh.380.1658419740817;
        Thu, 21 Jul 2022 09:09:00 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id i66-20020a626d45000000b00525373aac7csm1992670pfc.26.2022.07.21.09.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:09:00 -0700 (PDT)
Date:   Thu, 21 Jul 2022 16:08:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Santosh Shukla <santosh.shukla@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 4/7] KVM: SVM: Report NMI not allowed when Guest busy
 handling VNMI
Message-ID: <Ytl6GLui7UQFi3FO@google.com>
References: <20220709134230.2397-1-santosh.shukla@amd.com>
 <20220709134230.2397-5-santosh.shukla@amd.com>
 <Yth5hl+RlTaa5ybj@google.com>
 <c5acc3ac2aec4b98f9211ca3f4100c358bf2f460.camel@redhat.com>
 <Ytlpxa2ULiIQFOnj@google.com>
 <413f59cd3c0a80c5b71a0cd033fdaad082c5a0e7.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413f59cd3c0a80c5b71a0cd033fdaad082c5a0e7.camel@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022, Maxim Levitsky wrote:
> On Thu, 2022-07-21 at 14:59 +0000, Sean Christopherson wrote:
> > Yep.  Dropping an NMI in the last case is ok, AFAIK no CPU will pend multiple NMIs
> > while another is in-flight.  But triggering an immediate exit in svm_nmi_allowed()
> > will hang the vCPU as the second pending NMI will never go away since the vCPU
> 
> The idea is to trigger the immediate exit only when a NMI was just injected (V_NMI_PENDING=1)
> but not masked (that is currently in service, that is V_NMI_MASK=0).

I assume you mean "and an NMI is currently NOT in service"?

Anyways, we're on the same page, trigger an exit if and only if there's an NMI pending
and the vCPU isn't already handling a vNMI.  We may need to explicitly drop one of
the pending NMIs in that case though, otherwise the NMI that _KVM_ holds pending could
get "injected" well after NMIs are unmasked, which could suprise the guest.  E.g.
guest IRETs from the second (of three) NMIs, KVM doesn't "inject" that third NMI
until the next VM-Exit, which could be a long time in the future.

> In case both bits are set, the NMI is dropped, that is no immediate exit is requested.
> 
> In this case, next VM entry should have no reason to not inject the NMI and then VM exit
> on the interrupt we raised, so there should not be a problem with forward progress.
> 
> There is an issue still, the NMI could also be masked if we are in SMM (I suggested
> setting the V_NMI_MASK manually in this case), thus in this case we won't have more
> that one pending NMI, but I guess this is not that big problem.
> 
> We can btw also in this case "open" the NMI window by waiting for RSM intercept.
> (that is just not inject the NMI, and on RSM inject it, I think that KVM already does this)
> 
> I think it should overal work, but no doubt I do expect issues and corner cases,
> 
> 
> > won't make forward progress to unmask NMIs.  This can also happen if there are
> > two pending NMIs and GIF=0, i.e. any time there are multiple pending NMIs and NMIs
> > are blocked.
> 
> GIF=0 can be dealt with though, if GIF is 0 when 2nd pending NMI arrives, we can
> delay its injection to the moment the STGI is executed and intercept STGI.
> 
> We I think already do something like that as well.

Yep, you're right, svm_enable_nmi_window() sets INTERCEPT_STGI if VGIF is enabled
and GIF=0 (and STGI exits unconditional if VGIF=0?).

So we have a poor man's NMI-window exiting.
