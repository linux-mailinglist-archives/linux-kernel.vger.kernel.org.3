Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A937F507F90
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359193AbiDTDYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbiDTDYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E5C021E13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650424889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vcScalISLTRGa9X7fknkSeaZRuC9IWrN8eSAEHhs9bA=;
        b=gXXzQZpXMFH6xIcMJCsXwew75khO5IGZVgqVp0nbzxJD7cKkbts96ViP3q14XPyEAKcnVM
        xs1MUbLUBmwvDKZUEwVwpQQFhlcp3CDyku1ZhLeDsMnf+LUW4bVGkuEbYM+lQkNb9iQJ0e
        xjPIsv+AKh3y7QXYTQqzl9kalESTf4I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-8us0FuqaMyu6M_q7H8XUbA-1; Tue, 19 Apr 2022 23:21:27 -0400
X-MC-Unique: 8us0FuqaMyu6M_q7H8XUbA-1
Received: by mail-qv1-f70.google.com with SMTP id j7-20020a05621419c700b004461f75de48so483640qvc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vcScalISLTRGa9X7fknkSeaZRuC9IWrN8eSAEHhs9bA=;
        b=poJv7rQUdFeBX/3muDnG+dp7l/5TsiYomMrJ/1Ps+q2fx69Au9OT03FBl5i6YzPheW
         Z65gYCCfEk1E77vK06k9G8xKrYRbxCFO2dtAt5xIYsNDoiH8JKEbifu+sc+qhXadsAlg
         IF0Sb2AOvTIlimrk2KD7uujo569xoXcSNxrC5qP+ZFBZe5M/Ji1nXTHpZy2I0U8KMZgr
         hrtT9POgKkPr07V94CmcICx+Oyituj/0nHH9uMySap19kr8u68Dyd10b9B6sRUWEmT7T
         /fEdu34XMHZmhuIeLZEOmjZxJEBrcy8kcVpC078Yw4M7jGH6mXU0TRHm8StyhUCckubo
         dtVQ==
X-Gm-Message-State: AOAM532jvN4Ghfx9Sn9zxAmIGihk7HlNaWLH0QjQz2Bi4g2nkpIwg5lB
        lLb6gTx5vp/OPBd5SU3Ljpf2whYf7JvfutxlwjZhL1FnjsDTFt10ezWDEYILtlnV53wQffi71rD
        B1a2rwpocVqFCtZUUmgdg4HNC
X-Received: by 2002:a05:620a:c4f:b0:67d:4996:fd8 with SMTP id u15-20020a05620a0c4f00b0067d49960fd8mr10966321qki.518.1650424887530;
        Tue, 19 Apr 2022 20:21:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwf9TgIBGfQ61bSK7TMu6W+TVh8+OH5QstSpLQUA7x/OJ4zbQO9n0e0yirFEQ/1mEx9BdnT1A==
X-Received: by 2002:a05:620a:c4f:b0:67d:4996:fd8 with SMTP id u15-20020a05620a0c4f00b0067d49960fd8mr10966309qki.518.1650424887306;
        Tue, 19 Apr 2022 20:21:27 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id o6-20020a05622a044600b002e1b9be8e6fsm1060745qtx.36.2022.04.19.20.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 20:21:26 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:21:23 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/2] x86,entry: Use PUSH_AND_CLEAR_REGS for compat
Message-ID: <20220420032123.6c344rjr4poockjr@treble>
References: <20220419204109.520779286@infradead.org>
 <20220419205241.339242797@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220419205241.339242797@infradead.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:41:11PM +0200, Peter Zijlstra wrote:
> Since the upper regs don't exist for ia32 code, preserving them
> doesn't hurt and it simplifies the code.

But an attacker can still control those registers, so clearing them on
the stack is better, as it reduces user control over the kernel stack.

64-bit syscalls *do* have to save those registers to the stack, so
whether it truly matters if compat mode is made equally insecure, I
can't say.  But without evidence to the contrary, my feeling is that we
should err on the side of caution.

-- 
Josh

