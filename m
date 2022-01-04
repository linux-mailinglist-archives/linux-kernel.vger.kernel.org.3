Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7654C4848B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiADTmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiADTma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:42:30 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12DDC061761;
        Tue,  4 Jan 2022 11:42:29 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id y130so86716037ybe.8;
        Tue, 04 Jan 2022 11:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncAQv2DljIFRljclnMmZerc5ibGlEn4OCHalSWIpIz0=;
        b=qGxFkqq0niJN+9BfjqTxTOL7ISmBhLHgksGbQyGGLrvdjq/K4oqZHQIaUp670c5rYp
         0S9b+TQFw8v0Q20JMb5oFO0wlsZAVPNrZ8WpiRL6/C3EFEFkZawUbS+1FDH1Lktog8+b
         dJ5mIvU/wEOCmEOdYS3BBhUUyvUGJXBu5TfYAYbM7hdACCPWUnS0xAISSsJwAk6QMmUJ
         OZVQZ+UUYU5UYrJ4tg/HOYpr+ahDDANFTG331UdY+2K3x6cPAowlSoRVmRo14jCqxvXe
         1xREBS1ejUsVePrMKeslsQv4tDb+sRHoGxpzuDeD72mFuX9XW3sLhMQ9C4fvLtaRzF3L
         dsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncAQv2DljIFRljclnMmZerc5ibGlEn4OCHalSWIpIz0=;
        b=XXRQxuhtSYQvHJ5qYSxN53tYufBm1HS6KPX/dvhSthSC1U8K6Ja8zA0V01pf5N5j7+
         VCLl8eiyaXlQsNwJQ1gueM7fwuj7sbvpGqf31+UJBXPv6ft/gCnnMsfrVTuIpQTA6wiv
         Z7aYdZLH76UKMsLABylpY6hqBYYCi6PrCmM5OUHW6IbUCL/5BHh3mLSGqwgDgm2qIbiB
         Y6ulSAJaGw6g6uN0TUHnWOSOUmvqTOy2E7Y3G1JBiLWqP9KrPTN2LIzNh4s3LNTXFkYS
         aRX2G2DvRvLAXZCbwkPsZ7HNhHX3cKk1IDRE1rw7XqePki+OitGaK/1RzlMZlBG8MeUO
         RMig==
X-Gm-Message-State: AOAM532ZQIlucxaiGlJYF56q4shA9xSuI6XbB1NDPHDl3pJdDuKyKj+c
        ba0sWxST0CT2QP37I/hfWgXB2NXzzz5EQ2pdjTuJlpNqoJg=
X-Google-Smtp-Source: ABdhPJyrY43dMscA0Lmdb8zzAF2wEyIUmc4f8XLCz707RSMKzYswtTwMQZK+h2bsD7LikX5NIkCs0N4Jg02ziZcHa0w=
X-Received: by 2002:a25:7509:: with SMTP id q9mr46108130ybc.315.1641325348914;
 Tue, 04 Jan 2022 11:42:28 -0800 (PST)
MIME-Version: 1.0
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224131300.18198-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <25bf8893-7369-954e-bd5b-f3d592af5b09@omp.ru>
In-Reply-To: <25bf8893-7369-954e-bd5b-f3d592af5b09@omp.ru>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 4 Jan 2022 19:42:03 +0000
Message-ID: <CA+V-a8uEALwWXhsBZB6ct482W6iexuGaguVT5zxJiGQ6nL7hYg@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] ata: pata_platform: Use platform_get_irq_optional()
 to get the interrupt
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

Thank you for the review.

On Mon, Dec 27, 2021 at 7:58 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> On 12/24/21 4:12 PM, Lad Prabhakar wrote:
>
> > To be consistent with pata_of_platform driver use
> > platform_get_irq_optional() instead of
> > platform_get_resource(pdev, IORESOURCE_IRQ, 0).
>
>    But why can't we be consistent with the unpatched pata_of_platfrom(), and then
> convert to platform_get_irq_optional() after merging both drivers?
>    I'd like to avoid patching the driver to be gone if possible...
>
Basically to have members of struct pata_platform_priv{} in one shot,
instead of changing them again and again. btw you are OK with patching
for 06/10.

Cheers,
Prabhakar
