Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA4D581990
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239216AbiGZSSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239419AbiGZSSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:18:39 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34D032D8C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:18:37 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id e16so11589899qka.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PcIy1IoVeLTA5pN4xjHqrFFTOjRrYaH1roVxozVFMOY=;
        b=gFaqEJ7fu4l4IvYNN6/B/g21zWrCb0Po5DuLzh4FB2bv8EQkApW3NQtaVWNVbYoDiL
         mG/lo7cuHAs80ggJwHBf4cXxt5lueFCZ62jFgpUGvfcV8SuK7/3/L0mT22jQprZ6ptlS
         6mVeIE31mmdnkD03RZ4MfxqqMMQ0Ql6pd5uwrzHgBosNl9QoHxp+cjA7K9zmtuZUfMxv
         fIoadGHGBXyTYyheNoQ/z8z7JCs8c/FBvBsj8LJDPlIzx09wZeKq1L+wffcM7mMOvQTt
         vJiZtfQCB3SVie4xZ1bWsm49CMN8vojXf1vzbV/rFwFtEyLzxmjfZNrYG86Lo3OG5It0
         aRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PcIy1IoVeLTA5pN4xjHqrFFTOjRrYaH1roVxozVFMOY=;
        b=vr/smJLu/PwdE1KDL/UZRKO1E9DO8yd95SoglIuHBiwhI9XE+aGP+ljchRmbO1SHdX
         Nz9QXYfMfN8uxHaJg/T2+Zqp6ASkoxXYlzl9favS+dburo3aoyo+M4ooYPSbmTpjQUcp
         HYHmrTtp4wlZUi7Q7v3EOm4xA46K7FP9dukzotTiPQhBfJd8SIEkntE7xciSaryJkwJC
         akPiXBKSx2o7FwHHgUtHrLwC2Y6h5GjcxskH9Kfq3Pe5olDOX/RwAO0xeTVsoGuHqMRa
         5p8+H2wAhYcvDic8NFGZG6FkAe/n6T+aWIt966OU30GmWpZUs3tyxg/gw+Mrw+QVwchv
         eM7w==
X-Gm-Message-State: AJIora+Mi9VL77T3G3MaHvpZKAWVfLeYKzdYHFtiBbxpJU0XTLZcNDyk
        8MnQ8F8VOHoVP42n/QPOGzs=
X-Google-Smtp-Source: AGRyM1shIaNZWVK8sA3rDaCMoqXb6+vBPULuR/BA8pNVD+CuraDYlrtLnXxnboyxMZXsFBItME9fSA==
X-Received: by 2002:a05:620a:488a:b0:6b6:b45:d85c with SMTP id ea10-20020a05620a488a00b006b60b45d85cmr13748258qkb.453.1658859516951;
        Tue, 26 Jul 2022 11:18:36 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:8203:dece:781e:a773])
        by smtp.gmail.com with ESMTPSA id u22-20020a05620a431600b006af147d4876sm11881274qko.30.2022.07.26.11.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 11:18:36 -0700 (PDT)
Date:   Tue, 26 Jul 2022 11:18:34 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: Linux 5.19-rc8
Message-ID: <YuAv+lV324G7pmlk@yury-laptop>
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net>
 <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <YuAm5h1B6bsrR/9q@fedora>
 <CAHk-=wgYpJTMMxmfbpqc=JVtSK0Zj4b15G=AvEYk6vPNySDSsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgYpJTMMxmfbpqc=JVtSK0Zj4b15G=AvEYk6vPNySDSsA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Geert Uytterhoeven <geert@linux-m68k.org>
+ linux-m68k@lists.linux-m68k.org

On Tue, Jul 26, 2022 at 10:51:01AM -0700, Linus Torvalds wrote:
> On Tue, Jul 26, 2022 at 10:39 AM Dennis Zhou <dennis@kernel.org> wrote:
> >
> > Are we okay with adding the contract find_*_bit() operations must handle
> > asking for past size properly? FWIW, we'd have to modify most of the
> > iterators in find.h.
> 
> So I think we're ok with it, if only it makes the macros simpler.
> 
> I also think we should probably look at the m68k case, because while
> that one seems to not have the bug that the arm case had, if we remove
> the arm case the m68k code is now the only non-generic case remaining.
> 
> And it just makes me go "maybe we should get rid of the whole
> 'override the generic code' thing entirely?"
> 
> I don't think that inlining the first word (like the m68k code does)
> is worth it, but it *is* possible that the architecture-specific
> functions generate better code for some common cases,

We have find_bit_benchmark to check how it works in practice. Would
be great if someone with access to the hardware can share numbers.

> so I think this
> is a "needs looking at the generated code" and not just a blind
> removal.
> 
>               Linus
