Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF394C592C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 04:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiB0Dq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 22:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiB0Dq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 22:46:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F5E415A21A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 19:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645933579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x4aUECtApTLi7IbtfqOlybU7z4gHNVfRQbILL6yC8Y4=;
        b=LiZ8z1xogaVCTLWSDRpFJWqAcrLxQLsVAR3X1iLxadUhnwumlVsKcSHdC3eOGCGKAIklFL
        pCHlYrUuDi7WoMTi32VmMRaGKn6Qw85JTDqr9ohtcc8PwfP92BGTGF6YhvwLRq2hGBH84B
        UmBsRpbTvXmo2wwutVmHBk/roVaTJg0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-N6gIEN0dPUOkfKXG6QE0RA-1; Sat, 26 Feb 2022 22:46:18 -0500
X-MC-Unique: N6gIEN0dPUOkfKXG6QE0RA-1
Received: by mail-qv1-f72.google.com with SMTP id p12-20020a0c9a0c000000b0043299cbbd36so7968949qvd.16
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 19:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x4aUECtApTLi7IbtfqOlybU7z4gHNVfRQbILL6yC8Y4=;
        b=bK2LcNVzI6ald6mVabVPB9d+3eLiq3o+VGJdR4eCkfBiummL3e6yGTrp0MNpF3HbSw
         Zi8+sXRL1bZzKYex1l+kQt1ilYMfGvfC8QV++8uv+ZoFyzGDogoNg2WZZffmhqhmN6QS
         cxRyb0bKHWK6vcol8m/s8LTqfZhPrJn3SeAa87FsksuFU1hT1PrLOpPUqVSKVDCf1VrC
         zsOM+OC0RQND0T3lfs+xo7QcEkcI5VA27cObF8aI5kTUBsz5/feYoeA58QKkzNW83rof
         yGsDVI327qi5Vnila/UKS9CxTuqSDQRm3pDSunPM52in6r2m7QNzbaNjjLml+zJdjppJ
         aPSA==
X-Gm-Message-State: AOAM5320MiaYYe5sZDQpYYDIBfkEOFA6huvOrgGB3ABEeRX9CLxqH9/J
        fp630RY/+yEC1RCcPeR1tipqJFzFP3ppJH6bk93nkUvVk91kJIoIi7g4Vcs6SNBfS+1hlX7yyTX
        h3CRrCySfhbsjz2W7wUMvZuz3
X-Received: by 2002:a37:6c46:0:b0:60d:d526:7e48 with SMTP id h67-20020a376c46000000b0060dd5267e48mr8383221qkc.451.1645933577816;
        Sat, 26 Feb 2022 19:46:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmulbgIVrRKcenwAVeb4ilrwV9QWME+f9gh1iW6Yi4dtzdtyj9DUkiObXUBa6l+cLU16Mgbg==
X-Received: by 2002:a37:6c46:0:b0:60d:d526:7e48 with SMTP id h67-20020a376c46000000b0060dd5267e48mr8383203qkc.451.1645933577554;
        Sat, 26 Feb 2022 19:46:17 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id h188-20020a376cc5000000b00648d7e2a36bsm3371502qkc.117.2022.02.26.19.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 19:46:17 -0800 (PST)
Date:   Sat, 26 Feb 2022 19:46:13 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 36/39] objtool: Find unused ENDBR instructions
Message-ID: <20220227034613.a5ejjey5agxlympd@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151324.137868984@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224151324.137868984@infradead.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:52:14PM +0100, Peter Zijlstra wrote:
> +#ifdef CONFIG_X86_KERNEL_IBT
> +	. = ALIGN(8);
> +	.ibt_endbr_sites : AT(ADDR(.ibt_endbr_sites) - LOAD_OFFSET) {
> +		__ibt_endbr_sites = .;
> +		*(.ibt_endbr_sites)
> +		__ibt_endbr_sites_end = .;
> +	}
> +#endif

".ibt_endbr_superfluous" maybe?  It's not *all* the endbr sites.

> +
>  	/*
>  	 * struct alt_inst entries. From the header (alternative.h):
>  	 * "Alternative instructions for different CPU types or capabilities"
> --- a/tools/objtool/builtin-check.c
> +++ b/tools/objtool/builtin-check.c
> @@ -21,7 +21,7 @@
>  
>  bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
>       lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
> -     ibt, ibt_fix_direct;
> +     ibt, ibt_fix_direct, ibt_seal;
>  
>  static const char * const check_usage[] = {
>  	"objtool check [<options>] file.o",
> @@ -50,6 +50,7 @@ const struct option check_options[] = {
>  	OPT_BOOLEAN(0, "dry-run", &dryrun, "don't write the modifications"),
>  	OPT_BOOLEAN(0, "ibt", &ibt, "validate ENDBR placement"),
>  	OPT_BOOLEAN(0, "ibt-fix-direct", &ibt_fix_direct, "fixup direct jmp/call to ENDBR"),
> +	OPT_BOOLEAN(0, "ibt-seal", &ibt_seal, "list superfluous ENDBR instructions"),

s/list/annotate/ ?

Not sure "ibt-seal" is the appropriate name since the "seal" is done at
boot time.

Do we really need a separate option anyway?  To get the full benefits of
IBT you might as well enable it...  And always enabling it helps flush
out bugs quicker.

-- 
Josh

