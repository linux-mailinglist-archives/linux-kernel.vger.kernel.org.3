Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66744C3A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiBYAsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236137AbiBYAsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:48:08 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1488217B8A8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:47:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m22so3473252pja.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LyamL7TR0d5DBgnoX4hmrKIz1I7MdAv8R7y1lU7GQ3I=;
        b=lutr1bftG/+9JW7W8HJy7Tf1liVmGM6yhbcPKRFsR9sMV09amLSK55VUaxhf9psTzZ
         WDPcTqSVFbHcWgjJaSZmOwdDCESMlrqWqEinryV2o13VC2LS20SOHSu/MJtftm68RC2v
         GZl4luigP4ikNq3kiCYSFjj7tPGDFjANs8wU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LyamL7TR0d5DBgnoX4hmrKIz1I7MdAv8R7y1lU7GQ3I=;
        b=kM22rzglXxobA5F6lAdjoZeX+zB4nEBbAkxSgvMgVe3VGBjKzaWqPgfosm5FV9PDAT
         EI7cYSrXoxut6ZyLUdi2XFgHpCCe6htlJPQATZGkxUglyVj4sKtIyvfHlBunmZBxICZi
         bRpzbrfW2flRYjsZ374SPqyDnaV9OipFOwzFWoewTSj9Y+4JZABvYitx39UbXfF2ODJb
         7Bilp1t88OJZUGr40h9GMSidA0RaDzPMiONjSLoypZ0/Z1BsNF1sRzeZSEjhuecm6Qi7
         fjlJvQ7I1fn2pvzY3LYbrIJ38hBHtNrwwYnNCmOWpZGC8gzNIZ22EHAul5eHNHb681JX
         hCqA==
X-Gm-Message-State: AOAM530uffYZ9aUCofbqoDuO0NDFng8YquTvf4NtIWNHccpra6bemPON
        bAwt1e7aC1h3HKoRfTG8t54OGQ==
X-Google-Smtp-Source: ABdhPJzVpNWYSJZt8kCYNVp661j79wxnVokMWJzYh6kJt4qcYvk7xpZKDjDpUGv5t4mZBt2rNGoSTw==
X-Received: by 2002:a17:90a:4286:b0:1b8:8ba1:730c with SMTP id p6-20020a17090a428600b001b88ba1730cmr658354pjg.181.1645750056492;
        Thu, 24 Feb 2022 16:47:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k17-20020a056a00169100b004f3c2ac6600sm700213pfc.116.2022.02.24.16.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:47:36 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:47:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 09/39] x86/ibt,paravirt: Sprinkle ENDBR
Message-ID: <202202241645.49D0907077@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.539002964@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224151322.539002964@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:47PM +0100, Peter Zijlstra wrote:
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/entry_64.S                 |    1 +
>  arch/x86/include/asm/paravirt.h           |    1 +
>  arch/x86/include/asm/qspinlock_paravirt.h |    3 +++
>  arch/x86/kernel/kvm.c                     |    3 ++-
>  arch/x86/kernel/paravirt.c                |    2 ++
>  5 files changed, 9 insertions(+), 1 deletion(-)
> 
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -635,6 +635,7 @@ SYM_INNER_LABEL(restore_regs_and_return_
>  
>  SYM_INNER_LABEL_ALIGN(native_iret, SYM_L_GLOBAL)
>  	UNWIND_HINT_IRET_REGS
> +	ENDBR // paravirt_iret

If this is also setting the stage for finer grain CFI schemes, should
these macros instead be something more generically named? Like,
INDIRECT_ENTRY, or so? I imagine that'd avoid future churn, but maybe
I'm pre-optimizing... Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
