Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C72F4D21C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245469AbiCHTmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiCHTmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:42:38 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDCE344DF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:41:41 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id r12so34228pla.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VSDyqGnviveRTH3Wf+bUrNvV9Iy21N2m3phHscUBuWs=;
        b=cyA+UbQgHbzTcCp+o2TDE4wzOOaPcbAFv7XcK9PfDKf1HSUahkBUKOe4POQQMTcNxc
         bTUqLpL/e+wR311h4A75pOoXf5twYx1gkFeay6Yi4FmqTNHEvfRds/LRxcCHBrKYnx2Q
         Me6yCZ9lNX4BlKMq22UV0u1T4iiP9Ps1NZxpSg3qMKzUGvDrC2ODcCYZUPMQlhqCXuGz
         A3A6tX4J40KxpGZCtUgFREJV4lx91oRyxLYxJKvTcGBq79IQCBEFVRnj+fWRLg/5zRkb
         Ihf+32PmHpglIJ57eRzO200ifLPE7cGBFsnWyh6DiKUkFp3A27lSUEAwGdsQRZqX7+IT
         0ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VSDyqGnviveRTH3Wf+bUrNvV9Iy21N2m3phHscUBuWs=;
        b=xVBBGPGl0oIB8EYfHWLQRbHFSGGr1wG2/0+J3RySxHP5u8aj1BI75kwYHY0YW/CG7Y
         QciLo1o3xhDZZacufGojpONsvMq71j7zx9Omjm4CxKUwfAzwJxQqLs5F4XxAr/gtJHXi
         yJzQ6fj/UqDGBqTZrAcRU/pOEfUNW5iXQn43K+pv06PCMVrNy7o6FltnoXl9y6m3zJ+Q
         rV7K3eyhmLhLL7A4gTuxpkwXKQpMr+lQhEHO2njzO7BEQvZU47mWv3PdfrY5wkIQizas
         Jv+Z8sZlVEU0U1ylw8fZb8mxiAZ22M/km9zxLWCPEtnz+ilBPY5WdeCvmF5zhEuDYNqJ
         FkwA==
X-Gm-Message-State: AOAM530jSYgmK7sOu7ENWTx3N4mKrrYR33atRpJV1MXtHo6Wb7fwUvrV
        EuWOodlPP1jwn3eIDhR2lysq+VCf3BVqaw==
X-Google-Smtp-Source: ABdhPJwREhd7ngMoiKoylzzGHadoMHZXPOAvqTMKDqOtT+oqc/QedggAl2z0ZTXxEG5HtmybtkA9UQ==
X-Received: by 2002:a17:902:704b:b0:14d:2c86:387 with SMTP id h11-20020a170902704b00b0014d2c860387mr19265087plt.1.1646768501014;
        Tue, 08 Mar 2022 11:41:41 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p17-20020a056a000b5100b004f70db04218sm7393220pfo.33.2022.03.08.11.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 11:41:40 -0800 (PST)
Date:   Tue, 8 Mar 2022 19:41:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
Subject: Re: [PATCH v2 19/25] KVM: x86/mmu: simplify and/or inline
 computation of shadow MMU roles
Message-ID: <YiexcHXodAIfPRD4@google.com>
References: <20220221162243.683208-1-pbonzini@redhat.com>
 <20220221162243.683208-20-pbonzini@redhat.com>
 <Yiev/V/KPd1IrLta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yiev/V/KPd1IrLta@google.com>
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

On Tue, Mar 08, 2022, Sean Christopherson wrote:
> On Mon, Feb 21, 2022, Paolo Bonzini wrote:
> > @@ -4822,18 +4798,23 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
> >  {
> >  	struct kvm_mmu *context = &vcpu->arch.root_mmu;
> >  	union kvm_mmu_paging_mode cpu_mode = kvm_calc_cpu_mode(vcpu, regs);
> > -	union kvm_mmu_page_role root_role =
> > -		kvm_calc_shadow_mmu_root_page_role(vcpu, cpu_mode);
> > +	union kvm_mmu_page_role root_role;
> >  
> > -	shadow_mmu_init_context(vcpu, context, cpu_mode, root_role);
> > -}
> > +	root_role = cpu_mode.base;
> > +	root_role.level = max_t(u32, root_role.level, PT32E_ROOT_LEVEL);
> 
> Heh, we have different definitions of "simpler".   Can we split the difference
> and do?
> 
> 	/* KVM uses PAE paging whenever the guest isn't using 64-bit paging. */
> 	if (!____is_efer_lma(regs))
> 		root_role.level = PT32E_ROOT_LEVEL;

Ha, and then the very next patch stomps all over this.  I think this just needs
to add

	BUILD_MMU_ROLE_ACCESSOR(ext, efer, lma);

and do

	if (!is_efer_lma(context))
		root_role.level = PT32E_ROOT_LEVEL;
