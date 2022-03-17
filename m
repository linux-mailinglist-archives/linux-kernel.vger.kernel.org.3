Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5725C4DD0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiCQWVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiCQWVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:21:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E78A817B8BB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647555589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hQGIwBER0m+3DWeFVm7NY1/fkMpgtqQj1Lt77v4lZ+w=;
        b=P0n0AFW0SxxAS4m62EH4G2hinxjlbWFRmAIBbkWw8TVb7Kfnd/Vm8qt5Vt1rFELY+l/sxI
        +AdS77ZBXQ76VgKgZQFGP2a11yxRq9Tws8nrewq4giwak5uHZLus/l3W0KmEIv02asqAOV
        IHYWpym1EHaI8F6/4WXfpj0eJxmldaE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-OwtwWL76M6m7tWuwXEC2AA-1; Thu, 17 Mar 2022 18:19:47 -0400
X-MC-Unique: OwtwWL76M6m7tWuwXEC2AA-1
Received: by mail-qk1-f197.google.com with SMTP id 195-20020a3707cc000000b0067b0c849285so4295166qkh.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQGIwBER0m+3DWeFVm7NY1/fkMpgtqQj1Lt77v4lZ+w=;
        b=X3+4FTybdJ1Ekrz0FHXHYkTQtDEL61i4pYKA0bcuFPAVndd57m98EuFAgIr5KRCYpz
         kLdEu1pOmbVGV8HP1qIpiz4INje5LU+uHomH2BJrcDZx/BH6DWVhVCjkZ21WXpZBShHZ
         gHa8vbZ24exKGDEHx1AFgwo4tFNqbAsMpZhLXK5ic3aKayDYUZa9vNimvx1Q01vG/xNV
         p1sluiOmhhFkmXOg5ir+873JEBfw4FPU56ZuvkD1SzT4pfmr6oSRjejggN3Ftn/7vX9j
         RL9lTn0u7l4ZJSHo00LyMSYzDERxh3KQS1ELcHxt0ZdeZJEX0MzcuL1qHZ0EmlYk2idY
         h86A==
X-Gm-Message-State: AOAM531/fUSe3dv++KrxTczYE1eMAgxt8IjQMJcANn6+QyQWmmYByjx2
        WA2lG1cLgD/4V+2rmLKdgefM0H6YK7fAZfYQf4LUj3KrHf0RY7zBSBK0JYh1LCBK2rWEDVpUp/8
        j70ZDInk3QZCpHilnjvf2EGEB
X-Received: by 2002:ac8:7c46:0:b0:2e1:d6c2:2b15 with SMTP id o6-20020ac87c46000000b002e1d6c22b15mr5537939qtv.405.1647555587303;
        Thu, 17 Mar 2022 15:19:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7ZexznbauwoFGulSphibHkdYv25hNa9G+dJs27LjUY/VCW+59JLVomIg/9lvgrDRIr7gW9w==
X-Received: by 2002:ac8:7c46:0:b0:2e1:d6c2:2b15 with SMTP id o6-20020ac87c46000000b002e1d6c22b15mr5537922qtv.405.1647555587028;
        Thu, 17 Mar 2022 15:19:47 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id p2-20020a05620a15e200b0067d2c0455bcsm2965460qkm.36.2022.03.17.15.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 15:19:46 -0700 (PDT)
Date:   Thu, 17 Mar 2022 15:19:43 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/sev: Add ENCODE_FRAME_POINTER after stack changed
 for #VC
Message-ID: <20220317221943.6vhoqx3fdv7py6hi@treble>
References: <20220316041612.71357-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220316041612.71357-1-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 12:16:12PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> In idtentry_vc(), the real frame is changed after it switches to new
> stack, ENCODE_FRAME_POINTER should be called in case for unwinder.
> 
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  arch/x86/entry/entry_64.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index e20eabaa56b8..f99f2881ed83 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -540,6 +540,7 @@ SYM_CODE_START(\asmsym)
>  	call	vc_switch_off_ist
>  	movq	%rax, %rsp		/* Switch to new stack */
>  
> +	ENCODE_FRAME_POINTER
>  	UNWIND_HINT_REGS
>  
>  	/* Update pt_regs */

Looks right to me.  Any chance you have the ability to test this
scenario by unwinding from #VC with CONFIG_FRAME_POINTER?

-- 
Josh

