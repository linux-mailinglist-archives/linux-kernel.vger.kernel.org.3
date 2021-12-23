Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670BC47E2D7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348091AbhLWMDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbhLWMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:03:20 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAF3C061401;
        Thu, 23 Dec 2021 04:03:19 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z29so20503072edl.7;
        Thu, 23 Dec 2021 04:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GULw6FpLgoVlSnPti+ASNXJR3k8hiP6XA2nY3KteHQ=;
        b=N0obOTd94WL0PqDdM11HZUyqeo33DClomzuVoQVrjO6cAe824T7KEamF3JEXKrPKjU
         7BO2LwgBs9+GQFyMj+qyoOSt/Ndra1lDWqacqRrnrk+6dNaPeB6OZh/7JcEPgxzyaYe4
         TpovwDkmL+ggyuVekFrELpMK4S9ZDsujggY92AMPo0lVUqcj+ppRR3nVFn/ch97Gevuq
         kdyCXrM4eako++Qwe2O6AayIHrPhSQLNflyj4z/652v/GwjUp0XLCImuRGPaPr+7UeJr
         Kdl6ziWDide8xkstTnW2FYBSK5+WUc5S060JIhzkC+zX/zid8n9mIKfmphoX93TnT6jw
         YgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GULw6FpLgoVlSnPti+ASNXJR3k8hiP6XA2nY3KteHQ=;
        b=KHRgN9Pw9QQnz00zZbGCRRjI1yK2J209/BagUf3D5cD+BCzFmWsrKxg9g1xXi3x20W
         QarbBw1Z52wv7LXVFpP/OBcm4HsFuw9L2njwkVs/d3RKUSMLyQ1u/9NWLilVgQxUIyqE
         b6q2235V1fZmAXGFo72CAmMZVWuPMO6yIJT2Ize+IkVcZ42S122wW/GgCbvATltH2p97
         HQy4a/G0+SSgHDaDDsEoITN1slxdNn8UfObIybXOKg/VOHbmbMfM5uPGgUvXWn2HRgqJ
         OJ8mFVL48MrJDMGTvJI3OG+5S0CE3Vk5EwjAuJkopyBQ/ypDf1fayr2yaPHmM44ynG6z
         +qlA==
X-Gm-Message-State: AOAM532Q97UP32vud2zq4P6vKs6Zzp2wh9e3f9xR13xK1w+q+vJg2PQE
        Jka7B6PgtH4Ufmp5qw7mN00UHk/G4JvCY1CzAiw=
X-Google-Smtp-Source: ABdhPJyoXAPaldSqemyvBcuc738haFkWTxhVZ84xqbJcoS3bgpZM3v+9+z2bQ9s0rBKw862ski0mtmUctakKJdyZHTs=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr1559891ejj.636.1640260998058;
 Thu, 23 Dec 2021 04:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20211223114038.1306663-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20211223114038.1306663-1-jiasheng@iscas.ac.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Dec 2021 14:01:19 +0200
Message-ID: <CAHp75VeESBiu7jpPd8EOZprqQ+eURQ8aLp1387QwRbq=i-jsLA@mail.gmail.com>
Subject: Re: [PATCH v2] serial: mps2-uart: Check for error irq
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 1:40 PM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> On Thursday, December 23, 2021, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > Check the types.
>
> That's right.
> I correct previous version, using error variable to check.

Below (tags and code) everything is fine, now you need to prepare the
correct commit message and send a v3.

-- 
With Best Regards,
Andy Shevchenko
