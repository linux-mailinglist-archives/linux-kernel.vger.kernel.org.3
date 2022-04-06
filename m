Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBB04F6E10
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 00:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbiDFWxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 18:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbiDFWw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:52:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5E31FF40D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 15:50:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649285456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oo8BnTvTnMjo6ZgJBNScUqL3BREyI730+icd519jAck=;
        b=3B2xL2UxolikYO97tJGM0M7nLOAYdVh+LtA5JvD4+SbPbg/2hX+SlmV3iDVYi1CAPgOve6
        Rw0oOOlNFXGuRB/gr1zKkUFTdWgGU5k/YWA3yHpatMEYu+d8wYeGCe96jccznj/sasgvnK
        7478NR4ej+nSjs69DFm7hzrqba/lAxfp1YNNMLq5bqnjMDV/5kBqHV+1yRLVenarwQNJY8
        cBIKmEiut07UfCvi/mQfJarfkHJ3F9K6idK5cBW/CHcoV9wPVkwZWfvJUaXnpWY4swWkHn
        Y7ZF2bUw+UfXNp6PEdHQGHC91BBKzgkScA94n3b79LkBMRXjoJaXfilMcUGfYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649285456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oo8BnTvTnMjo6ZgJBNScUqL3BREyI730+icd519jAck=;
        b=d759eRy1EyZA+QNOtpkwGGzkMPjHlOzyeD2OaPS884TdJgwyjB0bsyScdrNnt+EdISZJxK
        eyBIJ1NW0EzyYIDg==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2] x86/apic: Do apic driver probe for "nosmp" use case
In-Reply-To: <20220406185430.552016-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220406185430.552016-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Thu, 07 Apr 2022 00:50:56 +0200
Message-ID: <87mtgxzuzz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06 2022 at 18:54, Kuppuswamy Sathyanarayanan wrote:
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index b70344bf6600..79b8b521981c 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -1419,22 +1419,22 @@ void __init apic_intr_mode_init(void)
>  		return;
>  	case APIC_VIRTUAL_WIRE:
>  		pr_info("APIC: Switch to virtual wire mode setup\n");
> -		default_setup_apic_routing();
>  		break;
>  	case APIC_VIRTUAL_WIRE_NO_CONFIG:
>  		pr_info("APIC: Switch to virtual wire mode setup with no configuration\n");
>  		upmode = true;
> -		default_setup_apic_routing();
>  		break;
>  	case APIC_SYMMETRIC_IO:
>  		pr_info("APIC: Switch to symmetric I/O mode setup\n");
> -		default_setup_apic_routing();
>  		break;
>  	case APIC_SYMMETRIC_IO_NO_ROUTING:
>  		pr_info("APIC: Switch to symmetric I/O mode setup in no SMP routine\n");
> +		upmode = true;

Why? The changelog tells nothing about this change.

And it's not correct because the APIC configuration is there, otherwise
__apic_intr_mode_select() would have returned APIC_VIRTUAL_WIRE_NO_CONFIG.

Thanks,

        tglx
