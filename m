Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46BD5B249C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiIHR1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiIHR0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:26:19 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874185FAE7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:25:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e5so791287pfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=7IqgCAbBltCgwXLRh/YGIeJJalN5os7YVeD7L2fO/30=;
        b=PQfW0BWqmSmYQkMR4MEBAgJeHxrnoQWDet2shcfdkN9DYclMzFsIMWu8BDMV9FcV0Y
         mbCaRLcfR8qfuM4pOX6bV/naG6eDMb/1XCxOLiZkD658wnF6xVtRkrywFaMVmkIFisJW
         FDM9H84/VjUH/TRTYVHq43wC54n/Q39N/aspB2cDdYhBJOukomNXpvuHoccq1ZTf7Rj5
         ZGCrNuR0hLsCL9sePunVJcAZUVVT9El8dkF4d78JhRcFq28BwwXwYP95mD1HeC6garQw
         wIHT+/jGOAf/HA1XpxbiV69AEULYFwyUtgChFti/xpDb/xJq3601LA26BJJ2e74j0OKq
         YN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7IqgCAbBltCgwXLRh/YGIeJJalN5os7YVeD7L2fO/30=;
        b=Y78vi428Ak71PjhMxVjqfaq+GFD/VHugnuAvcWqK0A3ldm+QdKhNT8L/YoBxWl53Kh
         iYdxo400D+KkiwQqkkQTQR7VjB24gqcE6cxaLFtDoWPi8HcB0MrE1QIbyDDlfSIQClQd
         9KHBPLCh6cB7t9XgaLA7J76ZZkGfg6ZaygBNRnxs0cGLJi0hbUG3NKJLRJEkdvIRZr5l
         VZSUvXPwRJF9DrqaPvhnppJhvXmyiW/ZXuNFYkdGkqDGlo9csr2smpZGQCWyv7Op0t58
         ghl2wL8wBw9ne2EXovYhh8oSjk9GA+U8wVEBMAly5sQnlAow2fIQBgmgwuNYUAOPJJLc
         RCNA==
X-Gm-Message-State: ACgBeo3bR5Da/oRnv+5oyQ3QiUcDlRVVXPiYACl03P8nkPP4aUdSKhKE
        C5huYsc4+6qHREaB8McwFsLuBg==
X-Google-Smtp-Source: AA6agR7jDw1++R0RS0tvY4MCiKwZ1yRMzWCXkmjqDMTya/Z9SYJ1nLYVD2hrsj4IFfb5LK+GdZGiaA==
X-Received: by 2002:a05:6a00:23c1:b0:52e:28f5:4e13 with SMTP id g1-20020a056a0023c100b0052e28f54e13mr9941256pfc.20.1662657931234;
        Thu, 08 Sep 2022 10:25:31 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b0016f196209c9sm14816331plg.123.2022.09.08.10.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 10:25:30 -0700 (PDT)
Date:   Thu, 8 Sep 2022 17:25:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM/VMX: Do not declare vmread_error asmlinkage
Message-ID: <Yxolh+QhLocER0oY@google.com>
References: <20220817144045.3206-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817144045.3206-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022, Uros Bizjak wrote:
> There is no need to declare vmread_error asmlinkage, its arguments
> can be passed via registers for both, 32-bit and 64-bit targets.
> Function argument registers are considered call-clobbered registers,
> they are saved in the trampoline just before the function call and
> restored afterwards.
> 
> Note that asmlinkage and __attribute__((regparm(0))) have no effect
> on 64-bit targets. The trampoline is called from the assembler glue
> code that implements its own stack-passing function calling convention,
> so the attribute on the trampoline declaration does not change anything
> for 64-bit as well as 32-bit targets. We can declare it asmlinkage for
> documentation purposes.
> 
> The patch unifies trampoline function argument handling between 32-bit
> and 64-bit targets and improves generated code for 32-bit targets.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---

Minus the vmread_error_trampoline() change, pushed to branch `for_paolo/6.1` at:

    https://github.com/sean-jc/linux.git

Unless you hear otherwise, it will make its way to kvm/queue "soon".

Note, the commit IDs are not guaranteed to be stable.
