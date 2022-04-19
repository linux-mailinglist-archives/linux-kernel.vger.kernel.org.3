Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD95F5071F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353912AbiDSPjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353862AbiDSPjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:39:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87B9814019
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650382588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2pbbOOrJklx/fDW+BkuKJc+aHfnpHjk4GxQKnI+JLOE=;
        b=QvBdiSWfRDviNZQuSx/1nQT7bshFYR4v23FMHVqybXXRux/76mi+8MD+r+1EG2s8UDwUAx
        jVGTCNnGJCj3p75KQkSTkS1x0eThLmujocfB7AnQ91ZjT7ScsuiaJ8zvXMfdjIuokB9EfY
        Ci/YxOINrIAiVHv4kiDEKU3FwFZzCNk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-p4JQuhhsMw2C1vGHD5SRQA-1; Tue, 19 Apr 2022 11:36:27 -0400
X-MC-Unique: p4JQuhhsMw2C1vGHD5SRQA-1
Received: by mail-qk1-f197.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so12666240qkb.23
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2pbbOOrJklx/fDW+BkuKJc+aHfnpHjk4GxQKnI+JLOE=;
        b=W//x/tVbLS0Nhh9qqac8Thj9ceUc3CfVSPiz7J7SMyvvOOvI7aO7z/lsJ2sid8oD2r
         4dqY0xiEIS+nArvCbfPZnpFqXr/kop2u/NsNH4FkkJroBJrkNZZDe3fPxd4G+vwAaU+q
         dNo+ibfPk3rA7J+H1NIaqae5tj0i2WwovKJTYH/1rz0uErpaelqBLlsy41lTmdgblA+a
         +cixn49uomRhnCgtMGo7k1rsa3XeDQ9TvvgwyTyyTftPoGapLLo0FUBcAPkgXXLRnWLa
         WKDwAorrq9KOeu8ZXuA3VVVBCHUzuP3CpaS2XsK77PWEW+DphRsFcIT3F6MkZBDyGFTX
         Afhg==
X-Gm-Message-State: AOAM531JeKMrabeEDy9jUTXeIajgQhTXcSMXiyeCV67wGn4KNGCdkTTk
        blgGi9yW5bnc7FXuuBipK6S9GuGDGBso6T6YpFFX47cYB/AI6BaKNbncwS+7R/wFsN6+uL0MKVS
        66jgjlB1palvGhVb28zOUOjvA
X-Received: by 2002:a05:6214:3e3:b0:444:3f84:d230 with SMTP id cf3-20020a05621403e300b004443f84d230mr12087243qvb.4.1650382586326;
        Tue, 19 Apr 2022 08:36:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMOClmzR+elD2Pg3WBKI9RDBasJsBUgkXTX8G4r7PgqpqnnBbMbq0goI+Nnk1MX0E/NeQyUw==
X-Received: by 2002:a05:6214:3e3:b0:444:3f84:d230 with SMTP id cf3-20020a05621403e300b004443f84d230mr12087229qvb.4.1650382586107;
        Tue, 19 Apr 2022 08:36:26 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id f21-20020a05620a409500b0069e88d91beesm168857qko.53.2022.04.19.08.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 08:36:25 -0700 (PDT)
Date:   Tue, 19 Apr 2022 08:36:22 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 00/25] objtool: Interface overhaul
Message-ID: <20220419153622.ydn6uurtaeencmol@treble>
References: <cover.1650300597.git.jpoimboe@redhat.com>
 <20220419115130.GT2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220419115130.GT2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 01:51:30PM +0200, Peter Zijlstra wrote:
> I've taken the liberty of reordering it slightly:
> 
>    objtool: Enable unreachable warnings for CLANG LTO
>    x86/static_call: Add ANNOTATE_NOENDBR to static call trampoline
>    x86/retpoline: Add ANNOTATE_ENDBR for retpolines
>    x86/uaccess: Add ENDBR to __put_user_nocheck*()
>    x86/xen: Add ANNOTATE_ENDBR to startup_xen()
>    objtool: Print data address for "!ENDBR" data warnings
>    objtool: Use offstr() to print address of missing ENDBR
> 
> Go into x86/urgent, and I've added Fixes: tags with various patches from
> the IBT series, and then the rest goes into objtool/core.
> 
> As already indicated, there's going to be a few merge conflicts against
> x86/core, but alas. Resolved as per the below.

Thanks!  I guess tip bot is broken?

>  -	$(if $(CONFIG_X86_SMAP), --uaccess)				\
>  +	--uaccess							\

Here we'll need HAVE_UACCESS_VALIDATION.  I'll work up a new patch for
that once your objtool/core changes go live (don't see them yet).

-- 
Josh

