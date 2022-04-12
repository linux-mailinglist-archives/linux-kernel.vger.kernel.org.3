Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1280A4FD997
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391615AbiDLJfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390231AbiDLJYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:24:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860EB4A90E;
        Tue, 12 Apr 2022 01:41:10 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d10so21545945edj.0;
        Tue, 12 Apr 2022 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=giFGNVwHbG/lhSPNKKA7CMnxchYVGgHfOUGNKmY5eO4=;
        b=X3z0iTsHbWL8/nnDhCfbysobbT4YzWzR8oLACB04paf4O3s4DyH0+d2Pg0xa9kj2KV
         DxTLYK1ijUCaz8e1U1QcCsshYzT4SIx8Qf2iFqd0SHZQ7puO6OOypqiXKSYkiuIPZjjs
         rel7tkZ0hnoBXOOD4B91YnLRE9Toq6WtwOJF76u9+uY1+yB5sF6DTb2I5C9HkectoZWQ
         6mle7utxxnL/EXO5V3Po2kft9ZyDMWI+H5WCURo3xD2rkvNvxDW2pQf2o1cu8XVaTIzB
         4p7E3Dg6ftd9mpnnOUBnflCvHnvA5jOU0KsawB3SRVxVFS2K2x2+JWsxfVP6iZUYa1yg
         tXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=giFGNVwHbG/lhSPNKKA7CMnxchYVGgHfOUGNKmY5eO4=;
        b=HrE4elLf3SweWHHE7SJAP02a+pGf/05dcxYPlgY9yrFDdpZgf6IpV7/RTmUz8GJJnC
         z0kNJtW1uFiMQ34moBSRGeWLffh+nMQK5rmahHc6p1OS/Z6Rin+zItT9ChUBn0mhvPRG
         ilsszn/tl1G2LTuubILyGWW6nuqPKANQkp+qernpkbHeU4HQhPRyDQ3qpdhl7uwMCgZu
         gw70fWMZX8jqG/xIWCT0Wqun53YBuKu+IvYp6YwEHTEn5snx/038hsFgoDJMBN/UcoJo
         4ZZydkCZ80E8mEG2a0EkJbcN5VnrHZv3fyGVNb9wtG24LQUllVUigphZ786FBk8R1UjA
         DHpA==
X-Gm-Message-State: AOAM530KAMgD1nx0SQ/Zndnr//pFyTGQz8GOlp1Yg/pB/UlFOlaegIBa
        K+1tjCh5DYKsNjR07aPJY5PV4COnrvOChtf5WSs=
X-Google-Smtp-Source: ABdhPJyMYXORsRdY466ZkJuoUQ4DDUvfoW7HRoR6aCUK/Wd2ui4r2QImUVnrj4ndNscb86MC6vL9AvkUGJqaJ7f0TLo=
X-Received: by 2002:a50:e696:0:b0:419:998d:5feb with SMTP id
 z22-20020a50e696000000b00419998d5febmr38394977edm.122.1649752868901; Tue, 12
 Apr 2022 01:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220411063324.98542-1-andrei.lalaev@emlid.com>
 <CAHp75VfyxspOScEt1qffshdrDYuQp50O5HFbr2cUV7MYsg=JdQ@mail.gmail.com> <CAMRc=MfakYvQUW4NLWCrm5yVA185X4t__aB3r4-9xTh8YJaq8g@mail.gmail.com>
In-Reply-To: <CAMRc=MfakYvQUW4NLWCrm5yVA185X4t__aB3r4-9xTh8YJaq8g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Apr 2022 11:36:56 +0300
Message-ID: <CAHp75VcWvmMMjgNEUQK2AqmUzrx3CADEQq6XieFiix+=FBgqSg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: of: fix bounds check for valid mask
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andrei Lalaev <andrei.lalaev@emlid.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 11:28 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Mon, Apr 11, 2022 at 2:17 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

...

> > OTOH, the current implementation suggests that we have start,end
> > rather than start,count. What does documentation tell about it? Does
> > it need to be fixed?

> Thanks Andy, I rushed this one. Backing it out.

With the last analysis by Andrei I think the patch is correct. I
suggest waiting for v2 with a better commit message.

-- 
With Best Regards,
Andy Shevchenko
