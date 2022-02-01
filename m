Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DD84A66E2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbiBAVQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiBAVQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:16:11 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0631C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 13:16:10 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id q22so25963016ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 13:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6yCl0yrttabI3s7nqjUHynlo3srHrhXhPGElzUkPOk=;
        b=bmiNtc6Ae29Swmg5fc3H/k70xhmmRjtEjcPNh6FgLoUvJUpcAPPu97uoLwA0w0jrBm
         pOM4eMl/IT8X7Cc+T6CXPeQN9ZhyAtdZvS+QxdMrD1DqVNceZpJM4lngftoZhGtHnGK4
         ZWyyIS9wSZqC66iUtcrIssw5hmv6RSKrTKBrF2jdoFRuGK8OpPHYqiTapSwFfZGjK8Tq
         LSwav0CpaPFnaGgLR7Q7ZTDTd2TRQ9mookKcao1R1BP/8Xe1sY2oucnvpapPvMkhzvbm
         CI4j/p0vMv2nfp4JhWuXv39ktAikVGbiN6n6lu5GHzemWtezMJcc97L4SzCcaPrNdxtU
         hzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6yCl0yrttabI3s7nqjUHynlo3srHrhXhPGElzUkPOk=;
        b=QEMz8U/SbTtd6thDWXi1o6Z9mf8sbu4Da6T5f16VYgiqoxUIeEad4kU3c1wIMgihS3
         beyYbu5l/+Xch+9Amcthny+EtvO7h47gu/7JoZ2MWr8QB94GUd5D+s8Ipt1qUD3FMXh0
         6PiL6Gf2h28pDAaynvb9TDY3kH6ArVqb8af7/Fru7m/ZGneXubfx3hj+Hh79ZwEZPq9T
         PpuIOiOIZvvrRq8NvTiIjd3m/nAaObsqsjJ4CSHFaKR++Q2wS0PUGMLf5/OGfAAB3Zsa
         /54yyywA23tYD8LQtKPJD/IFkHAgUKjrh80CsBc39HNOgiLnjrlhEQV+m1+H2F8V5kcr
         KueQ==
X-Gm-Message-State: AOAM533glHAGrvHYBJ4CeJiVkWX4H+TTZsKK67RRG0PStX2OHaCHOYcN
        v8Tcqq6Q/yQvjeEZ9J47zjEOcD10z/zgIaBN0TXzfr66T4U=
X-Google-Smtp-Source: ABdhPJwrMtZhliPhZS5ChFivx/H1H3iJJlf5uao7LihxBJyuwSEBW8JLn2Gy47GuM+rpUIC8+hvJOMzrexoadtJfL3Q=
X-Received: by 2002:a05:651c:3c7:: with SMTP id f7mr13251141ljp.62.1643750168915;
 Tue, 01 Feb 2022 13:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20220201010838.1494405-1-seanjc@google.com> <20220201010838.1494405-2-seanjc@google.com>
 <CAKwvOd=9nwR7z7wn50SU=mf5AywFLd95ZMH-EbYdHfbeHVvq1A@mail.gmail.com> <YfmedCAn8pK//I2R@google.com>
In-Reply-To: <YfmedCAn8pK//I2R@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Feb 2022 13:15:57 -0800
Message-ID: <CAKwvOdk3rtHCDfW-kCmmQ=UueeXpVVBnG1XGwdoiWWHZgmt5yQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] Kconfig: Add option for asm goto w/ tied outputs to
 workaround clang-13 bug
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+6cde2282daa792c49ab8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 12:56 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Feb 01, 2022, Nick Desaulniers wrote:
> > Note: gcc-10 had a bug with the symbolic references to labels when
> > using tied constraints.
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98096
> >
> > Both compilers had bugs here, and it may be worth mentioning that in
> > the commit message.
>
> Is this wording accurate?
>
>   gcc also had a similar bug[3], fixed in gcc-11, where gcc failed to
>   account for its behavior of assigning two numbers to tied outputs (one
>   for input, one for output) when evaluating symbolic references.

SGTM
-- 
Thanks,
~Nick Desaulniers
