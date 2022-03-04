Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066FB4CDBB1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbiCDSDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241468AbiCDSDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:03:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 317EFA9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646416945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jwMspaNRchzMEPn5JlJnpyUB+OOzsCuJrDrtcFfltU0=;
        b=FkAnvg/o4pOGhM722YvnjwWQQAID9apIHQQgun+rQMN4vp4cvoN1+g963U+xfwegtiZpIh
        LemFIY/jIOP1eCwQH4SJvvPTr6SfRi5xfmt5KIabI/fOwLaQw8RaDhOmzFPnDziKCdbiUd
        COkX3ftLDGYFvXllSVgax8AaBltFaZ8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-x9UyXWRnPsCeGYBUwqBxGA-1; Fri, 04 Mar 2022 13:02:24 -0500
X-MC-Unique: x9UyXWRnPsCeGYBUwqBxGA-1
Received: by mail-qv1-f71.google.com with SMTP id x16-20020a0ce250000000b00432ec6eaf85so7402862qvl.15
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jwMspaNRchzMEPn5JlJnpyUB+OOzsCuJrDrtcFfltU0=;
        b=dEaFalunFDNLNqI/dfn7N0YtUjJg2IRQbYG6UkJh/WUoUeSCRCGTCCPWC+0kmr7qoD
         n4x6CpigXNFWh+/IrTyp+bVuOeVzG28AFNeE7d5Wm8heMC9bGJb1cYS9MkOMmBBJBaQu
         AJc3NGTpjPJ+fpCuCY+N6xPJVzRP1+qaOcIr3f3ms9wcHZ9JKv2oTgY87zi1uDXtvBm8
         rPD59VB78PKQonfmzEsdw1Wd2NFuftPB4y7plC5K2MrzNg1bvedQmc1HwRBGV+uzkSCw
         3t6gNKCixbfqMuCpGUWEMMF5LGXqefKz4H5tAmFQKXewZo5TTZPLYJ0cE8nbG9mLgdRe
         EDKw==
X-Gm-Message-State: AOAM533o2zuQXy+pK7ryOwMQcRCu9Oo12M+5yecMe7z8PE6yTeDldVBK
        FaFDPxNtBf87MrBQfbPSHIA864BFATzzIMVlhGkBO9tYLtwFTd8Jr3T4GDi5OKJI7Ymx3Tbj1rB
        WMpkij3etLDVBLbUaya4g1jtf
X-Received: by 2002:a05:6214:16c1:b0:42b:f181:664c with SMTP id d1-20020a05621416c100b0042bf181664cmr29433724qvz.121.1646416943809;
        Fri, 04 Mar 2022 10:02:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6bf+tBF64junb2dRp6S4ZNxlqvhtDdM9ZUONJ1klEby09MSeLIEqY80ytWB5fEVODoCLn4A==
X-Received: by 2002:a05:6214:16c1:b0:42b:f181:664c with SMTP id d1-20020a05621416c100b0042bf181664cmr29433677qvz.121.1646416943401;
        Fri, 04 Mar 2022 10:02:23 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id c188-20020ae9edc5000000b0066269d5c3a7sm2741147qkg.53.2022.03.04.10.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:02:22 -0800 (PST)
Date:   Fri, 4 Mar 2022 10:02:19 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 23/39] x86/alternative: Simplify int3_selftest_ip
Message-ID: <20220304180219.hiyg2e6e6z76mfjz@treble>
References: <20220303112321.422525803@infradead.org>
 <20220303112826.360149715@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303112826.360149715@infradead.org>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 12:23:44PM +0100, Peter Zijlstra wrote:
> @@ -733,7 +733,7 @@ int3_exception_notify(struct notifier_bl
>  	if (val != DIE_INT3)
>  		return NOTIFY_DONE;
>  
> -	if (regs->ip - INT3_INSN_SIZE != int3_selftest_ip)
> +	if (regs->ip - INT3_INSN_SIZE != (unsigned long)&int3_selftest_ip)
>  		return NOTIFY_DONE;
>  
>  	int3_emulate_call(regs, (unsigned long)&int3_magic);
> @@ -757,14 +757,7 @@ static void __init int3_selftest(void)
>  	 * then trigger the INT3, padded with NOPs to match a CALL instruction
>  	 * length.
>  	 */
> -	asm volatile ("1: int3; nop; nop; nop; nop\n\t"
> -		      ".pushsection .init.data,\"aw\"\n\t"
> -		      ".align " __ASM_SEL(4, 8) "\n\t"
> -		      ".type int3_selftest_ip, @object\n\t"
> -		      ".size int3_selftest_ip, " __ASM_SEL(4, 8) "\n\t"
> -		      "int3_selftest_ip:\n\t"
> -		      __ASM_SEL(.long, .quad) " 1b\n\t"
> -		      ".popsection\n\t"
> +	asm volatile ("int3_selftest_ip: int3; nop; nop; nop; nop\n\t"
>  		      : ASM_CALL_CONSTRAINT
>  		      : __ASM_SEL_RAW(a, D) (&val)
>  		      : "memory");

Hm, why doesn't this need ANNOTATE_NOENDBR?

-- 
Josh

