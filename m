Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D66B4D1FD8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348118AbiCHSOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiCHSOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:14:21 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BB5286EF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:13:24 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id r22so10637885ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uk8vMG8yzUNABGSbXXlhMALinCLxe9UxsQZpByRJJYo=;
        b=Xcm39d4IsVwThejLea1knKW9B43AMUw0+QwtNkfcHuI8k7Z3/eGWS0Lj4SWyDGFoKI
         s6xYWNIFH8MyE4ov6jE5VGI62n2Uv3aNcve3A8xjbMU7sakLrdFgdRyVCLE4GPdj2nj5
         zwD3wGo75LsCYT/agZSVQ4u4X2Wl2+l1RWoJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uk8vMG8yzUNABGSbXXlhMALinCLxe9UxsQZpByRJJYo=;
        b=qCZ3YVGVfVSwMGwLC1ehLlhwdY2bfk/ghMPwBXRue/Jw4FiLx/ww4JziaXms4F7PnL
         cr0rA6hYmeBNAyv18Hya6ONzUfT1+fYMZrpGMr3LZ5ncuf5V6xRqfMFsIDx/2Q8KZo9t
         CGGIobXCn13SV6eBP96DmGIA1wRH36fO4VY/SDeIbvYzqEO10hihrh+vHf7EmbHRXjib
         Gh2WCyWzZRD49sjuxayPwkJOiAarYL617vtoxLwXM52f1pmLpz306YhQWZ40kySv31tx
         e3hgCN+PRNo1XPSuGcB1Ub6ZnjQanPwd5aqtl9oq4zgP0zh7mqMd4yNOHfwKiSKA15Wx
         UzyQ==
X-Gm-Message-State: AOAM533uI4FFFV046QP9NBwLaJAv4jj21Kkhzgww+8K65TmvX/pmY789
        t6WvM58vdORX5m/VZ8NiNG60yDEgJE4RQBwg8ZY=
X-Google-Smtp-Source: ABdhPJwy8ZTqfYDR+/ITgcujz6jfnW6cKI9LLay2MP8yEx26JVVz2UR//TF5oGqHBVfkvHyAtWlfMA==
X-Received: by 2002:a2e:871a:0:b0:246:ee2:1109 with SMTP id m26-20020a2e871a000000b002460ee21109mr11472126lji.165.1646763200550;
        Tue, 08 Mar 2022 10:13:20 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id n16-20020a0565120ad000b00443c3f383c5sm3615058lfu.231.2022.03.08.10.13.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 10:13:19 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id l12so26121419ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:13:18 -0800 (PST)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr3570290lji.291.1646763198615; Tue, 08
 Mar 2022 10:13:18 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr> <20220308141201.2343757-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220308141201.2343757-1-mailhol.vincent@wanadoo.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 10:13:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=whvGWbpsTa538CvQ9e=VF+m8WPQmES2y6-=0=-64uGkgg@mail.gmail.com>
Message-ID: <CAHk-=whvGWbpsTa538CvQ9e=VF+m8WPQmES2y6-=0=-64uGkgg@mail.gmail.com>
Subject: Re: [PATCH v2] linux/bits.h: GENMASK_INPUT_CHECK: reduce W=2 noise by
 31% treewide
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
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

On Tue, Mar 8, 2022 at 6:12 AM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> This patch silences a -Wtypes-limits warning in GENMASK_INPUT_CHECK()
> which is accountable for 31% of all warnings when compiling with W=2.

Please, just make the patch be "remote -Wtypes-limits".

Instead of making an already complicated check more complicated, and
making it more fragile.

I don't see why that int cast on h would be valid, for example. Why
just h? And should you not then check that the cast doesn't actually
change the value?

But the basic issue is that the compiler warns about bad things, and
the problem isn't the code, but the compiler.

                      Linus
