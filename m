Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76864D776E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 19:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiCMSGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 14:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiCMSGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 14:06:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E697779384
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 11:05:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bg10so29432565ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 11:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ba/SyefjHkKlZlkknq5QxkIEqcl/0Yy/G2fW6GbUc1w=;
        b=XaW39Az9MYtw5O/zqYNHeKLzkvbfNfOkx9ZZ2y6fhzja3ETHuBzJs9KuXun/GcdMQZ
         7y5EzbmzA9Zmra2huedlDvhXwL4MkNBCaSWlvPLaZavJuC4VbH4Tv8+GdhqBASDlLObK
         UJXqGcdLOVg7DK7vstMaUjouuF+NsyAiO+/8cmvO6XovJW52+Cs4f64wVAwkKi1OXgUf
         7rGD2c6Qddin/zHAyoNDgem9n7JRyrgZm2+QEqIL1Hn2SsCHT9IzuNAmc+DZD7YbKzM4
         ZPmDCA6TNljX6U5sBb7bkc6sDzhFacvNdZA19W2Q1bm4BrI3a3UuZY1cl062yRxVy68G
         LRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ba/SyefjHkKlZlkknq5QxkIEqcl/0Yy/G2fW6GbUc1w=;
        b=0DCRVqXNEFqlT/fxYeBzV+4WFN+U2Qn/LhGN2YbXvhNmBHlT/iOh8emhxFoEY4SUYU
         ZlFZBYDooyXSqldlaODcM/RBROvNPneQM4x2iENQyV7kRS3mMqxQXx/KIZvHkESZVinG
         ndntJRR2vQgQ6hGP9v9Mg8jh7YFPDHDotUTof9Mr9h08/JRgae1xugsrj6DwU0Pmy7Hz
         nUAwxSP8nBAY8Gtd3AtynvBkcKr0FRw083WIY0ldAbndrsEdWhAsFQBYKsAZNIDpqTxA
         v5DQPLapnwbKHV9pPcHjoq/oh2ZJns/wNM/hqlu5Vqjlb8B48V3eZ1O27POvDi2l3dKO
         r6ng==
X-Gm-Message-State: AOAM533g5gHs7z0c+r0js/k1SEIpghUJEy2i+FvoNJzrbxQjT4zYrW5E
        si3c6tTCL1fuBbQYVmxUbw==
X-Google-Smtp-Source: ABdhPJznc5zEXT/NucxDl2fAOK09BwcM+HPBAE3BpHDEd/3ZIrj6FFdri5Yl35phLsPRbq35yPlo0Q==
X-Received: by 2002:a17:906:6a02:b0:6d7:cda:2cf7 with SMTP id qw2-20020a1709066a0200b006d70cda2cf7mr15818319ejc.53.1647194738396;
        Sun, 13 Mar 2022 11:05:38 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.141])
        by smtp.gmail.com with ESMTPSA id n15-20020a05640206cf00b0041655b577f1sm6769345edy.25.2022.03.13.11.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 11:05:37 -0700 (PDT)
Date:   Sun, 13 Mar 2022 21:05:35 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] x86/alternative: record .altinstructions section
 entity size
Message-ID: <Yi4ybwog/H4gk5Ts@localhost.localdomain>
References: <20220311144312.88466-1-adobriyan@gmail.com>
 <20220311144312.88466-3-adobriyan@gmail.com>
 <20220312211740.GG28057@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220312211740.GG28057@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 10:17:40PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 11, 2022 at 05:43:10PM +0300, Alexey Dobriyan wrote:
> > .altinstructions entry was 12 bytes in size, then it was 13 bytes,
> > now it is 12 again. It was 24 bytes on some distros as well.
> > Record this information as section sh_entsize value so that tools
> > which parse .altinstructions have easier time.
> 
> Which tools would that be? Because afaict you've not actually updated
> objtool.

We parse .altinstructions to look for "dangerous" functions so that we
don't unpatch when a process is sleeping in a userspace pagefault caused
by such function. Defining .sh_entsize will simplify this process in the future.
Now that padding issues have been solved, "struct alt_instr" should be
stable and sizeof should be enough to tell one layout from another.

> > --- a/arch/x86/include/asm/alternative.h
> > +++ b/arch/x86/include/asm/alternative.h
> > @@ -9,6 +9,8 @@
> >  #define ALTINSTR_FLAG_INV	(1 << 15)
> >  #define ALT_NOT(feat)		((feat) | ALTINSTR_FLAG_INV)
> >  
> > +#define sizeof_struct_alt_instr 12
> > +
> >  #ifndef __ASSEMBLY__
> >  
> >  #include <linux/stddef.h>
> > @@ -66,6 +68,7 @@ struct alt_instr {
> >  	u8  instrlen;		/* length of original instruction */
> >  	u8  replacementlen;	/* length of new instruction */
> >  } __packed;
> > +_Static_assert(sizeof(struct alt_instr) == sizeof_struct_alt_instr, "");
> 
> Would it not be much simpler to have this in asm-offsets.h ?

I tried this and failed. alternative.h is getting included and
preprocessed before asm-offsets.c is generated so there are lines like

	#define 12 12

and it doesn't work.

> > +	".pushsection .altinstructions,\"aM\",@progbits," __stringify(sizeof_struct_alt_instr) "\n"\
> > +	".pushsection .altinstructions,\"aM\",@progbits," __stringify(sizeof_struct_alt_instr) "\n"\
> > +	".pushsection .altinstructions,\"aM\",@progbits," __stringify(sizeof_struct_alt_instr) "\n"\
> 
> > +	.pushsection .altinstructions,"aM",@progbits,sizeof_struct_alt_instr
> > +	.pushsection .altinstructions,"aM",@progbits,sizeof_struct_alt_instr
> 
> Aside of adding entsize, you're also adding the M(ergable) bit. Also,
> those lines are on the unwieldy side of things.

binutils doc says

	https://sourceware.org/binutils/docs/as/Section.html

	If flags contains the M symbol then the type argument must be specified as well as an extra argument—entsize—like this:

	.section name , "flags"M, @type, entsize

	Sections with the M flag but not S flag must contain fixed size constants,
	each entsize octets long. Sections with both M and S must contain zero
	terminated strings where each character is entsize bytes long. The linker
	may remove duplicates within sections with the same name, same entity size
	and same flags. entsize must be an absolute expression. For sections with
	both M and S, a string which is a suffix of a larger string is considered
	a duplicate. Thus "def" will be merged with "abcdef"; A reference to the
	first "def" will be changed to a reference to "abcdef"+3.

"a"M doesn't work, but "aM" does.

I don't know if merging is the issue, it is not like alt replacements have names.
