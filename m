Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41735A856D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiHaSYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiHaSXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:23:42 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4310210D4CD
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:19:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c2so14895851plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=81cxqnbCXs4IvcPvB7D0eLT2L7c7/05/+jBHEgh8YbI=;
        b=Al5khbiMiE91Wy0qYXl9rLmk69PiKN9UYLVA5bheW2gKrSXvKUWMwgGFkl6Kz94Lnj
         jpktS5izu0x2o9CxveFFRSFxFRTEeP6fDBlZWikTqKvkjdOajhZkOkM6U5ozaO6iberV
         CaR8vtyJFdZPFK157DioeqeomRzuyW/m3AY3YPFfIIQ3xXA8Gcw5JxK7FAauSEY7PoSt
         v9TUkK6EDSRYMO4T2FjyDEnhT6Idm0iJeL7CSX6pjyFP2iPYK3+8Hky1obcrt141syYs
         19oqOMc3ExUoWBtVbCBlAZrzD3NOIA8T/cu0GAerrbY0tT7Lt92tSfFraHIweRFE2agC
         2VFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=81cxqnbCXs4IvcPvB7D0eLT2L7c7/05/+jBHEgh8YbI=;
        b=lIviZpjHqz/kI+ti1cqrKLhwa5UMvn/Lxgfm77lyKsGYfgIURGsXb79mNL93OAfSIO
         gH0VB1bVhd9Qp3wpfVJ++M50ZNPWSlHAwe0bSTR+892EDN0Q8DkdmtJarn4yTvFBMGqx
         N4rPYcBZdzgs5hur4S6v8bgVhGArClZiBO/DbrzS1nCpBeYrnnygaOUO+Vjm3lOG63+V
         RoBJKZCUFuBLnTt9vX6YdmDI8RC5hu8m54OssXUjI8bH++l5LQiv/H6xJMfBQPNqu6ME
         v3hU1S7fJNJErARYS2/NDTkmVY70qbTMLj8iOEzFn3T4WkBYchrajf+k/r0Fs7p3Lweo
         UNBg==
X-Gm-Message-State: ACgBeo1yeFKhnwh5hbw77EMvZFn2u84605fzgBqV6Swgb/wWOu8NJo4s
        n/XjnIY5xM/cQXNLfog2EM1HIw==
X-Google-Smtp-Source: AA6agR6JakllMeX5LmRTVr5HK8mAyZUnOIwMOcY8w1XZC5rVQAU2d/3uhIXxGvht95N46CX0BxfdeQ==
X-Received: by 2002:a17:90a:2e12:b0:1fb:a4d4:be3f with SMTP id q18-20020a17090a2e1200b001fba4d4be3fmr4504751pjd.237.1661969945597;
        Wed, 31 Aug 2022 11:19:05 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902f14200b00173368e9dedsm8755331plb.252.2022.08.31.11.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:19:05 -0700 (PDT)
Date:   Wed, 31 Aug 2022 18:19:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH 17/19] KVM: SVM: Handle multiple logical targets in AVIC
 kick fastpath
Message-ID: <Yw+mFbuih3rBjMV8@google.com>
References: <20220831003506.4117148-1-seanjc@google.com>
 <20220831003506.4117148-18-seanjc@google.com>
 <ca3be5f88268f1547e6f02b01a472186566066c5.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca3be5f88268f1547e6f02b01a472186566066c5.camel@redhat.com>
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

On Wed, Aug 31, 2022, Maxim Levitsky wrote:
> On Wed, 2022-08-31 at 00:35 +0000, Sean Christopherson wrote:
> > +static void avic_kick_vcpu_by_logical_id(struct kvm *kvm, u32 *avic_logical_id_table,
> > +					 u32 logid_index, u32 icrl)
> > +{
> > +	u32 physical_id;
> > +
> > +	if (!avic_logical_id_table) {
> ^ Typo, the '!' shoudn't be there.

Ouch.  I suspect the tests pass because this just ends up routing events through
the slow path.  I try to concoct a testcase to expose this bug.

> > +static bool is_optimized_logical_map_enabled(struct kvm *kvm)
> > +{
> > +	struct kvm_apic_map *map;
> > +	bool enabled;
> > +
> > +	rcu_read_lock();
> > +	map = rcu_dereference(kvm->arch.apic_map);
> > +	enabled = map && map->logical_mode != KVM_APIC_MODE_MAP_DISABLED;
> > +	rcu_read_unlock();
> > +	return enabled;
> > +}
> 
> This function doesn't belong to avic, it should be in common KVM code.

I'll move it.  I'm not expecting any additional users, but I agree it belongs
elsewhere.  Actually, might be a moot point (see below).

> > @@ -394,50 +449,27 @@ static int avic_kick_target_vcpus_fast(struct kvm *kvm, struct kvm_lapic *source
> >  		if (unlikely(!bitmap))
> >  			return 0;
> >  
> > -		if (!is_power_of_2(bitmap))
> > -			/* multiple logical destinations, use slow path */
> > +		/*
> > +		 * Use the slow path if more than one bit is set in the bitmap
> > +		 * and KVM's optimized logical map is disabled to avoid kicking
> > +		 * a vCPU multiple times.  If the optimized map is disabled, a
> > +		 * vCPU _may_ have multiple bits set in its logical ID, i.e.
> > +		 * may have multiple entries in the logical table.
> > +		 */
> > +		if (!is_power_of_2(bitmap) &&
> > +		    !is_optimized_logical_map_enabled(kvm))
> >  			return -EINVAL;
> 
> 
> I hate to say it but there is another issue here, which I know about for a while
> but haven't gotten yet to fix.
> 
> The issue is that AVIC's logical to physical map can't cover all the corner cases
> that you discovered - it only supports the sane subset: for each cluster, and for each bit
> in the mask, it has a physical apic id - so things like logical ids with multiple bits,
> having same logical id for multiple vcpus and so on can't work.
> 
> In this case we need to either inhibit AVIC (I support this 100%),

I like the idea of inhibiting.

>  or clear its logical ID map, so all logicical IPIs VM exit, and then they
>  can be emulated.
> 
> I haven't studied it formally but the code which rebuilds the AVIC's logical ID map
> starts at 'avic_handle_ldr_update'.

I suspected there are issues here, but the new tests passed (somewhat surprisingly)
so I stopped trying to decipher the AVIC LDR handling.

Eww.  And the VM-Exit trap logic is broken too.  If the guest updates and disables
its LDR, SVM returns immediately and doesn't call into common APIC code, i.e. doesn't
recalc the optimized map.  E.g. if the guest clears its LDR, the optimized map will
be left as is and the vCPU will receive interrupts using its old LDR.

	case APIC_LDR:
		if (avic_handle_ldr_update(vcpu))
			return 0;
		break;

Rather than handling this purely in AVIC code, what if we a key off of
the optimized map being enabled?  E.g. drop the return from avic_handle_ldr_update()
and in the kvm_recalculate_apic_map() do:

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 3b6ef36b3963..6e188010b614 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -364,6 +364,11 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
                cluster[ldr] = apic;
        }
 out:
+       if (!new || new->logical_mode == KVM_APIC_MODE_MAP_DISABLED)
+               kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_LOGICAL_MAP_DISABLED);
+       else
+               kvm_clear_apicv_inhibit(kvm, APICV_INHIBIT_REASON_LOGICAL_MAP_DISABLED);
+
        old = rcu_dereference_protected(kvm->arch.apic_map,
                        lockdep_is_held(&kvm->arch.apic_map_lock));
        rcu_assign_pointer(kvm->arch.apic_map, new);
