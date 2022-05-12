Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B968525034
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355396AbiELOf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355370AbiELOfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:35:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B91E25F78E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:35:23 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q4so5034038plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VH9CtAWZfBNkMc4PV6ciArAbPEDFzOy6nzMqxMfXdx4=;
        b=TERBj7B9rvyTZG2Q0bQuEMyTj2MR4W/RGaFMvts5duvroI3qHRNJKDSQWLOhpa7+Ih
         fzeOVVFH0fbM8yikGZPXqdumhDkz9q+M2NUQMu1oN+96zcZpUiyhtjVNtJyqMp3Qw46f
         UTd8kP7R1wzL5oc4QzkBLDkHViFDqyMnUBiYYDpTgnqmkPvO1pJK9R1AqVDzCu1UDCy4
         +jKnr4sLzdRKjfSk5aC/zViNOcYcOS3sdxV1g4oQOzwcIbFsKP+xJ6hePlAXF3O/cSs/
         ZrxwEsk9tfx2P0PAmdWggL5eqJI+J2TY6/IThrN5jFnbZRubUxBDU5lrrVMgZ+QcQDVu
         kUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VH9CtAWZfBNkMc4PV6ciArAbPEDFzOy6nzMqxMfXdx4=;
        b=VnhdWkVLpHYwHT8wI/q6HZOusOIBnGivHhubyYr1Q3Rq7bJrVt2qeWpaiaZNUDBFZ9
         S2WBcpD+A2fqCJtP/oKBXr6KhkG6BzZSLojurETdwoEg0pbbMOEWUl7h3S4ZS/oAjdkU
         qSZJRaA+VTzKikE53Ye2vDAzDmwhHemQE+FCGXCn6lMb2nFQEZflzXaq9lQ7hjVCY7PX
         hHnScS1yKe0xopx9HorvN/6os+FMcY7UF6iCAbnKJvK9/auJoBHvH0wFsfbBb89nxU8I
         d2MucIhjYFY3dM77LCLuCxLvvhv/uD/E5WMEdLUcMkkQBkc51K1TWPzgpR6bsKedNGdx
         4j3w==
X-Gm-Message-State: AOAM533dVKIxqVaqyJuhaMA/I2wK8AhjjIKSf4EqtQ0g53LoyragWHAz
        QTSEUq8z3Rh+xt/Iauh3YyAGRw==
X-Google-Smtp-Source: ABdhPJyS+Wi6JIuFyAQjmiQNaTN9bTfS194VeoCwFkeNs/R1+Uj29i2lj82ARrJqGtQzOxeoQwH9kg==
X-Received: by 2002:a17:903:234e:b0:15e:d63f:973e with SMTP id c14-20020a170903234e00b0015ed63f973emr241023plh.47.1652366122444;
        Thu, 12 May 2022 07:35:22 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id ij14-20020a170902ab4e00b0015e8d4eb1c2sm8661plb.12.2022.05.12.07.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:35:21 -0700 (PDT)
Date:   Thu, 12 May 2022 14:35:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] x86/crash: Disable virt in core NMI crash handler to
 avoid double list_add
Message-ID: <Yn0bJkjgDOxPxDU4@google.com>
References: <20220511234332.3654455-1-seanjc@google.com>
 <20220511234332.3654455-2-seanjc@google.com>
 <87wnervxb7.ffs@tglx>
 <Yn0WPBGGI4VcbM4S@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn0WPBGGI4VcbM4S@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022, Sean Christopherson wrote:
> On Thu, May 12, 2022, Thomas Gleixner wrote:
> > Sean,
> > 
> > On Wed, May 11 2022 at 23:43, Sean Christopherson wrote:
> > > @@ -840,6 +858,20 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
> > >  	unsigned long msecs;
> > >  	local_irq_disable();
> > >  
> > > +	/*
> > > +	 * Invoking multiple callbacks is not currently supported, registering
> > > +	 * the NMI handler twice will cause a list_add() double add BUG().
> > > +	 * The exception is the "nop" handler in the emergency reboot path,
> > > +	 * which can run after e.g. kdump's shootdown.  Do nothing if the crash
> > > +	 * handler has already run, i.e. has already prepared other CPUs, the
> > > +	 * reboot path doesn't have any work of its to do, it just needs to
> > > +	 * ensure all CPUs have prepared for reboot.
> > 
> > This is confusing at best. The double list add is just one part of the
> > problem, which would be trivial enough to fix.
> > 
> > The real point is that after the first shoot down all other CPUs are
> > stuck in crash_nmi_callback() and won't respond to the second NMI.
> 
> Well that's embarrasingly obvious in hindsight.
> 
> > 
> > So trying to run this twice is completely pointless and guaranteed to
> > run into the timeout.
> > 
> > > +	 */
> > > +	if (shootdown_callback) {
> > > +		WARN_ON_ONCE(callback != nmi_shootdown_nop);
> > > +		return;
> > 
> > Instead of playing games with the callback pointer, I prefer to make
> > this all explicit. Delta patch below.
> 
> Much better.  If you're planning on doing fixup, can you also include a comment
> tweak about why the callback is left set?  If not, I'll do it in v2.  A bit
> overkill, but it's another thing that for me was obvious only once I realized "why".

Actually, I'll send a v2, there's some more cleanup that can be done if patch 2
uses cpu_crash_disable_virtualization().
