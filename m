Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B170B479696
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhLQVxk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Dec 2021 16:53:40 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:51735 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhLQVxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:53:38 -0500
Received: by mail-pj1-f42.google.com with SMTP id v16so3419375pjn.1;
        Fri, 17 Dec 2021 13:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OSouNAXKfQ8rN33RQ1qzlpM1z5+txx2hdojNvqQ2iiA=;
        b=PradlHJUTwS73dO0RntQab/fPAZ3DjFaFu6KNghZnSJDf/RyuYCD8k5EntbWZzAtuB
         jwTLuNiTdZHuUjNU5RKwQTws2VfffXawpvRLmikslhHQYlDPNYDRE5K4TQRfy2wvEBgz
         maNbEdGfsl7j9NDtUZ5PLvvu+eVboztVJIo0Vf4Q0eRuQG/hILv++VSFH1Sph0iJXLdm
         P/whMlCe7ChhNF60w+gidRpd3LWNIr0Mrs9BILn/9pUbcxzgt/SkPIqwmn8gOhLjFjH0
         s9U+qo9cOleWy7/au+7/WuKahHfyJ9FScdtbFhSFhbrwdm1ZdT6UUE3ln+eqohUZfQ7r
         iYGA==
X-Gm-Message-State: AOAM5330SYmT7oitayGLPRc2jUiRgCdHaWcVDrOfdOaRJEpra+asyxRO
        p21ffb28qpzs73pW9e1RaDqAs+5ivVXoeUENYKc=
X-Google-Smtp-Source: ABdhPJx1Zgynh4wUXHAumH4LM1mHoQULX+g2DiYYo478GOP+yyTFHo3EgCd7tYqK0eyI3a6CjCxf6rAt/dVCYOJdy8c=
X-Received: by 2002:a17:902:7609:b0:148:daa5:8133 with SMTP id
 k9-20020a170902760900b00148daa58133mr4904314pll.48.1639778017978; Fri, 17 Dec
 2021 13:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20211218003339.0061dcb4@canb.auug.org.au> <eff1f8d6-ec12-42c7-d869-8fbd9e3a560d@infradead.org>
In-Reply-To: <eff1f8d6-ec12-42c7-d869-8fbd9e3a560d@infradead.org>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Fri, 17 Dec 2021 22:53:26 +0100
Message-ID: <CANBLGcynOdjJDS45YwMPZQ+MuYHf4w-rQ5GixokLyvuZ4ZM4vQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Dec 17 (drivers/reset/reset-starfive-jh7100.c)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Fri, 17 Dec 2021 at 22:48, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 12/17/21 05:33, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20211216:
> >
>
> on i386:
>
> ../drivers/reset/reset-starfive-jh7100.c: In function ‘jh7100_reset_update’:
> ../drivers/reset/reset-starfive-jh7100.c:81:10: error: implicit declaration of function ‘readq’; did you mean ‘readl’? [-Werror=implicit-function-declaration]
>   value = readq(reg_assert);
>           ^~~~~
> ../drivers/reset/reset-starfive-jh7100.c:86:2: error: implicit declaration of function ‘writeq’; did you mean ‘writel’? [-Werror=implicit-function-declaration]
>   writeq(value, reg_assert);
>   ^~~~~~

Yes, It needs to include <linux/io-64-nonatomic-lo-hi.h> for compile
testing to work on 32bit architectures without readq.

Arnd: Do I just send a patch or do I redo the pull-request?

/Emil
