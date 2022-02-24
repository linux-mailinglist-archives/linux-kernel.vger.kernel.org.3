Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201A04C33F2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiBXRp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiBXRp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:45:56 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0134279470
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:45:25 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u20so5216783lff.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pOBmVUTfu7dJw7T0At09LeWpqEdb7Gx94oz8UfcdCXs=;
        b=AILmembZ985YYL0f4wZ5s11RyKgR5u6qiQrV7RZNkT9G5n/SUdL4Vhrq9B5bX8IAIQ
         Y6nGnLQuOzkqFVDrilbDkVYSx1GL7mMY7i0oqQFQ167eDMte/SkF8KYTQPuW8ZBUYD0I
         S+wsm+vFqKevBhVyTZaq6iuYgrlCFfQmfxWN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pOBmVUTfu7dJw7T0At09LeWpqEdb7Gx94oz8UfcdCXs=;
        b=WCIaTSuZA7klWeF8di3ltUqskNNNKSVyzZuwg4lz195sJSLxyLO8wcKjk1dRSVGIN/
         hA4HbICgwbvejgZciKrMV7+QJ3cTcUdyFb6lM+g7TRZZuTuzLLbREti87TMSk6PRKY/O
         XSiHFAl+6L9lOcP0nBULu9vyIboX2WJdTc0CjGxVCqbNdNdu5GJ5E+EWcBfyhw6yAxzG
         7s/krpw9gNal19cPMWvlQhDMIUoXYhC6ATYaZOc1eCwIzHTBPrxFKZcxijyLbVINCyVN
         SHLSbm0I/FZsshKxfhHb9suh0tDp33W0X4KG+FmHdQ4oZkOH1hMOWbPaADuoFr7O8fwy
         1xuQ==
X-Gm-Message-State: AOAM532JqeulMfIApPzobi6f3QfkzAXtueO3du+UWOH/11Ae8epXXMoc
        +SDOAG1gIRqshB4/DZk80lGZOacxgeVQAhmTQLA=
X-Google-Smtp-Source: ABdhPJw+ia2xAjp6ju5ZZYPn8EouCt8J78iwYl0OoJzvYmSv7WQ6IZ4eS0NOhN06f4+Car6uPY7BxQ==
X-Received: by 2002:ac2:5cb5:0:b0:442:13cb:481f with SMTP id e21-20020ac25cb5000000b0044213cb481fmr2445403lfq.174.1645724723835;
        Thu, 24 Feb 2022 09:45:23 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id bu40sm160169lfb.273.2022.02.24.09.45.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 09:45:22 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id bn33so3987334ljb.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:45:22 -0800 (PST)
X-Received: by 2002:a2e:80c6:0:b0:246:3334:9778 with SMTP id
 r6-20020a2e80c6000000b0024633349778mr2640059ljg.443.1645724721879; Thu, 24
 Feb 2022 09:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20220221122638.7971-1-franciman12@gmail.com> <e32de43c-e00a-5766-e988-fe192d36d719@quicinc.com>
 <CAH4F6utmtAM3CzX2_Fbn94Sb-X8m0patPh8yWwbuBB0t1VYH=g@mail.gmail.com>
 <87o82wvhtk.fsf@kernel.org> <20220224075346.GL3943@kadam> <87fso8vb3w.fsf_-_@kernel.org>
In-Reply-To: <87fso8vb3w.fsf_-_@kernel.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Thu, 24 Feb 2022 09:45:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whFKYMrF6euVvziW+drw7-yi1pYdf=uccnzJ8k09DoTXA@mail.gmail.com>
Message-ID: <CAHk-=whFKYMrF6euVvziW+drw7-yi1pYdf=uccnzJ8k09DoTXA@mail.gmail.com>
Subject: Re: Use of void pointer arithmetic?
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Francesco Magliocca <franciman12@gmail.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, rmanohar@qti.qualcomm.com,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 1:59 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> > What does -Wpointer-arith buy us?
>
> A good question. I have always just thought we should avoid void pointer
> arithmetic due to the C standard, but now that you mention it void
> pointers can indeed simplify the code. So I'm not so sure anymore.
>
> Any opinions? Is there a kernel wide recommendation for this?

We consciously use arithmetic on 'void *' in some places, although
it's not exactly _hugely_ common.

It's much more common to turn a pointer into an 'unsigned long' and
then doing basic operations on that.

The advantage of 'void *' is that it does avoid the need to cast the
pointer back.

But at the same time it will never replace the 'cast to an actual
integer type', because the 'void *' arithmetic only does simple
addition and subtraction, and many pointer operations need more (ie
alignment needs to do the bitops).

So I think it's mostly a personal preference. I *do* think that doing
arithmetic on 'void *' is generally superior to doing it the
old-fashioned C way on 'char *' - unless, of course, 'char *' is
simply the native type in question.

So if 'char *' casts (and casting back) is the alternative, then by
all means use 'void *' as a kind of generic and type-independent "byte
pointer". That is how it is meant to be used in the gcc extension.

And no, nobody should ever use -Wpointer-arith on the kernel in
general. Our use of it is not _hugely_ common, but it's does exist,
and it's not really frowned upon.

                    Linus
