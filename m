Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7064DA8B4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 04:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353404AbiCPDBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 23:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiCPDBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F21AE5D669
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647399590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vp8vCmT/9skOh/MpJw3aTrXywH+A8zMZsHdxs+e7Dk8=;
        b=HZtl4vJkU994GqDKdHphcTsPuOI6rCTOC4JVeQ2khLtyQEM7haqUymDEp42Myhm1agQEnY
        MzTXXfa9+Ne21b/EElpyoP2/bvYu3LJcc1isHZl3v1fX+n11pM3Q50I2Mpcd5p09ojd+K4
        fF6qPZ0imCzbjMyjeVbWxNRWySNMhcw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-XnRYMgXMP5u2a5oxM5KHnA-1; Tue, 15 Mar 2022 22:59:48 -0400
X-MC-Unique: XnRYMgXMP5u2a5oxM5KHnA-1
Received: by mail-qt1-f198.google.com with SMTP id e28-20020ac8415c000000b002c5e43ca6b7so650879qtm.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vp8vCmT/9skOh/MpJw3aTrXywH+A8zMZsHdxs+e7Dk8=;
        b=CBBdKYq8Me7AtgtsAenund014wcDDcWeORUEmUv67lOUPvjI391WeBnr53ETn79vdh
         jigL0t5W97nv6RTGRi3JoBMKJlpiGG2nL4SGFwG5sgjdF1SIMQ3Utvt7c0arsklqhk9D
         ilI4S/rVdnUleezU+BE4fgMZ0LR+LuoqH+HQwhq/PMd+VGmktSjb4Tonq2Azb+d95Fzw
         07TpWP7rufOQ7l6lIf4elXOzba2XI5sXfPZJHPoTOqi6z57/IKV5EfchJQDzaXQ66Ocw
         b6+4yzmlC3TAwWnr9OCMp3K8RDDDYt0hPQAd0I+TWMICdJiEQDX1iYGuASnRkbP+dbyZ
         8AWQ==
X-Gm-Message-State: AOAM5328bvt4017nB85FFJffMMA4PfSqB10DcEJWpQmrf/Y8P7DDIEmL
        /6MMsV4RQb5Z8wk4GLn7DZ+52dKa9ecHNXDE4ZCiuaX8R6p9cwCfa1fpZeryDY4RyD7e2/oedgd
        kOmoF3yJWwg6G5o3L4nk3H2e5
X-Received: by 2002:a05:620a:46a0:b0:67d:8cda:1aa8 with SMTP id bq32-20020a05620a46a000b0067d8cda1aa8mr14217306qkb.144.1647399588110;
        Tue, 15 Mar 2022 19:59:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHV6AOdsY+t4RbCZkDAC8BegebuD2ZHj9GyAG2aJbuUknCMJFNsreBnPoCgadrR2ajXIClSQ==
X-Received: by 2002:a05:620a:46a0:b0:67d:8cda:1aa8 with SMTP id bq32-20020a05620a46a000b0067d8cda1aa8mr14217303qkb.144.1647399587830;
        Tue, 15 Mar 2022 19:59:47 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::48])
        by smtp.gmail.com with ESMTPSA id a10-20020a05622a02ca00b002e1ce9c91d1sm569720qtx.23.2022.03.15.19.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 19:59:47 -0700 (PDT)
Date:   Tue, 15 Mar 2022 19:59:43 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V3 6/7] x86/entry: Don't call error_entry for XENPV
Message-ID: <20220316025943.rktyfmkvkqz3utek@treble>
References: <20220315073949.7541-1-jiangshanlai@gmail.com>
 <20220315073949.7541-7-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220315073949.7541-7-jiangshanlai@gmail.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 03:39:48PM +0800, Lai Jiangshan wrote:
> +++ b/arch/x86/entry/entry_64.S
> @@ -328,8 +328,17 @@ SYM_CODE_END(ret_from_fork)
>  	PUSH_AND_CLEAR_REGS
>  	ENCODE_FRAME_POINTER
>  
> -	call	error_entry
> -	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
> +	/*
> +	 * Call error_entry and switch stack settled by sync_regs().
> +	 *
> +	 * When in XENPV, it is already in the task stack, and it can't fault
> +	 * for native_iret() nor native_load_gs_index() since XENPV uses its
> +	 * own pvops for iret and load_gs_index().  And it doesn't need to
> +	 * switch CR3.  So it can skip invoking error_entry().
> +	 */
> +	ALTERNATIVE "call error_entry; movq %rax, %rsp", \
> +		"", X86_FEATURE_XENPV
> +
>  	ENCODE_FRAME_POINTER
>  	UNWIND_HINT_REGS

The second ENCODE_FRAME_POINTER is only needed for the stack-switching
(non-XENPV) case.  The second UNWIND_HINT_REGS shouldn't be needed at
all, since the first one still applies after the call.

How about something more readable like this?

.macro idtentry_body cfunc has_error_code:req

	PUSH_AND_CLEAR_REGS
	ENCODE_FRAME_POINTER

#ifdef CONFIG_XEN_PV
	/*
	 * When in XENPV, it is already in the task stack, and it can't fault
	 * for native_iret() nor native_load_gs_index() since XENPV uses its
	 * own pvops for iret and load_gs_index().  And it doesn't need to
	 * switch CR3.  So it can skip invoking error_entry().
	 */
	ALTERNATIVE "", "jmp 1f", X86_FEATURE_XENPV
#endif

	call error_entry
	movq %rax, %rsp
	ENCODE_FRAME_POINTER
1:
	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/

-- 
Josh

