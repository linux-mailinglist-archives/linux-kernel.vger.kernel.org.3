Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C63502E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 19:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbiDORgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 13:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiDORga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 13:36:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB7D5A586
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:34:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id i24-20020a17090adc1800b001cd5529465aso7576943pjv.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Cj4lHoJbdVe7/yfpNvTK/X4gKN0yimHzFNu70ixPoFc=;
        b=bQ9Uoq6f8ua+HQMVChR2hvHq9zh8N2X02Qsfy6gnUjzbOW0BA5UUuqextBMPbux0x6
         LOllMaVWds3+HMLb7Njk5gRa3V59cOgxRtCYiPPwq9aU5piIU38CeW9cTiMt81t+h2+Q
         s1tGV4SSdieISroNVa6qnTONweMP4/miOMFfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Cj4lHoJbdVe7/yfpNvTK/X4gKN0yimHzFNu70ixPoFc=;
        b=iB0WZBuJEQwORXq3aGRLIUBAV6fXyk8+XbN5rm2BZHW39rSCUz2oQvxHvPM1zHvkTn
         oMG2WPjEXn7KiKZ1NlAqhRAhjpIZqH08awGBW5iH3OMc5AJzGhrEQVBEFl55pcX+30lD
         5l37MypbKn3XFbhhjAfKEe2ZEujq6aUKfH1BllKgeMwAcoy3dortvc11MKAKWXQcaO1Q
         beX0/gaSLi7WGsWg9B+7bU1O28+G/eMdR4oIUsGM3XqpMXKA8kQvS/gfsZereTqCzOzU
         6V8i78N3vLGPBtqXv8QxuO4sQxIjSrvY522Al9vSox3KKYaBqqxAcBEBlFMlcALP25Ai
         TFYg==
X-Gm-Message-State: AOAM5329vMRINLWO3yceU7ucyJkcj8qH+NzGCLqxvN57b2lsQexCHnsv
        xps5kQTMNjcEJJpqZzbellVVmw==
X-Google-Smtp-Source: ABdhPJwGOIhdA72t4m1dL+juRKEBgpxoxbvjv/BaxNXuLioe9WQxNbkB2mNutNprB9Fue+CuZ/dZsQ==
X-Received: by 2002:a17:903:2052:b0:158:c6aa:b96 with SMTP id q18-20020a170903205200b00158c6aa0b96mr206943pla.140.1650044039760;
        Fri, 15 Apr 2022 10:33:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00245000b004f771b48736sm3571711pfj.194.2022.04.15.10.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 10:33:59 -0700 (PDT)
Date:   Fri, 15 Apr 2022 10:33:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Qing Zhao <qing.zhao@oracle.com>, Bill Wendling <morbo@google.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: toolchain mitigations plumbers session
Message-ID: <202204151024.DFDBF9DD6@keescook>
References: <CAKwvOdniB-+F37ygZhRytBGVFjwnukyOpmoiJTCeusMdb=6_=g@mail.gmail.com>
 <3DE35A81-1FC6-4EC7-8F3A-B395B576644D@oracle.com>
 <CAKwvOd=CqOfd=zprWQPYoddgnGPJMb_sdk2Eut9DZNJq_fFJ-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=CqOfd=zprWQPYoddgnGPJMb_sdk2Eut9DZNJq_fFJ-w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 10:17:46AM -0700, Nick Desaulniers wrote:
> On Fri, Apr 15, 2022 at 7:50 AM Qing Zhao <qing.zhao@oracle.com> wrote:
> >
> > Hi, Nick,
> >
> > > On Apr 14, 2022, at 4:30 PM, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > Hi Qing, Kees, and Bill,
> > > Jose and I are currently in the planning process to put together a
> > > Kernel+Toolchain microconference track at Linux Plumbers Conference
> > > this year (Sept 12-14) in Dublin, Ireland.
> > >
> > > Would you all be interested in leading another session on
> > > kernel+toolchain collaboration for mitigations? Do you plan to attend
> > > plumbers this year which will be in person?
> >
> > I’d love to attend  plumbers this year to meet people in person!
> > But not sure whether there will be enough new, big stuff to report this year since mostly bunch of bug fixes and minor
> > Improvements to the previous work.
> 
> No worries; it doesn't need to be a presentation, or just one person
> presenting.  I think a quick review of newly developed features from
> various authors, then a discussion with consumers (kernel developers)
> would be beneficial.

Yeah, this kind of overview is what I've been doing the last few years
(with Qing last year):

https://outflux.net/slides/2021/lpc/compiler-security-features.pdf
https://outflux.net/slides/2020/lpc/gcc-and-clang-security-feature-parity.pdf
https://outflux.net/slides/2019/lpc/gcc-and-clang.pdf

-- 
Kees Cook
