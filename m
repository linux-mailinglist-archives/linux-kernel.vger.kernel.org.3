Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4D55ABDA3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 09:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiICHSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 03:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiICHSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 03:18:49 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E03D99E8
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 00:18:48 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h188so3762044pgc.12
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 00:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SHiiav/UTzP3n773mJagoVt2o/t4dOU1H79RijaCaHU=;
        b=AskGi2axoxsEY7KBMXI29CjNbAw+cxBhimz+Uws86axHbnwkRzVkZm0D1J5APPX1zH
         RE63qqDfrdaIRKvGYkOK9sQyFnbW82CNfeKcNNVKRsuR6HwoHzDihm8NXT8SAX1B+tKM
         ROhbgkgg/KN32vOURtYpeFrRIqnmAQkrQ4fYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SHiiav/UTzP3n773mJagoVt2o/t4dOU1H79RijaCaHU=;
        b=vmIioGDKc+35ZaJXOqfp1kZRTmWXFMekFV6r0jrr5wzitp22+CFPW7oSHJfXN10vl+
         nT/NbNbo2Xx8J7PiMpHT/r1hI/AIZr9KZ5C63ExPG/5PSi0R/5nxKyxbBWItjcKCJHo+
         H6jXe6IDBz2vI7/hZA6ZkiVbWbpG6CI2xYbew+OdmiXAKXGwH65QjTYpl0Td9HXP2Kce
         yar9f6aaTVNwIy8rLxtYVy/gHGzJuNwWSPV1Mf+YeSLiAmSmduthRjTmCgmu7R3StIs0
         C5X5X8OsIxbJWULuMc2WjAickL5eoKJB+dYEOkUhunKWKImmO8FHCXqRPiE7/rFzqnMG
         MaWg==
X-Gm-Message-State: ACgBeo3h4Bzp+A9DBTXxWoWeDeUK5AZsnRe6PuAGQv+AYQmVlRJOYCqW
        x+3a8m0CV9h3iDlg0BO3RJdmjw==
X-Google-Smtp-Source: AA6agR7is3qPx2jzNtjCUYC08MYC3I8gIVe9jpfazv4o1qlzZaJVGogtiDukY6sKPz49eksygDlzsg==
X-Received: by 2002:a63:8bc3:0:b0:42b:1bd2:9a6d with SMTP id j186-20020a638bc3000000b0042b1bd29a6dmr31887720pge.503.1662189528295;
        Sat, 03 Sep 2022 00:18:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e24-20020a63f558000000b0042c5a1715d7sm2519864pgk.83.2022.09.03.00.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 00:18:47 -0700 (PDT)
Date:   Sat, 3 Sep 2022 00:18:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/paravirt: add extra clobbers with
 ZERO_CALL_USED_REGS enabled
Message-ID: <202209022251.B14BD50B29@keescook>
References: <20220902213750.1124421-1-morbo@google.com>
 <20220902213750.1124421-3-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902213750.1124421-3-morbo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 09:37:50PM +0000, Bill Wendling wrote:
> [...]
>         callq   *pv_ops+536(%rip)

Do you know which pv_ops function is this? I can't figure out where
pte_offset_kernel() gets converted into a pv_ops call....

> [...]
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -414,8 +414,17 @@ int paravirt_disable_iospace(void);
>  				"=c" (__ecx)
>  #define PVOP_CALL_CLOBBERS	PVOP_VCALL_CLOBBERS, "=a" (__eax)
>  
> -/* void functions are still allowed [re]ax for scratch */
> +/*
> + * void functions are still allowed [re]ax for scratch.
> + *
> + * The ZERO_CALL_USED REGS feature may end up zeroing out callee-saved
> + * registers. Make sure we model this with the appropriate clobbers.
> + */
> +#ifdef CONFIG_ZERO_CALL_USED_REGS
> +#define PVOP_VCALLEE_CLOBBERS	"=a" (__eax), PVOP_VCALL_CLOBBERS
> +#else
>  #define PVOP_VCALLEE_CLOBBERS	"=a" (__eax)
> +#endif
>  #define PVOP_CALLEE_CLOBBERS	PVOP_VCALLEE_CLOBBERS

I don't think this should depend on CONFIG_ZERO_CALL_USED_REGS; it should
always be present.

I've only been looking at this just now, so many I'm missing
something. The callee clobbers are for functions with return values,
yes?

For example, 32-bit has to manually deal with doing a 64-bit value return,
and even got it wrong originally, fixing it in commit 0eb592dbba40
("x86/paravirt: return full 64-bit result"), with:

-#define PVOP_VCALLEE_CLOBBERS          "=a" (__eax)
+#define PVOP_VCALLEE_CLOBBERS          "=a" (__eax), "=d" (__edx)

But the naming is confusing, since these aren't actually clobbers,
they're input constraints marked as clobbers (the "=" modifier).

Regardless, the note in the comments ...

 ...
 * However, x86_64 also have to clobber all caller saved registers, which
 * unfortunately, are quite a bit (r8 - r11)
 ...

... would indicate that ALL the function argument registers need to be
marked as clobbers (i.e. the compiler can't figure this out on its own).

I was going to say it seems like they're missing from EXTRA_CLOBBERS,
but it's not used with any of the macros using PVOP_VCALLEE_CLOBBERS,
and then I saw the weird alternatives patching that encodes the clobbers
a second time (CLBR_ANY vs CLBR_RET_REG) via:

#define _paravirt_alt(insn_string, type, clobber)       \
        "771:\n\t" insn_string "\n" "772:\n"            \
        ".pushsection .parainstructions,\"a\"\n"        \
        _ASM_ALIGN "\n"                                 \
        _ASM_PTR " 771b\n"                              \
        "  .byte " type "\n"                            \
        "  .byte 772b-771b\n"                           \
        "  .short " clobber "\n"                        \
        ".popsection\n"

And after reading the alternatives patching code which parses this via
the following struct:

/* These all sit in the .parainstructions section to tell us what to patch. */
struct paravirt_patch_site {
        u8 *instr;              /* original instructions */
        u8 type;                /* type of this instruction */
        u8 len;                 /* length of original instruction */
};

... I see it _doesn't use the clobbers_ at all! *head explode* I found
that removal in commit 27876f3882fd ("x86/paravirt: Remove clobbers from
struct paravirt_patch_site")

So, I guess the CLBR_* can all be entirely removed. But back to my other
train of thought...

It seems like all the input registers need to be explicitly listed in
the PVOP_VCALLEE_CLOBBERS list (as you have), but likely should be done
unconditionally and for 32-bit as well.

-Kees

(Also, please CC linux-hardening@vger.kernel.org.)

-- 
Kees Cook
