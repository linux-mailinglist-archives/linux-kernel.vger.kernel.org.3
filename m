Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4414931E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346022AbiASAe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiASAe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:34:28 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12509C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 16:34:28 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c3so547174pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 16:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fhtsshb779foHbUp9uRUsqpWENAGkHqJ8VEZb1EuPfo=;
        b=cts+MA9AHHlyk9r+XBHTWM5nizuHm/1LTrjv907OodM2rP0bLUgF5TK5lIOAzVMUj1
         HLVENadItvTm+SBpER3uaCQow8rmnlyfjxa0twynqbwUdgYG4VrBrmFTD8WeT6Xjj8j6
         XWKN8YaFVAVY4z7kiQ3GKu3vC6oGB6krTdjpTRN1FzH2kZXit0Fc1xV0j6SDZJ6yuUPD
         3RbMsb+P2OeNN2TNvsEtX03QC17a8E5xriYNXIDcRWsZBEX7ux8KHekB9cEH0kiOLQP1
         tliQRaxGJiRzHqTsBDBMnBZL6q/Oq4iDSe0ObdfUe/6WWIxbL+9dRew7xxQtXnVXpM+N
         vdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fhtsshb779foHbUp9uRUsqpWENAGkHqJ8VEZb1EuPfo=;
        b=2iHNaXuu4QYi8Yb/KkK27D0VzB1jlGBXci/swfP+QLHeA0JhRfoacCtnZeV1AYHxnI
         TzcOGGwHWQUq8gIfQpRowUPJjv8ofjWwbUXC+7w9sXavqabPscnx1c6t/7dWcHouLVIW
         xYNGeU18ufwSKSCLFfCgKwr88jFXFitNcR1G+zaRrcxgll5dURxL8dHMH3Ey5Q6iDELB
         v0yYcbBh9SijzYL3rQemMkIrNao/l7k1Z9bxZGyzsWwTwXEPvRet6bseYuvrjIP1/ov2
         R3wCwMTo7nOsFA8fAuF3UHIOaXThywAu1SYQ4R2zAPkbmTq8WH/M7lfZfwoVGphuFbpT
         0+aw==
X-Gm-Message-State: AOAM530t2Ev44Cu1rfGW21Rev5FYpuMrvYLKBq8jnT2cZR6yYh7CkSLn
        owDn3dBRUnafer6A6xwc+CbeVg==
X-Google-Smtp-Source: ABdhPJwzCq8jLEnOzlYAwNNMmWDUPgFImKOrZBeA6SdytoLo6ELVLP75EnatTaR9PDXpvl3+Xr8fRg==
X-Received: by 2002:a17:902:b189:b0:143:8079:3d3b with SMTP id s9-20020a170902b18900b0014380793d3bmr30164103plr.71.1642552467215;
        Tue, 18 Jan 2022 16:34:27 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a20sm9680713pfv.122.2022.01.18.16.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 16:34:26 -0800 (PST)
Date:   Wed, 19 Jan 2022 00:34:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] KVM: x86: Remove WARN_ON in
 kvm_arch_check_processor_compat
Message-ID: <YedcjqmGYekhPgec@google.com>
References: <20211227081515.2088920-1-chao.gao@intel.com>
 <20211227081515.2088920-6-chao.gao@intel.com>
 <Ydy6aIyI3jFQvF0O@google.com>
 <BN9PR11MB5276DEA925C72AF585E7472C8C519@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Yd3fFxg3IjWPUIqH@google.com>
 <20220112110000.GA10249@gao-cwp>
 <Yd8RUJ6YpQrpe4Zf@google.com>
 <20220117133503.GA27833@gao-cwp>
 <20220117134608.GA30004@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117134608.GA30004@gao-cwp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022, Chao Gao wrote:
> On Mon, Jan 17, 2022 at 09:35:04PM +0800, Chao Gao wrote:
> >OK. How about:
> >
> >	/*
> >	 * Compatibility checks are done when loading KVM or in KVM's CPU
> >	 * hotplug callback. It ensures all online CPUs are compatible before
> >	 * running any vCPUs. For other cases, compatibility checks are
> >	 * unnecessary or even problematic. Try to detect improper usages here.
> >	 */
> >	WARN_ON(!irqs_disabled() && !cpu_active(smp_processor_id()));
> 
> Sorry. It should be:
> 	WARN_ON(!irqs_disabled() && cpu_active(smp_processor_id()));

Nice!  That's exactly what I was hoping we could do.
