Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E41486938
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242453AbiAFRzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:55:23 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:37815 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241987AbiAFRzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:55:22 -0500
Received: by mail-qt1-f182.google.com with SMTP id c15so2659623qtc.4;
        Thu, 06 Jan 2022 09:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ox3rPC9dAJrohl85LiIr9TxRU2+Tpf4TawpkA4ZLMwY=;
        b=yKaLSYq02AjsfK125WQSrda6ZzeuJe4vCJq2WiYs5qkpEKg+BisqCw0CyS3p32YEfp
         Hnm8M+feS1N2z5MPr8k59iNItCT/7fgpspWK3SEywnsf35OgZtPcnec6mH00jbQd7sM9
         V6jJAfn8EkWCxgky/mut1CzWs/u2SfxB2Hh30O1fYhSTR+8MQa6x2ydwQYU1JZdgPKlQ
         +3CbmGgv6PHdLAURgonJNj5jCTlxyngE2M2jWWex3OhxDKT2ymFYUrA2+5vLkNpNP4Wd
         tJRo8hckIq13Bv/Zz37gio55rYbwnuUlD4NjxIiGmPfDECmjKvvDT01MAtAx3oThjbh5
         ZEyA==
X-Gm-Message-State: AOAM5314DIS5+D5LCxaKR97e+I/6TfTWfAy5OkdXkbA00HEGOJ6qETKf
        Ri5Y94hSwahooybMhfDh7ZYpvzf4KRYSyh5igNc=
X-Google-Smtp-Source: ABdhPJwYNeFYQxoDVUz//hM8GmP2HPaR/FE+YwTYKJG9R5D++RSQa6alF+L3/8lQypXXDtVMhzwdPBKoUAqNnnVW8So=
X-Received: by 2002:ac8:7c4e:: with SMTP id o14mr52864128qtv.80.1641491721157;
 Thu, 06 Jan 2022 09:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20220106075448.3215141-1-yangyingliang@huawei.com> <20220106084207.GA865257@chenyu-desktop>
In-Reply-To: <20220106084207.GA865257@chenyu-desktop>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Jan 2022 18:55:10 +0100
Message-ID: <CAJZ5v0iDVLhDbJZXsoOQ915O4X3MVxHeQx=3Y=1+AYYa5=WgPw@mail.gmail.com>
Subject: Re: [PATCH -next] ACPI: pfr_update: Fix return value check in pfru_write()
To:     Chen Yu <yu.c.chen@intel.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 9:42 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> On Thu, Jan 06, 2022 at 03:54:48PM +0800, Yang Yingliang wrote:
> > In case of error, memremap() returns NULL pointer not
> > ERR_PTR(). The IS_ERR() test in the return value check
> > should be replaced with NULL test.
> >
> > Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update device driver")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  drivers/acpi/pfr_update.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
> > index 149b5b2530b9..6bb0b778b5da 100644
> > --- a/drivers/acpi/pfr_update.c
> > +++ b/drivers/acpi/pfr_update.c
> > @@ -460,8 +460,8 @@ static ssize_t pfru_write(struct file *file, const char __user *buf,
> >       /* map the communication buffer */
> >       phy_addr = (phys_addr_t)((buf_info.addr_hi << 32) | buf_info.addr_lo);
> >       buf_ptr = memremap(phy_addr, buf_info.buf_size, MEMREMAP_WB);
> > -     if (IS_ERR(buf_ptr))
> > -             return PTR_ERR(buf_ptr);
> > +     if (!buf_ptr)
> > +             return -ENOMEM;
> >
> >       if (!copy_from_iter_full(buf_ptr, len, &iter)) {
> >               ret = -EINVAL;
> > --
> > 2.25.1
> >
> Acked-by: Chen Yu <yu.c.chen@intel.com>

Applied, thanks!
