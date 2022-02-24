Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A66C4C39BD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbiBXXiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiBXXiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:38:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E52F165C24
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645745857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DS9GbFQPq6tT/AziBO1ezm5qGsFL1mRocjkn+iaYZvY=;
        b=XZOyvw+/MQv0tkE520B9eCn5VayOBejTPpK4jnGIZfoxkhi1Zk6TRXN1cB/1ULCrVGKiZT
        V5ffDKfYyxfjFC3zs2GdCLFe2iQNuF/fuEkQ+EdfvMkGgAKywYQAgALd1ap6E5H0aj+IVx
        RLjKFLC0xTRFsyUKycdKM53JCKsmRlg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-BO2lcBEkOfqwF8hhqne1DQ-1; Thu, 24 Feb 2022 18:37:36 -0500
X-MC-Unique: BO2lcBEkOfqwF8hhqne1DQ-1
Received: by mail-qk1-f200.google.com with SMTP id k23-20020a05620a139700b0062cda5c6cecso4168270qki.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DS9GbFQPq6tT/AziBO1ezm5qGsFL1mRocjkn+iaYZvY=;
        b=E1E8U5ABcFWmk37pAJw93CDfDWZ7kjPowjjrgXesTsX973IXOz/BlZcJWWaFuoqc8w
         iyv5yeDINXD2NOAQa//8faEj/GMnY4WkkcluAtrvOL1gA2Tr29BA/G6dbxeFLbgSNYg0
         /Mf8Guw7bw7C9BSzoQOk1b05LcvYV0aKm5iFxaJxu/nKR44dm+Rw+HnNcZ4fn4G1Tec6
         yN3O41JA6SFYo+YgM0EmfRiBfBHOixyir7jCiMhtDhrnsFSpsGq5kPhw2TuRK8DQ4zOS
         I6dgcJEdvfr4kYpZU9WHpSDYGcvj/2LVUrGLDZQQE7YsA9RV7rXFk41XY63q1zHxrDue
         9Vbg==
X-Gm-Message-State: AOAM532YIITyWR5hyul/qlJWlxsWy1NZeClLsO5HyJ6yNLxz8I8ytkCG
        6yAwy0pJgE5J3gS6VIxvZ3iRUY61VKtuHplDhYzj8Dx1X8i+ENWLqZwBYWX6QgBbDH0rLk+LnZS
        97Nxhdk5xLYGUO8ODZW/rP8S7
X-Received: by 2002:ac8:688f:0:b0:2d2:966c:cdf1 with SMTP id m15-20020ac8688f000000b002d2966ccdf1mr4746512qtq.368.1645745855602;
        Thu, 24 Feb 2022 15:37:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzx26JczMaAu2PUDcFP/nQzk4986greeN2RcJxMQKLKriKAmSRtLnDTBExnPkZL1rJm+i8slw==
X-Received: by 2002:ac8:688f:0:b0:2d2:966c:cdf1 with SMTP id m15-20020ac8688f000000b002d2966ccdf1mr4746489qtq.368.1645745855395;
        Thu, 24 Feb 2022 15:37:35 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id p25-20020a05620a057900b005f1928e8cd0sm453253qkp.134.2022.02.24.15.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 15:37:34 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:37:31 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 16/39] x86/bpf: Add ENDBR instructions to prologue and
 trampoline
Message-ID: <20220224233731.7hdwbszv5c6fgx4y@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.950111925@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224151322.950111925@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:54PM +0100, Peter Zijlstra wrote:
> @@ -339,9 +350,18 @@ static int __bpf_arch_text_poke(void *ip
>  	u8 *prog;
>  	int ret;
>  
> +#ifdef CONFIG_X86_KERNEL_IBT
> +	if (is_endbr(*(u32 *)ip))
> +		ip += 4;
> +#endif
> +
>  	memcpy(old_insn, nop_insn, X86_PATCH_SIZE);
>  	if (old_addr) {
>  		prog = old_insn;
> +#ifdef CONFIG_X86_KERNEL_IBT
> +		if (is_endbr(*(u32 *)old_addr))
> +			old_addr += 4;
> +#endif
>  		ret = t == BPF_MOD_CALL ?
>  		      emit_call(&prog, old_addr, ip) :
>  		      emit_jump(&prog, old_addr, ip);
> @@ -352,6 +372,10 @@ static int __bpf_arch_text_poke(void *ip
>  	memcpy(new_insn, nop_insn, X86_PATCH_SIZE);
>  	if (new_addr) {
>  		prog = new_insn;
> +#ifdef CONFIG_X86_KERNEL_IBT
> +		if (is_endbr(*(u32 *)new_addr))
> +			new_addr += 4;
> +#endif

All the above ifdef-itis should be able to be removed since is_endbr()
returns false for !IBT.

>  		ret = t == BPF_MOD_CALL ?
>  		      emit_call(&prog, new_addr, ip) :
>  		      emit_jump(&prog, new_addr, ip);
> @@ -2028,10 +2052,11 @@ int arch_prepare_bpf_trampoline(struct b
>  		/* skip patched call instruction and point orig_call to actual
>  		 * body of the kernel function.
>  		 */
> -		orig_call += X86_PATCH_SIZE;
> +		orig_call += X86_PATCH_SIZE + 4*HAS_KERNEL_IBT;

All the "4*HAS_KERNEL_IBT" everywhere is cute, but you might as well
just have IBT_ENDBR_SIZE (here and in other patches).

-- 
Josh

