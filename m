Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10D158CC65
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbiHHQvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244128AbiHHQuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:50:54 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEAE17589
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:50:43 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id g18so5179886ilk.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csp-edu.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Hexph1Ne0TDVhVFt14xW1tLuE+4LWiZPsGHTJhk6mQQ=;
        b=XLeyE1+VrTmXUQ2nuKxWeZrS6RGNB82kYULu/5zVDdOMjPgFEYsh/5xUQlPDftLlVX
         pp5WP5s94cV3P//k6tjaVuhamv4e8D2bOPmdKqvCcOmgWdiTBz6laCXv64U2BSSyh1xP
         mrHxJkviJWuTp2rrlFwPkhpioxvYVp6oejMXqCdAQkEzi9yKSjF31f6os4AZ/bHkoVX4
         Q031O78lM5C9E2x5+Q+Qw9+W2VoR+2hCkZi7BCi+44Wbio7kuUZaSLgp0RN/+bgWg85O
         lMuOF5Lzs7orGDrHSaIGPJO5pnkpVh0jncqrBwKE+94uf3PW4yB/n3n+9FKWHZDrAFiP
         2veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Hexph1Ne0TDVhVFt14xW1tLuE+4LWiZPsGHTJhk6mQQ=;
        b=4hI9wULFzWedCxaxGBUwY8m/jq3VYUNXlM6Gr4IGysJBs84UNZxrJbmQelm2Wx8KKD
         XfzcODomhrSFh0ggBMT/aC0wvMSB/FjvyfElRhpfKuR+9E0CSUygpQoopMdek+XP/CiF
         q20t+cSoXrK3Z50/tFMQD8XLEcnydkkr+53nhMh9t+wNYRKssUM59aWDhE3gHF3k2WI4
         sydL6PE/Ic+MI3RJppBhehXsSb9jNxr5lEhBTGw51QUu5N+/M5VjUA27exMLFjXBnNwN
         ON+opnBJXCaVuMvccEo5uXtJ/rlxLeeBF5EaEYb8RjLvf9HVFwYFXcLwWF2mdSPid2sh
         o7WQ==
X-Gm-Message-State: ACgBeo3O0yjVXcUqIJK9h3BZ2DqeiQ4iDYguNNSBW7yud3Cbpw6K73Oi
        vpYSRQhZCf+yYM/6jFUmvVx6QQ==
X-Google-Smtp-Source: AA6agR7OlSEq77/USJRGE3OAR3nROR5QRah2QUhx5IjVTD7Exvwq0R1j0aNRbaqDFUfRc7urrOY7fA==
X-Received: by 2002:a92:cda6:0:b0:2df:a33b:202b with SMTP id g6-20020a92cda6000000b002dfa33b202bmr6244227ild.161.1659977442615;
        Mon, 08 Aug 2022 09:50:42 -0700 (PDT)
Received: from kernel-dev-1 (75-168-113-69.mpls.qwest.net. [75.168.113.69])
        by smtp.gmail.com with ESMTPSA id k3-20020a0566022d8300b006788259b526sm42598iow.41.2022.08.08.09.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:50:42 -0700 (PDT)
Date:   Mon, 8 Aug 2022 11:50:41 -0500
From:   Coleman Dietsch <dietschc@csp.edu>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Pavel Skripkin <paskripkin@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/2] KVM: x86/xen: Initialize Xen timer only once
Message-ID: <YvE+4ZfWJ+86XDA1@kernel-dev-1>
References: <20220729184640.244969-1-dietschc@csp.edu>
 <20220729184640.244969-2-dietschc@csp.edu>
 <Yu1jWSPHiow72qVc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu1jWSPHiow72qVc@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 06:37:13PM +0000, Sean Christopherson wrote:
> On Fri, Jul 29, 2022, Coleman Dietsch wrote:
> > Add a check for existing xen timers before initializing a new one.
> > 
> > Currently kvm_xen_init_timer() is called on every
> > KVM_XEN_VCPU_ATTR_TYPE_TIMER, which is causing the following ODEBUG
> > crash when vcpu->arch.xen.timer is already set.
> > 
> > ODEBUG: init active (active state 0)
> > object type: hrtimer hint: xen_timer_callbac0
> > RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:502
> > Call Trace:
> > __debug_object_init
> > debug_hrtimer_init
> > debug_init
> > hrtimer_init
> > kvm_xen_init_timer
> > kvm_xen_vcpu_set_attr
> > kvm_arch_vcpu_ioctl
> > kvm_vcpu_ioctl
> > vfs_ioctl
> > 
> 
> Fixes: 536395260582 ("KVM: x86/xen: handle PV timers oneshot mode")
> Cc: stable@vger.kernel.org
> 
> > Link: https://syzkaller.appspot.com/bug?id=8234a9dfd3aafbf092cc5a7cd9842e3ebc45fc42
> > Reported-by: syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com
> > Signed-off-by: Coleman Dietsch <dietschc@csp.edu>
> > ---
> 
> One uber nit below, otherwise:
> 
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> 

Got it, thanks Sean.

> >  arch/x86/kvm/xen.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> > index 610beba35907..2dd0f72a62f2 100644
> > --- a/arch/x86/kvm/xen.c
> > +++ b/arch/x86/kvm/xen.c
> > @@ -713,7 +713,10 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
> >  				break;
> >  			}
> >  			vcpu->arch.xen.timer_virq = data->u.timer.port;
> > -			kvm_xen_init_timer(vcpu);
> > +
> > +			/* Check for existing timer */
> 
> I vote to omit the comment, "existing timer" is ambiguous, e.g. it could mean that
> there's an existing _running_ timer as opposed to an existing initialized timer.
> IMO the code is obvious enough on its own.
> 

This makes perfect sense. I will ommit the comment in the next patch.

> > +			if (!vcpu->arch.xen.timer.function)
> > +				kvm_xen_init_timer(vcpu);
> >  
> >  			/* Restart the timer if it's set */
> >  			if (data->u.timer.expires_ns)
> > -- 
> > 2.34.1
> > 
