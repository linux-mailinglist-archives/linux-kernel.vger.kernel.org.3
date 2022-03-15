Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDF24D90E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244656AbiCOAJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244580AbiCOAJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:09:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5518AE00B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:08:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e2so14881802pls.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNOHO0MxND9U5QYTutXy4JWYuAASnDKcx8vBDjMeWwg=;
        b=jfdXT7xBd71Bf8/eabDPpUSNh/yhLcRlOu/GD8JBy9t/2EcozNl/l17+OX54PVXx2/
         yCogKYYNHbNaLUlu6Sq6+0YBR+72hqjyciROITBwSPeN+J2+Oyh81Riw4me8fBrEWn7l
         T60BJ96mUNSwc1GfufqglTy4cgW025PyRo+L3+9W1f56Z4C/Qd5M60m2R2U/JArt6Sx3
         r55Q+tZ7bvL5FvygXzx5IPqMITqRuzZvgql5vFjlgNy+9it0ACkdpLPbeojfCaWOi3VL
         Vjt5kIxCNa3vsE7ylPwYw2txJ+sADmU5/y/Dylexxv2QxCst2Z4uRQMz5yz0GoL/AmNz
         DuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNOHO0MxND9U5QYTutXy4JWYuAASnDKcx8vBDjMeWwg=;
        b=zm40faobXujAL/8jVq3mTJQ1+vJn63LYTOF0sYKjd8AwHRKx0O6mLqBDdnxFu+KsTw
         DaPxxcBALRRx3PNZQmCNEnerNoCrCJYG40wpJlLrE3ZYGNfDO4McgHs/+KcQLRUOdp08
         etFXgIEK3snUU+odhyDaGeHiPwuor/ewYOX6g/sJPYiRCFWsvserW5mg7AcIPz8R1N96
         jvDgRAjhbf6RqydIuf1aSRkb6na2qrIp9Y9mYMzGK4Bx7LUnFjT4xcSJuBypMr59D9Jr
         rMGlFWX7DOHOzPCWw2czWTMv8N5LuJ45/pFIg3fpSAZL99NKO/xoFrRzG3lmmghWNKUF
         Z0ow==
X-Gm-Message-State: AOAM5331E37LySJm5tWQwW9WWgFZCFxQsJzhwb35vhv/4XFEBaZfwoZB
        uRVZ2buVT8uAYDn4Epyv5cADkeeqEd4zUl+NtLx+
X-Google-Smtp-Source: ABdhPJyTl2dscitxyL5B/Z6MzR7vvqUpFfY6Hae/3AEMYiqXzeVQQ6vEgbpH4fs+TS9zcFfCzRRQIBqPXzjTGccstk0=
X-Received: by 2002:a17:90a:c252:b0:1bc:52a8:cac8 with SMTP id
 d18-20020a17090ac25200b001bc52a8cac8mr1599760pjx.61.1647302909598; Mon, 14
 Mar 2022 17:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211215211847.206208-1-morbo@google.com> <87mtl1l63m.ffs@tglx>
 <CAGG=3QV2sw1w+j2NDqPVAbobGj04QXfOF0VcSCebRbs6y-L5WA@mail.gmail.com> <dccb0cf2-edc1-fb98-d4ca-4f76687b7e6c@zytor.com>
In-Reply-To: <dccb0cf2-edc1-fb98-d4ca-4f76687b7e6c@zytor.com>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 14 Mar 2022 17:08:18 -0700
Message-ID: <CAGG=3QUHSRHNKsibezy6NSaJea3uJhnHE61k1+W384tbPzuMrA@mail.gmail.com>
Subject: Re: [PATCH] x86: use builtins to read eflags
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 4:10 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 12/16/21 11:55, Bill Wendling wrote:
> > On Wed, Dec 15, 2021 at 4:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> Bill,
> >>
> >> On Wed, Dec 15 2021 at 13:18, Bill Wendling wrote:
> >>
> >> please always CC the relevant mailing lists, i.e. this lacks a cc:
> >> linux-kernel@vger.kernel.org
> >>
> > I thought that was automatically added. But as Peter pointed out in
> > another email thread, no one has time to read the LKML, so it seems a
> > bit pointless? Nonetheless it's added now.
> >
>
> Consider linux-kernel a distributed archive. Noone reads it in real
> time, but it is really great to be able to search for someone specific
> in one place.
>
Ah! Okay. That makes more sense then. :-)

-bw
