Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFF1485092
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbiAEKDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiAEKC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:02:58 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5E8C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 02:02:58 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id bm14so159784771edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 02:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LiCr3DcHWP/vYQDt4xtXpCAxWVUtAnKSm8w0neZQr6w=;
        b=AdsbaxEVPKv2LOI32RpwGFfMKufbWpjbpgOllifmVcHevqUPXHZDPO3VxdzvG1tzRc
         YoGK2LgL+3RjoL04itwsfexZ7CBE/tlEaiOjs1SebUrSoyQQurNpqjzhtDJmwldgGKaB
         pq46OBfTSEWDc2Sa4UKP23cc080Q9A7FMrXvAe2ynqtyYgRUKRcBnhgEOT+s1nYLZQM1
         88q9mANkMNwe3F1sLJt8d7vRG3tHxplZj5/NuXzRZoIm0QmW5yCkyBvQjihT4DWREuOz
         wKcn7+4AUtJr7t6j8kX7Y2O1AW2tDFozaEdkvRgDEDNy5fSmlRpMkURgVl1FIfgE5hfH
         2jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LiCr3DcHWP/vYQDt4xtXpCAxWVUtAnKSm8w0neZQr6w=;
        b=LMkNph0O+Y0kzlMAdmPSXIbYUEBTfeZWRmCU5MrDdSoxbZ4J25pPMJD0qOBbxncUEZ
         PNoyQksfxzDnjYa4x3XRGvtPzLxKaVNTrgkWGNfkVaDtwxQY+NjC2kqxwLHMDOIPRJGM
         WcU6t89PuIr7jB2+Qfw1uSk/uLht+l0ak+R4yYxjItvGjvcMet/WZClr165JIdAE7ZIY
         G9QIFww5BYh+3Iazp+XsQFYtJfPrkbnALDA+V1omXu4+vLP4xDtPTZV+lg9uPzx5mmAm
         bSyoDM0bu3pZ20pi5WGFQG8rYBXzxtXL/uvnbbLQ2CD2CMNM8OeqaN1zte4MVrQP2Cu7
         x1SQ==
X-Gm-Message-State: AOAM531MZvBWYOhV5e5Kd51FMtCcky1uGiJh+FF1NQejc7SBjFAyD603
        HaWU6KFU9oGXOzbvK3FrjSe7nXeY6lQra7YDbt4=
X-Google-Smtp-Source: ABdhPJzXWoVNpGDpjBMwOpIwK5eCU2AKsnQfeoNaF9bncqaZruIPbUJdArnZhBOlr5fsxcBcWll97DBe+7jJvpd+F/A=
X-Received: by 2002:a05:6402:2ce:: with SMTP id b14mr52939053edx.122.1641376976925;
 Wed, 05 Jan 2022 02:02:56 -0800 (PST)
MIME-Version: 1.0
References: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru> <87pmp7volh.wl-maz@kernel.org>
 <CAMuHMdWjGUHZQhKDPASfpfNOiUg9HP2f3DsUsmJoijap29xpyQ@mail.gmail.com>
 <87mtkbvktb.wl-maz@kernel.org> <YdQnLuQseVhq40yd@kroah.com>
In-Reply-To: <YdQnLuQseVhq40yd@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Jan 2022 12:02:20 +0200
Message-ID: <CAHp75VcFY9RPeCAKC0vnNhXK-_-Zy7cWeLMBSuJLYZEDw_iAGg@mail.gmail.com>
Subject: Re: [PATCH] platform: finally disallow IRQ0 in platform_get_irq() and
 its ilk
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 2:08 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Jan 04, 2022 at 10:48:00AM +0000, Marc Zyngier wrote:
> > On Tue, 04 Jan 2022 09:47:21 +0000,
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:

...

> > I think the end-goal is to never return 0. Either we return a valid
> > interrupt number, or we return an error. It should be the
> > responsibility of the caller to decide what they want to do in the
> > error case.
>
> As 0 still is a valid irq for some platforms (as mentioned above), then
> how is this ever going to be possible?

To avoid that we should first convert that SH case to use IRQ domains
instead of putting some arbitrary (HW dependent) values to IRQ
resources. When that is done it won't use vIRQ0 anymore. So, I agree
with Marc on that, except _optinal variants, but it doesn't contradict
the basic idea.

-- 
With Best Regards,
Andy Shevchenko
