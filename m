Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2094B3400
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 10:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiBLJXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 04:23:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiBLJX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 04:23:29 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A05E26562
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 01:23:26 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p9so4510655ejd.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 01:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQxuwYXRyYUymC0nv8LtPvAyCwq+SjfKuitASpf9b8c=;
        b=GtTztpKAfezmMys6OpEIn2nWbo/GqvB5Oos478kLkJCUxhN5olCS2zSuhE8pXPw5Hj
         9wGLVZKdpHU/v0OaCEVNZWTQvRyXrYyrWaVh6P79raY5Hd/I3oHP+l/aitRKt8IN7KBO
         ASdGBE9hBiy1tsgNkRLXr8S5P+Ma59JkbNbmU1SypL5+PkHTTSOa43HiE83Z1KwU9CWP
         u/RKeVWxJmbqFS6+aJx4WxzcoS34FLzKWnwanbYJannfskzriwZBlM8rcfEozkiAvxEX
         lYn4aTrxL4ISMBWalU0A2gymUSeGh9BpCONFDtrck4RDEAK/J0AsqmOugVh+82/Osc9J
         zTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQxuwYXRyYUymC0nv8LtPvAyCwq+SjfKuitASpf9b8c=;
        b=J20LpKhgIlF+URCtCz7sXQaSyiTk1yIkUrhnnxrwkPNJgkBcn78uBRrey2duAHwQEW
         ntpBPZRS2LlWRsntMo7ALC2TKGHyp7Wtqsy6ccvUm65aZiORIsSn2JPOIA9XMBGttPr9
         DuzwtefnMTmCRjT26CaYUUCYUwyVQPKScfk4RTWtmgw6rDAL3vcVvdmk4VGhSYSTbZ+N
         5bbU+tX0LJvPoFaZQ5swF9let5i5yz3HcqrK+hz6eb/FINtJYD4Dz9oYSlcdcreocs/Z
         VjVTigU5Kbdgsh0iKUK/77TUVP6cOIGhWt7TTzMs8SONK8q0/PrO2itOGjQQj9ds/NYI
         EUWQ==
X-Gm-Message-State: AOAM531PtsuqRHzGTn4Lp7nDOccvehwzZ1fE+1NjTspcTb9lTzb964jN
        xipSmDGCRW/k1Ug70j2o7rHfjEC+9v38DA+xwpHs
X-Google-Smtp-Source: ABdhPJytMk5SxWzvQpjZUpYvjyvFSnw3e08lRh+rlrf+maOllfFiyQe6ROhhCGHgoslwjvZ5GG1YlCud3jYxHBGFxek=
X-Received: by 2002:a17:906:72de:: with SMTP id m30mr2194742ejl.163.1644657804498;
 Sat, 12 Feb 2022 01:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20220204005742.1222997-1-morbo@google.com> <20220210223134.233757-1-morbo@google.com>
 <cb2ff5da9b704a9792549a9433dc0ac8@AcuMS.aculab.com> <CAGG=3QXvSt=d94iqSV-Y9JVNc+pt-WOZGpSeW--fp=w2ttMvUA@mail.gmail.com>
 <CAKwvOdmqQ4M1pcz1BW+MTtRdwP3itOLcV83X+1nJQkf9BNJ7Fw@mail.gmail.com>
In-Reply-To: <CAKwvOdmqQ4M1pcz1BW+MTtRdwP3itOLcV83X+1nJQkf9BNJ7Fw@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Sat, 12 Feb 2022 01:23:12 -0800
Message-ID: <CAGG=3QWmp_nXH0nkREMwRcqAcBOmGFuDifsE5t=wNjDGkLMcgg@mail.gmail.com>
Subject: Re: [PATCH v4] x86: use builtins to read eflags
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, Feb 11, 2022 at 4:24 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> I would like to discuss this further off list with you Bill before you
> resend this patch again.

That won't be necessary.

-bw
