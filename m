Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA87492E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343580AbiARTXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:23:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245416AbiARTXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642533781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szFzYuqp/rVABkm8mkSgMpFZFDViwmtCeMvEqr1ilK0=;
        b=f0ZovC1KXkl9fMiWKKpGH/cHQXNjUQVwwQwvAPep4cx2c0gv0HyDdsZZDF+HDCs9jbDfDD
        HJG9xtr018CZF7yeAQ47YmKZFi5/2yjpi+G+f20kpOE4KENu6B/Ria2EYDRsdeLlw7CUzU
        SwkxUBHryn+ogRluG2HY/Ju2bMN2bZQ=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-A5bnrqFTNri99O6MOtetlg-1; Tue, 18 Jan 2022 14:23:00 -0500
X-MC-Unique: A5bnrqFTNri99O6MOtetlg-1
Received: by mail-ot1-f69.google.com with SMTP id c3-20020a9d6c83000000b00591cba30d03so8510634otr.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=szFzYuqp/rVABkm8mkSgMpFZFDViwmtCeMvEqr1ilK0=;
        b=1m/jMulj8iTN1sjX2bN/F9y/01IH2e7uWR5kVAhAhE/Gotcv/ti3FkevZH62fSK4o5
         H/iQ4G87CQNqArHF/uQn0OxD8+KLhtdWviikoodzOI74WXPxNpHKlsf4dtLMKfTwD7fi
         fMPIXhUV4+KVnUy87f7FHdhyhSKRwXqRxPthamKrTYJlHugxAWZ7tOGzKnmNrPqgyzBy
         P7Qf+oEWXcrGQVC0nxJFY/Dkro7oI5O/4htDv7pG2EQiKUFeuEdq1jOhg7YqOU0N9Utc
         MFQxmKJsVfaT3OACkI92FxmN9hCYemo+haiKPxRNFw0vCflRBd99KyJOqAJUEHs669u9
         MFcA==
X-Gm-Message-State: AOAM530C3DUdy8Ids8bEURToTcT0RPbipORA/jo2YwRhmsq7E4CJkpN3
        WS6Cx4XVXcTW/kNQTvhfCQVMRuA4lilGzF6uPDlykq4gYdY/ad0xJgswAxyh42JghLg/tQDaMrU
        Td6wlx6jMmZWcfoL5Ycd6lO3a
X-Received: by 2002:a05:6830:148f:: with SMTP id s15mr12549740otq.242.1642533779971;
        Tue, 18 Jan 2022 11:22:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzr0wpP0kkTCgrhkGxkaIaWoXrzgt8LpYDiF/kTrxf2zstxk5uqrspsrdw765/b9E+vg16lA==
X-Received: by 2002:a05:6830:148f:: with SMTP id s15mr12549720otq.242.1642533779776;
        Tue, 18 Jan 2022 11:22:59 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::c])
        by smtp.gmail.com with ESMTPSA id i25sm7472390otl.8.2022.01.18.11.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 11:22:59 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:22:56 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        x86@kernel.org, llvm@lists.linux.dev, linux-sparse@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] objtool: prefer memory clobber & %= to volatile &
 __COUNTER__
Message-ID: <20220118192256.jzk5dnceeusq7x7u@treble>
References: <20220114010526.1776605-1-ndesaulniers@google.com>
 <YeQei0xNzMq7bFdg@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YeQei0xNzMq7bFdg@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 02:32:59PM +0100, Borislav Petkov wrote:
> so I like the local label and how it is more readable this way.
> 
> So, provided the memory clobber works (I wonder here if Josh has some
> concrete failing cases which could be tested with your version) and
> after the nitpicks have been addressed
> 
> Acked-by: Borislav Petkov <bp@suse.de>

I think Nick was already able to recreate the original issue.  I'll run
it through some more testing.

I wanted to make this change years ago, but couldn't because of legacy
toolchains.  Here's hoping this is the final solution for those @#$%^
macros.

Boris, thanks for looping Nick in, I should have done so to begin with.

-- 
Josh

