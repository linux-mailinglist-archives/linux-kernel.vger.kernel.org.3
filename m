Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6054C53C5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 06:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiBZFEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 00:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiBZFEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 00:04:50 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9B616F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 21:04:16 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d17so6509603pfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 21:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=E873fV4pQ7eoesQTVG0pcEDlvHYqEcX/Ujnaje4n6Sc=;
        b=PuNlEqmTgPvbVko2IReAQCR8Mr+X9hEMLYKWGjCC0QrDMXopv4fjrjc5WPTJ1TelI5
         CX32T4CBThdDDf4nK51URXF7g0gEiXfPGw5XuDcgxeYbfWyKCdbzJdmqiv8thAwnrSVJ
         nKVc11gI72oQ7nbLe9qIFneRzbBaxyAdSq/+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E873fV4pQ7eoesQTVG0pcEDlvHYqEcX/Ujnaje4n6Sc=;
        b=fYaRaGGl32w35kaZO8bs0O+GesublRPj8j+8/gBwADliOI1clHizzfluJwKlpv8gEb
         Ona6DmVsDOkV9CNC13HE7bTY+9m3OR7UrWAc+AVY2iTYzEpzqQiHP4nd9n/diMUomN+4
         ppbe2b9Med7HMk+U9xJK/m5Ob4ytJ0PszINDcFOMC/EmD/5koM5zxoSHkHqKdB8+xbfr
         wIERsbByvn0ocdjgJsRK7qEa/ZxvbpLR3LpZPZax5USDVYOdJ27YpRD2geLJMkBLQPir
         M5EwmUr9HwqYR2DhkdRBXxzDc0XdcupQzv/xldqrE1qyJcNc1wyMpMENcJ0tj7bqCm5i
         1ALQ==
X-Gm-Message-State: AOAM530K8aOIXTuSVbbpWMcSEx9Hq6scchaesrrZ28f738odX9eLT37W
        Mvu7k0JwARCOWccWvycK+00Ymw==
X-Google-Smtp-Source: ABdhPJwNToOBqTnqAPGsKmAI9k63BhDZ7x7s2H8BYnul7vzHErq3PCxizFnKnvtBns8K+4T0tIyBxA==
X-Received: by 2002:a63:4560:0:b0:370:1f21:36b8 with SMTP id u32-20020a634560000000b003701f2136b8mr8813537pgk.181.1645851856083;
        Fri, 25 Feb 2022 21:04:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004e5c2c0b9dcsm5212196pfe.30.2022.02.25.21.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 21:04:15 -0800 (PST)
Date:   Fri, 25 Feb 2022 21:04:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Joao Moreira <joao@overdrivepizza.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        Mark.Rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com, llvm@lists.linux.dev
Subject: Re: [PATCH v2 05/39] x86: Base IBT bits
Message-ID: <202202252103.966D14E1@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.307406918@infradead.org>
 <202202241627.EEF3D5D2@keescook>
 <YhgnA8O4Bp19hfse@dev-arch.archlinux-ax161>
 <YhlTRhh7qj538ygM@dev-arch.archlinux-ax161>
 <605731324a76f36aafa87bd9390808c3@overdrivepizza.com>
 <202202252055.AB16A4B8@keescook>
 <CAFP8O3LDdGKQ0HzhfmsuDRfCEWC3sAAizUTjU_UKERzseX+H3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3LDdGKQ0HzhfmsuDRfCEWC3sAAizUTjU_UKERzseX+H3w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 08:59:57PM -0800, Fāng-ruì Sòng wrote:
> On Fri, Feb 25, 2022 at 8:58 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Feb 25, 2022 at 04:29:49PM -0800, Joao Moreira wrote:
> > > > https://github.com/ClangBuiltLinux/linux/issues/1606
> > >
> > > Candidate fix: https://reviews.llvm.org/D120600
> >
> > And landed! Thanks!
> >
> > Since this is a pretty small change, do you think it could be backported
> > to the clang-14 branch?
> >
> > --
> > Kees Cook
> 
> I have pushed it to release/14.x :)
> https://github.com/llvm/llvm-project/commit/f8ca5fabdb54fdf64b3dffb38ebf7d0220f415a2
> 
> The current release schedule is
> https://discourse.llvm.org/t/llvm-14-0-0-release-schedule/5846

Great! :)

-- 
Kees Cook
