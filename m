Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06E64D2405
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348062AbiCHWNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiCHWNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:13:48 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3E22C664
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 14:12:50 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id dr20so935711ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 14:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q667ThhdkxL8AUOuU2qYFbGa17GC7zYlSfkMfKxv3/4=;
        b=NusUdDknL66lGLdEP5FNX3LOWWrWLPuP37qgc1opFNmna8r1+mPTnGkGut+szDcFa/
         g2D3r9SMSZRg66H5SIzcejOYlji2wOURANJzlFKjsk/PS2e7FWmhTkUb8u8CDBkM67p8
         4ySDCD9CGHFSObrQ6khjnN5ALk0dIGbg/2xbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q667ThhdkxL8AUOuU2qYFbGa17GC7zYlSfkMfKxv3/4=;
        b=qKfX9Gabc//o9VSsWzx+edvjmM5FOGQ/svIabymNiHNm/T7SoGE2v8GOA7VSeQAOze
         KGuuLNpSfovaRZaxGx5DbMNk0b+3Uw41dbRkG6ODVQu0eSHXJDC8RZTq7n2VN9aUqcF0
         +FlBf0gdBKin4dq+zHgCIaKaceu+3Ph0QCBG9y05AixsBdPvdnevkUXamBR69kjaU/V2
         SCAkXY2Mcflugf5DPWH35lX+Cqc2QQvZuBtZgopBcQaMuaNXqMqXGExtM2k7A8a6mMaj
         Kor19UPnM6CsSGZ0wmYQEukhPvaJvg93gXK52cBGUEo9zfX95uYtPqVeI9wNPgY4NetB
         m4Cg==
X-Gm-Message-State: AOAM5327k9V4j4G9idzGi99l1VfNAJY87pd2FPMchRSQOu7c3zg5LeK8
        15mK9VCYyrre3Clc539ty2THI5XXKDHeXYdI
X-Google-Smtp-Source: ABdhPJxinXXRPvFPh/f69nnS2GNvG0n7Bq4rjfjUdPzWtyUIjnsjzatwwDGMZNEB0LGsbmcAJFTwmw==
X-Received: by 2002:a17:907:7da9:b0:6da:866a:3c59 with SMTP id oz41-20020a1709077da900b006da866a3c59mr15376272ejc.13.1646777568948;
        Tue, 08 Mar 2022 14:12:48 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906a18400b006db0a78bde8sm17870ejy.87.2022.03.08.14.12.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 14:12:48 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id r10so262091wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 14:12:47 -0800 (PST)
X-Received: by 2002:adf:eb45:0:b0:1ef:6070:7641 with SMTP id
 u5-20020adfeb45000000b001ef60707641mr14280334wrn.301.1646777567076; Tue, 08
 Mar 2022 14:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20220308033241.22099-1-rdunlap@infradead.org> <CAD=FV=W90Hd-baPzurraEaDUGNOCxb8FLUysHKOQg2frMuZRAQ@mail.gmail.com>
 <2c693cb8-f4b8-a723-c804-9492d9cc4881@infradead.org>
In-Reply-To: <2c693cb8-f4b8-a723-c804-9492d9cc4881@infradead.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Mar 2022 14:12:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X004_55zOovjazkqqZ_EXQ-QCYS1o4VxdCvEjt3+7Tbw@mail.gmail.com>
Message-ID: <CAD=FV=X004_55zOovjazkqqZ_EXQ-QCYS1o4VxdCvEjt3+7Tbw@mail.gmail.com>
Subject: Re: [PATCH] kgdboc: fix return value of __setup handler
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 8, 2022 at 1:19 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi Doug,
>
> >> Unknown kernel command line parameters "BOOT_IMAGE=/boot/bzImage-517rc7
> >>   kgdboc=kbd kgdbts=", will be passed to user space.
> >>
> >>  Run /sbin/init as init process
> >>    with arguments:
> >>      /sbin/init
> >>    with environment:
> >>      HOME=/
> >>      TERM=linux
> >>      BOOT_IMAGE=/boot/bzImage-517rc7
> >>      kgdboc=kbd
> >>      kgdbts=
> >>
> >> Fixes: 1cd25cbb2fed ("kgdboc: Fix warning with module build")
> >
> > Are you certain about this "Fixes" line? That commit was just code
> > motion to move the code inside the #ifdef. It sure looks like it was
> > broken even before this.
> >
>
> Yes, but I am not enough of a git user to be able to backtrack
> to see where this code was added. :(
> (help?)

I always just chain back w/ git blame. In this case:

git blame 1cd25cbb2fed~ -- drivers/tty/serial/kgdboc.c

...then search for __setup there and it finds:

Fixes: f2d937f3bf00 ("consoles: polling support, kgdboc")
