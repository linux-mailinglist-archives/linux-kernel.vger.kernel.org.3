Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A612757A438
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbiGSQfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiGSQfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:35:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B5863C9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:35:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bp15so28254890ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xlfzi0mVmWi9G0I/mY1MHM7z0OG4bhE7Or7p89HZyMU=;
        b=FoAkRYULGV4X6ZrFtDAkEVt/BKsgTrqYgRBy8dc+oOTvqCgMJzqa+hZNbAqUAg7h0X
         uXpcXEZNxqV60KB0HXIvuxmkpcb/v0b6V2DXzVOUCbLBhVxX6Otc0gfmd9U84Yyj2N2o
         auYWCnJD8QLRwC7ycUlmKDJ2mtqQwTAQz2xzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xlfzi0mVmWi9G0I/mY1MHM7z0OG4bhE7Or7p89HZyMU=;
        b=lAu1KydU4z+9XKHsEADNBXUu+aK6+qDYEHYZIYsvlKFnl67NiYFq1SWq4r4aU7VFcm
         oz/8aDYQAnVzxr79RZPIA5r884YaDZ1B+TAsVqerYfDGmR9ryxykpC0ffpCyb5osWMG+
         cU6rt86SX4tXsAO/feoXFTZZPhWvieSW91z0zduyOnrC1XhAG4gq5keRn1T+hwHr1FOZ
         yLZk6q64IZUDwPtS4aG3hrFEOlH2cSI0lhnHCwkkwF65PK4sdvfRGX1Hsk69UoOIczDS
         gAfJmyUOANjk0OCMi6qrKxHTSvmirypJSbP5Nu/+Ggv7+SSdEstz/qAsNjprJkyDKu8S
         Q1rQ==
X-Gm-Message-State: AJIora9y356AloGs79Ot7AXNWDtk/LTIF8EHY6aRRZu6sKkHES6zs23a
        9ZH0SkJ7gTfeRYkUcEsPibjL+hzCDD4xAD4xFf4=
X-Google-Smtp-Source: AGRyM1sP09M7umonIfeCgmvtrnlWTpZtriCCzeyBJqsCjd/i0CIRrbbw2qnnMYNqGxLbaV2JTMkeGQ==
X-Received: by 2002:a17:907:69b0:b0:72f:6520:9305 with SMTP id ra48-20020a17090769b000b0072f65209305mr112051ejc.388.1658248516308;
        Tue, 19 Jul 2022 09:35:16 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id g17-20020a17090604d100b00722e52d043dsm6848419eja.114.2022.07.19.09.35.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 09:35:15 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id v12so20375384edc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:35:15 -0700 (PDT)
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr27998829wrh.193.1658248038755; Tue, 19
 Jul 2022 09:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx> <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx> <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <87lesqukm5.ffs@tglx> <2f7f899cb75b79b08b0662ff4d2cb877@overdrivepizza.com>
 <CABCJKudvSv9bAOrDLHki5XPYNJK6=PS-x8v=E08es8w4LJpxBw@mail.gmail.com>
 <87fsiyuhyz.ffs@tglx> <CAHk-=wjEDJ4+xg0CWR7CaCKnO6Nhzn+vjJy7CjaVmf9R+g_3ag@mail.gmail.com>
 <CAHk-=wj6U3UamfLLV+rPu1WmKG_w3p0Bg=YbQcG1DxHpmP40Ag@mail.gmail.com>
 <CAHk-=wiYHXeWnF8Ea5xb735ehJ8FbjTT6UCvHYjX=Ooc7Z5sOw@mail.gmail.com> <0e038c2795784b7eb4de52f77b67206a@AcuMS.aculab.com>
In-Reply-To: <0e038c2795784b7eb4de52f77b67206a@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Jul 2022 09:27:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whycTCSPwqV53ybUX=fDKMDk_Y8JaLug3KfUSiMF2TOQg@mail.gmail.com>
Message-ID: <CAHk-=whycTCSPwqV53ybUX=fDKMDk_Y8JaLug3KfUSiMF2TOQg@mail.gmail.com>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
To:     David Laight <David.Laight@aculab.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Nuzman, Joseph" <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 1:26 AM David Laight <David.Laight@aculab.com> wrote:
>
> Shouldn't it be testing the value the caller supplied?

Actually, I'm just all confused.

All that verification code is *in* the caller, before the call - to
verify that the target looks fine.

I think I was confused by the hash thunk above the function also being
generated with a "cmpl $hash". And I don't even know why that is, and
why it wasn't just the bare constant.

            Linus
