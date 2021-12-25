Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1926047F19A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 02:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhLYBIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 20:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhLYBIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 20:08:15 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05A7C061401;
        Fri, 24 Dec 2021 17:08:14 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so9472620pjq.4;
        Fri, 24 Dec 2021 17:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EL3Dq5TmzKZTYH6R2nxXnIMQFNr3bo4ypkh6vrYhshc=;
        b=ANTs6AaMh9Xv+SEq9FN84UnQyFkAK1wzteyLgRzWsZm/ZIXEny+gVkpCCF38PmCCPD
         U3kVZ17ysox/ZyS+K2kYpIuRBKB7eTCl3r04NqQ/013gVFmp5eQUcU0890833IUYF9kZ
         wiVgM5kJsRssyTvs/JvHwiyYbncWnH2EKHVp9uw97vjCm+AaIb2VUlzDR998e0qfYHwH
         44Tq0lIMr9S0xcf78NXAlzvWPCTBG9HJCkrflYqYbyrMsJ6vrp68nc4WHSGMjVAbW/vj
         XE2FQZrk7zzAiTZplGbydnc7CNJuAGcUVU/sHqsv5QQyCREB1oOk5eGr016PuYKzIiCQ
         mLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EL3Dq5TmzKZTYH6R2nxXnIMQFNr3bo4ypkh6vrYhshc=;
        b=ShZBsrZPEyapMIPQNsq4mYVLCMqek/MvIft9DShmyqgT+h/ZQ+Xb6OtktI5eN0ukhN
         L5T6UZEndJ98j6uukZJlwXx8ZJUiYGzvphYaw/YDWHZYKC0TC75k+2cmRaM2KyTOFrbj
         G5MkrHyXH4y7RJSwteo/z2TpPa2iQg0bb3AEVgUSe5wdHrNUGAyij4MlUbaBddpGblQo
         B3um8gxAHP5FgMYgVkt5VBIz8GIpHr485AjCbkv5PNQq9xfUXUwLBXch0Lao/RxoRpOC
         ysbWzABn9RjWxi5NC329nswB9lMJyZrTWKcV22evzvnmp0jsMGPqYra/G0rQzilVsI+c
         lJkg==
X-Gm-Message-State: AOAM532BV2tQgokPIgq1NlfaRTqGPyN/PEijnZaN4Ry7H9GE1aDe+qYI
        vQn/IH0QBVCy/LkvQ/rQh7B5PNEKfbMjKr5SMVk=
X-Google-Smtp-Source: ABdhPJzfK61jo474Cn7NsNqiEL1YxMVo77g1HDHOVNp8m8YOqeXaNFT2FKY6v56SdxDN1qkFoVjO/Q1A6KMul1lntKc=
X-Received: by 2002:a17:903:1212:b0:148:ac36:25fb with SMTP id
 l18-20020a170903121200b00148ac3625fbmr8470206plh.147.1640394493261; Fri, 24
 Dec 2021 17:08:13 -0800 (PST)
MIME-Version: 1.0
References: <YcJZWiQ407ZxMM+y@bombadil.infradead.org> <20211222132332.7817-1-vimal.agrawal@sophos.com>
 <YcRRQCMZFepB/hzX@infradead.org> <CALkUMdRxTm6STT4CncTuvQ9hM_bez+B91TsuenEj71KPxFgMsg@mail.gmail.com>
 <YcVtG26b/sO9k7ox@infradead.org>
In-Reply-To: <YcVtG26b/sO9k7ox@infradead.org>
From:   Vimal Agrawal <avimalin@gmail.com>
Date:   Sat, 25 Dec 2021 06:38:02 +0530
Message-ID: <CALkUMdSY3XCHqhH9dDQ+0VHykv9AiBiqLgoC+cj5P=9Q1jdXrg@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/module.c: heuristic enhancement when
 INSTALL_MOD_STRIP= "--strip-unneeded" is used
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Vimal Agrawal <vimal.Agrawal@sophos.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 12:17 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> I don't think we can support passing arbitrary linker options and
> expects things to work.  If we want to support --strip-unneeded
> it needs a good rationale and be added as a direct config option.
INSTALL_MOD_STRIP was provided to give flexibility for providing
strippping options. It will be a separate discussion if we want to
continue allowing this flexibility or not but it is available now. I
see that it works but just that it is behaving erratically during
symbol decodes. I tried few other stripping options. --strip-all does
not work and insmod fails as it needs some symbols which is fine as it
is hinting the user there is a problem with stripping option. This is
not the case with --strip-unneeded option as it builds and loads/works
fine but fails to decode symbols properly sometimes.

One of the rationale for --strip-unneeded option is that it
significantly reduces the size of .ko without affecting its
functionality ( though debuggability takes a hit). I guess many
platforms/products that need limited memory footprint might be using
this option.

I am fine if we decide to say that --strip-unneeded option is not
supported by kbuild/INSTALL_MOD_STRIP which is not the case now. In
that case, I agree that this patch will not even be required.

Vimal
