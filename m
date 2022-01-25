Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342D349BFC9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiAYX5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:57:10 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:38674 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiAYX5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:57:08 -0500
Received: by mail-qv1-f53.google.com with SMTP id b12so7401465qvz.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gxwqg8D1Ma9afcfX+Lz0vVJUSn5slwhkWJibMLeSw38=;
        b=UEwBzW3+hJvW/xwcSf6dMtldh9V+tvTSN80K/reXNbcnqIs6rs2bk7Fp6xc07+aOCg
         Az0RY2aYzKzZldw14Xuub0jg6AeSnZFSlXS+5/7YSXIj5id7zcDMMYLr3JY0rK0Bz/Fx
         yAuldlwUlAMda7TQFW16Dw83tGkcXFneD3g/yxTIeT2zgKeuTrqzhwZGaD/a+CCHOT4p
         /oT7cOu7MYTKPI25yv4wiIevElmpVIwbsP5d3pTibgJY7qANTBhHJHBN9fZKMK3Pcu2E
         4iJgO+Q0wfoRQmU7Wdpok4G7dxzpyPXceiIYSwCcHW/Hhj8tgWWbmxc51VCRf+O82R/Y
         5W0Q==
X-Gm-Message-State: AOAM531+HP+EvnCyUa9j/pEjMfll0yRV/cAxohqE/vreih7MVUWtKERO
        R5ABmvwW0eg1qNzGmyo7glgvm0HWB1BOkbxwaackPlwRbSMZsQ==
X-Google-Smtp-Source: ABdhPJyMZ1i2gyggE9FaJauaXH+V1m2KrJqyYzgrY7wzC/nG4cpyf5g9wApH+P2QDsiqFEefmcHrSU6JHlrwzcxrxjE=
X-Received: by 2002:a05:6214:d04:: with SMTP id 4mr21989258qvh.62.1643155028014;
 Tue, 25 Jan 2022 15:57:08 -0800 (PST)
MIME-Version: 1.0
References: <CAM=k+5qEfxHOFkiXfobJERr=gMQ9jgcxgpydnkJx3ed3uPPsQg@mail.gmail.com>
 <55b4da35b6e44bf48306280d900e0fa8@AcuMS.aculab.com>
In-Reply-To: <55b4da35b6e44bf48306280d900e0fa8@AcuMS.aculab.com>
From:   Aleksey Senin <aleksey-linux-kernel@senin.name>
Date:   Tue, 25 Jan 2022 17:56:57 -0600
Message-ID: <CAM=k+5p4hF1_d+XUR8xUm18Y=BJQPYG2==Tq=7HOY8Z2rwRUxg@mail.gmail.com>
Subject: Re: Using memcpy instead of copy_to_user. xprtrdma code.
To:     David Laight <david.laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
It seems clue is in new proc_sys_call_handler code that allocates the
kernel buffer first, calls to particular function and than copying
obtained buffer to user space using copy_to_user. Right?

On Tue, Jan 25, 2022 at 4:21 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Aleksey Senin <aleksey-linux-kernel@senin.name>
> > Sent: 25 January 2022 18:04
> >
> > This specific patch -  - implements using memcpy instead of
> > copy_to_user. Why is it considered to be safe in this specific case?
> > All readings about how to copy data are mentioning to use
> > copy_to_user/copy_from_user. Why use direct copy here? What prevents
> > the kernel from failure if the page is not present or doesn't have
> > required access rights?
> >
> > @@ -103,8 +102,8 @@ static int read_reset_stat(struct ctl_table
> > *table, int write,
> >                 len -= *ppos;
> >                 if (len > *lenp)
> >                         len = *lenp;
> > -               if (len && copy_to_user(buffer, str_buf, len))
> > -                       return -EFAULT;
> > +               if (len)
> > +                       memcpy(buffer, str_buf, len);
> >
> > Reference to the specific patch in the services of commits:
> > https://lkml.org/lkml/2020/4/17/60
>
> Read the commit message.
>
> >
> > Commit itself:
> > 32927393dc1ccd60fb2bdc05b9e8e88753761469
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
