Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31F04C7887
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiB1TPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiB1TPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:15:54 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0558DE2F5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:15:12 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id t14so18768290ljh.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RaHvQvU+g+DJPHB4pwP7EaF4IEodKDmqN1Ss46lBbuk=;
        b=eva7/zFozRLyNBFcsYg1XG44yt+LkiFwgUQHGuPMMFE9jumunmKXgw3Oaj9bSWnnks
         sjxO/gP2sXtD10iEbogR1SRuM1/llu9YnuNBLr4/cZN7DYKUzrwy0ttJwSMs9j7FUkia
         Hf3uPSgvlT0mtpwZJ4nVHwkRgrSh2Duk7pXBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RaHvQvU+g+DJPHB4pwP7EaF4IEodKDmqN1Ss46lBbuk=;
        b=fwLdeQTnyRXxRDb/3rJMDjBqKWiY91CajNmS32YaRrkYR4nb1t+QUetCsPzX2LXhZm
         Ekuayi52066X2FHJAKsOwhcIhZLJ1IWF2J4BqmW+DIHmb1lR1tpHlYNbgAwhTWS+MhpK
         tViNB70Xu1PFhlr0OfVXuxuGHTHIRMVvBRzxFS0/q9jeTpqN7Rtzm057UTsxlIw0dsun
         ONn4S0FOspKhRZAIQCCDlF1qGSc/hCeeIsZtN31vcURi+9S3TuPX0B9RpYUSaQmys5H+
         Noi+InIRXGYzSkWWe7f9+LI2h6h2yQ6rXpUzxR189c0YPjTSM3Tlz5T5EsQ2VEY8U2lp
         Ow4g==
X-Gm-Message-State: AOAM531JyJGUiB2pdi5OKDmLi4MArygB0CWZmh0Hy95OgtVXSoVhTRk8
        /7CMaDHEP+RJv2Ltf6RvVzlb48+HKc1+4wQKKrU=
X-Google-Smtp-Source: ABdhPJzif1OuO7Cr2f/prcM0dTPGORWX/hPJMQ08aCNy5ofqQiby63t1cv1z4f+EktrOoOS8uymGXQ==
X-Received: by 2002:a05:651c:170a:b0:23e:5515:54a9 with SMTP id be10-20020a05651c170a00b0023e551554a9mr14682440ljb.163.1646075710771;
        Mon, 28 Feb 2022 11:15:10 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id n16-20020a0565120ad000b004431bbc33f4sm1094175lfu.223.2022.02.28.11.15.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 11:15:10 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id j7so23083662lfu.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:15:09 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr13597040lfb.687.1646075709682; Mon, 28
 Feb 2022 11:15:09 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdYM21hcH5d9rXyvjMPHQp429OZ1Zcy7uLU2tndoJcOmUQ@mail.gmail.com>
 <CAHk-=whg3eRY1nOJjHam+jORmVymU539CxhBUjp4=tGoFitotw@mail.gmail.com> <CACRpkdbWkm1WDY30qoGLEQba+G2cDEhT+M8nCdJbcD=ZQiu6uw@mail.gmail.com>
In-Reply-To: <CACRpkdbWkm1WDY30qoGLEQba+G2cDEhT+M8nCdJbcD=ZQiu6uw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Feb 2022 11:14:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjNdW6Tdei6+6OJy6jGqY=PCJ2TWFKpV+g0projUC1eag@mail.gmail.com>
Message-ID: <CAHk-=wjNdW6Tdei6+6OJy6jGqY=PCJ2TWFKpV+g0projUC1eag@mail.gmail.com>
Subject: Re: [GIT PULL] pin control fixes for the v5.17 series
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 6:44 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sun, Feb 27, 2022 at 9:38 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Hmm. Am I confused because I thought I'd see a fix for the orangepi
> > problem that Guenter has been reporting?
>
> OK let's poke Hans, he usually fix things quickly so it must have been missed.

Well, part of me being confused is that I've literally seen you reply
with 'patch applied' to the fixes.. Ie:

    https://lore.kernel.org/lkml/CACRpkdZ1nFAmzRvsvKvZ08fsP_MgsnsiNpD7LdRRXUDWtO_w=Q@mail.gmail.com/

but then I didn't get the result.

Afaik, that patch is only relevant if you applied the previous fix
("pinctrl-sunxi: use the right offset" or something like that).

I get the feeling that you didn't realize that this was a 5.17 issue,
and have maybe applied them to the wrong branch, and they are pending
for the next merge window.

            Linus
