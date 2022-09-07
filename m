Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73B85B0BBB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiIGRpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIGRpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:45:22 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9993F67C99
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:45:20 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 130so17115498ybz.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4UnzWTocG2iPpAqMvQabkV9NRhaTMUyHYWRKvOA4oZs=;
        b=gHOGoE/DwxYALJI33vb4pBn5j3ORXk2cd05bL54ID/21l2b2vQ0106kj6v+/9GglxM
         pcmHJzYHGHwO9x8Nw6os/zYLAAmKzINCzgmvlNFCI0MI6lcgHhRQLcmS3BnuPnBFdra4
         Y65udLpippAuS+K591wU4s+ejdivlYbrrnDG7oonBP8Gcmc1AROEiHaCaCSKPq1LhSSG
         3MKrl/CAu9SquxByAjXIo3qHbCJcJ53YMacpOrey2nTDb9AslfdrjcHvmrsIG7QPBoeK
         O4eTzn8/6J15sgvrGQ+/uTDNYUEwvz68zREbrWAVB7x1+Iroy8k8Mv7bAzta9Q/z/O3t
         EeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4UnzWTocG2iPpAqMvQabkV9NRhaTMUyHYWRKvOA4oZs=;
        b=XC+oX6KLzomLbusoIr0bx4UWvwyf5U7TLANMoN4h2ToEjirru6DE7gVW7UTrWOQjnT
         bXXHzTZKn/rCLzRQi2GVrbKvlhiaivp0l5Ji8SW8d1gazwmuWaHMxKTqPRSaH+HxGw4g
         XLq42Et9LJPUcgDwCgjN5UsxIKIhdJmKvwCuY+uKB5ZUintk/Qt5AFfY7/2Ix8+XTSIk
         CAQmqBg2m7YZETPupWjHffWdVGR1KlIfc/7C4eLO92tN93P3Hz7+yTrKoKKmMI8AkcoO
         RFDsFd33Xiau5GMz/bEYplwO4cZUG71rVvIJOQllzkywkwClV0e0oyy958HCWC+8jrX8
         wBuQ==
X-Gm-Message-State: ACgBeo2XQ27TD1En0+oxZbwmXcuLamke8Y4sC5oQK1C2gK+0XBMIuUGQ
        x+jjkxMm2AO6aD+ijumZk0KicEmSXkoO7pnDDXTwNA==
X-Google-Smtp-Source: AA6agR5EJfDo1S55dZcD3KuTpTr76XKXhF6Z9iRiTzeOauk5dATRDVC8XJn5mqvOcVvcK0gXefud+OOUpE0zokVNZwk=
X-Received: by 2002:a25:1e86:0:b0:68d:549a:e4c2 with SMTP id
 e128-20020a251e86000000b0068d549ae4c2mr3717220ybe.93.1662572719703; Wed, 07
 Sep 2022 10:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220907173903.2268161-1-elver@google.com> <20220907173903.2268161-2-elver@google.com>
 <YxjXwBXpejAP6zoy@boqun-archlinux> <CANpmjNN2cch+HDVUYLD27sF9E39RaFrCf++KN=ZZ7j0DH8VaDw@mail.gmail.com>
In-Reply-To: <CANpmjNN2cch+HDVUYLD27sF9E39RaFrCf++KN=ZZ7j0DH8VaDw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 7 Sep 2022 19:44:43 +0200
Message-ID: <CANpmjNO6zbVpM2rr7frvE6S9c0PLHi34O5d+9_v5k7fOxNQMHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] objtool, kcsan: Add volatile read/write
 instrumentation to whitelist
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
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

On Wed, 7 Sept 2022 at 19:43, Marco Elver <elver@google.com> wrote:
>
> On Wed, 7 Sept 2022 at 19:42, Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Wed, Sep 07, 2022 at 07:39:03PM +0200, Marco Elver wrote:
> > > Adds KCSAN's volatile barrier instrumentation to objtool's uaccess
> >
> > Confused. Are things like "__tsan_volatile_read4" considered as
> > "barrier" for KCSAN?
>
> No, it's what's emitted for READ_ONCE() and WRITE_ONCE().

And you rightly pointed out there's a mistake in the commit message I
just saw. :-)

If there's no v2, Paul, kindly perform a s/barrier//.

Thanks,
-- Marco
