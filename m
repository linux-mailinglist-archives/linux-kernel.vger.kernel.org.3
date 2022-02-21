Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388414BDF83
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357536AbiBUOio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:38:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350689AbiBUOid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:38:33 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600E9205D2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:38:08 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id z66so11190324qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SQkkpjsX6TpHTIkwX4rlheMVKzlTSUCBOIkGIhUmEnk=;
        b=lFloJT5XTRR77kzfHXTKnbI4pb8ZRFszg5NJtpODh2xdLUe/I00E73ECSqJvCocxE2
         b91NgLxHbLq2mKguKL6+A8vg59eCEqgoc3DveKrETnDLj1w3kQOwUnqmAyyMEzwuyF++
         1oz4fM9tYT3W1pjPYzepabrJTciPcMKBtMn9aK5T3gg7gaxtxK3qGRDfcii8PSRqH1m5
         jTfcfIxVWzqsyre+F9ScBo3PJyTGXXcumCcPycf5oTgrENXqutdnUW36PETYhvnU0X6i
         kE5fYBI0/0sqdCVOLbEJmColObNXJPYvXf2JzQQK0cwu9DtCZ/5LkSqn+45P9FbV6RjB
         gqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SQkkpjsX6TpHTIkwX4rlheMVKzlTSUCBOIkGIhUmEnk=;
        b=Q4+vPdyV9fpi2+NZ5mGjsa2HOMv4HFMT5gGAYg5lap1gzEN2GRUkdPErzewtMKi5vB
         xo05kXqTNl52I6yGGvUXBCp9QInfMvi+M1c3ke36TfcLjEoqoo9rPw55yMqE35Vr+YxS
         cSmxHCFg9OiO0J94em92WASiqkxmxrs5cyOvNWz//EmvxOW8Xyw+31dQr+WD/q53Egpe
         KeIN/v24JAqqbVm1nyzCSG6EaE+m/WyefGn/itL1zivo5oqNlM/QN4RtpKvcl8QXELpl
         kPq4C/jmHDpqj8xucAxLP8M2OW9xRNKQJiHHm2ueDh8WqewyB+esmDZwKnSpLBjNb4hK
         oENQ==
X-Gm-Message-State: AOAM531Zw3YB0QBDWeVN6j3OSfK90qY44xRKzvWGQjBnC9fNlQjhW2FC
        ofzXNy4QrFnjqJhbF8dcxXY=
X-Google-Smtp-Source: ABdhPJxlKmrxFZuT/FAITTFKtimqCuPmpqJElllBfSaAREj/db8P6HZlcu9ug388nFgwdaclSsMcRA==
X-Received: by 2002:ae9:df42:0:b0:47e:fe7b:a202 with SMTP id t63-20020ae9df42000000b0047efe7ba202mr12266908qkf.256.1645454287319;
        Mon, 21 Feb 2022 06:38:07 -0800 (PST)
Received: from mail.google.com ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id bm8sm20942916qkb.25.2022.02.21.06.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:38:07 -0800 (PST)
Date:   Mon, 21 Feb 2022 22:37:58 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] kallsyms: ignore all local labels prefixed by '.L'
Message-ID: <20220221143758.7wln3mklyaj7mzod@mail.google.com>
References: <20220201013257.17926-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201013257.17926-1-changbin.du@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Masahiro,
Could you consider picking up this change if you have no objection?

On Tue, Feb 01, 2022 at 09:32:57AM +0800, Changbin Du wrote:
> The llvm compiler can generate lots of local labels ('.LBB', '.Ltmpxxx',
> '.L__unnamed_xx', etc.). These symbols usually are useless for debugging.
> And they might overlap with handwritten symbols.
> 
> Before this change, a dumpstack shows a local symbol for epc:
> [    0.040341][    T0] Hardware name: riscv-virtio,qemu (DT)
> [    0.040376][    T0] epc : .LBB6_14+0x22/0x6a
> [    0.040452][    T0]  ra : restore_all+0x12/0x6e
> 
> The simple solution is that we can ignore all local labels prefixed by '.L'.
> For handwritten symbols which need to be preserved should drop the '.L'
> prefix.
> 
> After this change, the C defined symbol is shown so we can locate the
> problematical code immediately:
> [    0.035795][    T0] Hardware name: riscv-virtio,qemu (DT)
> [    0.036332][    T0] epc : trace_hardirqs_on+0x54/0x13c
> [    0.036567][    T0]  ra : restore_all+0x12/0x6e
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  scripts/kallsyms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 54ad86d13784..8caabddf817c 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -108,7 +108,7 @@ static bool is_ignored_symbol(const char *name, char type)
>  	/* Symbol names that begin with the following are ignored.*/
>  	static const char * const ignored_prefixes[] = {
>  		"$",			/* local symbols for ARM, MIPS, etc. */
> -		".LASANPC",		/* s390 kasan local symbols */
> +		".L",			/* local labels, .LBB,.Ltmpxxx,.L__unnamed_xx,.LASANPC, etc. */
>  		"__crc_",		/* modversions */
>  		"__efistub_",		/* arm64 EFI stub namespace */
>  		"__kvm_nvhe_",		/* arm64 non-VHE KVM namespace */
> -- 
> 2.32.0
> 

-- 
Cheers,
Changbin Du
