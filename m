Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C734CDBD7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241541AbiCDSKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiCDSK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:10:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F1631C666E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646417380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yKdhHb9FA35X+M1Lm91uIQV6Ws1tPIj4ZRL2nNabFZs=;
        b=bZZiRAeB64xUlPso39DeiraoKf1CnPiAGgWlVlSuZ7ydxIj1UHntVnrP2JvpRKKN6EJ2E5
        9/WQyVwLp6rBHgemqmMR3u1KvKKFRh+Ux3TI4KFkyLAcKGE4c0faIAhPEg3ooyg+XHsXPl
        EbkfdLRWmGbWKmDyJqqz3Hp1Pdkm3OM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-kUzHWDbKOQC2czQtmhKqYw-1; Fri, 04 Mar 2022 13:09:39 -0500
X-MC-Unique: kUzHWDbKOQC2czQtmhKqYw-1
Received: by mail-qt1-f197.google.com with SMTP id r16-20020ac87950000000b002de06985208so6687170qtt.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yKdhHb9FA35X+M1Lm91uIQV6Ws1tPIj4ZRL2nNabFZs=;
        b=14U8E/nQUDKERJzZDVP+W062zn3gXrKs+O6b8gYSh/VgWGPiERPFBB+FJJrfQ6fzPA
         /t7seTJm7oU9t59lmVTBxunJCWCbw25yLsWc0LI/keIBYuvNw2ask7jA9jSvPgD+VVD1
         hnPTrflHddxk1CyVtIooWFjnQfVbuQQ1ECPyHww33XHa3HDGaxtmowQyCoytIskS9bfK
         f8YSdhsA1fa3EYPmxKQ2o/vc8w8fphwfADQitGTEDwpDKkudZMOSukalv8MA0WybJp1+
         /FG3tUI3B8f9XGAbvtIMwlARlsfaR565e8/OZIB/qB8wMnNIUcUD1NFcX9o+ARV/sHXM
         WkKw==
X-Gm-Message-State: AOAM531wSx9a/TdYlzZxVZTaq11ZhKmN8URgrBUSLHj98nBoJt6fKPRO
        SD8b5HDPzxtWKiVNpkZLKE2K440xD2+4TMBo0y8I8KJScr9ST8YpNhNp/4DZC2/tfOWDSgGQfnv
        /ZU5yNSty5zzYVBEnL9bPCslx
X-Received: by 2002:a37:9b0d:0:b0:46c:e3c1:71b7 with SMTP id d13-20020a379b0d000000b0046ce3c171b7mr3311775qke.626.1646417378500;
        Fri, 04 Mar 2022 10:09:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3rIvTYWiSWeZtTmfvdsBn5QrChThgTZvOdR/grLhqsNl2A275CWvNZ8ZgNNFgKiuEe01/TA==
X-Received: by 2002:a37:9b0d:0:b0:46c:e3c1:71b7 with SMTP id d13-20020a379b0d000000b0046ce3c171b7mr3311758qke.626.1646417378241;
        Fri, 04 Mar 2022 10:09:38 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id l19-20020a05622a175300b002de935a94c9sm3864924qtk.8.2022.03.04.10.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:09:37 -0800 (PST)
Date:   Fri, 4 Mar 2022 10:09:33 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 23/39] x86/alternative: Simplify int3_selftest_ip
Message-ID: <20220304180933.4byakmv7snrai7lh@treble>
References: <20220303112321.422525803@infradead.org>
 <20220303112826.360149715@infradead.org>
 <20220304180219.hiyg2e6e6z76mfjz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220304180219.hiyg2e6e6z76mfjz@treble>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 10:02:23AM -0800, Josh Poimboeuf wrote:
> On Thu, Mar 03, 2022 at 12:23:44PM +0100, Peter Zijlstra wrote:
> > @@ -733,7 +733,7 @@ int3_exception_notify(struct notifier_bl
> >  	if (val != DIE_INT3)
> >  		return NOTIFY_DONE;
> >  
> > -	if (regs->ip - INT3_INSN_SIZE != int3_selftest_ip)
> > +	if (regs->ip - INT3_INSN_SIZE != (unsigned long)&int3_selftest_ip)
> >  		return NOTIFY_DONE;
> >  
> >  	int3_emulate_call(regs, (unsigned long)&int3_magic);
> > @@ -757,14 +757,7 @@ static void __init int3_selftest(void)
> >  	 * then trigger the INT3, padded with NOPs to match a CALL instruction
> >  	 * length.
> >  	 */
> > -	asm volatile ("1: int3; nop; nop; nop; nop\n\t"
> > -		      ".pushsection .init.data,\"aw\"\n\t"
> > -		      ".align " __ASM_SEL(4, 8) "\n\t"
> > -		      ".type int3_selftest_ip, @object\n\t"
> > -		      ".size int3_selftest_ip, " __ASM_SEL(4, 8) "\n\t"
> > -		      "int3_selftest_ip:\n\t"
> > -		      __ASM_SEL(.long, .quad) " 1b\n\t"
> > -		      ".popsection\n\t"
> > +	asm volatile ("int3_selftest_ip: int3; nop; nop; nop; nop\n\t"
> >  		      : ASM_CALL_CONSTRAINT
> >  		      : __ASM_SEL_RAW(a, D) (&val)
> >  		      : "memory");
> 
> Hm, why doesn't this need ANNOTATE_NOENDBR?

Never mind, I see it's added later... though I still have the same
comment about the ANNOTATE_ENDBR coming after the label.

-- 
Josh

