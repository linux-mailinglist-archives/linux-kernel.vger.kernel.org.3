Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11912478432
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhLQEph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhLQEpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:45:36 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2469EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 20:45:36 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id p2so2082005uad.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 20:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bowteYFUSb68Kk+FpHsWHap6R+P/0DEq2g+PO5y0/q0=;
        b=jSGXJygNb1E1nAR6rmGlUVenCpyjwwAAFaQhJcsGVhEm4Fd9yN62dfzM7X/a/IU+Vb
         cKFXAvT4MJzhKVGE6SFjqlNuxXJOJRtwmzW28Al05snTpNKuHf1nhk2Fa9CAwlgoFZkJ
         /hBTWaXSKEBXHLwnNQ6qBVIZgHOkEqmv0q2CKy+KvXOdyN7GTgjF+XwkKOirv5oSfIBY
         +9y3gheMuiqO1+My6StdOsq1kYtiLOQeiaq8Ox5YiVWC8wq8JV0q0mOE7ILQ6EGqZ4NM
         zw1JG3ZCB33RXJgfsykIYaHFbQIjJ5rJ0wmUGwJ0Y1u4kyNsWUCHMAk3d+yoqttBTCMk
         21ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bowteYFUSb68Kk+FpHsWHap6R+P/0DEq2g+PO5y0/q0=;
        b=QyD0m2G/RfdG72F+PYcfe7LPqVs183pPsmF3CxyuJu53R59ZYT+lJ9GM7zTPGZqofX
         TexibJcGo4i9ZZaJI2GE5ni8W0MZvuXMemYl65PZfcM5rID78Y5K8KXxh/L9zb3OJzGO
         EQzQghCi7Dpyo8XHXbYX106gQdZEa442YA7Hoxq4rBkkopk8HI3+QBXcX8/Q/3qmVv8j
         yq04mBmm1Jvrzw1SF65tIX8YRsEX7ZqAPmvX0sMALlEKagmXH6lu4jQRrSgWGtYiQgRR
         2ZDhXVAVhN8RLPHkARZiYCuh83vKUe1MNEJVDZrDHUNon32wqiFwqiTwiQKRnwvLJLnb
         jQ3w==
X-Gm-Message-State: AOAM531PRqoOtXTAVw16uIjFtifxpcKFR57juYP1Pkr0deeuC6RX5fIb
        xx85XLbMBLRgcZJ3opXKhnTOz3RbinbnyjFY3eQ=
X-Google-Smtp-Source: ABdhPJwqkSCZfBjG15LUJnU8YhuTZ86T+fZvgz4qN0xNwe9C9ep6lWgdhhzcGiURSfTOogQ9rEQSsKsKGZvDHlkI6G4=
X-Received: by 2002:a05:6102:c46:: with SMTP id y6mr399610vss.53.1639716335162;
 Thu, 16 Dec 2021 20:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20211216125157.631992-1-chenhuacai@loongson.cn>
 <20211216125356.632067-1-chenhuacai@loongson.cn> <20211216125356.632067-2-chenhuacai@loongson.cn>
 <87pmpwwpw5.wl-maz@kernel.org>
In-Reply-To: <87pmpwwpw5.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 17 Dec 2021 12:45:24 +0800
Message-ID: <CAAhV-H75SwqWiRjey_9MiRQtY-_Wjm7Tppx31XM8EfLDb_YUhQ@mail.gmail.com>
Subject: Re: [PATCH V8 02/10] irqchip/loongson-pch-pic: Add ACPI init support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Thu, Dec 16, 2021 at 11:06 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 16 Dec 2021 12:53:48 +0000,
> Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > We are preparing to add new Loongson (based on LoongArch, not compatible
> > with old MIPS-based Loongson) support. LoongArch use ACPI other than DT
> > as its boot protocol, so add ACPI init support.
> >
> > PCH-PIC/PCH-MSI stands for "Interrupt Controller" that described in
> > Section 5 of "Loongson 7A1000 Bridge User Manual". For more information
> > please refer Documentation/loongarch/irq-chip-model.rst.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/irqchip/irq-loongson-pch-pic.c | 108 ++++++++++++++++++-------
> >  1 file changed, 81 insertions(+), 27 deletions(-)
>
> [...]
>
> >
> > +#ifdef CONFIG_ACPI
> > +
> > +struct irq_domain *pch_pic_acpi_init(struct irq_domain *parent,
> > +                                     struct acpi_madt_bio_pic *acpi_pchpic)
>
> Who is calling this? This works the opposite way from what the arm64
> irqchips are doing. Why? I have the ugly feeling that this is called
> from the arch code, bypassing the existing infrastructure...
Yes, this is called from the arch code and a bit ugly, but I can't
find a better way to do this.

Is the "existing infrastructure" declare the irqchip init function
with  IRQCHIP_ACPI_DECLARE and the arch code only need to call
irqchip_init()? Then we have a problem: our irqchips have a 4 level
hierachy and the parent should be initialized before its children. In
FDT world this is not a problem, because of_irq_init() will sort
irqchip drivers to ensure the right order. But in ACPI world,
acpi_probe_device_table just call init functions in the linking order.
If we want to control the order, it seems we can only sort the drivers
in drivers/irq/Makefile. But I don't think this is a good idea...

If there are better solutions, please let me know. Thanks.

Huacai
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
